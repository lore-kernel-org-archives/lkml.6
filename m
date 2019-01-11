Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8573C43612
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E36B21841
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217419;
	bh=12yyh5T0jJ13Ig6oSg/mvn/p79OjC2pGoLvIlf54d2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d9TlUJ4yuv9iAidYuN53I+08AAJQnjEMXCzqXbK3ivkzmZr/s3FCJHmH9WHGvo/3I
	 p96it3LC9iVoM4qBYh8jeLvi0q1IBshTlP5NQMgPjMmrtucQOsS4m1OVuQgtq85U+s
	 wNpgmDe5nLyEFQiiJHpGO19h7s6qvHJE+zHz7DQY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390521AbfAKOg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:36:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:57308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390504AbfAKOgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:36:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55693204EC;
        Fri, 11 Jan 2019 14:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217413;
        bh=12yyh5T0jJ13Ig6oSg/mvn/p79OjC2pGoLvIlf54d2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OCbh3iVtg4AT/A0IEkYxHNhe5OThRbkYBdXShJEvugyJQwXgCGDx0fbKKDw0nVj/o
         vADRWdp3dxVwicIO9VYRRRqOe7iWHSOQboZGCJkIaWdtfIUDII3Ny6K2WLY9SHF88m
         ji7l92Wt6EKXyv8n0ZI5SPYj2DTd0fgDQbdBqIf0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yonglong Liu <liuyonglong@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 050/148] net: hns: Clean rx fbd when ae stopped.
Date:   Fri, 11 Jan 2019 15:13:48 +0100
Message-Id: <20190111131116.273306257@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 31f6b61d810654fb3ef43f4d8afda0f44b142fad ]

If there are packets in hardware when changing the speed or duplex,
it may cause hardware hang up.

This patch adds the code to wait rx fbd clean up when ae stopped.

Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c b/drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c
index b52029e26d15..ad1779fc410e 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c
@@ -379,6 +379,9 @@ static void hns_ae_stop(struct hnae_handle *handle)
 
 	hns_ae_ring_enable_all(handle, 0);
 
+	/* clean rx fbd. */
+	hns_rcb_wait_fbd_clean(handle->qs, handle->q_num, RCB_INT_FLAG_RX);
+
 	(void)hns_mac_vm_config_bc_en(mac_cb, 0, false);
 }
 
-- 
2.19.1



