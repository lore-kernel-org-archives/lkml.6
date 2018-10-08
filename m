Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50732C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02A5B2089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3PxIXV5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02A5B2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbeJICPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:15:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:48942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730752AbeJICAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:00:19 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D25D42064A;
        Mon,  8 Oct 2018 18:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024433;
        bh=IsDN8sYWBRcDbsQfeX5KWlSywER9ggdvEMRJF5Q48k4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P3PxIXV5614JMlHLAaMJwm+Fjm/A4hQEHW1gG0cr9Gxil29yQCsxlAIhzCFrWwns7
         PTy8oE3YdEfZpUwE5brjj+e4pB9niQSUZ7ED3SxuD3MdZ2s7M2S4FzbPQTJkWH0L+x
         3XNrP/ZAiarYT7xy44IOIgHJHm5+QZlyeb36aue4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 013/168] bpf, sockmap: fix psock refcount leak in bpf_tcp_recvmsg
Date:   Mon,  8 Oct 2018 20:29:53 +0200
Message-Id: <20181008175620.542501811@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
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

From: Daniel Borkmann <daniel@iogearbox.net>

[ Upstream commit 15c480efab01197c965ce0562a43ffedd852b8f9 ]

In bpf_tcp_recvmsg() we first took a reference on the psock, however
once we find that there are skbs in the normal socket's receive queue
we return with processing them through tcp_recvmsg(). Problem is that
we leak the taken reference on the psock in that path. Given we don't
really do anything with the psock at this point, move the skb_queue_empty()
test before we fetch the psock to fix this case.

Fixes: 8934ce2fd081 ("bpf: sockmap redirect ingress support")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/sockmap.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/kernel/bpf/sockmap.c
+++ b/kernel/bpf/sockmap.c
@@ -915,6 +915,8 @@ static int bpf_tcp_recvmsg(struct sock *
 
 	if (unlikely(flags & MSG_ERRQUEUE))
 		return inet_recv_error(sk, msg, len, addr_len);
+	if (!skb_queue_empty(&sk->sk_receive_queue))
+		return tcp_recvmsg(sk, msg, len, nonblock, flags, addr_len);
 
 	rcu_read_lock();
 	psock = smap_psock_sk(sk);
@@ -925,9 +927,6 @@ static int bpf_tcp_recvmsg(struct sock *
 		goto out;
 	rcu_read_unlock();
 
-	if (!skb_queue_empty(&sk->sk_receive_queue))
-		return tcp_recvmsg(sk, msg, len, nonblock, flags, addr_len);
-
 	lock_sock(sk);
 bytes_ready:
 	while (copied != len) {


