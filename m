Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE11C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA712213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHvDQDMC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA712213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733070AbeK3BbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:31:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:58634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731628AbeK3BbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:31:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7ED421104;
        Thu, 29 Nov 2018 14:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501540;
        bh=pRM/0Qn0UML5kXuWYt3DWX+48xl/YSp8j0fjZmcziRY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NHvDQDMCwR5DWpQhi0v7HwO1cSrDDCqwDCYPOEIxY3qT0MT+EzOuwTdA4v5Km90eB
         PeXgFQlqguVuT1TFwJZ9LndU6OKXws3cz4NWlqtlccVJPGQwLot8QA+T7cdD5kl/rT
         EyK1ibMM3NebO0pYRbi8Yx7ksMT+iKOshzOz3R5o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+1cb36954e127c98dd037@syzkaller.appspotmail.com,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 012/100] ALSA: oss: Use kvzalloc() for local buffer allocations
Date:   Thu, 29 Nov 2018 15:11:42 +0100
Message-Id: <20181129140059.986581736@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140058.768942700@linuxfoundation.org>
References: <20181129140058.768942700@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 65766ee0bf7fe8b3be80e2e1c3ef54ad59b29476 upstream.

PCM OSS layer may allocate a few temporary buffers, one for the core
read/write and another for the conversions via plugins.  Currently
both are allocated via vmalloc().  But as the allocation size is
equivalent with the PCM period size, the required size might be quite
small, depending on the application.

This patch replaces these vmalloc() calls with kvzalloc() for covering
small period sizes better.  Also, we use "z"-alloc variant here for
addressing the possible uninitialized access reported by syzkaller.

Reported-by: syzbot+1cb36954e127c98dd037@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/oss/pcm_oss.c    |    6 +++---
 sound/core/oss/pcm_plugin.c |    6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -1062,8 +1062,8 @@ static int snd_pcm_oss_change_params_loc
 	runtime->oss.channels = params_channels(params);
 	runtime->oss.rate = params_rate(params);
 
-	vfree(runtime->oss.buffer);
-	runtime->oss.buffer = vmalloc(runtime->oss.period_bytes);
+	kvfree(runtime->oss.buffer);
+	runtime->oss.buffer = kvzalloc(runtime->oss.period_bytes, GFP_KERNEL);
 	if (!runtime->oss.buffer) {
 		err = -ENOMEM;
 		goto failure;
@@ -2328,7 +2328,7 @@ static void snd_pcm_oss_release_substrea
 {
 	struct snd_pcm_runtime *runtime;
 	runtime = substream->runtime;
-	vfree(runtime->oss.buffer);
+	kvfree(runtime->oss.buffer);
 	runtime->oss.buffer = NULL;
 #ifdef CONFIG_SND_PCM_OSS_PLUGINS
 	snd_pcm_oss_plugin_clear(substream);
--- a/sound/core/oss/pcm_plugin.c
+++ b/sound/core/oss/pcm_plugin.c
@@ -66,8 +66,8 @@ static int snd_pcm_plugin_alloc(struct s
 		return -ENXIO;
 	size /= 8;
 	if (plugin->buf_frames < frames) {
-		vfree(plugin->buf);
-		plugin->buf = vmalloc(size);
+		kvfree(plugin->buf);
+		plugin->buf = kvzalloc(size, GFP_KERNEL);
 		plugin->buf_frames = frames;
 	}
 	if (!plugin->buf) {
@@ -191,7 +191,7 @@ int snd_pcm_plugin_free(struct snd_pcm_p
 	if (plugin->private_free)
 		plugin->private_free(plugin);
 	kfree(plugin->buf_channels);
-	vfree(plugin->buf);
+	kvfree(plugin->buf);
 	kfree(plugin);
 	return 0;
 }


