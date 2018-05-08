Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoiNdrcDtplvCJicmFfsWM2AHcPt1cTaMQtmGh9AtjuogyjpytbRMwAUNMyZJI1GqlZ1RSu
ARC-Seal: i=1; a=rsa-sha256; t=1525767394; cv=none;
        d=google.com; s=arc-20160816;
        b=KwkUfohpFmJ/cg6q3F0xZdyLqnrVCcYNH8bmPzwW5sLK1ooTDI4NPMA21WrWJfAoX+
         WmOhbsC1qMTeF5rx8OVsgB5anXTcQLCMP0KbhVYtdBUtxxRmm7nH2ErBypUL9CYm2rI5
         lGp4qvqnmop+Z9q1jyb7YWn4Abo3geNzK6KvgsQ/IBj9ozPEDQgELMHMSuNUzhQH/pzk
         8+mQsGg92pRUihuEosy/S9DXwD5vChT/IWHaMjWLxAdBcjaVHFjubFDApmF55xP/v+JH
         JsgutLUycWV6gBI+i46jZTs8O+31GyGOTV8ol7GLFQJmrNmr1CipHbsxVdY03/piaiHK
         BTZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=psrsQX83YYy0XtE2z58XndPJCwbrl24EvGb0DvyKKy4=;
        b=LdIG/YivEHilgCmvQfTdnPsquNtxffQ/U92LAppvtjanB/SdZlvq+N0uoe4ZcuPcgg
         +Gl/1A7LFwCFX/lJahoieKyCnL4qSW/04Hm9K/2S+TpDghefgSq9NCAwvAO8jIq21iS4
         SpGsnBxq2Q0Mng23TaozjmPJd9hTOD844TVpmuCEh+ej181E0+J9ivMQ5A3ZMGncws2W
         9ayYiYVxCgWa5fA2LTC7G/V4oHLbgJTXW8fF0apU5+5xhI3Dcr2ngGNzDoxpbK0OHN8K
         boWNA1lFLyyJpYqEccD8fMU/OnhqsBlbqD+hakzEiJmE6nBBlso1Qji6HgbscM4G/T1U
         QmCQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=kaxvva0M;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=kaxvva0M;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Teng Qin <qinteng@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Chenbo Feng <fengc@google.com>,
	Lorenzo Colitti <lorenzo@google.com>
Subject: [PATCH 4.9 03/32] bpf: map_get_next_key to return first key on NULL
Date: Tue,  8 May 2018 10:10:43 +0200
Message-Id: <20180508074009.258256748@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508074008.800421598@linuxfoundation.org>
References: <20180508074008.800421598@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599883071702316267?=
X-GMAIL-MSGID: =?utf-8?q?1599883071702316267?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Teng Qin <qinteng@fb.com>

commit 8fe45924387be6b5c1be59a7eb330790c61d5d10 upstream.

When iterating through a map, we need to find a key that does not exist
in the map so map_get_next_key will give us the first key of the map.
This often requires a lot of guessing in production systems.

This patch makes map_get_next_key return the first key when the key
pointer in the parameter is NULL.

Signed-off-by: Teng Qin <qinteng@fb.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chenbo Feng <fengc@google.com>
Cc: Lorenzo Colitti <lorenzo@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/bpf/arraymap.c |    2 +-
 kernel/bpf/hashtab.c  |    9 +++++----
 kernel/bpf/syscall.c  |   18 +++++++++++-------
 3 files changed, 17 insertions(+), 12 deletions(-)

--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -190,7 +190,7 @@ int bpf_percpu_array_copy(struct bpf_map
 static int array_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
 {
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
-	u32 index = *(u32 *)key;
+	u32 index = key ? *(u32 *)key : U32_MAX;
 	u32 *next = (u32 *)next_key;
 
 	if (index >= array->map.max_entries) {
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -326,12 +326,15 @@ static int htab_map_get_next_key(struct
 	struct hlist_head *head;
 	struct htab_elem *l, *next_l;
 	u32 hash, key_size;
-	int i;
+	int i = 0;
 
 	WARN_ON_ONCE(!rcu_read_lock_held());
 
 	key_size = map->key_size;
 
+	if (!key)
+		goto find_first_elem;
+
 	hash = htab_map_hash(key, key_size);
 
 	head = select_bucket(htab, hash);
@@ -339,10 +342,8 @@ static int htab_map_get_next_key(struct
 	/* lookup the key */
 	l = lookup_elem_raw(head, hash, key, key_size);
 
-	if (!l) {
-		i = 0;
+	if (!l)
 		goto find_first_elem;
-	}
 
 	/* key was found, get next key in the same bucket */
 	next_l = hlist_entry_safe(rcu_dereference_raw(hlist_next_rcu(&l->hash_node)),
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -508,14 +508,18 @@ static int map_get_next_key(union bpf_at
 	if (IS_ERR(map))
 		return PTR_ERR(map);
 
-	err = -ENOMEM;
-	key = kmalloc(map->key_size, GFP_USER);
-	if (!key)
-		goto err_put;
+	if (ukey) {
+		err = -ENOMEM;
+		key = kmalloc(map->key_size, GFP_USER);
+		if (!key)
+			goto err_put;
 
-	err = -EFAULT;
-	if (copy_from_user(key, ukey, map->key_size) != 0)
-		goto free_key;
+		err = -EFAULT;
+		if (copy_from_user(key, ukey, map->key_size) != 0)
+			goto free_key;
+	} else {
+		key = NULL;
+	}
 
 	err = -ENOMEM;
 	next_key = kmalloc(map->key_size, GFP_USER);
