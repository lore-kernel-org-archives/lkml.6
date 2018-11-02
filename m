Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6948FC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D22820848
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ow7nwM9d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D22820848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730809AbeKCEAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:00:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:56358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbeKCEAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:00:32 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 531012084A;
        Fri,  2 Nov 2018 18:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184737;
        bh=Zk8VdP6Z8UoLaD9eCfSnB/AN992Amv8su2BXWEU/aEI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ow7nwM9dhwleLNPzd4xwI8hEJBLcWasqdZv50m+k2KVk2uIoiPZ6X+qViBkio2ux8
         fjeVN1+ASJdJxvleEDl4ynJ2DIBik4qVoe7NILq7OPgdcrqzHRnfhlIpLQCk3kTTRX
         B6ue6SdPn72u4CLWIumtlkqBEURolvajNuwoQATw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Govindarajulu Varadarajan <gvaradar@cisco.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 084/143] enic: do not overwrite error code
Date:   Fri,  2 Nov 2018 19:34:29 +0100
Message-Id: <20181102182904.393997109@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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



