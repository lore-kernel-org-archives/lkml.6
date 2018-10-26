Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2442C46475
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 03:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 467962082E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 03:15:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 467962082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbeJZLux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 07:50:53 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13695 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725754AbeJZLux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 07:50:53 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EB6A8C389567E;
        Fri, 26 Oct 2018 11:15:36 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.96) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.408.0; Fri, 26 Oct 2018
 11:15:36 +0800
To:     <rasesh.mody@qlogic.com>, <netdev@vger.kernel.org>,
        <f.fainelli@gmail.com>, <andrew@lunn.ch>,
        <linux-kernel@vger.kernel.org>
From:   maowenan <maowenan@huawei.com>
Subject: bnx2: rx_fw_discards: BCM5716 sporadically drops packets when update
 to driver version 2.2.6
Message-ID: <1a94796f-1760-f332-46f0-6ab0b5a0aab7@huawei.com>
Date:   Fri, 26 Oct 2018 11:15:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.96.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi，

After I update version of bnx2 driver from 2.2.1 to 2.2.6, I find BCM5716 sporadically drops packets, which
shows in rx_fw_discards.
C36-141-5:~ #  ethtool -S NIC0

NIC statistics:
     rx_ucast_packets: 11902

     rx_mcast_packets: 217

     rx_bcast_packets: 4954320

     rx_filtered_packets: 328793

     rx_fw_discards: 2742

C36-141-5:~ #

5s later:

C36-141-5:~ #  ethtool -S NIC0

NIC statistics:
     rx_ucast_packets: 11910

     rx_mcast_packets: 217

     rx_bcast_packets: 4958117

     rx_filtered_packets: 328897

     rx_fw_discards: 2750

C36-141-5:~ #

so rx_fw_discards: 2742-----> rx_fw_discards: 2750, lost 8 packets.

the information of bnx2
C36-141-5:~ # modinfo bnx2
kernel/drivers/net/ethernet/broadcom/bnx2.ko

firmware:       bnx2/bnx2-rv2p-09ax-6.0.17.fw

firmware:       bnx2/bnx2-rv2p-09-6.0.17.fw

firmware:       bnx2/bnx2-mips-09-6.2.1b.fw

firmware:       bnx2/bnx2-rv2p-06-6.0.15.fw

firmware:       bnx2/bnx2-mips-06-6.2.3.fw
version:        2.2.6


1) Firstly, I check the patches from 2.2.1 to 2.2.6, below patch is interesting.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0021850d0417a4dc38ed871d929b651b87e2ead9
Do not enable filter SORT MODE in chip init routine. This patch addresses an
issue where BCM5716 sporadically drops packets when changing multicast list.

diff --git a/drivers/net/ethernet/broadcom/bnx2.c b/drivers/net/ethernet/broadcom/bnx2.c
index 8957eb5f4478..8c9a8b7787d2 100644
--- a/drivers/net/ethernet/broadcom/bnx2.c
+++ b/drivers/net/ethernet/broadcom/bnx2.c
@@ -4984,8 +4984,6 @@ bnx2_init_chip(struct bnx2 *bp)

 	bp->idle_chk_status_idx = 0xffff;

-	bp->rx_mode = BNX2_EMAC_RX_MODE_SORT_MODE;
-
 	/* Set up how to generate a link change interrupt. */
 	BNX2_WR(bp, BNX2_EMAC_ATTENTION_ENA, BNX2_EMAC_ATTENTION_ENA_LINK);


2) Secondly, I revert this patch, after verify it, I find rx_fw_discards does not increasing.
so I think this patch can fix current issue. But I'm not sure the issue of this patch to fix
will be reproduced?
I'm not convinced that what factor will trigger rx_fw_discards increasing?
And how to fix this?

Thanks a lot.












