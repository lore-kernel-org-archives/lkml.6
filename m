Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E809BC43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4F7E24FDC
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4F7E24FDC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754883AbeFXPcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:32:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59148 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751965AbeFXPcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:32:03 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DC0F62C;
        Sun, 24 Jun 2018 15:32:01 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+5c74af81c547738e1684@syzkaller.appspotmail.com,
        syzbot+709f2810a6a05f11d4d3@syzkaller.appspotmail.com,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Watson <davejwatson@fb.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 12/64] tls: fix use-after-free in tls_push_record
Date:   Sun, 24 Jun 2018 23:21:53 +0800
Message-Id: <20180624142744.413455239@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180624142743.613370789@linuxfoundation.org>
References: <20180624142743.613370789@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Borkmann <daniel@iogearbox.net>

[ Upstream commit a447da7d00410278c90d3576782a43f8b675d7be ]

syzkaller managed to trigger a use-after-free in tls like the
following:

  BUG: KASAN: use-after-free in tls_push_record.constprop.15+0x6a2/0x810 [tls]
  Write of size 1 at addr ffff88037aa08000 by task a.out/2317

  CPU: 3 PID: 2317 Comm: a.out Not tainted 4.17.0+ #144
  Hardware name: LENOVO 20FBCTO1WW/20FBCTO1WW, BIOS N1FET47W (1.21 ) 11/28/2016
  Call Trace:
   dump_stack+0x71/0xab
   print_address_description+0x6a/0x280
   kasan_report+0x258/0x380
   ? tls_push_record.constprop.15+0x6a2/0x810 [tls]
   tls_push_record.constprop.15+0x6a2/0x810 [tls]
   tls_sw_push_pending_record+0x2e/0x40 [tls]
   tls_sk_proto_close+0x3fe/0x710 [tls]
   ? tcp_check_oom+0x4c0/0x4c0
   ? tls_write_space+0x260/0x260 [tls]
   ? kmem_cache_free+0x88/0x1f0
   inet_release+0xd6/0x1b0
   __sock_release+0xc0/0x240
   sock_close+0x11/0x20
   __fput+0x22d/0x660
   task_work_run+0x114/0x1a0
   do_exit+0x71a/0x2780
   ? mm_update_next_owner+0x650/0x650
   ? handle_mm_fault+0x2f5/0x5f0
   ? __do_page_fault+0x44f/0xa50
   ? mm_fault_error+0x2d0/0x2d0
   do_group_exit+0xde/0x300
   __x64_sys_exit_group+0x3a/0x50
   do_syscall_64+0x9a/0x300
   ? page_fault+0x8/0x30
   entry_SYSCALL_64_after_hwframe+0x44/0xa9

This happened through fault injection where aead_req allocation in
tls_do_encryption() eventually failed and we returned -ENOMEM from
the function. Turns out that the use-after-free is triggered from
tls_sw_sendmsg() in the second tls_push_record(). The error then
triggers a jump to waiting for memory in sk_stream_wait_memory()
resp. returning immediately in case of MSG_DONTWAIT. What follows is
the trim_both_sgl(sk, orig_size), which drops elements from the sg
list added via tls_sw_sendmsg(). Now the use-after-free gets triggered
when the socket is being closed, where tls_sk_proto_close() callback
is invoked. The tls_complete_pending_work() will figure that there's
a pending closed tls record to be flushed and thus calls into the
tls_push_pending_closed_record() from there. ctx->push_pending_record()
is called from the latter, which is the tls_sw_push_pending_record()
from sw path. This again calls into tls_push_record(). And here the
tls_fill_prepend() will panic since the buffer address has been freed
earlier via trim_both_sgl(). One way to fix it is to move the aead
request allocation out of tls_do_encryption() early into tls_push_record().
This means we don't prep the tls header and advance state to the
TLS_PENDING_CLOSED_RECORD before allocation which could potentially
fail happened. That fixes the issue on my side.

Fixes: 3c4d7559159b ("tls: kernel TLS support")
Reported-by: syzbot+5c74af81c547738e1684@syzkaller.appspotmail.com
Reported-by: syzbot+709f2810a6a05f11d4d3@syzkaller.appspotmail.com
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Dave Watson <davejwatson@fb.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tls/tls_sw.c |   26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -195,18 +195,12 @@ static void tls_free_both_sg(struct sock
 }
 
 static int tls_do_encryption(struct tls_context *tls_ctx,
-			     struct tls_sw_context *ctx, size_t data_len,
-			     gfp_t flags)
+			     struct tls_sw_context *ctx,
+			     struct aead_request *aead_req,
+			     size_t data_len)
 {
-	unsigned int req_size = sizeof(struct aead_request) +
-		crypto_aead_reqsize(ctx->aead_send);
-	struct aead_request *aead_req;
 	int rc;
 
-	aead_req = kzalloc(req_size, flags);
-	if (!aead_req)
-		return -ENOMEM;
-
 	ctx->sg_encrypted_data[0].offset += tls_ctx->prepend_size;
 	ctx->sg_encrypted_data[0].length -= tls_ctx->prepend_size;
 
@@ -223,7 +217,6 @@ static int tls_do_encryption(struct tls_
 	ctx->sg_encrypted_data[0].offset -= tls_ctx->prepend_size;
 	ctx->sg_encrypted_data[0].length += tls_ctx->prepend_size;
 
-	kfree(aead_req);
 	return rc;
 }
 
@@ -232,8 +225,14 @@ static int tls_push_record(struct sock *
 {
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
 	struct tls_sw_context *ctx = tls_sw_ctx(tls_ctx);
+	struct aead_request *req;
 	int rc;
 
+	req = kzalloc(sizeof(struct aead_request) +
+		      crypto_aead_reqsize(ctx->aead_send), sk->sk_allocation);
+	if (!req)
+		return -ENOMEM;
+
 	sg_mark_end(ctx->sg_plaintext_data + ctx->sg_plaintext_num_elem - 1);
 	sg_mark_end(ctx->sg_encrypted_data + ctx->sg_encrypted_num_elem - 1);
 
@@ -249,15 +248,14 @@ static int tls_push_record(struct sock *
 	tls_ctx->pending_open_record_frags = 0;
 	set_bit(TLS_PENDING_CLOSED_RECORD, &tls_ctx->flags);
 
-	rc = tls_do_encryption(tls_ctx, ctx, ctx->sg_plaintext_size,
-			       sk->sk_allocation);
+	rc = tls_do_encryption(tls_ctx, ctx, req, ctx->sg_plaintext_size);
 	if (rc < 0) {
 		/* If we are called from write_space and
 		 * we fail, we need to set this SOCK_NOSPACE
 		 * to trigger another write_space in the future.
 		 */
 		set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
-		return rc;
+		goto out_req;
 	}
 
 	free_sg(sk, ctx->sg_plaintext_data, &ctx->sg_plaintext_num_elem,
@@ -272,6 +270,8 @@ static int tls_push_record(struct sock *
 		tls_err_abort(sk);
 
 	tls_advance_record_sn(sk, tls_ctx);
+out_req:
+	kfree(req);
 	return rc;
 }
 


