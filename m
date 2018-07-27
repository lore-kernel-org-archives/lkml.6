Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC2AC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F39F20893
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iT1Aw/tH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F39F20893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730416AbeG0JnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 05:43:25 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:46672 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730189AbeG0JnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 05:43:25 -0400
Received: by mail-pl0-f66.google.com with SMTP id t17-v6so1998241ply.13;
        Fri, 27 Jul 2018 01:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/gzMd54Ec+OtZaWMQabcpGO3Adpp6UPzv3QK9xSICBM=;
        b=iT1Aw/tHcOrtcvZTWUUffBXO61lXo8j9RsD3zivpcsABkx471mCgVzWQ3E+TPox6zH
         znfNN73ogmlyWH5jQr13cKH/bP4GXYO/0bgwU7H1XaiXSq9h7Lczw/T9JVosVCXv2IkP
         tWArHaGeDdIQoTTlkplXvLUbzQNvEJaXQ47LSF+/6NxRgKmhTWawEzF/eugtRBwtlzt1
         t7QZ7LgJipNRBAjY5QQJjuRHmBmF96wMQinVO6qt8QXU6aUM5TxdRWDa6hb37FnOZgfU
         gE7zaIpjbCozWm0ijVCYWXbMHo3umOHEwfYDfEWDTcP4yzAjWeO7aN/SW+guGy4eUTn3
         fC0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/gzMd54Ec+OtZaWMQabcpGO3Adpp6UPzv3QK9xSICBM=;
        b=udYGIN3mMeTBt97olk7kpcDfH7X0G1UCfma6VUMIIh0r/t3oh37U6t+sBwdaqm2Wuv
         q4uRBqwvIGz+4vNW5zZr42NU+RaXX9xhzs7g5wv40W1DSZBtdwmoHzeIJHXBbQstN68A
         ghaGLA/NXD5NGPd7tt2JeqAY0yD/e6ZnHQFKEG4TkleAMh8PvAQ3IaJ2OLWFZJoxs1gz
         5S/umzQn7WNIgUH1UsafIYsZT2UuOi7L+sGtNSPeq4v1c3awT9yE/Gei/rVTnZiEFj9F
         R8cQZoLkAQy0UPAQWxFSUgqF/miuNt0nET4P2fY/4CSSjZbmPmpVpFCKmOzD1sTg2tLe
         BTCw==
X-Gm-Message-State: AOUpUlHypgv9E26Ugs1JCFpYtduxVqzfnYFoVgPTXJkyfy9mlaNDOHeN
        t8DfUrmWZ/935KgQOcATbMaa1Ee/
X-Google-Smtp-Source: AAOMgpcppLIQ8h6bhdFicM/GXHwGJlnqyA/0iF+82wSFCSzUKgVDE/XUnfu9a8qQiIPgTu9Kf34lvw==
X-Received: by 2002:a17:902:28a4:: with SMTP id f33-v6mr5043668plb.297.1532679758992;
        Fri, 27 Jul 2018 01:22:38 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:6c14:7712:e625:1be4])
        by smtp.gmail.com with ESMTPSA id d132-v6sm4573023pga.10.2018.07.27.01.22.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 01:22:38 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     jeffrey.t.kirsher@intel.com
Cc:     intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] net: intel: ixgbe: Replace GFP_ATOMIC with GFP_KERNEL
Date:   Fri, 27 Jul 2018 16:22:31 +0800
Message-Id: <20180727082231.3798-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ixgbe_fcoe_ddp_setup(), ixgbe_setup_fcoe_ddp_resources() and 
ixgbe_sw_init() are never called in atomic context.
They call kmalloc(), dma_pool_alloc() and kzalloc() with GFP_ATOMIC, 
which is not necessary.
GFP_ATOMIC can be replaced with GFP_KERNEL.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c | 4 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
index 7a09a40e4472..ff7ed77ce224 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
@@ -217,7 +217,7 @@ static int ixgbe_fcoe_ddp_setup(struct net_device *netdev, u16 xid,
 	}
 
 	/* alloc the udl from per cpu ddp pool */
-	ddp->udl = dma_pool_alloc(ddp_pool->pool, GFP_ATOMIC, &ddp->udp);
+	ddp->udl = dma_pool_alloc(ddp_pool->pool, GFP_KERNEL, &ddp->udp);
 	if (!ddp->udl) {
 		e_err(drv, "failed allocated ddp context\n");
 		goto out_noddp_unmap;
@@ -785,7 +785,7 @@ int ixgbe_setup_fcoe_ddp_resources(struct ixgbe_adapter *adapter)
 		return 0;
 
 	/* Extra buffer to be shared by all DDPs for HW work around */
-	buffer = kmalloc(IXGBE_FCBUFF_MIN, GFP_ATOMIC);
+	buffer = kmalloc(IXGBE_FCBUFF_MIN, GFP_KERNEL);
 	if (!buffer)
 		return -ENOMEM;
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index afadba99f7b8..fe4a6125576d 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -6138,7 +6138,7 @@ static int ixgbe_sw_init(struct ixgbe_adapter *adapter,
 
 	adapter->mac_table = kzalloc(sizeof(struct ixgbe_mac_addr) *
 				     hw->mac.num_rar_entries,
-				     GFP_ATOMIC);
+				     GFP_KERNEL);
 	if (!adapter->mac_table)
 		return -ENOMEM;
 
-- 
2.17.0

