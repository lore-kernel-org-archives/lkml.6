Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C768C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5C3120871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFieFisM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5C3120871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388005AbeKLJb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:31:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:41330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731689AbeKLITe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:19:34 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D93AA216FD;
        Sun, 11 Nov 2018 22:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975378;
        bh=i7R/De9rebiqSVBGTVrfZpGBPQLtdPhyZ/ohdjuHkZ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WFieFisML/nef//u26vlN93FDZ8TgMNudEbl+7LlzA+2o9DEtlAlA+iEnxuDXZudT
         1hJesLYUwb8tHB14yQ5qcZzQvNw6emMuM8mm+TupyIuMidPEyHXsqUHrAapFcE1UnU
         g+0bostcR3qYUOwL/7wF8Oo2provPsWOQ8Ckzf/8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 047/350] xsk: do not call synchronize_net() under RCU read lock
Date:   Sun, 11 Nov 2018 14:18:31 -0800
Message-Id: <20181111221709.129034776@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/xskmap.c |   10 ++--------
 net/xdp/xsk.c       |    2 ++
 2 files changed, 4 insertions(+), 8 deletions(-)

--- a/kernel/bpf/xskmap.c
+++ b/kernel/bpf/xskmap.c
@@ -191,11 +191,8 @@ static int xsk_map_update_elem(struct bp
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
@@ -211,11 +208,8 @@ static int xsk_map_delete_elem(struct bp
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
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -744,6 +744,8 @@ static int xsk_create(struct net *net, s
 	sk->sk_destruct = xsk_destruct;
 	sk_refcnt_debug_inc(sk);
 
+	sock_set_flag(sk, SOCK_RCU_FREE);
+
 	xs = xdp_sk(sk);
 	mutex_init(&xs->mutex);
 	spin_lock_init(&xs->tx_completion_lock);


