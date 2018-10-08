Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F08C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 032872064A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ux7peitx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 032872064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731322AbeJICAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:00:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:48534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727510AbeJICAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:00:08 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EFC32064A;
        Mon,  8 Oct 2018 18:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024422;
        bh=D81P50hhM4xRL2htHpotgICtZIu+XEDMxZFZPAT81K4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ux7peitxPl9QC5mFh6tQ0f84MYljYMp9x6/ZhUQs9FnKrXOzBXgV2preA5RQBBAVO
         IHHfR7qGKEF1UVFPv7hJPJP/Fy1ETtCMlXn5oMLcSnSTpxdK9YXVn0Cn6qjwyiZulR
         2DCIBWvkW6Wrvs9axw6pQBthGIOrWIAZfw3ZeM7s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peng Li <lipeng321@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 033/168] net: hns: add netif_carrier_off before change speed and duplex
Date:   Mon,  8 Oct 2018 20:30:13 +0200
Message-Id: <20181008175621.304668362@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peng Li <lipeng321@huawei.com>

[ Upstream commit 455c4401fe7a538facaffb35b906ce19f1ece474 ]

If there are packets in hardware when changing the speed
or duplex, it may cause hardware hang up.

This patch adds netif_carrier_off before change speed and
duplex in ethtool_ops.set_link_ksettings, and adds
netif_carrier_on after complete the change.

Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
@@ -243,7 +243,9 @@ static int hns_nic_set_link_ksettings(st
 	}
 
 	if (h->dev->ops->adjust_link) {
+		netif_carrier_off(net_dev);
 		h->dev->ops->adjust_link(h, (int)speed, cmd->base.duplex);
+		netif_carrier_on(net_dev);
 		return 0;
 	}
 


