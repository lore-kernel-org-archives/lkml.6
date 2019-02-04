Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0D3C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CBD92070C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277298;
	bh=z5oApNHEWTGXr9AiSrV9woXBMAWsMrZ6MK6NhAC4fGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ty+TeMOYDxtzNhsD7hBEAR5CKVKEz9txLVOh66nopnso7A+M/J/VhPPEbjm0kuSlF
	 kNAfl/k/pCfNjWmCl4uQmFQb+Jq41xfQCAv8bdHOLE/kNJDCiec+I7JXVWihQ0zaUg
	 g/PXDzvDXo+ptEzJzA2akaKzL2HQCDxw4JJyB0BY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731804AbfBDKsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:48:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:46300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731777AbfBDKsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:48:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78B1A2070C;
        Mon,  4 Feb 2019 10:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277292;
        bh=z5oApNHEWTGXr9AiSrV9woXBMAWsMrZ6MK6NhAC4fGs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q7jL4PzF/36n+BxlVCIkg4YpXiF9LJ8QClMevUnrWoBaDdvxVlzgobceeTj4mw+Cs
         xr6ZvyTwvrhu7bYxxi2K6o8p3C7OiHBDQVyM7M8Sp6vCMmhWKi+yDT1mJ5fizehvZY
         /QHT+pH4Wsrf9gQhOB1den9nRkPZGmSO9X5tvQZk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aya Levin <ayal@mellanox.com>,
        Eran Ben Elisha <eranbe@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.19 21/74] net/mlx5e: Allow MAC invalidation while spoofchk is ON
Date:   Mon,  4 Feb 2019 11:36:34 +0100
Message-Id: <20190204103622.502837984@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103619.714714157@linuxfoundation.org>
References: <20190204103619.714714157@linuxfoundation.org>
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

From: Aya Levin <ayal@mellanox.com>

[ Upstream commit 9d2cbdc5d334967c35b5f58c7bf3208e17325647 ]

Prior to this patch the driver prohibited spoof checking on invalid MAC.
Now the user can set this configuration if it wishes to.

This is required since libvirt might invalidate the VF Mac by setting it
to zero, while spoofcheck is ON.

Fixes: 1ab2068a4c66 ("net/mlx5: Implement vports admin state backup/restore")
Signed-off-by: Aya Levin <ayal@mellanox.com>
Reviewed-by: Eran Ben Elisha <eranbe@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c |   18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1133,13 +1133,6 @@ static int esw_vport_ingress_config(stru
 	int err = 0;
 	u8 *smac_v;
 
-	if (vport->info.spoofchk && !is_valid_ether_addr(vport->info.mac)) {
-		mlx5_core_warn(esw->dev,
-			       "vport[%d] configure ingress rules failed, illegal mac with spoofchk\n",
-			       vport->vport);
-		return -EPERM;
-	}
-
 	esw_vport_cleanup_ingress_rules(esw, vport);
 
 	if (!vport->info.vlan && !vport->info.qos && !vport->info.spoofchk) {
@@ -1812,13 +1805,10 @@ int mlx5_eswitch_set_vport_mac(struct ml
 	mutex_lock(&esw->state_lock);
 	evport = &esw->vports[vport];
 
-	if (evport->info.spoofchk && !is_valid_ether_addr(mac)) {
+	if (evport->info.spoofchk && !is_valid_ether_addr(mac))
 		mlx5_core_warn(esw->dev,
-			       "MAC invalidation is not allowed when spoofchk is on, vport(%d)\n",
+			       "Set invalid MAC while spoofchk is on, vport(%d)\n",
 			       vport);
-		err = -EPERM;
-		goto unlock;
-	}
 
 	err = mlx5_modify_nic_vport_mac_address(esw->dev, vport, mac);
 	if (err) {
@@ -1964,6 +1954,10 @@ int mlx5_eswitch_set_vport_spoofchk(stru
 	evport = &esw->vports[vport];
 	pschk = evport->info.spoofchk;
 	evport->info.spoofchk = spoofchk;
+	if (pschk && !is_valid_ether_addr(evport->info.mac))
+		mlx5_core_warn(esw->dev,
+			       "Spoofchk in set while MAC is invalid, vport(%d)\n",
+			       evport->vport);
 	if (evport->enabled && esw->mode == SRIOV_LEGACY)
 		err = esw_vport_ingress_config(esw, evport);
 	if (err)


