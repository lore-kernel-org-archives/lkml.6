Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F79EC282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16FE2222C1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uZggyscE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733226AbfBMCCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:02:41 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54640 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728534AbfBMCCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:02:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kcz9f5+50zys83eIS0vRL1OcfBPDJmdMaWMyZpyOHus=; b=uZggyscEOmGW2cRDl4iELgDwU
        jsZBYwDC5pLHznEunpsZJLejO0VXbrhDRF7iKjLYB4cZMk4D7Ts6SXCxNlFdDxvCqzb5FiiP069pC
        g9yh//Kgq5mADcCBNL4qepOZHrGXiR6DrdJ8iiUBkGp4/lfLh40ZaQWQKdi0UoatfFX7Fkf8x4ifH
        geu19osA9cgSGR/8RXX5NgTE5Cyry7m5LoHqeR6XBorpVBZGLMvcgl4x5Zk/fuCuoV/uo+TP2+ARX
        d5u8AVwWLFk09JKrniXGUSvX75MbFix2sboEzNBmJmowF7uwhR9oj70Shf1xLF4R4Z7YDfsEs++OR
        wBV1QeDgw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtjsl-0007tE-Bs; Wed, 13 Feb 2019 02:02:39 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Mahesh Bandewar <maheshb@google.com>,
        David Miller <davem@davemloft.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] net: ipvlan_l3s: fix kconfig unmet dependency warning
Message-ID: <c2d5e413-01c8-8da4-aa67-9517a9518a68@infradead.org>
Date:   Tue, 12 Feb 2019 18:02:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix the kconfig warning in IPVLAN_L3S when neither INET nor IPV6
is enabled:

WARNING: unmet direct dependencies detected for NET_L3_MASTER_DEV
  Depends on [n]: NET [=y] && (INET [=n] || IPV6 [=n])
  Selected by [y]:
  - IPVLAN_L3S [=y] && NETDEVICES [=y] && NET_CORE [=y] && NETFILTER [=y]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Mahesh Bandewar <maheshb@google.com>
---
Seen in mmotm but applies to linux-next.

 drivers/net/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- mmotm-2019-0212-1537.orig/drivers/net/Kconfig
+++ mmotm-2019-0212-1537/drivers/net/Kconfig
@@ -147,6 +147,7 @@ config MACVTAP
 
 config IPVLAN_L3S
 	depends on NETFILTER
+	depends on INET || IPV6 # same as NET_L3_MASTER_DEV
 	def_bool y
 	select NET_L3_MASTER_DEV
 


