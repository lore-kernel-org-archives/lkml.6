Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0261EC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBBC72083C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:06:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBBC72083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ubuntu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbeHaQN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 12:13:58 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57632 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbeHaQN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 12:13:58 -0400
Received: from mail-pl1-f199.google.com ([209.85.214.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <anthony.wong@canonical.com>)
        id 1fviCN-0002Px-NK
        for linux-kernel@vger.kernel.org; Fri, 31 Aug 2018 12:06:47 +0000
Received: by mail-pl1-f199.google.com with SMTP id bg5-v6so5942382plb.20
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 05:06:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id;
        bh=Eac9dLNtG/6uDHozOoONEh0nwgSKKi/qjb8+t3n7HD4=;
        b=gTnvUpCWnd9zmY3YjrJCrd/Q7Gl55dgUaNYDaC2LFSjajLjkkRToprVcSAIUONjOUP
         2vVxxUbfvVsW55VIkqMsizgHQdalMF3gmIfGtCNwQtIGBybKwU58Dj55VqI2B0F1Fxdl
         3wFZyRU8ltCPoitvcKk84cP2izhDn6ZLhY6KDu/nZyMuEqeo4bVGNLqr0YOixgGCB0Cs
         anRnNLfgHVsZixntw1+/EAkyKZE4jBZiKBC0PIjL6tMFyIUmghp5e7sg3skzJXPn/+wB
         WB/p5WCH1CuA5lQuhXEGGQ9hBJxXiYSUUKe8yDAxc9EXv2jmfnCme2OMu9mmOR9+2+TO
         IcMg==
X-Gm-Message-State: APzg51BGKJ3hmTq/TCgl+ocrH8mzd6MqwjTkaYtFGNJKqj7rrlAQbzC3
        /YVbOAMNN+r2bFuocTeWf8WXzrv+OfI5rPEcbvdc4EZHE5Sn1Q1Sld5UWhr/UtH51eSKZY007Hq
        fTuWKbgXpb/Z+BAMPo6Xy7Xh5bVUOooZKrhH4D8wC6A==
X-Received: by 2002:a17:902:74ca:: with SMTP id f10-v6mr15242315plt.260.1535717206341;
        Fri, 31 Aug 2018 05:06:46 -0700 (PDT)
X-Google-Smtp-Source: ANB0VdawtQHkHq+zPWanIoAHS31v5ybouA1gZK/XIDyrygmwiLRPLaNjzn3UMM6DXlWWP9YMkSjlrQ==
X-Received: by 2002:a17:902:74ca:: with SMTP id f10-v6mr15242287plt.260.1535717206087;
        Fri, 31 Aug 2018 05:06:46 -0700 (PDT)
Received: from canonical.com (li1734-10.members.linode.com. [172.104.124.10])
        by smtp.gmail.com with ESMTPSA id o21-v6sm16147655pfi.165.2018.08.31.05.06.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 05:06:45 -0700 (PDT)
From:   Anthony Wong <anthony.wong@ubuntu.com>
To:     nic_swsd@realtek.com, bhelgaas@google.com, netdev@vger.kernel.org,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH] r8169: add support for NCube 8168 network card
Date:   Fri, 31 Aug 2018 20:06:42 +0800
Message-Id: <1535717202-26397-1-git-send-email-anthony.wong@ubuntu.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This card identifies itself as:
  Ethernet controller [0200]: NCube Device [10ff:8168] (rev 06)
  Subsystem: TP-LINK Technologies Co., Ltd. Device [7470:3468]

Adding a new entry to rtl8169_pci_tbl makes the card work.

Link: http://launchpad.net/bugs/1788730
Cc: <stable@vger.kernel.org>
Signed-off-by: Anthony Wong <anthony.wong@ubuntu.com>
---
 drivers/net/ethernet/realtek/r8169.c | 1 +
 include/linux/pci_ids.h              | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
index ac30679..b08d51b 100644
--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -218,6 +218,7 @@ static const struct pci_device_id rtl8169_pci_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_REALTEK,	0x8161), 0, 0, RTL_CFG_1 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_REALTEK,	0x8167), 0, 0, RTL_CFG_0 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_REALTEK,	0x8168), 0, 0, RTL_CFG_1 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NCUBE,	0x8168), 0, 0, RTL_CFG_1 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_REALTEK,	0x8169), 0, 0, RTL_CFG_0 },
 	{ PCI_VENDOR_ID_DLINK,			0x4300,
 		PCI_VENDOR_ID_DLINK, 0x4b10,		 0, 0, RTL_CFG_1 },
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 6656286..d4afd80 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -3088,4 +3088,6 @@
 
 #define PCI_VENDOR_ID_OCZ		0x1b85
 
+#define PCI_VENDOR_ID_NCUBE		0x10ff
+
 #endif /* _LINUX_PCI_IDS_H */
-- 
2.7.4

