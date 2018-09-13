Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9226DC07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 533FB20854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:54:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 533FB20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731047AbeIMTEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:04:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33866 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728671AbeIMTEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:04:11 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E1A11D1B;
        Thu, 13 Sep 2018 13:54:34 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 063/197] bpf, sockmap: fix map elem deletion race with smap_stop_sock
Date:   Thu, 13 Sep 2018 15:30:12 +0200
Message-Id: <20180913131844.047074315@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
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

[ Upstream commit 166ab6f0a0702fdd4d865ad5090bf3094ed83428 ]

The smap_start_sock() and smap_stop_sock() are each protected under
the sock->sk_callback_lock from their call-sites except in the case
of sock_map_delete_elem() where we drop the old socket from the map
slot. This is racy because the same sock could be part of multiple
sock maps, so we run smap_stop_sock() in parallel, and given at that
point psock->strp_enabled might be true on both CPUs, we might for
example wrongly restore the sk->sk_data_ready / sk->sk_write_space.
Therefore, hold the sock->sk_callback_lock as well on delete. Looks
like 2f857d04601a ("bpf: sockmap, remove STRPARSER map_flags and add
multi-map support") had this right, but later on e9db4ef6bf4c ("bpf:
sockhash fix omitted bucket lock in sock_close") removed it again
from delete leaving this smap_stop_sock() instance unprotected.

Fixes: e9db4ef6bf4c ("bpf: sockhash fix omitted bucket lock in sock_close")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Acked-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/sockmap.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/kernel/bpf/sockmap.c
+++ b/kernel/bpf/sockmap.c
@@ -1784,8 +1784,11 @@ static int sock_map_delete_elem(struct b
 	if (!psock)
 		goto out;
 
-	if (psock->bpf_parse)
+	if (psock->bpf_parse) {
+		write_lock_bh(&sock->sk_callback_lock);
 		smap_stop_sock(psock, sock);
+		write_unlock_bh(&sock->sk_callback_lock);
+	}
 	smap_list_map_remove(psock, &stab->sock_map[k]);
 	smap_release_sock(psock, sock);
 out:


