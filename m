Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84907C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EA1D20838
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPJJM+GG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EA1D20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbeJ3WU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:20:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:51874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727768AbeJ3WU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:20:57 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FD752080A;
        Tue, 30 Oct 2018 13:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540906049;
        bh=xr6qys1tLzdVxTyuQ9ICVYPij5NuuU/hRtzp3gbIVa4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FPJJM+GGe9/YIOAS2UFET/jkJHVhvb2VB3IFQjGdGSdEvv8ujuq49x87MVHOtIC3q
         kX6OG+iqNFXniOMvmN0RXnNduoVxILweYQONgRq5pYgaOjeL1rsRSLu8dK2V5GRyqH
         8lFo/6/+EcvEZU1k8HVjFaQfCRveC8i/Fyo9zt7k=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 09/33] xsk: do not call synchronize_net() under RCU read lock
Date:   Tue, 30 Oct 2018 09:26:33 -0400
Message-Id: <20181030132657.217970-9-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181030132657.217970-1-sashal@kernel.org>
References: <20181030132657.217970-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Björn Töpel <bjorn.topel@intel.com>

[ Upstream commit cee271678d0e3177a25d0fcb2fa5e051d48e4262 ]

The XSKMAP update and delete functions called synchronize_net(), which
can sleep. It is not allowed to sleep during an RCU read section.

Instead we need to make sure that the sock sk_destruct (xsk_destruct)
function is asynchronously called after an RCU grace period. Setting
the SOCK_RCU_FREE flag for XDP sockets takes care of this.

Fixes: fbfc504a24f5 ("bpf: introduce new bpf AF_XDP map type BPF_MAP_TYPE_XSKMAP")
Reported-by: Eric Dumazet <eric.dumazet@gmail.com>
Signed-off-by: Björn Töpel <bjorn.topel@intel.com>
Acked-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/xskmap.c | 10 ++--------
 net/xdp/xsk.c       |  2 ++
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/xskmap.c b/kernel/bpf/xskmap.c
index b3c557476a8d..c98501a04742 100644
--- a/kernel/bpf/xskmap.c
+++ b/kernel/bpf/xskmap.c
@@ -191,11 +191,8 @@ static int xsk_map_update_elem(struct bpf_map *map, void *key, void *value,
 	sock_hold(sock->sk);
 
 	old_xs = xchg(&m->xsk_map[i], xs);
-	if (old_xs) {
-		/* Make sure we've flushed everything. */
-		synchronize_net();
+	if (old_xs)
 		sock_put((struct sock *)old_xs);
-	}
 
 	sockfd_put(sock);
 	return 0;
@@ -211,11 +208,8 @@ static int xsk_map_delete_elem(struct bpf_map *map, void *key)
 		return -EINVAL;
 
 	old_xs = xchg(&m->xsk_map[k], NULL);
-	if (old_xs) {
-		/* Make sure we've flushed everything. */
-		synchronize_net();
+	if (old_xs)
 		sock_put((struct sock *)old_xs);
-	}
 
 	return 0;
 }
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 4e937cd7c17d..661504042d30 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -744,6 +744,8 @@ static int xsk_create(struct net *net, struct socket *sock, int protocol,
 	sk->sk_destruct = xsk_destruct;
 	sk_refcnt_debug_inc(sk);
 
+	sock_set_flag(sk, SOCK_RCU_FREE);
+
 	xs = xdp_sk(sk);
 	mutex_init(&xs->mutex);
 	spin_lock_init(&xs->tx_completion_lock);
-- 
2.17.1

