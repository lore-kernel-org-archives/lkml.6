Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4C7ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 03:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B12262077B
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 03:03:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B12262077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=angband.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731667AbeGRDj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 23:39:26 -0400
Received: from tartarus.angband.pl ([89.206.35.136]:37784 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731295AbeGRDjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 23:39:25 -0400
Received: from 89-71-158-145.dynamic.chello.pl ([89.71.158.145] helo=umbar.angband.pl)
        by tartarus.angband.pl with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <kilobyte@angband.pl>)
        id 1ffckZ-0007zO-4n; Wed, 18 Jul 2018 05:03:39 +0200
Received: from kilobyte by umbar.angband.pl with local (Exim 4.91)
        (envelope-from <kilobyte@umbar.angband.pl>)
        id 1ffckY-0000AT-Pj; Wed, 18 Jul 2018 05:03:34 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-console@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Adam Borowski <kilobyte@angband.pl>
Date:   Wed, 18 Jul 2018 05:03:26 +0200
Message-Id: <20180718030327.579-5-kilobyte@angband.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180718030327.579-1-kilobyte@angband.pl>
References: <20180718030152.kdq53mwpdfusvwl5@angband.pl>
 <20180718030327.579-1-kilobyte@angband.pl>
X-SA-Exim-Connect-IP: 89.71.158.145
X-SA-Exim-Mail-From: kilobyte@angband.pl
Subject: [PATCH 5/6] vt: compensate for brightening the 256-color palette
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on tartarus.angband.pl)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The algorithm for 256-to-16 conversion was designed with wrong input
palette but actually tuned on mainstream GUI terminals.  This resulted in
something that works well only for data we convert ourselves (ie, 256 not
24-bit).

As the change is non-linear, I did not bother replicating it exactly, thus
there are some differences, among others:
* values very close to black go to 0 (black) rather than 8 (dark grey)
* grayscale ramp is more even

A comparison of the old vs new vs FreeBSD's teken is at:
https://github.com/kilobyte/colorkernel

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 drivers/tty/vt/vt.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 8c61caafdf3c..c777f4c91df0 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1559,17 +1559,17 @@ static void rgb_foreground(struct vc_data *vc, const struct rgb *c)
 {
 	u8 hue = 0, max = max3(c->r, c->g, c->b);
 
-	if (c->r > max / 2)
+	if (c->r > max / 2 + 32)
 		hue |= 4;
-	if (c->g > max / 2)
+	if (c->g > max / 2 + 32)
 		hue |= 2;
-	if (c->b > max / 2)
+	if (c->b > max / 2 + 32)
 		hue |= 1;
 
-	if (hue == 7 && max <= 0x55) {
+	if (hue == 7 && max <= 0x70) {
 		hue = 0;
 		vc->vc_intensity = 2;
-	} else if (max > 0xaa)
+	} else if (max > 0xc0)
 		vc->vc_intensity = 2;
 	else
 		vc->vc_intensity = 1;
-- 
2.18.0

