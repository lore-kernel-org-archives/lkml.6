Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD2CFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD59B20893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:04:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD59B20893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbeG3LiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 07:38:21 -0400
Received: from www62.your-server.de ([213.133.104.62]:44206 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbeG3LiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 07:38:21 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fk522-0002E4-CZ; Mon, 30 Jul 2018 12:04:02 +0200
Received: from [62.203.87.61] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1fk522-000KsY-7b; Mon, 30 Jul 2018 12:04:02 +0200
Subject: Re: [PATCH v3] Add BPF_SYNCHRONIZE_MAP_TO_MAP_REFERENCES bpf(2)
 command
To:     Daniel Colascione <dancol@google.com>, joelaf@google.com
Cc:     linux-kernel@vger.kernel.org, timmurray@google.com,
        netdev@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Lorenzo Colitti <lorenzo@google.com>,
        Chenbo Feng <fengc@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexei Starovoitov <ast@fb.com>
References: <CAKOZuesQ6GdNTGDFsNi4o8LYzxLBtYZ=Cz4=aZbqqCNia+QFnQ@mail.gmail.com>
 <20180729205835.34850-1-dancol@google.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <e8f6e709-e694-ddad-b61e-d2ce1598dff3@iogearbox.net>
Date:   Mon, 30 Jul 2018 12:04:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180729205835.34850-1-dancol@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.0/24796/Mon Jul 30 10:41:17 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/29/2018 10:58 PM, Daniel Colascione wrote:
> BPF_SYNCHRONIZE_MAP_TO_MAP_REFERENCES waits for the release of all
> references to maps active at the instant the
> BPF_SYNCHRONIZE_MAP_TO_MAP_REFERENCES is
> issued. BPF_SYNCHRONIZE_MAP_TO_MAP_REFERENCES waits only for the
> expiration of map references obtained by BPF programs from other maps.
> 
> The purpose of this command is to provide a means for userspace to
> replace a BPF map with another, newer version, then ensure that no
> component is still using the "old" map before manipulating the "old"
> map in some way.
> 
> Signed-off-by: Daniel Colascione <dancol@google.com>
> ---
>  include/uapi/linux/bpf.h | 14 ++++++++++++++
>  kernel/bpf/syscall.c     | 13 +++++++++++++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index b7db3261c62d..ca3cfca76edc 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -75,6 +75,19 @@ struct bpf_lpm_trie_key {
>  	__u8	data[0];	/* Arbitrary size */
>  };
>  
> +/* BPF_SYNCHRONIZE_MAP_TO_MAP_REFERENCES waits for the release of all
> + * references to maps active at the instant the
> + * BPF_SYNCHRONIZE_MAP_TO_MAP_REFERENCES is
> + * issued. BPF_SYNCHRONIZE_MAP_TO_MAP_REFERENCES waits only for the
> + * expiration of map references obtained by BPF programs from
> + * other maps.
> + *
> + * The purpose of this command is to provide a means for userspace to
> + * replace a BPF map with another, newer version, then ensure that no
> + * component is still using the "old" map before manipulating the
> + * "old" map in some way.
> + */
> +
>  /* BPF syscall commands, see bpf(2) man-page for details. */
>  enum bpf_cmd {
>  	BPF_MAP_CREATE,
> @@ -98,6 +111,7 @@ enum bpf_cmd {
>  	BPF_BTF_LOAD,
>  	BPF_BTF_GET_FD_BY_ID,
>  	BPF_TASK_FD_QUERY,
> +	BPF_SYNCHRONIZE_MAP_TO_MAP_REFERENCES,
>  };
>  
>  enum bpf_map_type {
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index a31a1ba0f8ea..bc9a0713f47d 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -2274,6 +2274,19 @@ SYSCALL_DEFINE3(bpf, int, cmd, union bpf_attr __user *, uattr, unsigned int, siz
>  	if (sysctl_unprivileged_bpf_disabled && !capable(CAP_SYS_ADMIN))
>  		return -EPERM;
>  
> +	if (cmd == BPF_SYNCHRONIZE_MAP_TO_MAP_REFERENCES) {
> +		if (uattr != NULL || size != 0)
> +			return -EINVAL;
> +		err = security_bpf(cmd, NULL, 0);
> +		if (err < 0)
> +			return err;
> +		/* BPF programs always enter a critical section while
> +		 * they have a map reference outstanding.
> +		 */
> +		synchronize_rcu();
> +		return 0;
> +	}
> +
>  	err = bpf_check_uarg_tail_zero(uattr, sizeof(attr), size);
>  	if (err)
>  		return err;
> 

Hmm, I don't think such UAPI as above is future-proof. In case we would want
a similar mechanism in future for other maps, we would need a whole new bpf
command or reuse BPF_SYNCHRONIZE_MAP_TO_MAP_REFERENCES as a workaround though
the underlying map may not even be a map-to-map. Additionally, we don't have
any map object at hand in the above, so we couldn't make any finer grained
decisions either. Something like below would be more suitable and leaves room
for extending this further in future.

Thanks,
Daniel

From 8dfea71b73fa0d402633b76f78c106e82a7a5007 Mon Sep 17 00:00:00 2001
From: Daniel Borkmann <daniel@iogearbox.net>
Date: Mon, 30 Jul 2018 11:47:37 +0200
Subject: [PATCH] sync map refs

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 include/linux/bpf.h      |  1 +
 include/uapi/linux/bpf.h |  1 +
 kernel/bpf/arraymap.c    |  1 +
 kernel/bpf/hashtab.c     |  1 +
 kernel/bpf/map_in_map.c  |  6 ++++++
 kernel/bpf/map_in_map.h  |  1 +
 kernel/bpf/syscall.c     | 24 ++++++++++++++++++++++++
 7 files changed, 35 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5b5ad95..7b51f86 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -34,6 +34,7 @@ struct bpf_map_ops {
 	void (*map_free)(struct bpf_map *map);
 	int (*map_get_next_key)(struct bpf_map *map, void *key, void *next_key);
 	void (*map_release_uref)(struct bpf_map *map);
+	int (*map_sync_refs)(struct bpf_map *map);

 	/* funcs callable from userspace and from eBPF programs */
 	void *(*map_lookup_elem)(struct bpf_map *map, void *key);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 8701139..e6ec1de 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -98,6 +98,7 @@ enum bpf_cmd {
 	BPF_BTF_LOAD,
 	BPF_BTF_GET_FD_BY_ID,
 	BPF_TASK_FD_QUERY,
+	BPF_MAP_SYNC_REFS,
 };

 enum bpf_map_type {
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 544e58f..ddaf42a 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -748,5 +748,6 @@ const struct bpf_map_ops array_of_maps_map_ops = {
 	.map_fd_get_ptr = bpf_map_fd_get_ptr,
 	.map_fd_put_ptr = bpf_map_fd_put_ptr,
 	.map_fd_sys_lookup_elem = bpf_map_fd_sys_lookup_elem,
+	.map_sync_refs = bpf_map_sync_refs,
 	.map_gen_lookup = array_of_map_gen_lookup,
 };
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 513d9df..05380ea 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1407,5 +1407,6 @@ const struct bpf_map_ops htab_of_maps_map_ops = {
 	.map_fd_get_ptr = bpf_map_fd_get_ptr,
 	.map_fd_put_ptr = bpf_map_fd_put_ptr,
 	.map_fd_sys_lookup_elem = bpf_map_fd_sys_lookup_elem,
+	.map_sync_refs = bpf_map_sync_refs,
 	.map_gen_lookup = htab_of_map_gen_lookup,
 };
diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
index 1da5746..698a50f 100644
--- a/kernel/bpf/map_in_map.c
+++ b/kernel/bpf/map_in_map.c
@@ -96,6 +96,12 @@ void bpf_map_fd_put_ptr(void *ptr)
 	bpf_map_put(ptr);
 }

+int bpf_map_sync_refs(struct bpf_map *map)
+{
+	synchronize_rcu();
+	return 0;
+}
+
 u32 bpf_map_fd_sys_lookup_elem(void *ptr)
 {
 	return ((struct bpf_map *)ptr)->id;
diff --git a/kernel/bpf/map_in_map.h b/kernel/bpf/map_in_map.h
index 6183db9..ac02456 100644
--- a/kernel/bpf/map_in_map.h
+++ b/kernel/bpf/map_in_map.h
@@ -19,6 +19,7 @@ bool bpf_map_meta_equal(const struct bpf_map *meta0,
 void *bpf_map_fd_get_ptr(struct bpf_map *map, struct file *map_file,
 			 int ufd);
 void bpf_map_fd_put_ptr(void *ptr);
+int bpf_map_sync_refs(struct bpf_map *map);
 u32 bpf_map_fd_sys_lookup_elem(void *ptr);

 #endif
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a31a1ba..b1286cc 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -896,6 +896,27 @@ static int map_get_next_key(union bpf_attr *attr)
 	return err;
 }

+#define BPF_MAP_SYNC_REFS_LAST_FIELD map_fd
+
+static int map_sync_refs(union bpf_attr *attr)
+{
+	int err = -ENOTSUPP, ufd = attr->map_fd;
+	struct bpf_map *map;
+	struct fd f;
+
+	if (CHECK_ATTR(BPF_MAP_SYNC_REFS))
+		return -EINVAL;
+
+	f = fdget(ufd);
+	map = __bpf_map_get(f);
+	if (IS_ERR(map))
+		return PTR_ERR(map);
+	if (map->ops->map_sync_refs)
+		err = map->ops->map_sync_refs(map);
+	fdput(f);
+	return err;
+}
+
 static const struct bpf_prog_ops * const bpf_prog_types[] = {
 #define BPF_PROG_TYPE(_id, _name) \
 	[_id] = & _name ## _prog_ops,
@@ -2303,6 +2324,9 @@ SYSCALL_DEFINE3(bpf, int, cmd, union bpf_attr __user *, uattr, unsigned int, siz
 	case BPF_MAP_GET_NEXT_KEY:
 		err = map_get_next_key(&attr);
 		break;
+	case BPF_MAP_SYNC_REFS:
+		err = map_sync_refs(&attr);
+		break;
 	case BPF_PROG_LOAD:
 		err = bpf_prog_load(&attr);
 		break;
-- 
2.9.5
