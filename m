Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FE5C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D039F20854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:54:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D039F20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731213AbeIMTEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:04:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33904 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbeIMTEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:04:23 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1CD4ED19;
        Thu, 13 Sep 2018 13:54:46 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 065/197] bpf, sockmap: fix sock_map_ctx_update_elem race with exist/noexist
Date:   Thu, 13 Sep 2018 15:30:14 +0200
Message-Id: <20180913131844.125576816@linuxfoundation.org>
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

[ Upstream commit 585f5a6252ee43ec8feeee07387e3fcc7e8bb292 ]

The current code in sock_map_ctx_update_elem() allows for BPF_EXIST
and BPF_NOEXIST map update flags. While on array-like maps this approach
is rather uncommon, e.g. bpf_fd_array_map_update_elem() and others
enforce map update flags to be BPF_ANY such that xchg() can be used
directly, the current implementation in sock map does not guarantee
that such operation with BPF_EXIST / BPF_NOEXIST is atomic.

The initial test does a READ_ONCE(stab->sock_map[i]) to fetch the
socket from the slot which is then tested for NULL / non-NULL. However
later after __sock_map_ctx_update_elem(), the actual update is done
through osock = xchg(&stab->sock_map[i], sock). Problem is that in
the meantime a different CPU could have updated / deleted a socket
on that specific slot and thus flag contraints won't hold anymore.

I've been thinking whether best would be to just break UAPI and do
an enforcement of BPF_ANY to check if someone actually complains,
however trouble is that already in BPF kselftest we use BPF_NOEXIST
for the map update, and therefore it might have been copied into
applications already. The fix to keep the current behavior intact
would be to add a map lock similar to the sock hash bucket lock only
for covering the whole map.

Fixes: 174a79ff9515 ("bpf: sockmap with sk redirect support")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Acked-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/sockmap.c |  106 +++++++++++++++++++++++++++------------------------
 1 file changed, 57 insertions(+), 49 deletions(-)

--- a/kernel/bpf/sockmap.c
+++ b/kernel/bpf/sockmap.c
@@ -58,6 +58,7 @@ struct bpf_stab {
 	struct bpf_map map;
 	struct sock **sock_map;
 	struct bpf_sock_progs progs;
+	raw_spinlock_t lock;
 };
 
 struct bucket {
@@ -89,9 +90,9 @@ enum smap_psock_state {
 
 struct smap_psock_map_entry {
 	struct list_head list;
+	struct bpf_map *map;
 	struct sock **entry;
 	struct htab_elem __rcu *hash_link;
-	struct bpf_htab __rcu *htab;
 };
 
 struct smap_psock {
@@ -343,13 +344,18 @@ static void bpf_tcp_close(struct sock *s
 	e = psock_map_pop(sk, psock);
 	while (e) {
 		if (e->entry) {
-			osk = cmpxchg(e->entry, sk, NULL);
+			struct bpf_stab *stab = container_of(e->map, struct bpf_stab, map);
+
+			raw_spin_lock_bh(&stab->lock);
+			osk = *e->entry;
 			if (osk == sk) {
+				*e->entry = NULL;
 				smap_release_sock(psock, sk);
 			}
+			raw_spin_unlock_bh(&stab->lock);
 		} else {
 			struct htab_elem *link = rcu_dereference(e->hash_link);
-			struct bpf_htab *htab = rcu_dereference(e->htab);
+			struct bpf_htab *htab = container_of(e->map, struct bpf_htab, map);
 			struct hlist_head *head;
 			struct htab_elem *l;
 			struct bucket *b;
@@ -1644,6 +1650,7 @@ static struct bpf_map *sock_map_alloc(un
 		return ERR_PTR(-ENOMEM);
 
 	bpf_map_init_from_attr(&stab->map, attr);
+	raw_spin_lock_init(&stab->lock);
 
 	/* make sure page count doesn't overflow */
 	cost = (u64) stab->map.max_entries * sizeof(struct sock *);
@@ -1714,14 +1721,15 @@ static void sock_map_free(struct bpf_map
 	 * and a grace period expire to ensure psock is really safe to remove.
 	 */
 	rcu_read_lock();
+	raw_spin_lock_bh(&stab->lock);
 	for (i = 0; i < stab->map.max_entries; i++) {
 		struct smap_psock *psock;
 		struct sock *sock;
 
-		sock = xchg(&stab->sock_map[i], NULL);
+		sock = stab->sock_map[i];
 		if (!sock)
 			continue;
-
+		stab->sock_map[i] = NULL;
 		psock = smap_psock_sk(sock);
 		/* This check handles a racing sock event that can get the
 		 * sk_callback_lock before this case but after xchg happens
@@ -1733,6 +1741,7 @@ static void sock_map_free(struct bpf_map
 			smap_release_sock(psock, sock);
 		}
 	}
+	raw_spin_unlock_bh(&stab->lock);
 	rcu_read_unlock();
 
 	sock_map_remove_complete(stab);
@@ -1776,14 +1785,16 @@ static int sock_map_delete_elem(struct b
 	if (k >= map->max_entries)
 		return -EINVAL;
 
-	sock = xchg(&stab->sock_map[k], NULL);
+	raw_spin_lock_bh(&stab->lock);
+	sock = stab->sock_map[k];
+	stab->sock_map[k] = NULL;
+	raw_spin_unlock_bh(&stab->lock);
 	if (!sock)
 		return -EINVAL;
 
 	psock = smap_psock_sk(sock);
 	if (!psock)
-		goto out;
-
+		return 0;
 	if (psock->bpf_parse) {
 		write_lock_bh(&sock->sk_callback_lock);
 		smap_stop_sock(psock, sock);
@@ -1791,7 +1802,6 @@ static int sock_map_delete_elem(struct b
 	}
 	smap_list_map_remove(psock, &stab->sock_map[k]);
 	smap_release_sock(psock, sock);
-out:
 	return 0;
 }
 
@@ -1827,11 +1837,9 @@ out:
 static int __sock_map_ctx_update_elem(struct bpf_map *map,
 				      struct bpf_sock_progs *progs,
 				      struct sock *sock,
-				      struct sock **map_link,
 				      void *key)
 {
 	struct bpf_prog *verdict, *parse, *tx_msg;
-	struct smap_psock_map_entry *e = NULL;
 	struct smap_psock *psock;
 	bool new = false;
 	int err = 0;
@@ -1904,14 +1912,6 @@ static int __sock_map_ctx_update_elem(st
 		new = true;
 	}
 
-	if (map_link) {
-		e = kzalloc(sizeof(*e), GFP_ATOMIC | __GFP_NOWARN);
-		if (!e) {
-			err = -ENOMEM;
-			goto out_free;
-		}
-	}
-
 	/* 3. At this point we have a reference to a valid psock that is
 	 * running. Attach any BPF programs needed.
 	 */
@@ -1933,17 +1933,6 @@ static int __sock_map_ctx_update_elem(st
 		write_unlock_bh(&sock->sk_callback_lock);
 	}
 
-	/* 4. Place psock in sockmap for use and stop any programs on
-	 * the old sock assuming its not the same sock we are replacing
-	 * it with. Because we can only have a single set of programs if
-	 * old_sock has a strp we can stop it.
-	 */
-	if (map_link) {
-		e->entry = map_link;
-		spin_lock_bh(&psock->maps_lock);
-		list_add_tail(&e->list, &psock->maps);
-		spin_unlock_bh(&psock->maps_lock);
-	}
 	return err;
 out_free:
 	smap_release_sock(psock, sock);
@@ -1954,7 +1943,6 @@ out_progs:
 	}
 	if (tx_msg)
 		bpf_prog_put(tx_msg);
-	kfree(e);
 	return err;
 }
 
@@ -1964,36 +1952,57 @@ static int sock_map_ctx_update_elem(stru
 {
 	struct bpf_stab *stab = container_of(map, struct bpf_stab, map);
 	struct bpf_sock_progs *progs = &stab->progs;
-	struct sock *osock, *sock;
+	struct sock *osock, *sock = skops->sk;
+	struct smap_psock_map_entry *e;
+	struct smap_psock *psock;
 	u32 i = *(u32 *)key;
 	int err;
 
 	if (unlikely(flags > BPF_EXIST))
 		return -EINVAL;
-
 	if (unlikely(i >= stab->map.max_entries))
 		return -E2BIG;
 
-	sock = READ_ONCE(stab->sock_map[i]);
-	if (flags == BPF_EXIST && !sock)
-		return -ENOENT;
-	else if (flags == BPF_NOEXIST && sock)
-		return -EEXIST;
+	e = kzalloc(sizeof(*e), GFP_ATOMIC | __GFP_NOWARN);
+	if (!e)
+		return -ENOMEM;
 
-	sock = skops->sk;
-	err = __sock_map_ctx_update_elem(map, progs, sock, &stab->sock_map[i],
-					 key);
+	err = __sock_map_ctx_update_elem(map, progs, sock, key);
 	if (err)
 		goto out;
 
-	osock = xchg(&stab->sock_map[i], sock);
-	if (osock) {
-		struct smap_psock *opsock = smap_psock_sk(osock);
+	/* psock guaranteed to be present. */
+	psock = smap_psock_sk(sock);
+	raw_spin_lock_bh(&stab->lock);
+	osock = stab->sock_map[i];
+	if (osock && flags == BPF_NOEXIST) {
+		err = -EEXIST;
+		goto out_unlock;
+	}
+	if (!osock && flags == BPF_EXIST) {
+		err = -ENOENT;
+		goto out_unlock;
+	}
+
+	e->entry = &stab->sock_map[i];
+	e->map = map;
+	spin_lock_bh(&psock->maps_lock);
+	list_add_tail(&e->list, &psock->maps);
+	spin_unlock_bh(&psock->maps_lock);
 
-		smap_list_map_remove(opsock, &stab->sock_map[i]);
-		smap_release_sock(opsock, osock);
+	stab->sock_map[i] = sock;
+	if (osock) {
+		psock = smap_psock_sk(osock);
+		smap_list_map_remove(psock, &stab->sock_map[i]);
+		smap_release_sock(psock, osock);
 	}
+	raw_spin_unlock_bh(&stab->lock);
+	return 0;
+out_unlock:
+	smap_release_sock(psock, sock);
+	raw_spin_unlock_bh(&stab->lock);
 out:
+	kfree(e);
 	return err;
 }
 
@@ -2356,7 +2365,7 @@ static int sock_hash_ctx_update_elem(str
 	b = __select_bucket(htab, hash);
 	head = &b->head;
 
-	err = __sock_map_ctx_update_elem(map, progs, sock, NULL, key);
+	err = __sock_map_ctx_update_elem(map, progs, sock, key);
 	if (err)
 		goto err;
 
@@ -2382,8 +2391,7 @@ static int sock_hash_ctx_update_elem(str
 	}
 
 	rcu_assign_pointer(e->hash_link, l_new);
-	rcu_assign_pointer(e->htab,
-			   container_of(map, struct bpf_htab, map));
+	e->map = map;
 	spin_lock_bh(&psock->maps_lock);
 	list_add_tail(&e->list, &psock->maps);
 	spin_unlock_bh(&psock->maps_lock);


