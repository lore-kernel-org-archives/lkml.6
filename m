Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7443DC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 22:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA82C2407C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 22:20:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA82C2407C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752970AbeGDWUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 18:20:44 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.182]:17763 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752867AbeGDWUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 18:20:43 -0400
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id 4190C56E1F5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jul 2018 17:20:43 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id aq8hfD9cWaSeyaq8hfrUdR; Wed, 04 Jul 2018 17:20:43 -0500
X-Authority-Reason: nr=8
Received: from [189.250.65.56] (port=58364 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1faq8g-000Ihs-Nk; Wed, 04 Jul 2018 17:20:42 -0500
Date:   Wed, 4 Jul 2018 17:20:41 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     David Airlie <airlied@linux.ie>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] char: amd64-agp: Use 64-bit arithmetic instead of 32-bit
Message-ID: <20180704222041.GA13289@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.65.56
X-Source-L: No
X-Exim-ID: 1faq8g-000Ihs-Nk
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.65.56]:58364
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 8
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cast *tmp* and *nb_base* to u64 in order to give the compiler
complete information about the proper arithmetic to use.

Notice that such variables are used in contexts that expect
expressions of type u64 (64 bits, unsigned) and the following
expressions are currently being evaluated using 32-bit arithmetic:

tmp << 25
nb_base << 25

Addresses-Coverity-ID: 200586 ("Unintentional integer overflow")
Addresses-Coverity-ID: 200587 ("Unintentional integer overflow")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/char/agp/amd64-agp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/agp/amd64-agp.c b/drivers/char/agp/amd64-agp.c
index e50c29c..c69e39f 100644
--- a/drivers/char/agp/amd64-agp.c
+++ b/drivers/char/agp/amd64-agp.c
@@ -156,7 +156,7 @@ static u64 amd64_configure(struct pci_dev *hammer, u64 gatt_table)
 
 	/* Address to map to */
 	pci_read_config_dword(hammer, AMD64_GARTAPERTUREBASE, &tmp);
-	aperturebase = tmp << 25;
+	aperturebase = (u64)tmp << 25;
 	aper_base = (aperturebase & PCI_BASE_ADDRESS_MEM_MASK);
 
 	enable_gart_translation(hammer, gatt_table);
@@ -277,7 +277,7 @@ static int fix_northbridge(struct pci_dev *nb, struct pci_dev *agp, u16 cap)
 	pci_read_config_dword(nb, AMD64_GARTAPERTURECTL, &nb_order);
 	nb_order = (nb_order >> 1) & 7;
 	pci_read_config_dword(nb, AMD64_GARTAPERTUREBASE, &nb_base);
-	nb_aper = nb_base << 25;
+	nb_aper = (u64)nb_base << 25;
 
 	/* Northbridge seems to contain crap. Try the AGP bridge. */
 
-- 
2.7.4

