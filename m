Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CEFC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36EE820811
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298998;
	bh=XdTJY55mo39yRhbFQWyImqP8hYDqpZVm+Gw5MXkCBgY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B00F0MSD6a7yiFdZ1XThchHnyJGKYcl03tf9UWuqKmpqg3IXPhIiibdCHMTsmM9zS
	 hBElzVrywjzMYgYzJ9qQ9OJ/RPlvBWnAtSKLQwyWVGFkdN4Lo4At0wUnQKm6GutA95
	 dGSCn9RnEnqzY9L87lRTk4tcNZX8wrBu9ngVzrXQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731769AbeLTJnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:43:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:46318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731395AbeLTJWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:22:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5820E217D9;
        Thu, 20 Dec 2018 09:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297760;
        bh=XdTJY55mo39yRhbFQWyImqP8hYDqpZVm+Gw5MXkCBgY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ly/SgtUI5Il6BG3WwhGwq8CK3aiL7fA7cULgJUbj2EZFVixRw9Q/Mq/wlywxFNjzU
         cJlC+SFEfwiZctTdrzNe9YD3GFBH9PwvIUoRsoppO9XSwFHFqwDkJ7AYYHFbHXvJeI
         T3fue9Ms+82aa1hTgQ/Glr04Sq/21hrfv+iwiC04=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 40/40] ALSA: isa/wavefront: prevent some out of bound writes
Date:   Thu, 20 Dec 2018 10:18:52 +0100
Message-Id: <20181220085828.039845237@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085826.212663515@linuxfoundation.org>
References: <20181220085826.212663515@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 84d7a4470dbac0dd9389050100b54a1625d04264 ]

"header->number" can be up to USHRT_MAX and it comes from the ioctl so
it needs to be capped.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/isa/wavefront/wavefront_synth.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/isa/wavefront/wavefront_synth.c b/sound/isa/wavefront/wavefront_synth.c
index 69f76ff5693d..718d5e3b7806 100644
--- a/sound/isa/wavefront/wavefront_synth.c
+++ b/sound/isa/wavefront/wavefront_synth.c
@@ -785,6 +785,9 @@ wavefront_send_patch (snd_wavefront_t *dev, wavefront_patch_info *header)
 	DPRINT (WF_DEBUG_LOAD_PATCH, "downloading patch %d\n",
 				      header->number);
 
+	if (header->number >= ARRAY_SIZE(dev->patch_status))
+		return -EINVAL;
+
 	dev->patch_status[header->number] |= WF_SLOT_FILLED;
 
 	bptr = buf;
@@ -809,6 +812,9 @@ wavefront_send_program (snd_wavefront_t *dev, wavefront_patch_info *header)
 	DPRINT (WF_DEBUG_LOAD_PATCH, "downloading program %d\n",
 		header->number);
 
+	if (header->number >= ARRAY_SIZE(dev->prog_status))
+		return -EINVAL;
+
 	dev->prog_status[header->number] = WF_SLOT_USED;
 
 	/* XXX need to zero existing SLOT_USED bit for program_status[i]
@@ -898,6 +904,9 @@ wavefront_send_sample (snd_wavefront_t *dev,
 		header->number = x;
 	}
 
+	if (header->number >= WF_MAX_SAMPLE)
+		return -EINVAL;
+
 	if (header->size) {
 
 		/* XXX it's a debatable point whether or not RDONLY semantics
-- 
2.19.1



