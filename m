Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE841ECDFB4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 03:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8487E2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 03:03:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8487E2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=angband.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731704AbeGRDja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 23:39:30 -0400
Received: from tartarus.angband.pl ([89.206.35.136]:37820 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731295AbeGRDj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 23:39:29 -0400
Received: from 89-71-158-145.dynamic.chello.pl ([89.71.158.145] helo=umbar.angband.pl)
        by tartarus.angband.pl with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <kilobyte@angband.pl>)
        id 1ffckY-0007zL-Jp; Wed, 18 Jul 2018 05:03:44 +0200
Received: from kilobyte by umbar.angband.pl with local (Exim 4.91)
        (envelope-from <kilobyte@umbar.angband.pl>)
        id 1ffckY-0000AQ-9S; Wed, 18 Jul 2018 05:03:34 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-console@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Adam Borowski <kilobyte@angband.pl>
Date:   Wed, 18 Jul 2018 05:03:25 +0200
Message-Id: <20180718030327.579-4-kilobyte@angband.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180718030327.579-1-kilobyte@angband.pl>
References: <20180718030152.kdq53mwpdfusvwl5@angband.pl>
 <20180718030327.579-1-kilobyte@angband.pl>
X-SA-Exim-Connect-IP: 89.71.158.145
X-SA-Exim-Mail-From: kilobyte@angband.pl
Subject: [PATCH 4/6] vt: change 256-color palette to match all(?) modern terminals
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on tartarus.angband.pl)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Turns out that osso-xterm which I based upon uses something a lot different
from apparently any other terminal -- they all use identical shades, much
brighter than what I copied:

    Old: 00 2a 55 7f aa d4
    New: 00 5f 87 af d7 ff

This did hardly matter as we immediately shoehorn the colors into only 16
values, but recently 24-bit codes turned from an oddity to something
widespread, thus it's better to handle 256 vs 24-bit consistently.

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 drivers/tty/vt/vt.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 4096093c8cd2..8c61caafdf3c 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1545,9 +1545,12 @@ static void rgb_from_256(int i, struct rgb *c)
 		c->g = i&2 ? 0xff : 0x55;
 		c->b = i&4 ? 0xff : 0x55;
 	} else if (i < 232) {   /* 6x6x6 colour cube. */
-		c->r = (i - 16) / 36 * 85 / 2;
-		c->g = (i - 16) / 6 % 6 * 85 / 2;
-		c->b = (i - 16) % 6 * 85 / 2;
+		int r = (i - 16) / 36;
+		int g = (i - 16) / 6 % 6;
+		int b = (i - 16) % 6;
+		c->r = r ? r * 0x28 + 0x37 : 0;
+		c->g = g ? g * 0x28 + 0x37 : 0;
+		c->b = b ? b * 0x28 + 0x37 : 0;
 	} else                  /* Grayscale ramp. */
 		c->r = c->g = c->b = i * 10 - 2312;
 }
-- 
2.18.0

