Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16EDC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B24E720880
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690517;
	bh=j0oze8YxwtHsd/gfGAtTmAHCoWwciZyZ3FO1h2/ogms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rE6DGj1vCqK2dZoVIAO1pFYaHRfpzVJg7b8ClIhA5IBzGMuAWg1Vp9QbhAcmG0V6f
	 3QSCqpGCcbH2iIyhsZ81XXEusNzm4HtxGUgIjn/9IZBsa5ownKONEwan70znUqarwu
	 73yJzo8hGGrvmtr+UMdQPOeE0AbO37VgNuNVAD50=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbfA1Psf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:48:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:33952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727855AbfA1Pse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:48:34 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 275F420880;
        Mon, 28 Jan 2019 15:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690513;
        bh=j0oze8YxwtHsd/gfGAtTmAHCoWwciZyZ3FO1h2/ogms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OZ04fbcHmQZ0NEDfTj2BvHLMMJ06O6UC0YF6YWRq96YprRjp5sbWBBeqIMu/2MbH/
         9CXGmf8CJTWSf2esUXVznqBR9PTEEb5ETMugEJzlNVinpcVc/+VmE2ld0hxAGD1Nim
         cr75hbeSnJ+lHT/1EdONuXon3Lg7V1J5cgjwvKMI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, oss-drivers@netronome.com,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 109/304] nfp: add locking around representor changes
Date:   Mon, 28 Jan 2019 10:40:26 -0500
Message-Id: <20190128154341.47195-109-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <jakub.kicinski@netronome.com>

[ Upstream commit 71844fac1ed459024dd2a448d63d5b28b8c87daa ]

Up until now we never needed to keep a networking locks around
representors accesses, we only accessed them when device was
reconfigured (under nfp pf->lock) or on fast path (under RCU).
Now we want to be able to iterate over all representors during
notifications, so make sure representor assignment is done
under RTNL lock.

Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reviewed-by: John Hurley <john.hurley@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/netronome/nfp/abm/main.c     | 4 ++++
 drivers/net/ethernet/netronome/nfp/nfp_app.c      | 2 ++
 drivers/net/ethernet/netronome/nfp/nfp_net_repr.c | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/netronome/nfp/abm/main.c b/drivers/net/ethernet/netronome/nfp/abm/main.c
index c0830c0c2c3f..376df412ea55 100644
--- a/drivers/net/ethernet/netronome/nfp/abm/main.c
+++ b/drivers/net/ethernet/netronome/nfp/abm/main.c
@@ -384,7 +384,9 @@ nfp_abm_spawn_repr(struct nfp_app *app, struct nfp_abm_link *alink,
 
 	reprs = nfp_reprs_get_locked(app, rtype);
 	WARN(nfp_repr_get_locked(app, reprs, alink->id), "duplicate repr");
+	rtnl_lock();
 	rcu_assign_pointer(reprs->reprs[alink->id], netdev);
+	rtnl_unlock();
 
 	nfp_info(app->cpp, "%s Port %d Representor(%s) created\n",
 		 ptype == NFP_PORT_PF_PORT ? "PCIe" : "Phys",
@@ -410,7 +412,9 @@ nfp_abm_kill_repr(struct nfp_app *app, struct nfp_abm_link *alink,
 	netdev = nfp_repr_get_locked(app, reprs, alink->id);
 	if (!netdev)
 		return;
+	rtnl_lock();
 	rcu_assign_pointer(reprs->reprs[alink->id], NULL);
+	rtnl_unlock();
 	synchronize_rcu();
 	/* Cast to make sure nfp_repr_clean_and_free() takes a nfp_repr */
 	nfp_repr_clean_and_free((struct nfp_repr *)netdev_priv(netdev));
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_app.c b/drivers/net/ethernet/netronome/nfp/nfp_app.c
index 68a0991aac22..3bd1386162b9 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_app.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_app.c
@@ -131,7 +131,9 @@ nfp_app_reprs_set(struct nfp_app *app, enum nfp_repr_type type,
 	struct nfp_reprs *old;
 
 	old = nfp_reprs_get_locked(app, type);
+	rtnl_lock();
 	rcu_assign_pointer(app->reprs[type], reprs);
+	rtnl_unlock();
 
 	return old;
 }
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_repr.c b/drivers/net/ethernet/netronome/nfp/nfp_net_repr.c
index c09b893c30dd..0cf3f40eb8cf 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_repr.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_repr.c
@@ -442,7 +442,9 @@ int nfp_reprs_resync_phys_ports(struct nfp_app *app)
 			continue;
 
 		nfp_app_repr_preclean(app, netdev);
+		rtnl_lock();
 		rcu_assign_pointer(reprs->reprs[i], NULL);
+		rtnl_unlock();
 		synchronize_rcu();
 		nfp_repr_clean(repr);
 	}
-- 
2.19.1

