Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C535C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 550EB2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yhj5ckpf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 550EB2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730840AbeKAIKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:10:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:60486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730817AbeKAIKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:10:05 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FD7620821;
        Wed, 31 Oct 2018 23:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027394;
        bh=uM0kR4w+ZCco6GT3Hu5u94ZHnxpAuJ/AHa3vnguWCDc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yhj5ckpfxXAPjMzXmhbSQJ8HQIf0+fKrQCZlkujL0GojNV8LFtyHeurIRw64tIKBp
         0IweHVgYdX2SWJg1s0n6xKee0mUIr4Ksgw2Ts3iCKWk/l+BAMzPR15K9rbg4g54dlc
         fyq9bN8IO5hWvPbpNxYNIbMADk1YAxBXoLvDXhZU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ryan C Goodfellow <rgoodfel@isi.edu>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 05/73] nfp: devlink port split support for 1x100G CXP NIC
Date:   Wed, 31 Oct 2018 19:08:40 -0400
Message-Id: <20181031230948.29203-5-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230948.29203-1-sashal@kernel.org>
References: <20181031230948.29203-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryan C Goodfellow <rgoodfel@isi.edu>

[ Upstream commit 5948185b97fa1f83d7855e638a72982a1073ebf5 ]

This commit makes it possible to use devlink to split the 100G CXP
Netronome into two 40G interfaces. Currently when you ask for 2
interfaces, the math in src/nfp_devlink.c:nfp_devlink_port_split
calculates that you want 5 lanes per port because for some reason
eth_port.port_lanes=10 (shouldn't this be 12 for CXP?). What we really
want when asking for 2 breakout interfaces is 4 lanes per port. This
commit makes that happen by calculating based on 8 lanes if 10 are
present.

Signed-off-by: Ryan C Goodfellow <rgoodfel@isi.edu>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reviewed-by: Greg Weeks <greg.weeks@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/netronome/nfp/nfp_devlink.c    | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_devlink.c b/drivers/net/ethernet/netronome/nfp/nfp_devlink.c
index 6c9f29c2e975..90a6c4fbc113 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_devlink.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_devlink.c
@@ -96,6 +96,7 @@ nfp_devlink_port_split(struct devlink *devlink, unsigned int port_index,
 {
 	struct nfp_pf *pf = devlink_priv(devlink);
 	struct nfp_eth_table_port eth_port;
+	unsigned int lanes;
 	int ret;
 
 	if (count < 2)
@@ -114,8 +115,12 @@ nfp_devlink_port_split(struct devlink *devlink, unsigned int port_index,
 		goto out;
 	}
 
-	ret = nfp_devlink_set_lanes(pf, eth_port.index,
-				    eth_port.port_lanes / count);
+	/* Special case the 100G CXP -> 2x40G split */
+	lanes = eth_port.port_lanes / count;
+	if (eth_port.lanes == 10 && count == 2)
+		lanes = 8 / count;
+
+	ret = nfp_devlink_set_lanes(pf, eth_port.index, lanes);
 out:
 	mutex_unlock(&pf->lock);
 
@@ -127,6 +132,7 @@ nfp_devlink_port_unsplit(struct devlink *devlink, unsigned int port_index)
 {
 	struct nfp_pf *pf = devlink_priv(devlink);
 	struct nfp_eth_table_port eth_port;
+	unsigned int lanes;
 	int ret;
 
 	mutex_lock(&pf->lock);
@@ -142,7 +148,12 @@ nfp_devlink_port_unsplit(struct devlink *devlink, unsigned int port_index)
 		goto out;
 	}
 
-	ret = nfp_devlink_set_lanes(pf, eth_port.index, eth_port.port_lanes);
+	/* Special case the 100G CXP -> 2x40G unsplit */
+	lanes = eth_port.port_lanes;
+	if (eth_port.port_lanes == 8)
+		lanes = 10;
+
+	ret = nfp_devlink_set_lanes(pf, eth_port.index, lanes);
 out:
 	mutex_unlock(&pf->lock);
 
-- 
2.17.1

