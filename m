Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BD3C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4EF02084A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjciwfXt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4EF02084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731180AbeKCECa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:02:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:58290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729463AbeKCEC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:02:29 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33DE72084C;
        Fri,  2 Nov 2018 18:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184852;
        bh=15Zw9RL54Jx8FB/2+4D1qmEc+gVjMuOLHGDB3mehgW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JjciwfXt50NdbR25Nrli4/5PhuTpuhZt1h4BoMAuAF/34qWMZTfIAPHpSGzMUpUVV
         2t5+GSckTPXhuqdHGFfMRMJUvFqSZ+rDmIsNWjOqQwldymrVfO6YuhNFYCqEykc5b5
         zAnmnGwlbg1+Qfe0lIk782jXV+h+Y/DcZMTXBzCw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 076/143] bpf: sockmap, map_release does not hold refcnt for pinned maps
Date:   Fri,  2 Nov 2018 19:34:21 +0100
Message-Id: <20181102182903.541228511@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
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

[ Upstream commit ba6b8de423f8d0dee48d6030288ed81c03ddf9f0 ]

Relying on map_release hook to decrement the reference counts when a
map is removed only works if the map is not being pinned. In the
pinned case the ref is decremented immediately and the BPF programs
released. After this BPF programs may not be in-use which is not
what the user would expect.

This patch moves the release logic into bpf_map_put_uref() and brings
sockmap in-line with how a similar case is handled in prog array maps.

Fixes: 3d9e952697de ("bpf: sockmap, fix leaking maps with attached but not detached progs")
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/bpf.h   | 2 +-
 kernel/bpf/arraymap.c | 3 ++-
 kernel/bpf/sockmap.c  | 4 ++--
 kernel/bpf/syscall.c  | 4 ++--
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5c5be80ce802..c9d2a1a3ef11 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -27,6 +27,7 @@ struct bpf_map_ops {
 	void (*map_release)(struct bpf_map *map, struct file *map_file);
 	void (*map_free)(struct bpf_map *map);
 	int (*map_get_next_key)(struct bpf_map *map, void *key, void *next_key);
+	void (*map_release_uref)(struct bpf_map *map);
 
 	/* funcs callable from userspace and from eBPF programs */
 	void *(*map_lookup_elem)(struct bpf_map *map, void *key);
@@ -300,7 +301,6 @@ int bpf_stackmap_copy(struct bpf_map *map, void *key, void *value);
 int bpf_fd_array_map_update_elem(struct bpf_map *map, struct file *map_file,
 				 void *key, void *value, u64 map_flags);
 int bpf_fd_array_map_lookup_elem(struct bpf_map *map, void *key, u32 *value);
-void bpf_fd_array_map_clear(struct bpf_map *map);
 int bpf_fd_htab_map_update_elem(struct bpf_map *map, struct file *map_file,
 				void *key, void *value, u64 map_flags);
 int bpf_fd_htab_map_lookup_elem(struct bpf_map *map, void *key, u32 *value);
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index f57d0bdf3c9e..a8f55ea4146b 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -467,7 +467,7 @@ static u32 prog_fd_array_sys_lookup_elem(void *ptr)
 }
 
 /* decrement refcnt of all bpf_progs that are stored in this map */
-void bpf_fd_array_map_clear(struct bpf_map *map)
+static void bpf_fd_array_map_clear(struct bpf_map *map)
 {
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
 	int i;
@@ -485,6 +485,7 @@ const struct bpf_map_ops prog_array_map_ops = {
 	.map_fd_get_ptr = prog_fd_array_get_ptr,
 	.map_fd_put_ptr = prog_fd_array_put_ptr,
 	.map_fd_sys_lookup_elem = prog_fd_array_sys_lookup_elem,
+	.map_release_uref = bpf_fd_array_map_clear,
 };
 
 static struct bpf_event_entry *bpf_event_entry_gen(struct file *perf_file,
diff --git a/kernel/bpf/sockmap.c b/kernel/bpf/sockmap.c
index 20eaddfa691c..22991e19c01c 100644
--- a/kernel/bpf/sockmap.c
+++ b/kernel/bpf/sockmap.c
@@ -875,7 +875,7 @@ static int sock_map_update_elem(struct bpf_map *map,
 	return err;
 }
 
-static void sock_map_release(struct bpf_map *map, struct file *map_file)
+static void sock_map_release(struct bpf_map *map)
 {
 	struct bpf_stab *stab = container_of(map, struct bpf_stab, map);
 	struct bpf_prog *orig;
@@ -895,7 +895,7 @@ const struct bpf_map_ops sock_map_ops = {
 	.map_get_next_key = sock_map_get_next_key,
 	.map_update_elem = sock_map_update_elem,
 	.map_delete_elem = sock_map_delete_elem,
-	.map_release = sock_map_release,
+	.map_release_uref = sock_map_release,
 };
 
 BPF_CALL_4(bpf_sock_map_update, struct bpf_sock_ops_kern *, bpf_sock,
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 4e933219fec6..ea22d0b6a9f0 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -214,8 +214,8 @@ static void bpf_map_free_deferred(struct work_struct *work)
 static void bpf_map_put_uref(struct bpf_map *map)
 {
 	if (atomic_dec_and_test(&map->usercnt)) {
-		if (map->map_type == BPF_MAP_TYPE_PROG_ARRAY)
-			bpf_fd_array_map_clear(map);
+		if (map->ops->map_release_uref)
+			map->ops->map_release_uref(map);
 	}
 }
 
-- 
2.17.1



