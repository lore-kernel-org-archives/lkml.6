Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC86C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EE902075B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277034;
	bh=8rSrhPICNeOvt8wsZzv0QJ25/2RN7mBlva0/uhipqLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SsVpikHFFaitkLB9fifU6I3ud0UHn7SIPHdZjozGc0RtiIvRbb9+V1h+HSO3Q9N6u
	 qM94Ef7XrdSNjmfVvgyklUJMhLvVKiqOaGWy0sccT+yzrrTyRFQskf2QtbbU1IL/bw
	 NJiWrgbPqKdM/KN8WCtO+L21yLWJlvc0i2kSxZcE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730841AbfBDKnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:43:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:41620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728701AbfBDKns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:43:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C81F12087C;
        Mon,  4 Feb 2019 10:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277028;
        bh=8rSrhPICNeOvt8wsZzv0QJ25/2RN7mBlva0/uhipqLM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M/Iromn3T1Rgdl6zAyX0NlXHKGqQHposNchSWElAggsK1+RTlsRggRn/rYthDeSLg
         Y6cV1YJPEDp9URE2FE99D3ox8HxEPcJcT21V8oLNMDhyjIIjyN8rKde40S/u5TmVlo
         owYWIkHzmtUX/2tnieFfh7BYKTpG29Yaq2vzuoGU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aya Levin <ayal@mellanox.com>,
        Eran Ben Elisha <eranbe@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.9 09/30] net/mlx5e: Allow MAC invalidation while spoofchk is ON
Date:   Mon,  4 Feb 2019 11:36:47 +0100
Message-Id: <20190204103606.962074350@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103605.271746870@linuxfoundation.org>
References: <20190204103605.271746870@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c |   19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1216,14 +1216,6 @@ static int esw_vport_ingress_config(stru
 	int err = 0;
 	u8 *smac_v;
 
-	if (vport->info.spoofchk && !is_valid_ether_addr(vport->info.mac)) {
-		mlx5_core_warn(esw->dev,
-			       "vport[%d] configure ingress rules failed, illegal mac with spoofchk\n",
-			       vport->vport);
-		return -EPERM;
-
-	}
-
 	esw_vport_cleanup_ingress_rules(esw, vport);
 
 	if (!vport->info.vlan && !vport->info.qos && !vport->info.spoofchk) {
@@ -1709,13 +1701,10 @@ int mlx5_eswitch_set_vport_mac(struct ml
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
@@ -1859,6 +1848,10 @@ int mlx5_eswitch_set_vport_spoofchk(stru
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


