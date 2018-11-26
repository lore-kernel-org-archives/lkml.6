Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5554C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABE4F2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zlViChRk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABE4F2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731557AbeKZWAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 17:00:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:46846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729543AbeKZWAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 17:00:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2446620645;
        Mon, 26 Nov 2018 11:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230382;
        bh=saohxsP9pObiHYLkTJpS582mfNLXaIsBv8yc+ef2yTM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zlViChRkgxe/dVlLayl9zqffEvCIEekLr9Q1IbjSVF8B+LEzn9uaMOvrxXtrhMtnm
         zI7C7AE35PJeqtYlrz7husX1iPgipHkfZRaq1ah3ku6qYe99Ik3odx+X1QHkMrSbVQ
         WWvJpw+ibN7kNy4Ds2IE1njGSLHCHOIjEzxk3Ig0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 080/118] i40e: restore NETIF_F_GSO_IPXIP[46] to netdev features
Date:   Mon, 26 Nov 2018 11:51:14 +0100
Message-Id: <20181126105104.873110907@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105059.832485122@linuxfoundation.org>
References: <20181126105059.832485122@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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



