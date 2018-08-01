Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38C2C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEF1B208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:55:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEF1B208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405995AbeHATIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:08:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50270 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405917AbeHATIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:08:39 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0D6CB112F;
        Wed,  1 Aug 2018 17:05:03 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Doug Oucharek <doug.s.oucharek@intel.com>,
        Andrew Perepechko <andrew.perepechko@seagate.com>,
        Dmitry Eremin <dmitry.eremin@intel.com>,
        James Simmons <uja.ornl@yahoo.com>,
        Oleg Drokin <oleg.drokin@intel.com>,
        Doug Oucharek <dougso@me.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 222/336] staging: lustre: o2iblnd: Fix FastReg map/unmap for MLX5
Date:   Wed,  1 Aug 2018 18:49:17 +0200
Message-Id: <20180801165037.573030562@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Doug Oucharek <dougso@me.com>

[ Upstream commit 24d4b7c8de007cff9c7d83c06ae76099fdcce008 ]

The FastReg support in ko2iblnd was not unmapping pool items
causing the items to leak.  In addition, the mapping code
is not growing the pool like we do with FMR.

This patch makes sure we are unmapping FastReg pool elements
when we are done with them.  It also makes sure the pool
will grow when we depleat the pool.

Signed-off-by: Doug Oucharek <doug.s.oucharek@intel.com>
Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-9472
Reviewed-on: https://review.whamcloud.com/27015
Reviewed-by: Andrew Perepechko <andrew.perepechko@seagate.com>
Reviewed-by: Dmitry Eremin <dmitry.eremin@intel.com>
Reviewed-by: James Simmons <uja.ornl@yahoo.com>
Reviewed-by: Oleg Drokin <oleg.drokin@intel.com>
Signed-off-by: Doug Oucharek <dougso@me.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c    |    2 +-
 drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c |   12 ++++--------
 2 files changed, 5 insertions(+), 9 deletions(-)

--- a/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c
+++ b/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c
@@ -1702,7 +1702,7 @@ int kiblnd_fmr_pool_map(struct kib_fmr_p
 				return 0;
 			}
 			spin_unlock(&fps->fps_lock);
-			rc = -EBUSY;
+			rc = -EAGAIN;
 		}
 
 		spin_lock(&fps->fps_lock);
--- a/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c
+++ b/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c
@@ -48,7 +48,7 @@ static int kiblnd_init_rdma(struct kib_c
 			    __u64 dstcookie);
 static void kiblnd_queue_tx_locked(struct kib_tx *tx, struct kib_conn *conn);
 static void kiblnd_queue_tx(struct kib_tx *tx, struct kib_conn *conn);
-static void kiblnd_unmap_tx(struct lnet_ni *ni, struct kib_tx *tx);
+static void kiblnd_unmap_tx(struct kib_tx *tx);
 static void kiblnd_check_sends_locked(struct kib_conn *conn);
 
 static void
@@ -66,7 +66,7 @@ kiblnd_tx_done(struct lnet_ni *ni, struc
 	LASSERT(!tx->tx_waiting);	      /* mustn't be awaiting peer response */
 	LASSERT(tx->tx_pool);
 
-	kiblnd_unmap_tx(ni, tx);
+	kiblnd_unmap_tx(tx);
 
 	/* tx may have up to 2 lnet msgs to finalise */
 	lntmsg[0] = tx->tx_lntmsg[0]; tx->tx_lntmsg[0] = NULL;
@@ -591,13 +591,9 @@ kiblnd_fmr_map_tx(struct kib_net *net, s
 	return 0;
 }
 
-static void kiblnd_unmap_tx(struct lnet_ni *ni, struct kib_tx *tx)
+static void kiblnd_unmap_tx(struct kib_tx *tx)
 {
-	struct kib_net *net = ni->ni_data;
-
-	LASSERT(net);
-
-	if (net->ibn_fmr_ps)
+	if (tx->fmr.fmr_pfmr || tx->fmr.fmr_frd)
 		kiblnd_fmr_pool_unmap(&tx->fmr, tx->tx_status);
 
 	if (tx->tx_nfrags) {


