Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AEDC282DB
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E866B2177E
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbfBCOTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:19:45 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55128 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727918AbfBCOTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:19:44 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIcY-00061p-KD; Sun, 03 Feb 2019 14:19:42 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9e-000785-0F; Sun, 03 Feb 2019 14:49:50 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        syzbot+1cb36954e127c98dd037@syzkaller.appspotmail.com,
        "Takashi Iwai" <tiwai@suse.de>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.278166051@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 172/305] ALSA: oss: Use kvzalloc() for local buffer
 allocations
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Takashi Iwai <tiwai@suse.de>
[bwh: Backported to 3.16: kvzalloc() does not exist, so only change to
 using vzalloc()]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -1075,7 +1075,7 @@ static int snd_pcm_oss_change_params_loc
 	runtime->oss.rate = params_rate(params);
 
 	vfree(runtime->oss.buffer);
-	runtime->oss.buffer = vmalloc(runtime->oss.period_bytes);
+	runtime->oss.buffer = vzalloc(runtime->oss.period_bytes);
 	if (!runtime->oss.buffer) {
 		err = -ENOMEM;
 		goto failure;
--- a/sound/core/oss/pcm_plugin.c
+++ b/sound/core/oss/pcm_plugin.c
@@ -67,7 +67,7 @@ static int snd_pcm_plugin_alloc(struct s
 	size /= 8;
 	if (plugin->buf_frames < frames) {
 		vfree(plugin->buf);
-		plugin->buf = vmalloc(size);
+		plugin->buf = vzalloc(size);
 		plugin->buf_frames = frames;
 	}
 	if (!plugin->buf) {

