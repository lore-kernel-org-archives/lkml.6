Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64E4C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95DF52151D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:57:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95DF52151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390666AbeHGVNN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:13:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34548 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389192AbeHGVNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:13:12 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E28CB74;
        Tue,  7 Aug 2018 18:57:24 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhouyang Jia <jiazhouyang09@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 06/85] ALSA: fm801: add error handling for snd_ctl_add
Date:   Tue,  7 Aug 2018 20:51:08 +0200
Message-Id: <20180807172357.591294207@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807172357.357252052@linuxfoundation.org>
References: <20180807172357.357252052@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhouyang Jia <jiazhouyang09@gmail.com>

[ Upstream commit ef1ffbe7889e99f5b5cccb41c89e5c94f50f3218 ]

When snd_ctl_add fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling snd_ctl_add.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/fm801.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

--- a/sound/pci/fm801.c
+++ b/sound/pci/fm801.c
@@ -1070,11 +1070,19 @@ static int snd_fm801_mixer(struct fm801
 		if ((err = snd_ac97_mixer(chip->ac97_bus, &ac97, &chip->ac97_sec)) < 0)
 			return err;
 	}
-	for (i = 0; i < FM801_CONTROLS; i++)
-		snd_ctl_add(chip->card, snd_ctl_new1(&snd_fm801_controls[i], chip));
+	for (i = 0; i < FM801_CONTROLS; i++) {
+		err = snd_ctl_add(chip->card,
+			snd_ctl_new1(&snd_fm801_controls[i], chip));
+		if (err < 0)
+			return err;
+	}
 	if (chip->multichannel) {
-		for (i = 0; i < FM801_CONTROLS_MULTI; i++)
-			snd_ctl_add(chip->card, snd_ctl_new1(&snd_fm801_controls_multi[i], chip));
+		for (i = 0; i < FM801_CONTROLS_MULTI; i++) {
+			err = snd_ctl_add(chip->card,
+				snd_ctl_new1(&snd_fm801_controls_multi[i], chip));
+			if (err < 0)
+				return err;
+		}
 	}
 	return 0;
 }


