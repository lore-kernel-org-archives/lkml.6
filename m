Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30EBAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 04:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E66CF2147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 04:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="UyZw/B4f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730425AbfBTEJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 23:09:11 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36208 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730376AbfBTEJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 23:09:10 -0500
Received: by mail-qk1-f195.google.com with SMTP id o125so1144911qkf.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 20:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P1C55xJx/uAH3YLT6Vk7PSnsH5amwpGoZRQoHvwEukE=;
        b=UyZw/B4fiNHUYDJUNfiS5hkWYfP0lwpKvyAB5zcqI8UfU62YyWx9alAF5kVcJWS8/T
         VfVFeJB7pjC7a89hMsyqbQTdRd6vY6VJHZHUMSrGzC7rA7Ong3ARGbRPPHH5/c3mlsyq
         wr8goT+AesLpCk+OHYDqabldcgIIrxKktcYxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P1C55xJx/uAH3YLT6Vk7PSnsH5amwpGoZRQoHvwEukE=;
        b=K+PrvucWL5Ukgov6IJhUCYM7zv5Tvkzzl/M1pbJegqbiigrZWXmVDfhsLxMDxC4dTk
         yQUDDzHVTx7Pw6q3vfxskdac2+m5cLyAbJpVqrwIZAaGy0iwd1UZTfDmVBQrnLCKms2m
         Btsr6trwjIZvGMSbZQKaIH0YDmknXuhgklPEkuhxSopY4nKLJP45xUy5ymFmIDvWZavM
         D58oj0v353vmgR9JuNxU8vEVtz5wSytRNveARKzRaGqhe0+5RQLwFCxGRg7bMSe9M0sA
         AMI4LhM7YCki8WpWOmqwzETGDnv3GKr0o3QK52c2iTlXme35SCBzpncuvYvnqI+6i+kU
         CaoA==
X-Gm-Message-State: AHQUAuabUsBeaJtIrTA8dHAZ9lEyOHostMAQDwVIhyPY35uttgXrYs1C
        wtRFUd4Lm010YAYTSEY9/q05DF4Puwo=
X-Google-Smtp-Source: AHgI3IaRs9RlamroA7mKwp5GKGS/8HZbpHYiGuuidAjqsEnsnyqnGaNNnCV0gmfondkinNwRW3467A==
X-Received: by 2002:a0c:96c1:: with SMTP id b1mr24723353qvd.45.1550635748756;
        Tue, 19 Feb 2019 20:09:08 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id s19sm2024593qth.80.2019.02.19.20.09.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 20:09:07 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>, paulmck@linux.ibm.com
Subject: [RFC 2/5] ixgbe: Fix incorrect RCU API usage
Date:   Tue, 19 Feb 2019 23:08:24 -0500
Message-Id: <20190220040827.136184-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <20190220040827.136184-1-joel@joelfernandes.org>
References: <20190220040827.136184-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joel Fernandes <joel@joelfernandes.org>

Recently, I added an RCU annotation check in rcu_assign_pointer. This
caused a sparse error to be reported by the ixgbe driver.

Further looking, it seems the adapter->xdp_prog pointer is not annotated
with __rcu. Annonating it fixed the error, but caused a bunch of other
warnings.

This patch tries to fix all warnings by using RCU API properly. This
makes sense to do because not using RCU properly can result in various
hard to find bugs. This is a best effort fix and is only build tested.
The sparse errors and warnings go away with the change. I request
maintainers / developers in this area to test it properly.

Signed-off-by: Joel Fernandes <joel@joelfernandes.org>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  4 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 16 +++++++++++-----
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 08d85e336bd4..3b14daf27516 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -311,7 +311,7 @@ struct ixgbe_ring {
 	struct ixgbe_ring *next;	/* pointer to next ring in q_vector */
 	struct ixgbe_q_vector *q_vector; /* backpointer to host q_vector */
 	struct net_device *netdev;	/* netdev ring belongs to */
-	struct bpf_prog *xdp_prog;
+	struct bpf_prog __rcu *xdp_prog;
 	struct device *dev;		/* device for DMA mapping */
 	void *desc;			/* descriptor ring memory */
 	union {
@@ -560,7 +560,7 @@ struct ixgbe_adapter {
 	unsigned long active_vlans[BITS_TO_LONGS(VLAN_N_VID)];
 	/* OS defined structs */
 	struct net_device *netdev;
-	struct bpf_prog *xdp_prog;
+	struct bpf_prog __rcu *xdp_prog;
 	struct pci_dev *pdev;
 	struct mii_bus *mii_bus;
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index daff8183534b..aad7b800aacd 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2199,7 +2199,7 @@ static struct sk_buff *ixgbe_run_xdp(struct ixgbe_adapter *adapter,
 	u32 act;
 
 	rcu_read_lock();
-	xdp_prog = READ_ONCE(rx_ring->xdp_prog);
+	xdp_prog = rcu_dereference(rx_ring->xdp_prog);
 
 	if (!xdp_prog)
 		goto xdp_out;
@@ -6547,7 +6547,7 @@ int ixgbe_setup_rx_resources(struct ixgbe_adapter *adapter,
 			     rx_ring->queue_index) < 0)
 		goto err;
 
-	rx_ring->xdp_prog = adapter->xdp_prog;
+	rcu_assign_pointer(rx_ring->xdp_prog, adapter->xdp_prog);
 
 	return 0;
 err:
@@ -10246,7 +10246,8 @@ static int ixgbe_xdp_setup(struct net_device *dev, struct bpf_prog *prog)
 	if (nr_cpu_ids > MAX_XDP_QUEUES)
 		return -ENOMEM;
 
-	old_prog = xchg(&adapter->xdp_prog, prog);
+	old_prog = rcu_dereference(adapter->xdp_prog);
+	rcu_assign_pointer(adapter->xdp_prog, prog);
 
 	/* If transitioning XDP modes reconfigure rings */
 	if (!!prog != !!old_prog) {
@@ -10271,13 +10272,18 @@ static int ixgbe_xdp_setup(struct net_device *dev, struct bpf_prog *prog)
 static int ixgbe_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 {
 	struct ixgbe_adapter *adapter = netdev_priv(dev);
+	struct bpf_prog *prog;
+	int ret;
 
 	switch (xdp->command) {
 	case XDP_SETUP_PROG:
 		return ixgbe_xdp_setup(dev, xdp->prog);
 	case XDP_QUERY_PROG:
-		xdp->prog_id = adapter->xdp_prog ?
-			adapter->xdp_prog->aux->id : 0;
+		rcu_read_lock();
+		prog = rcu_dereference(adapter->xdp_prog);
+		xdp->prog_id = prog ? prog->aux->id : 0;
+		rcu_read_unlock();
+
 		return 0;
 	case XDP_QUERY_XSK_UMEM:
 		return ixgbe_xsk_umem_query(adapter, &xdp->xsk.umem,
-- 
2.21.0.rc0.258.g878e2cd30e-goog

