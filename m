Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDECC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C098214C5
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJ4gjIdQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C098214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731395AbeJICAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:00:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:49028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730764AbeJICAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:00:23 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 931CB204FD;
        Mon,  8 Oct 2018 18:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024436;
        bh=h8ccCx1vyp0/9iC3KVBX62hVtbcwjKAVYIL0sx5z01E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SJ4gjIdQ0pwjDFFWlHOx5nsXfkQ1aKVguo1Y77hiVIOhMOiXUq+V3v0tAjGqf5a5I
         FrCQpPnU4hV0+UAxMKDJ19sqsSPlshXcAwgWQLKwmW5HXf0dCvIH+/yVg5H4wXZLF8
         U9uaJGYo0iolJfs/3Hyq1vHqy0Cu2gm++/dUZ5Eg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 014/168] bpf: sockmap, decrement copied count correctly in redirect error case
Date:   Mon,  8 Oct 2018 20:29:54 +0200
Message-Id: <20181008175620.579835286@linuxfoundation.org>
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

From: John Fastabend <john.fastabend@gmail.com>

[ Upstream commit 501ca81760c204ec59b73e4a00bee5971fc0f1b1 ]

Currently, when a redirect occurs in sockmap and an error occurs in
the redirect call we unwind the scatterlist once in the error path
of bpf_tcp_sendmsg_do_redirect() and then again in sendmsg(). Then
in the error path of sendmsg we decrement the copied count by the
send size.

However, its possible we partially sent data before the error was
generated. This can happen if do_tcp_sendpages() partially sends the
scatterlist before encountering a memory pressure error. If this
happens we need to decrement the copied value (the value tracking
how many bytes were actually sent to TCP stack) by the number of
remaining bytes _not_ the entire send size. Otherwise we risk
confusing userspace.

Also we don't need two calls to free the scatterlist one is
good enough. So remove the one in bpf_tcp_sendmsg_do_redirect() and
then properly reduce copied by the number of remaining bytes which
may in fact be the entire send size if no bytes were sent.

To do this use bool to indicate if free_start_sg() should do mem
accounting or not.

Signed-off-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/sockmap.c |   45 ++++++++++++++++++++++-----------------------
 1 file changed, 22 insertions(+), 23 deletions(-)

--- a/kernel/bpf/sockmap.c
+++ b/kernel/bpf/sockmap.c
@@ -236,7 +236,7 @@ static int bpf_tcp_init(struct sock *sk)
 }
 
 static void smap_release_sock(struct smap_psock *psock, struct sock *sock);
-static int free_start_sg(struct sock *sk, struct sk_msg_buff *md);
+static int free_start_sg(struct sock *sk, struct sk_msg_buff *md, bool charge);
 
 static void bpf_tcp_release(struct sock *sk)
 {
@@ -248,7 +248,7 @@ static void bpf_tcp_release(struct sock
 		goto out;
 
 	if (psock->cork) {
-		free_start_sg(psock->sock, psock->cork);
+		free_start_sg(psock->sock, psock->cork, true);
 		kfree(psock->cork);
 		psock->cork = NULL;
 	}
@@ -330,14 +330,14 @@ static void bpf_tcp_close(struct sock *s
 	close_fun = psock->save_close;
 
 	if (psock->cork) {
-		free_start_sg(psock->sock, psock->cork);
+		free_start_sg(psock->sock, psock->cork, true);
 		kfree(psock->cork);
 		psock->cork = NULL;
 	}
 
 	list_for_each_entry_safe(md, mtmp, &psock->ingress, list) {
 		list_del(&md->list);
-		free_start_sg(psock->sock, md);
+		free_start_sg(psock->sock, md, true);
 		kfree(md);
 	}
 
@@ -570,14 +570,16 @@ static void free_bytes_sg(struct sock *s
 	md->sg_start = i;
 }
 
-static int free_sg(struct sock *sk, int start, struct sk_msg_buff *md)
+static int free_sg(struct sock *sk, int start,
+		   struct sk_msg_buff *md, bool charge)
 {
 	struct scatterlist *sg = md->sg_data;
 	int i = start, free = 0;
 
 	while (sg[i].length) {
 		free += sg[i].length;
-		sk_mem_uncharge(sk, sg[i].length);
+		if (charge)
+			sk_mem_uncharge(sk, sg[i].length);
 		if (!md->skb)
 			put_page(sg_page(&sg[i]));
 		sg[i].length = 0;
@@ -594,9 +596,9 @@ static int free_sg(struct sock *sk, int
 	return free;
 }
 
-static int free_start_sg(struct sock *sk, struct sk_msg_buff *md)
+static int free_start_sg(struct sock *sk, struct sk_msg_buff *md, bool charge)
 {
-	int free = free_sg(sk, md->sg_start, md);
+	int free = free_sg(sk, md->sg_start, md, charge);
 
 	md->sg_start = md->sg_end;
 	return free;
@@ -604,7 +606,7 @@ static int free_start_sg(struct sock *sk
 
 static int free_curr_sg(struct sock *sk, struct sk_msg_buff *md)
 {
-	return free_sg(sk, md->sg_curr, md);
+	return free_sg(sk, md->sg_curr, md, true);
 }
 
 static int bpf_map_msg_verdict(int _rc, struct sk_msg_buff *md)
@@ -718,7 +720,7 @@ static int bpf_tcp_ingress(struct sock *
 		list_add_tail(&r->list, &psock->ingress);
 		sk->sk_data_ready(sk);
 	} else {
-		free_start_sg(sk, r);
+		free_start_sg(sk, r, true);
 		kfree(r);
 	}
 
@@ -755,14 +757,10 @@ static int bpf_tcp_sendmsg_do_redirect(s
 		release_sock(sk);
 	}
 	smap_release_sock(psock, sk);
-	if (unlikely(err))
-		goto out;
-	return 0;
+	return err;
 out_rcu:
 	rcu_read_unlock();
-out:
-	free_bytes_sg(NULL, send, md, false);
-	return err;
+	return 0;
 }
 
 static inline void bpf_md_init(struct smap_psock *psock)
@@ -825,7 +823,7 @@ more_data:
 	case __SK_PASS:
 		err = bpf_tcp_push(sk, send, m, flags, true);
 		if (unlikely(err)) {
-			*copied -= free_start_sg(sk, m);
+			*copied -= free_start_sg(sk, m, true);
 			break;
 		}
 
@@ -848,16 +846,17 @@ more_data:
 		lock_sock(sk);
 
 		if (unlikely(err < 0)) {
-			free_start_sg(sk, m);
+			int free = free_start_sg(sk, m, false);
+
 			psock->sg_size = 0;
 			if (!cork)
-				*copied -= send;
+				*copied -= free;
 		} else {
 			psock->sg_size -= send;
 		}
 
 		if (cork) {
-			free_start_sg(sk, m);
+			free_start_sg(sk, m, true);
 			psock->sg_size = 0;
 			kfree(m);
 			m = NULL;
@@ -1124,7 +1123,7 @@ wait_for_memory:
 		err = sk_stream_wait_memory(sk, &timeo);
 		if (err) {
 			if (m && m != psock->cork)
-				free_start_sg(sk, m);
+				free_start_sg(sk, m, true);
 			goto out_err;
 		}
 	}
@@ -1583,13 +1582,13 @@ static void smap_gc_work(struct work_str
 		bpf_prog_put(psock->bpf_tx_msg);
 
 	if (psock->cork) {
-		free_start_sg(psock->sock, psock->cork);
+		free_start_sg(psock->sock, psock->cork, true);
 		kfree(psock->cork);
 	}
 
 	list_for_each_entry_safe(md, mtmp, &psock->ingress, list) {
 		list_del(&md->list);
-		free_start_sg(psock->sock, md);
+		free_start_sg(psock->sock, md, true);
 		kfree(md);
 	}
 


