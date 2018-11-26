Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86036C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EDE22089F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dImigbXc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EDE22089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730114AbeKZVzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:55:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:37520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728901AbeKZVzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:55:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 978EE21104;
        Mon, 26 Nov 2018 11:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230081;
        bh=NPXZctWdD8HkuVKfjvbEvSEuG4lx8Z4qdvAFPo/WUHg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dImigbXcWomY7t2ypfOGI6j+4vEcMFKFq27VziGSF22xl6GRU3BHxnE3koG6yZ49n
         835yWuTWy/qcOUm9Lx3rTiGjyymB4aWnA+iIwfXIXHX+rAuCL51GVLOkSveAN8O2lI
         6rZgwFEE+CYxWiLxqk+LnDkE8J44L8TRV8Fv6qtg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 4.14 62/62] libceph: fall back to sendmsg for slab pages
Date:   Mon, 26 Nov 2018 11:51:43 +0100
Message-Id: <20181126105055.188894611@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105050.592727680@linuxfoundation.org>
References: <20181126105050.592727680@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilya Dryomov <idryomov@gmail.com>

commit 7e241f647dc7087a0401418a187f3f5b527cc690 upstream.

skb_can_coalesce() allows coalescing neighboring slab objects into
a single frag:

  return page == skb_frag_page(frag) &&
         off == frag->page_offset + skb_frag_size(frag);

ceph_tcp_sendpage() can be handed slab pages.  One example of this is
XFS: it passes down sector sized slab objects for its metadata I/O.  If
the kernel client is co-located on the OSD node, the skb may go through
loopback and pop on the receive side with the exact same set of frags.
When tcp_recvmsg() attempts to copy out such a frag, hardened usercopy
complains because the size exceeds the object's allocated size:

  usercopy: kernel memory exposure attempt detected from ffff9ba917f20a00 (kmalloc-512) (1024 bytes)

Although skb_can_coalesce() could be taught to return false if the
resulting frag would cross a slab object boundary, we already have
a fallback for non-refcounted pages.  Utilize it for slab pages too.

Cc: stable@vger.kernel.org # 4.8+
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ceph/messenger.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -594,9 +594,15 @@ static int ceph_tcp_sendpage(struct sock
 	struct bio_vec bvec;
 	int ret;
 
-	/* sendpage cannot properly handle pages with page_count == 0,
-	 * we need to fallback to sendmsg if that's the case */
-	if (page_count(page) >= 1)
+	/*
+	 * sendpage cannot properly handle pages with page_count == 0,
+	 * we need to fall back to sendmsg if that's the case.
+	 *
+	 * Same goes for slab pages: skb_can_coalesce() allows
+	 * coalescing neighboring slab objects into a single frag which
+	 * triggers one of hardened usercopy checks.
+	 */
+	if (page_count(page) >= 1 && !PageSlab(page))
 		return __ceph_tcp_sendpage(sock, page, offset, size, more);
 
 	bvec.bv_page = page;


