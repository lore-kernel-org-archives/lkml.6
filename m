Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B341AC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A67821557
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JiS8ob5G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A67821557
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbeJHWi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:38:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:56896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727827AbeJHWiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:38:24 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51523214DC;
        Mon,  8 Oct 2018 15:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539012368;
        bh=QFK5ue3WEVMe74bdKKp4H+L5pyBnVmwh0zov7I4ceng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JiS8ob5Gk3hm5jgUWHjFjwgNEx544f14meGEeaQFdSFIe7VbVrZ4BwUi/J6l2GKSd
         8YwFo6sDYrrHTaJmTRVkKgwU1ED2Fk58IwSkJK3KUXgDMLNZMtsiDCDAhKoMG8iuHS
         n2fzwbPgE88RN5GPHE/5J23h/Gatqx2gi3pyZu/k=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 44/58] bpf: sockmap only allow ESTABLISHED sock state
Date:   Mon,  8 Oct 2018 11:25:09 -0400
Message-Id: <20181008152523.70705-44-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008152523.70705-1-sashal@kernel.org>
References: <20181008152523.70705-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Fastabend <john.fastabend@gmail.com>

[ Upstream commit 5607fff303636d48b88414c6be353d9fed700af2 ]

After this patch we only allow socks that are in ESTABLISHED state or
are being added via a sock_ops event that is transitioning into an
ESTABLISHED state. By allowing sock_ops events we allow users to
manage sockmaps directly from sock ops programs. The two supported
sock_ops ops are BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB and
BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB.

Similar to TLS ULP this ensures sk_user_data is correct.

Reported-by: Eric Dumazet <edumazet@google.com>
Fixes: 1aa12bdf1bfb ("bpf: sockmap, add sock close() hook to remove socks")
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 kernel/bpf/sockmap.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/sockmap.c b/kernel/bpf/sockmap.c
index ed707b21d152..0d829e71024b 100644
--- a/kernel/bpf/sockmap.c
+++ b/kernel/bpf/sockmap.c
@@ -2092,8 +2092,12 @@ static int sock_map_update_elem(struct bpf_map *map,
 		return -EINVAL;
 	}
 
+	/* ULPs are currently supported only for TCP sockets in ESTABLISHED
+	 * state.
+	 */
 	if (skops.sk->sk_type != SOCK_STREAM ||
-	    skops.sk->sk_protocol != IPPROTO_TCP) {
+	    skops.sk->sk_protocol != IPPROTO_TCP ||
+	    skops.sk->sk_state != TCP_ESTABLISHED) {
 		fput(socket->file);
 		return -EOPNOTSUPP;
 	}
@@ -2448,6 +2452,16 @@ static int sock_hash_update_elem(struct bpf_map *map,
 		return -EINVAL;
 	}
 
+	/* ULPs are currently supported only for TCP sockets in ESTABLISHED
+	 * state.
+	 */
+	if (skops.sk->sk_type != SOCK_STREAM ||
+	    skops.sk->sk_protocol != IPPROTO_TCP ||
+	    skops.sk->sk_state != TCP_ESTABLISHED) {
+		fput(socket->file);
+		return -EOPNOTSUPP;
+	}
+
 	lock_sock(skops.sk);
 	preempt_disable();
 	rcu_read_lock();
@@ -2536,10 +2550,22 @@ const struct bpf_map_ops sock_hash_ops = {
 	.map_release_uref = sock_map_release,
 };
 
+static bool bpf_is_valid_sock_op(struct bpf_sock_ops_kern *ops)
+{
+	return ops->op == BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB ||
+	       ops->op == BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB;
+}
 BPF_CALL_4(bpf_sock_map_update, struct bpf_sock_ops_kern *, bpf_sock,
 	   struct bpf_map *, map, void *, key, u64, flags)
 {
 	WARN_ON_ONCE(!rcu_read_lock_held());
+
+	/* ULPs are currently supported only for TCP sockets in ESTABLISHED
+	 * state. This checks that the sock ops triggering the update is
+	 * one indicating we are (or will be soon) in an ESTABLISHED state.
+	 */
+	if (!bpf_is_valid_sock_op(bpf_sock))
+		return -EOPNOTSUPP;
 	return sock_map_ctx_update_elem(bpf_sock, map, key, flags);
 }
 
@@ -2558,6 +2584,9 @@ BPF_CALL_4(bpf_sock_hash_update, struct bpf_sock_ops_kern *, bpf_sock,
 	   struct bpf_map *, map, void *, key, u64, flags)
 {
 	WARN_ON_ONCE(!rcu_read_lock_held());
+
+	if (!bpf_is_valid_sock_op(bpf_sock))
+		return -EOPNOTSUPP;
 	return sock_hash_ctx_update_elem(bpf_sock, map, key, flags);
 }
 
-- 
2.17.1

