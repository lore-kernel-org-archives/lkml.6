Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F25C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 05:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCA2B2084F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 05:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="jT740G6e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfBUFuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 00:50:04 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35075 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbfBUFuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 00:50:01 -0500
Received: by mail-qk1-f195.google.com with SMTP id z13so2302620qki.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 21:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JmLFpdRORBxQq944X6ow6jxn2Py1BtKo1o+DDQDbcPs=;
        b=jT740G6evoueaiJkbiGaGk2LjNX0z7MTAZi+fD2cpXIP210C+G4HEXamwzwB9f3j3n
         okdYQ422tOGTD2Sxn/0g/EyMYJJk0CzjHVDJh5+fUmQcBDwYkvWB18jKitux3eahODAo
         2GIame4vikPR+xBuFaIgPHpPxTizicTNgU7WU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JmLFpdRORBxQq944X6ow6jxn2Py1BtKo1o+DDQDbcPs=;
        b=eL6IYGKSiaOujeZapu6A1nFoHTUYy4jOeEeHHWbr4rZH7OAVVJW4OF1bkspMSo2n0W
         MjH5Vw/yGFezXJCqBHUp2pTzqWbOzZx9/DES84yCb0w/Sq4buYbw7LjtYPM+Bs4EdUNg
         zl8uptF6k45MJ8AqderXr9uUP53NV2sHYO6QijJ8KU7ntc3Dfp5VFe3ODx4XrboqbG8P
         FVn2nhCNmOmLqAxw4hDfd+ghAhmwNvg36qklHqKntcPx+3tmL+/mZljLJwQVZsYCfel0
         9DHuhM0uI8nQQfGZ8pyYKRrE7T26RjEeQi95G+5HNZwkfUM/0dxtkVtuMDX8EDFHk/mt
         v3tg==
X-Gm-Message-State: AHQUAuarwQnqqtBXp2DYKSea4pVek+rMpajs1XeOwFiWkC2w4Q9W7hLd
        sDLRtvbHzveRLQ4ggINoKaY3LInfzbQ=
X-Google-Smtp-Source: AHgI3IbOR4CRoe9MkfK2GQWb1kgEoC51CJYPHhkELH+l4iSnuB0HTltkfM39dpwbfZwR6vOy5FGzWg==
X-Received: by 2002:a37:8d01:: with SMTP id p1mr28226874qkd.91.1550728200127;
        Wed, 20 Feb 2019 21:50:00 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id k185sm11561219qkd.62.2019.02.20.21.49.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 21:49:59 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        Ingo Molnar <mingo@redhat.com>,
        intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>, keescook@chromium.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        netdev@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>, rcu@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        xdp-newbies@vger.kernel.org, Yonghong Song <yhs@fb.com>
Subject: [PATCH RFC 2/5] ixgbe: Fix incorrect RCU API usage
Date:   Thu, 21 Feb 2019 00:49:39 -0500
Message-Id: <20190221054942.132388-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <20190221054942.132388-1-joel@joelfernandes.org>
References: <20190221054942.132388-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  4 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 17 ++++++++++++-----
 2 files changed, 14 insertions(+), 7 deletions(-)

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
index daff8183534b..6aa59bb13a14 100644
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
@@ -10246,7 +10246,10 @@ static int ixgbe_xdp_setup(struct net_device *dev, struct bpf_prog *prog)
 	if (nr_cpu_ids > MAX_XDP_QUEUES)
 		return -ENOMEM;
 
-	old_prog = xchg(&adapter->xdp_prog, prog);
+	rcu_read_lock();
+	old_prog = rcu_dereference(adapter->xdp_prog);
+	rcu_assign_pointer(adapter->xdp_prog, prog);
+	rcu_read_unlock();
 
 	/* If transitioning XDP modes reconfigure rings */
 	if (!!prog != !!old_prog) {
@@ -10271,13 +10274,17 @@ static int ixgbe_xdp_setup(struct net_device *dev, struct bpf_prog *prog)
 static int ixgbe_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 {
 	struct ixgbe_adapter *adapter = netdev_priv(dev);
+	struct bpf_prog *prog;
 
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

