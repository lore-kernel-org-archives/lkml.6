Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B70ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0A5920869
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOZC2Vn9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0A5920869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbeJYWok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:44:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:53634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728299AbeJYWoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:44:39 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A39C2084A;
        Thu, 25 Oct 2018 14:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476704;
        bh=HKN3oNuGracI+/5GQOIxkiZhHbjLwgVnFvBpx4CA0VY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QOZC2Vn91Tlf4TZqgGJKjyOJ4HBS7ExEMQsOsoE4Dwsnx1XIx1qdlVGHOXSTKWZ1J
         evE4ofWV2YEyNux8eAok7UDrtqEV3bj2otktrTfdtxtmjCOe6lzyfETN6ezIezRhLe
         BHZ3ABv8ut3NFJ1QlvNEbHQOvZG1NxEijoHRuak8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Govindarajulu Varadarajan <gvaradar@cisco.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 35/46] enic: do not overwrite error code
Date:   Thu, 25 Oct 2018 10:10:42 -0400
Message-Id: <20181025141053.213330-35-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141053.213330-1-sashal@kernel.org>
References: <20181025141053.213330-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Govindarajulu Varadarajan <gvaradar@cisco.com>

[ Upstream commit 56f772279a762984f6e9ebbf24a7c829faba5712 ]

In failure path, we overwrite err to what vnic_rq_disable() returns. In
case it returns 0, enic_open() returns success in case of error.

Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Fixes: e8588e268509 ("enic: enable rq before updating rq descriptors")
Signed-off-by: Govindarajulu Varadarajan <gvaradar@cisco.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cisco/enic/enic_main.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index 2bfaf3e118b1..03f4fee1bbc9 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -1879,7 +1879,7 @@ static int enic_open(struct net_device *netdev)
 {
 	struct enic *enic = netdev_priv(netdev);
 	unsigned int i;
-	int err;
+	int err, ret;
 
 	err = enic_request_intr(enic);
 	if (err) {
@@ -1936,10 +1936,9 @@ static int enic_open(struct net_device *netdev)
 
 err_out_free_rq:
 	for (i = 0; i < enic->rq_count; i++) {
-		err = vnic_rq_disable(&enic->rq[i]);
-		if (err)
-			return err;
-		vnic_rq_clean(&enic->rq[i], enic_free_rq_buf);
+		ret = vnic_rq_disable(&enic->rq[i]);
+		if (!ret)
+			vnic_rq_clean(&enic->rq[i], enic_free_rq_buf);
 	}
 	enic_dev_notify_unset(enic);
 err_out_free_intr:
-- 
2.17.1

