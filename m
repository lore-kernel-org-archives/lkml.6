Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165320AbeE1NUe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:20:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:39024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163362AbeE1KtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:49:16 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Karsten Graul <kgraul@linux.vnet.ibm.com>,
        Ursula Braun <ubraun@linux.vnet.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 174/496] net/smc: use link_id of server in confirm link reply
Date: Mon, 28 May 2018 11:59:19 +0200
Message-Id: <20180528100327.212059258@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Karsten Graul <kgraul@linux.vnet.ibm.com>

[ Upstream commit 2be922f31606f114119f48de3207d122a90e7357 ]

The CONFIRM LINK reply message must contain the link_id sent
by the server. And set the link_id explicitly when
initializing the link.

Signed-off-by: Karsten Graul <kgraul@linux.vnet.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/smc/smc_core.c |    1 +
 net/smc/smc_llc.c  |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -174,6 +174,7 @@ static int smc_lgr_create(struct smc_soc
 
 	lnk = &lgr->lnk[SMC_SINGLE_LINK];
 	/* initialize link */
+	lnk->link_id = SMC_SINGLE_LINK;
 	lnk->smcibdev = smcibdev;
 	lnk->ibport = ibport;
 	lnk->path_mtu = smcibdev->pattr[ibport - 1].active_mtu;
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -92,7 +92,7 @@ int smc_llc_send_confirm_link(struct smc
 	memcpy(confllc->sender_mac, mac, ETH_ALEN);
 	memcpy(confllc->sender_gid, gid, SMC_GID_SIZE);
 	hton24(confllc->sender_qp_num, link->roce_qp->qp_num);
-	/* confllc->link_num = SMC_SINGLE_LINK; already done by memset above */
+	confllc->link_num = link->link_id;
 	memcpy(confllc->link_uid, lgr->id, SMC_LGR_ID_SIZE);
 	confllc->max_links = SMC_LINKS_PER_LGR_MAX;
 	/* send llc message */
