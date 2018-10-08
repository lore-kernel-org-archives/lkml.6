Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844E9C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D3C8214DC
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOZgMGjw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D3C8214DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731557AbeJICBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:01:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:49930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728239AbeJICBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:01:02 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 156DC214C2;
        Mon,  8 Oct 2018 18:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024475;
        bh=oLfD5pePvazR8pMVlAWlYLXI6itcODynxHkSj9/0aNE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MOZgMGjwIxCzF9GWu7xz+ibnlMj2SPiUWOD+h7Vz+ei74o2cVcLzI6Z2FIjMdj++w
         pbqhOvQmxmN3DYv8pgOsorNhcYEny4gy9LGDL8HDsS10hKRk7aHSrjUxBHx0Suefjr
         5XfWmSNGJQyNKcaxFLXXbrh0khNYwXT+QhUnusA4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 052/168] bpf: avoid misuse of psock when TCP_ULP_BPF collides with another ULP
Date:   Mon,  8 Oct 2018 20:30:32 +0200
Message-Id: <20181008175622.029416852@linuxfoundation.org>
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

[ Upstream commit 597222f72a94118f593e4f32bf58ae7e049a0df1 ]

Currently we check sk_user_data is non NULL to determine if the sk
exists in a map. However, this is not sufficient to ensure the psock
or the ULP ops are not in use by another user, such as kcm or TLS. To
avoid this when adding a sock to a map also verify it is of the
correct ULP type. Additionally, when releasing a psock verify that
it is the TCP_ULP_BPF type before releasing the ULP. The error case
where we abort an update due to ULP collision can cause this error
path.

For example,

  __sock_map_ctx_update_elem()
     [...]
     err = tcp_set_ulp_id(sock, TCP_ULP_BPF) <- collides with TLS
     if (err)                                <- so err out here
        goto out_free
     [...]
  out_free:
     smap_release_sock() <- calling tcp_cleanup_ulp releases the
                            TLS ULP incorrectly.

Fixes: 2f857d04601a ("bpf: sockmap, remove STRPARSER map_flags and add multi-map support")
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/sockmap.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/kernel/bpf/sockmap.c
+++ b/kernel/bpf/sockmap.c
@@ -1465,10 +1465,16 @@ static void smap_destroy_psock(struct rc
 	schedule_work(&psock->gc_work);
 }
 
+static bool psock_is_smap_sk(struct sock *sk)
+{
+	return inet_csk(sk)->icsk_ulp_ops == &bpf_tcp_ulp_ops;
+}
+
 static void smap_release_sock(struct smap_psock *psock, struct sock *sock)
 {
 	if (refcount_dec_and_test(&psock->refcnt)) {
-		tcp_cleanup_ulp(sock);
+		if (psock_is_smap_sk(sock))
+			tcp_cleanup_ulp(sock);
 		write_lock_bh(&sock->sk_callback_lock);
 		smap_stop_sock(psock, sock);
 		write_unlock_bh(&sock->sk_callback_lock);
@@ -1895,6 +1901,10 @@ static int __sock_map_ctx_update_elem(st
 	 * doesn't update user data.
 	 */
 	if (psock) {
+		if (!psock_is_smap_sk(sock)) {
+			err = -EBUSY;
+			goto out_progs;
+		}
 		if (READ_ONCE(psock->bpf_parse) && parse) {
 			err = -EBUSY;
 			goto out_progs;


