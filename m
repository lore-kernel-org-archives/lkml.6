Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AB8JxZquFGmm1RMhEeIMKC18g++e97rhpB+WeP8XiQmxKGBAEZtsK5tqH+wvrafABPQCEyx+L3HB
ARC-Seal: i=1; a=rsa-sha256; t=1525146803; cv=none;
        d=google.com; s=arc-20160816;
        b=rZznEYZL5a6hAdkBwdzdPpwHvABJrs6lM9YtN9IdvKiyuxIqvN5J1sGq+Sc7sO1sNT
         8Cuw1FWMRnnHuI/L692zaz2EIp5zlHr7vOc/Cc8BxnmFhq4LoSK0GN/aByCoQZcFU8KB
         r2XEQzUnhcJc3YGeb80xEdkT1zTjeODs/IH1+KdzM4MkLHJXZeLyXA613M4Vf0u5l+1t
         lTv4WE2XY2eX3gqNsMbp3qpWznjABVhGSGaZNxOT2PS6YKCdlNexVwP6WVCOwheZsbJs
         1cBGlpOabCH9byllbboFUPc5MrYYK6slNDg/d47BizfiCpXpcTz0KD52tBEUGQ39hWiN
         zckA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=Uqo69BuPC0z68tJ3X6GrZ2/K/kaDfrN0FQIqz/ISxgc=;
        b=xsu40HZuhbNHCxDUdQx+GgT9wYyzDbMnfs8gZ4BVoTkQQ7196Nq3O7TbgrXjln5R+z
         6KsL8EH9FYaAgZE0+M1bNpY8Hh5W2bPwwhrQQHdKDdmAz55cgwk1Tpbq4EPlsiVlHbwL
         8UsBYz7a22BSfZMcHaF5/N8HCjg22pAIBck4VAkU1uyZG+HKmN/2lM+2yudwLmRPlzTF
         4LoTKFFCkdkvdpDmwKyBVeYlIG3hshh3vFQrCRbrK+GPxM71v6LXTlTksuIYpFkNeI3m
         aJOGCAr8h91O4H47pmnMMDiAxU/p9c0GAT8N3q0NM1A4cLY9bd6YwM9w/GwvkmXade7V
         djoQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 James Simmons <jsimmons@infradead.org>,
 Andreas Dilger <andreas.dilger@intel.com>
Date: Tue, 01 May 2018 13:52:38 +1000
Subject: [PATCH 03/10] staging: lustre: lu_object: discard extra lru count.
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Message-ID: <152514675893.17843.8396665070911641266.stgit@noble>
In-Reply-To: <152514658325.17843.11455067361317157487.stgit@noble>
References: <152514658325.17843.11455067361317157487.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599232334415255756?=
X-GMAIL-MSGID: =?utf-8?q?1599232334415255756?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

lu_object maintains 2 lru counts.
One is a per-bucket lsb_lru_len.
The other is the per-cpu ls_lru_len_counter.

The only times the per-bucket counters are use are:
- a debug message when an object is added
- in lu_site_stats_get when all the counters are combined.

The debug message is not essential, and the per-cpu counter
can be used to get the combined total.

So discard the per-bucket lsb_lru_len.

Signed-off-by: NeilBrown <neilb@suse.com>
Reviewed-by: Andreas Dilger <andreas.dilger@dilger.ca>
---
 drivers/staging/lustre/lustre/obdclass/lu_object.c |   24 ++++++++------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/lustre/lustre/obdclass/lu_object.c b/drivers/staging/lustre/lustre/obdclass/lu_object.c
index 2a8a25d6edb5..2bf089817157 100644
--- a/drivers/staging/lustre/lustre/obdclass/lu_object.c
+++ b/drivers/staging/lustre/lustre/obdclass/lu_object.c
@@ -57,10 +57,6 @@
 #include <linux/list.h>
 
 struct lu_site_bkt_data {
-	/**
-	 * number of object in this bucket on the lsb_lru list.
-	 */
-	long			lsb_lru_len;
 	/**
 	 * LRU list, updated on each access to object. Protected by
 	 * bucket lock of lu_site::ls_obj_hash.
@@ -187,10 +183,9 @@ void lu_object_put(const struct lu_env *env, struct lu_object *o)
 	if (!lu_object_is_dying(top)) {
 		LASSERT(list_empty(&top->loh_lru));
 		list_add_tail(&top->loh_lru, &bkt->lsb_lru);
-		bkt->lsb_lru_len++;
 		percpu_counter_inc(&site->ls_lru_len_counter);
-		CDEBUG(D_INODE, "Add %p to site lru. hash: %p, bkt: %p, lru_len: %ld\n",
-		       o, site->ls_obj_hash, bkt, bkt->lsb_lru_len);
+		CDEBUG(D_INODE, "Add %p to site lru. hash: %p, bkt: %p\n",
+		       o, site->ls_obj_hash, bkt);
 		cfs_hash_bd_unlock(site->ls_obj_hash, &bd, 1);
 		return;
 	}
@@ -238,7 +233,6 @@ void lu_object_unhash(const struct lu_env *env, struct lu_object *o)
 
 			list_del_init(&top->loh_lru);
 			bkt = cfs_hash_bd_extra_get(obj_hash, &bd);
-			bkt->lsb_lru_len--;
 			percpu_counter_dec(&site->ls_lru_len_counter);
 		}
 		cfs_hash_bd_del_locked(obj_hash, &bd, &top->loh_hash);
@@ -422,7 +416,6 @@ int lu_site_purge_objects(const struct lu_env *env, struct lu_site *s,
 			cfs_hash_bd_del_locked(s->ls_obj_hash,
 					       &bd2, &h->loh_hash);
 			list_move(&h->loh_lru, &dispose);
-			bkt->lsb_lru_len--;
 			percpu_counter_dec(&s->ls_lru_len_counter);
 			if (did_sth == 0)
 				did_sth = 1;
@@ -621,7 +614,6 @@ static struct lu_object *htable_lookup(struct lu_site *s,
 		lprocfs_counter_incr(s->ls_stats, LU_SS_CACHE_HIT);
 		if (!list_empty(&h->loh_lru)) {
 			list_del_init(&h->loh_lru);
-			bkt->lsb_lru_len--;
 			percpu_counter_dec(&s->ls_lru_len_counter);
 		}
 		return lu_object_top(h);
@@ -1834,19 +1826,21 @@ struct lu_site_stats {
 	unsigned int	lss_busy;
 };
 
-static void lu_site_stats_get(struct cfs_hash *hs,
+static void lu_site_stats_get(const struct lu_site *s,
 			      struct lu_site_stats *stats, int populated)
 {
+	struct cfs_hash *hs = s->ls_obj_hash;
 	struct cfs_hash_bd bd;
 	unsigned int i;
+	/* percpu_counter_read_positive() won't accept a const pointer */
+	struct lu_site *s2 = (struct lu_site *)s;
 
+	stats->lss_busy += cfs_hash_size_get(hs) -
+		percpu_counter_read_positive(&s2->ls_lru_len_counter);
 	cfs_hash_for_each_bucket(hs, &bd, i) {
-		struct lu_site_bkt_data *bkt = cfs_hash_bd_extra_get(hs, &bd);
 		struct hlist_head	*hhead;
 
 		cfs_hash_bd_lock(hs, &bd, 1);
-		stats->lss_busy  +=
-			cfs_hash_bd_count_get(&bd) - bkt->lsb_lru_len;
 		stats->lss_total += cfs_hash_bd_count_get(&bd);
 		stats->lss_max_search = max((int)stats->lss_max_search,
 					    cfs_hash_bd_depmax_get(&bd));
@@ -2039,7 +2033,7 @@ int lu_site_stats_print(const struct lu_site *s, struct seq_file *m)
 	struct lu_site_stats stats;
 
 	memset(&stats, 0, sizeof(stats));
-	lu_site_stats_get(s->ls_obj_hash, &stats, 1);
+	lu_site_stats_get(s, &stats, 1);
 
 	seq_printf(m, "%d/%d %d/%ld %d %d %d %d %d %d %d\n",
 		   stats.lss_busy,
