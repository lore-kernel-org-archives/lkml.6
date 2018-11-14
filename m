Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D1DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0472223DD
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="shZgQUhH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0472223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388089AbeKOIqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:46:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:34470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728990AbeKOI1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:27:25 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 454F12251A;
        Wed, 14 Nov 2018 22:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234142;
        bh=2uBskBgZwF5/JBqfOh1BIgCMobgGLHMtqrqF3NfaFvU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=shZgQUhHgTGs310CgfPf+cnrXBSMt6w/2iKp/FdimF/UXGjfYbp6JDdWnpZAyAwhD
         Z9matPPvhbbp5tdULrrzaXanJyKH+lgmLANYcq2SCtwHoYoJTkiE4ByCflcxWOlUkm
         BILJBb+o83Kc2ySljXwD/Bzdrs2Z1W7aM9XfffMI=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 58/73] i40e: restore NETIF_F_GSO_IPXIP[46] to netdev features
Date:   Wed, 14 Nov 2018 17:21:52 -0500
Message-Id: <20181114222207.98701-58-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222207.98701-1-sashal@kernel.org>
References: <20181114222207.98701-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacob Keller <jacob.e.keller@intel.com>

[ Upstream commit ba766b8b99c30ad3c55ed8cf224d1185ecff1476 ]

Since commit bacd75cfac8a ("i40e/i40evf: Add capability exchange for
outer checksum", 2017-04-06) the i40e driver has not reported support
for IP-in-IP offloads. This likely occurred due to a bad rebase, as the
commit extracts hw_enc_features into its own variable. As part of this
change, it dropped the NETIF_F_FSO_IPXIP flags from the
netdev->hw_enc_features. This was unfortunately not caught during code
review.

Fix this by adding back the missing feature flags.

For reference, NETIF_F_GSO_IPXIP4 was added in commit 7e13318daa4a
("net: define gso types for IPx over IPv4 and IPv6", 2016-05-20),
replacing NETIF_F_GSO_IPIP and NETIF_F_GSO_SIT.

NETIF_F_GSO_IPXIP6 was added in commit bf2d1df39502 ("intel: Add support
for IPv6 IP-in-IP offload", 2016-05-20).

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index ac685ad4d877..6eccfa82ca94 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -11926,6 +11926,8 @@ static int i40e_config_netdev(struct i40e_vsi *vsi)
 			  NETIF_F_GSO_GRE		|
 			  NETIF_F_GSO_GRE_CSUM		|
 			  NETIF_F_GSO_PARTIAL		|
+			  NETIF_F_GSO_IPXIP4		|
+			  NETIF_F_GSO_IPXIP6		|
 			  NETIF_F_GSO_UDP_TUNNEL	|
 			  NETIF_F_GSO_UDP_TUNNEL_CSUM	|
 			  NETIF_F_SCTP_CRC		|
-- 
2.17.1

