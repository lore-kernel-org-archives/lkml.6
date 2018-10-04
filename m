Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEEDC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 548F020684
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=herochao.de header.i=@herochao.de header.b="LhHGPF41"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 548F020684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=herochao.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbeJDVoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 17:44:13 -0400
Received: from mail.huaman.de ([88.99.34.23]:39304 "EHLO mail.huaman.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727380AbeJDVoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 17:44:13 -0400
X-Greylist: delayed 475 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Oct 2018 17:44:11 EDT
Received: from localhost.localdomain (ip5f5acd5e.dynamic.kabel-deutschland.de [95.90.205.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: nicolas@herochao.de)
        by mail.huaman.de (Postfix) with ESMTPSA id E1F331A1570;
        Thu,  4 Oct 2018 16:42:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=herochao.de; s=dkim;
        t=1538664159; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=mZdWCnvNL5gApRumXk9wNEFbyyBurInk+2sLVXpNzn4=;
        b=LhHGPF41n91DlQ5IqSd4NVTgeGnYmQST4AXXXCgmlgXsIVO3caRUxCwrASH9v5OWOeaElm
        xhjhvYwhkW4ktIUDjVDCyV+YmJk/JFTmKm6QYvsz4ci6Oa+6ulxYZuzBt1LPUNBkuoGxwt
        09hKXL7k9HTRcQR7W4U52SkQbQrgGjY=
From:   Nicolas Huaman <nicolas@herochao.de>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Nicolas Huaman <nicolas@herochao.de>
Subject: [PATCH] ALSA: usb-audio: update quirk for B&W PX to remove microphone
Date:   Thu,  4 Oct 2018 16:42:05 +0200
Message-Id: <20181004144205.18153-1-nicolas@herochao.de>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=herochao.de;
        s=dkim; t=1538664159; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=mZdWCnvNL5gApRumXk9wNEFbyyBurInk+2sLVXpNzn4=;
        b=gOqRS8xeXkDhw4O7gTaPLhzuiH9ZPIpuA03MCSWvhzwDz3ZBUBAl5fP+fNtZArnBNkYMXT
        WWKxT99QGgq0T26f/TzjyxcR9SkYoePf7IC0noMkXcAM/9a1UTB++loiQSUfI4AVRGwM+/
        QST6YHdf2GKOoOVZp8RYxyNcB8u1m9A=
ARC-Seal: i=1; s=dkim; d=herochao.de; t=1538664159; a=rsa-sha256; cv=none;
        b=MzdB0/89T2LRJ4cFRodVC7fFRWhUTAUTwm+hHLD4wpzVWfjkproIt8EZFpVX9asbh3RtFci2zCBOcy7Po6Oup1YPIeuR5rsaAt8SCJ6AmKhD8ZyTfz/soMVUlfWTnmRi00+kDJO3iRQ1xZ+jhqlkHAA7IzYhabFAJ6pYO+5Cq0Y=
ARC-Authentication-Results: i=1;
        mail.huaman.de;
        auth=pass smtp.auth=nicolas@herochao.de smtp.mailfrom=nicolas@herochao.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A quirk in snd-usb-audio was added to automate setting sample rate to
4800k and remove the previously exposed nonfunctional microphone for 
the Bowers & Wilkins PX:
commit 240a8af929c7c57dcde28682725b29cf8474e8e5
https://lore.kernel.org/patchwork/patch/919689/

However the headphones where updated shortly after that to remove the
unintentional microphone functionality. I guess because of this the
headphones now crash when connecting them via USB while the quirk is
active. Dmesg:

snd-usb-audio: probe of 2-3:1.0 failed with error -22
usb 2-3: 2:1: cannot get min/max values for control 2 (id 2)

This patch removes the microfone and allows the headphones to connect 
and work out of the box. It is based on the current mainline kernel 
 and successfully applied an tested on my machine (4.18.10.arch1-1).

Signed-off-by: Nicolas Huaman <nicolas@herochao.de>
---
 sound/usb/quirks-table.h | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 08aa78007020..849953e5775c 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -3346,19 +3346,14 @@ AU0828_DEVICE(0x2040, 0x7270, "Hauppauge", "HVR-950Q"),
 				.ifnum = 0,
 				.type = QUIRK_AUDIO_STANDARD_MIXER,
 			},
-			/* Capture */
-			{
-				.ifnum = 1,
-				.type = QUIRK_IGNORE_INTERFACE,
-			},
 			/* Playback */
 			{
-				.ifnum = 2,
+				.ifnum = 1,
 				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
 				.data = &(const struct audioformat) {
 					.formats = SNDRV_PCM_FMTBIT_S16_LE,
 					.channels = 2,
-					.iface = 2,
+					.iface = 1,
 					.altsetting = 1,
 					.altset_idx = 1,
 					.attributes = UAC_EP_CS_ATTR_FILL_MAX |
-- 
2.19.0

