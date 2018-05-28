Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033866AbeE1KYl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:24:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:43932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033847AbeE1KYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:24:36 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Govindarajulu Varadarajan <gvaradar@cisco.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 234/268] enic: enable rq before updating rq descriptors
Date: Mon, 28 May 2018 12:03:28 +0200
Message-Id: <20180528100229.860636552@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100202.045206534@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Govindarajulu Varadarajan <gvaradar@cisco.com>

[ Upstream commit e8588e268509292550634d9a35f2723a207683b2 ]

rq should be enabled before posting the buffers to rq desc. If not hw sees
stale value and casuses DMAR errors.

Signed-off-by: Govindarajulu Varadarajan <gvaradar@cisco.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/cisco/enic/enic_main.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -1726,6 +1726,8 @@ static int enic_open(struct net_device *
 	}
 
 	for (i = 0; i < enic->rq_count; i++) {
+		/* enable rq before updating rq desc */
+		vnic_rq_enable(&enic->rq[i]);
 		vnic_rq_fill(&enic->rq[i], enic_rq_alloc_buf);
 		/* Need at least one buffer on ring to get going */
 		if (vnic_rq_desc_used(&enic->rq[i]) == 0) {
@@ -1737,8 +1739,6 @@ static int enic_open(struct net_device *
 
 	for (i = 0; i < enic->wq_count; i++)
 		vnic_wq_enable(&enic->wq[i]);
-	for (i = 0; i < enic->rq_count; i++)
-		vnic_rq_enable(&enic->rq[i]);
 
 	if (!enic_is_dynamic(enic) && !enic_is_sriov_vf(enic))
 		enic_dev_add_station_addr(enic);
@@ -1765,8 +1765,12 @@ static int enic_open(struct net_device *
 	return 0;
 
 err_out_free_rq:
-	for (i = 0; i < enic->rq_count; i++)
+	for (i = 0; i < enic->rq_count; i++) {
+		err = vnic_rq_disable(&enic->rq[i]);
+		if (err)
+			return err;
 		vnic_rq_clean(&enic->rq[i], enic_free_rq_buf);
+	}
 	enic_dev_notify_unset(enic);
 err_out_free_intr:
 	enic_unset_affinity_hint(enic);
