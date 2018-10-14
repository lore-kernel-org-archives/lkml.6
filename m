Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B7FC7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7E9E20645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:37:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7E9E20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbeJNXMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:12:02 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36215 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728048AbeJNXMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:12:01 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLo-0004cY-Aj; Sun, 14 Oct 2018 16:30:40 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLX-0000Yv-Q1; Sun, 14 Oct 2018 16:30:23 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Doug Ledford" <dledford@redhat.com>,
        "Rohit Zambre" <rzambre@uci.edu>,
        "Leon Romanovsky" <leonro@mellanox.com>,
        "Yishai Hadas" <yishaih@mellanox.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.623259148@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 274/366] RDMA/mlx5: Don't assume that medium
 blueFlame register exists
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Yishai Hadas <yishaih@mellanox.com>

commit 18b0362e87dfa09e355093b897b9db854e360d28 upstream.

User can leave system without medium BlueFlames registers,
however the code assumed that at least one such register exists.

This patch fixes that assumption.

Fixes: c1be5232d21d ("IB/mlx5: Fix micro UAR allocator")
Reported-by: Rohit Zambre <rzambre@uci.edu>
Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
[bwh: Backported to 3.16:
 - s/bfreg/uuar/g
 - Neither alloc_med_class_uuar() nor num_med_uuar() takes a mlx5_ib_dev
   pointer, so first_med_uuar() doesn't need to take one
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/infiniband/hw/mlx5/qp.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -356,11 +356,6 @@ static int qp_has_rq(struct ib_qp_init_a
 	return 1;
 }
 
-static int first_med_uuar(void)
-{
-	return 1;
-}
-
 static int next_uuar(int n)
 {
 	n++;
@@ -395,6 +390,11 @@ static int max_uuari(struct mlx5_uuar_in
 	return uuari->num_uars * 4;
 }
 
+static int first_med_uuar(struct mlx5_uuar_info *uuari)
+{
+	return num_med_uuar(uuari) ? 1 : -ENOMEM;
+}
+
 static int first_hi_uuar(struct mlx5_uuar_info *uuari)
 {
 	int med;
@@ -420,10 +420,13 @@ static int alloc_high_class_uuar(struct
 
 static int alloc_med_class_uuar(struct mlx5_uuar_info *uuari)
 {
-	int minidx = first_med_uuar();
+	int minidx = first_med_uuar(uuari);
 	int i;
 
-	for (i = first_med_uuar(); i < first_hi_uuar(uuari); i = next_uuar(i)) {
+	if (minidx < 0)
+		return minidx;
+
+	for (i = minidx; i < first_hi_uuar(uuari); i = next_uuar(i)) {
 		if (uuari->count[i] < uuari->count[minidx])
 			minidx = i;
 		if (!uuari->count[minidx])

