Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54107C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21F5620879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548078538;
	bh=iCAjZKFux/eGfJTBKSCXoTkjwDxGLSYbg1OuQHcAxLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z8CsNf5vkbHK9SBGM14GSimXiHURz5Gqr96JSmVkA/khbHOhj2haniSYJnSH9lZhO
	 Q/FKbFiz4NtUPlifiTC79iXlD8tFURzZ64efiLN2mbsJkSR6xHMxniWOOjMn2p1jd1
	 1UCOadI/Ts3mCDkaDOSZffUfSWsZJmiyJxW2hpxY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbfAUNs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:48:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:58972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729441AbfAUNsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:48:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBF7320879;
        Mon, 21 Jan 2019 13:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078529;
        bh=iCAjZKFux/eGfJTBKSCXoTkjwDxGLSYbg1OuQHcAxLM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0r95DyN8khz91o9Tkv93tKnfavuuHQCWBpJFO7lUCRsAfSIdbq/96Rrip5QxjifQo
         o/J4Q2Wp8CYoG5PAp8jJXoptmoAWTkXjOAtPqL/staFWbCjkLptmgYTxg89KAhVXEV
         pWp30MPL1nbR8hRKL/XktZfKXicuqpn5m6hultrQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Subject: [PATCH 4.20 065/111] SUNRPC: Fix TCP receive code on archs with flush_dcache_page()
Date:   Mon, 21 Jan 2019 14:42:59 +0100
Message-Id: <20190121122503.621264445@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122455.819406896@linuxfoundation.org>
References: <20190121122455.819406896@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trondmy@gmail.com>

commit 6a829eb8619fbdde6d7d627ad582fe119805f39d upstream.

After receiving data into the page cache, we need to call flush_dcache_page()
for the architectures that define it.

Fixes: 277e4ab7d530b ("SUNRPC: Simplify TCP receive code by switching...")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: stable@vger.kernel.org # v4.20
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/sunrpc/xprtsock.c |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -48,6 +48,7 @@
 #include <net/udp.h>
 #include <net/tcp.h>
 #include <linux/bvec.h>
+#include <linux/highmem.h>
 #include <linux/uio.h>
 
 #include <trace/events/sunrpc.h>
@@ -380,6 +381,26 @@ xs_read_discard(struct socket *sock, str
 	return sock_recvmsg(sock, msg, flags);
 }
 
+#if ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
+static void
+xs_flush_bvec(const struct bio_vec *bvec, size_t count, size_t seek)
+{
+	struct bvec_iter bi = {
+		.bi_size = count,
+	};
+	struct bio_vec bv;
+
+	bvec_iter_advance(bvec, &bi, seek & PAGE_MASK);
+	for_each_bvec(bv, bvec, bi, bi)
+		flush_dcache_page(bv.bv_page);
+}
+#else
+static inline void
+xs_flush_bvec(const struct bio_vec *bvec, size_t count, size_t seek)
+{
+}
+#endif
+
 static ssize_t
 xs_read_xdr_buf(struct socket *sock, struct msghdr *msg, int flags,
 		struct xdr_buf *buf, size_t count, size_t seek, size_t *read)
@@ -413,6 +434,7 @@ xs_read_xdr_buf(struct socket *sock, str
 				seek + buf->page_base);
 		if (ret <= 0)
 			goto sock_err;
+		xs_flush_bvec(buf->bvec, ret, seek + buf->page_base);
 		offset += ret - buf->page_base;
 		if (offset == count || msg->msg_flags & (MSG_EOR|MSG_TRUNC))
 			goto out;


