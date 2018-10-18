Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A39EECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1451E21479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRJKebGw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1451E21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728973AbeJSCAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:00:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:47766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727605AbeJSCAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:00:06 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66A5721473;
        Thu, 18 Oct 2018 17:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885480;
        bh=ZH+LAi49z8QursPiapNOrcvZSJhtwW2HCR1Vlq7h02o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gRJKebGwLl6dEnRTCEQAj8I8lURV65XKZU5eA6qSmqNLM6bxF+i9CMZQrKXaErUjs
         G4JazGA/7t65zVIN6qLCoF5qfwGB/+0jZIWHktR+pEsRDM07wH1k7v6sdjTv9Igsiw
         MK1MrokSXLF+KIIvoJJhPtaaveu7YI1us4182vk4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 36/53] bpf: sockmap only allow ESTABLISHED sock state
Date:   Thu, 18 Oct 2018 19:54:29 +0200
Message-Id: <20181018175422.888783173@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175416.561567978@linuxfoundation.org>
References: <20181018175416.561567978@linuxfoundation.org>
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/sockmap.c |   31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

--- a/kernel/bpf/sockmap.c
+++ b/kernel/bpf/sockmap.c
@@ -2100,8 +2100,12 @@ static int sock_map_update_elem(struct b
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
@@ -2456,6 +2460,16 @@ static int sock_hash_update_elem(struct
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
@@ -2544,10 +2558,22 @@ const struct bpf_map_ops sock_hash_ops =
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
 
@@ -2566,6 +2592,9 @@ BPF_CALL_4(bpf_sock_hash_update, struct
 	   struct bpf_map *, map, void *, key, u64, flags)
 {
 	WARN_ON_ONCE(!rcu_read_lock_held());
+
+	if (!bpf_is_valid_sock_op(bpf_sock))
+		return -EOPNOTSUPP;
 	return sock_hash_ctx_update_elem(bpf_sock, map, key, flags);
 }
 


