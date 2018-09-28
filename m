Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950FCC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B1A020652
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:42:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B1A020652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbeI1VGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 17:06:44 -0400
Received: from a2nlsmtp01-02.prod.iad2.secureserver.net ([198.71.225.36]:37394
        "EHLO a2nlsmtp01-02.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726473AbeI1VGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 17:06:44 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id 5txZgoMGOM0DP5txZgX4G6; Fri, 28 Sep 2018 07:41:37 -0700
x-originating-ip: 107.180.71.197
Received: from haiyangz by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <haiyangz@linuxonhyperv2.linuxonhyperv.com>)
        id 1g5txZ-000375-7o; Fri, 28 Sep 2018 07:41:37 -0700
From:   Haiyang Zhang <haiyangz@linuxonhyperv.com>
To:     davem@davemloft.net, netdev@vger.kernel.org
Cc:     haiyangz@microsoft.com, kys@microsoft.com, sthemmin@microsoft.com,
        olaf@aepfle.de, vkuznets@redhat.com, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next] hv_netvsc: Fix rndis_per_packet_info internal field initialization
Date:   Fri, 28 Sep 2018 14:41:23 +0000
Message-Id: <20180928144123.11926-1-haiyangz@linuxonhyperv.com>
X-Mailer: git-send-email 2.18.0
Reply-To: haiyangz@microsoft.com
X-CMAE-Envelope: MS4wfI3mVWiHsa0E6pA/GDlXFR653jfUxSVxblp2rP6BNPbNkOsIDEY9XP/M2/Z5sI9i5xaB7wP7Q92OfzvyXwv04+gUz3i8q99m2f/I+zn5ZO9VN9j1U5rx
 WFO1dVHDhguiT6PVMit+/t4pvsL1ug0QTcw0uwX8RDnDw55JauFUZUHxbCyfGqPxuV5TdGgKd/83qJqHN7Dwvs6pS/vPN6/SPCi9PvkgElAlQZ+fYl3ycgz7
 j3M2Yjlp71roucIk+C0gbu8TiTgZTR9RbppyXI0yfEgl0DlAX7HIWheJQC3RLcGRh7s7cB9oeJMvFAhIWuB8m/DcY8AWpEUV6RCsrbRGAro7FDzxnyNdlKtX
 CTF8Da2fnvS/7GpkFWw/zQFIWZ+d+tM7RwrHhBNp3WrGCr9a2HOD3ktb2sVlNFirEyk4f6j/DQO37Zh1Cvm1Z42PEvbQ3LldCEZHN+BcfUI8P9sfjhQeqgow
 f1f52dOWxkbYZ5WM0GyR72Yr6s5PqcxioLNhmA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haiyang Zhang <haiyangz@microsoft.com>

The RSC feature -- a bit field "internal" was added here with total
size unchanged:
struct rndis_per_packet_info {
	u32 size;
	u32 type:31;
	u32 internal:1;
	u32 ppi_offset;
};

On TX path, we put rndis msg into skb head room, which is not zeroed
before passing to us. We do not use the "internal" field in TX path,
but it may impact older hosts which use the entire 32 bits as "type".

To fix the bug, this patch sets the field "internal" to zero.

Fixes: c8e4eff4675f ("hv_netvsc: Add support for LRO/RSC in the vSwitch")
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/net/hyperv/netvsc_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index ec699741170b..005cbaa2fa3b 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -226,6 +226,7 @@ static inline void *init_ppi_data(struct rndis_message *msg,
 
 	ppi->size = ppi_size;
 	ppi->type = pkt_type;
+	ppi->internal = 0;
 	ppi->ppi_offset = sizeof(struct rndis_per_packet_info);
 
 	rndis_pkt->per_pkt_info_len += ppi_size;
-- 
2.18.0

