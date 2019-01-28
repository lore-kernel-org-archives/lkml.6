Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37690C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F142421841
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690984;
	bh=UZFvkic7KZu2S3ma2iA2WcWy2rfaaBK9diHSk0II7Ms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WNHCA7Dib06UexOwVw7nSd3XXhB3Gvk47IgO0BYCmWFx2uFhtd0NaP71+tD9lfSxb
	 Fhz84FkFoj8YdnkgjORsmb7YxrAWJjDuKnlpRWEIlK9FC8217Ng89dM8OpHDBGQel2
	 VqWcV4QRnLFRUCf+XjDcz1alDrtm6cqndsSDt7mc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730080AbfA1P4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:56:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:42058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729632AbfA1P4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:56:18 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6CBD2183F;
        Mon, 28 Jan 2019 15:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690977;
        bh=UZFvkic7KZu2S3ma2iA2WcWy2rfaaBK9diHSk0II7Ms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DDz0LX4bMfvhpeejaVymf70Td3hErNLI5h+u66CqXkt//bYMBXUJoa0zyqsw44xY2
         27zkYQePlK2q+BPOGCaAaoc5Nk9lGfV8FQP1MO9VExJhZJm1MxSQefNEIUqjNC3xzw
         PxcC8+tgXm/1cKQdnfDhrC23RRnzN9tBpZVPHg0g=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 252/304] bpf: sk_msg, zap ingress queue on psock down
Date:   Mon, 28 Jan 2019 10:42:49 -0500
Message-Id: <20190128154341.47195-252-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Fastabend <john.fastabend@gmail.com>

[ Upstream commit a136678c0bdbb650daff5df5eec1dab960e074a7 ]

In addition to releasing any cork'ed data on a psock when the psock
is removed we should also release any skb's in the ingress work queue.
Otherwise the skb's eventually get free'd but late in the tear
down process so we see the WARNING due to non-zero sk_forward_alloc.

  void sk_stream_kill_queues(struct sock *sk)
  {
	...
	WARN_ON(sk->sk_forward_alloc);
	...
  }

Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/skmsg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index b7dbb3c976cd..fc7d59f1c57c 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -575,6 +575,7 @@ void sk_psock_drop(struct sock *sk, struct sk_psock *psock)
 {
 	rcu_assign_sk_user_data(sk, NULL);
 	sk_psock_cork_free(psock);
+	sk_psock_zap_ingress(psock);
 	sk_psock_restore_proto(sk, psock);
 
 	write_lock_bh(&sk->sk_callback_lock);
-- 
2.19.1

