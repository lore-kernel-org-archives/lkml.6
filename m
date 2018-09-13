Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F3FC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E51BA20854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:54:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E51BA20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731235AbeIMTEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:04:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33930 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730414AbeIMTEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:04:32 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D5442D1B;
        Thu, 13 Sep 2018 13:54:56 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 067/197] bpf, sockmap: fix leakage of smap_psock_map_entry
Date:   Thu, 13 Sep 2018 15:30:16 +0200
Message-Id: <20180913131844.199727283@linuxfoundation.org>
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

[ Upstream commit d40b0116c94bd8fc2b63aae35ce8e66bb53bba42 ]

While working on sockmap I noticed that we do not always kfree the
struct smap_psock_map_entry list elements which track psocks attached
to maps. In the case of sock_hash_ctx_update_elem(), these map entries
are allocated outside of __sock_map_ctx_update_elem() with their
linkage to the socket hash table filled. In the case of sock array,
the map entries are allocated inside of __sock_map_ctx_update_elem()
and added with their linkage to the psock->maps. Both additions are
under psock->maps_lock each.

Now, we drop these elements from their psock->maps list in a few
occasions: i) in sock array via smap_list_map_remove() when an entry
is either deleted from the map from user space, or updated via
user space or BPF program where we drop the old socket at that map
slot, or the sock array is freed via sock_map_free() and drops all
its elements; ii) for sock hash via smap_list_hash_remove() in exactly
the same occasions as just described for sock array; iii) in the
bpf_tcp_close() where we remove the elements from the list via
psock_map_pop() and iterate over them dropping themselves from either
sock array or sock hash; and last but not least iv) once again in
smap_gc_work() which is a callback for deferring the work once the
psock refcount hit zero and thus the socket is being destroyed.

Problem is that the only case where we kfree() the list entry is
in case iv), which at that point should have an empty list in
normal cases. So in cases from i) to iii) we unlink the elements
without freeing where they go out of reach from us. Hence fix is
to properly kfree() them as well to stop the leakage. Given these
are all handled under psock->maps_lock there is no need for deferred
RCU freeing.

I later also ran with kmemleak detector and it confirmed the finding
as well where in the state before the fix the object goes unreferenced
while after the patch no kmemleak report related to BPF showed up.

  [...]
  unreferenced object 0xffff880378eadae0 (size 64):
    comm "test_sockmap", pid 2225, jiffies 4294720701 (age 43.504s)
    hex dump (first 32 bytes):
      00 01 00 00 00 00 ad de 00 02 00 00 00 00 ad de  ................
      50 4d 75 5d 03 88 ff ff 00 00 00 00 00 00 00 00  PMu]............
    backtrace:
      [<000000005225ac3c>] sock_map_ctx_update_elem.isra.21+0xd8/0x210
      [<0000000045dd6d3c>] bpf_sock_map_update+0x29/0x60
      [<00000000877723aa>] ___bpf_prog_run+0x1e1f/0x4960
      [<000000002ef89e83>] 0xffffffffffffffff
  unreferenced object 0xffff880378ead240 (size 64):
    comm "test_sockmap", pid 2225, jiffies 4294720701 (age 43.504s)
    hex dump (first 32 bytes):
      00 01 00 00 00 00 ad de 00 02 00 00 00 00 ad de  ................
      00 44 75 5d 03 88 ff ff 00 00 00 00 00 00 00 00  .Du]............
    backtrace:
      [<000000005225ac3c>] sock_map_ctx_update_elem.isra.21+0xd8/0x210
      [<0000000030e37a3a>] sock_map_update_elem+0x125/0x240
      [<000000002e5ce36e>] map_update_elem+0x4eb/0x7b0
      [<00000000db453cc9>] __x64_sys_bpf+0x1f9/0x360
      [<0000000000763660>] do_syscall_64+0x9a/0x300
      [<00000000422a2bb2>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
      [<000000002ef89e83>] 0xffffffffffffffff
  [...]

Fixes: e9db4ef6bf4c ("bpf: sockhash fix omitted bucket lock in sock_close")
Fixes: 54fedb42c653 ("bpf: sockmap, fix smap_list_map_remove when psock is in many maps")
Fixes: 2f857d04601a ("bpf: sockmap, remove STRPARSER map_flags and add multi-map support")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Acked-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/sockmap.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/kernel/bpf/sockmap.c
+++ b/kernel/bpf/sockmap.c
@@ -376,6 +376,7 @@ static void bpf_tcp_close(struct sock *s
 			}
 			raw_spin_unlock_bh(&b->lock);
 		}
+		kfree(e);
 		e = psock_map_pop(sk, psock);
 	}
 	rcu_read_unlock();
@@ -1685,8 +1686,10 @@ static void smap_list_map_remove(struct
 
 	spin_lock_bh(&psock->maps_lock);
 	list_for_each_entry_safe(e, tmp, &psock->maps, list) {
-		if (e->entry == entry)
+		if (e->entry == entry) {
 			list_del(&e->list);
+			kfree(e);
+		}
 	}
 	spin_unlock_bh(&psock->maps_lock);
 }
@@ -1700,8 +1703,10 @@ static void smap_list_hash_remove(struct
 	list_for_each_entry_safe(e, tmp, &psock->maps, list) {
 		struct htab_elem *c = rcu_dereference(e->hash_link);
 
-		if (c == hash_link)
+		if (c == hash_link) {
 			list_del(&e->list);
+			kfree(e);
+		}
 	}
 	spin_unlock_bh(&psock->maps_lock);
 }


