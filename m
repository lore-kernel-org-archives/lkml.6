Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7084C677E4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1375214C4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8Csqcc9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1375214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731357AbeJICAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:00:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:48878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727510AbeJICAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:00:16 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 148FC2087D;
        Mon,  8 Oct 2018 18:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024430;
        bh=3LsNPwVUyyOvfHyKsE0eXKcxjjXdszt8tL8VxKBBLGY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R8Csqcc9wnzeWD0sN99AiZz1vaYrMmP1Q6CKKwRSE49qBdOV8i5zp263SQn/5HsS0
         SoAsOwNFiuX9ACGnGQpT9xHOdK2qKQZR4Hz4tFYKe44sPM6XP5iOzop6YMzxG46U9P
         4nbDTyMunzoSJEqtr57d4kdylr9sqxNnTg7JRa3A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 012/168] bpf, sockmap: fix potential use after free in bpf_tcp_close
Date:   Mon,  8 Oct 2018 20:29:52 +0200
Message-Id: <20181008175620.507636913@linuxfoundation.org>
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

[ Upstream commit e06fa9c16ce4b740996189fa5610eabcee734e6c ]

bpf_tcp_close() we pop the psock linkage to a map via psock_map_pop().
A parallel update on the sock hash map can happen between psock_map_pop()
and lookup_elem_raw() where we override the element under link->hash /
link->key. In bpf_tcp_close()'s lookup_elem_raw() we subsequently only
test whether an element is present, but we do not test whether the
element is infact the element we were looking for.

We lock the sock in bpf_tcp_close() during that time, so do we hold
the lock in sock_hash_update_elem(). However, the latter locks the
sock which is newly updated, not the one we're purging from the hash
table. This means that while one CPU is doing the lookup from bpf_tcp_close(),
another CPU is doing the map update in parallel, dropped our sock from
the hlist and released the psock.

Subsequently the first CPU will find the new sock and attempts to drop
and release the old sock yet another time. Fix is that we need to check
the elements for a match after lookup, similar as we do in the sock map.
Note that the hash tab elems are freed via RCU, so access to their
link->hash / link->key is fine since we're under RCU read side there.

Fixes: e9db4ef6bf4c ("bpf: sockhash fix omitted bucket lock in sock_close")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/sockmap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/bpf/sockmap.c
+++ b/kernel/bpf/sockmap.c
@@ -369,7 +369,7 @@ static void bpf_tcp_close(struct sock *s
 			/* If another thread deleted this object skip deletion.
 			 * The refcnt on psock may or may not be zero.
 			 */
-			if (l) {
+			if (l && l == link) {
 				hlist_del_rcu(&link->hash_node);
 				smap_release_sock(psock, link->sk);
 				free_htab_elem(htab, link);


