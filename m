Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AB8JxZqw3VnrlorIBp4Dl1oGwxDYxd8xoFNuzDrHMpzmDRRlOBoDNAgYroqoJmY/7G4P7bIwNss0
ARC-Seal: i=1; a=rsa-sha256; t=1525654543; cv=none;
        d=google.com; s=arc-20160816;
        b=HYiyxfJDDKDF+L4T0nw1vQP9pqsQSj7yTTBtaHAuhIcbIuQQQTfmPlWgGrYZujN/Wo
         TDs79tHROdeRy7e4faK/3bLHb7QscQEcGau87IKR8pX08Kcyn8GQrDcZ5QALb+eYBTDl
         e6oJvAnUlh4vvuLGOUpSdBm08ae/3zgyc/NScDLQ2Exhdg83UR6yE7cF+uhJsr+NM8H/
         fYZzagAyCf4KtM4o/ymdGT+uszxt/DYE6yFG70FSM2AJVJSG5Se48dUjcrBycG2Dc6zA
         ZzFBgokLuZTA8u/C7lFT0oET4EZV7lAeQbvSOGU8y2HeII6HHyNQGezqSuSgcM9FdAWW
         PGfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=RKG0BshFFvGjAKDa/8zwRfJB1fGpAusIQOtdpOzKLeE=;
        b=Zw+IlWywS/9G2Bs2hf5s+h6lBDxnirIIc6zeMDnkIFoH6lW1pHgjtyD0yVjEhkawKK
         hl/4j/cynq3WCEooYSqjvYjVe1xJj7FEiS9RfIf3xDZ9q3QoRI7j5ZAuxdq2CNu7wchT
         D0hJAzhNreIj9je9yd8ltD6pHP8cu5ONZ0Gy9FgUp6NX3ksII71zehpfrqOotZyrTq18
         kZh3Sy+zHFp5u7QyvaI3yT/T+XE8kba1dF48zKg94YNeFsUCi630EJKngoc2dBfp+1g0
         0t/7ba23PU+jGUFC0WVqPAT1x9pvtFkQCYW2P0+3Tymmnwo0ubICt0E8y3I/RIiefkDU
         2xVg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 James Simmons <jsimmons@infradead.org>,
 Andreas Dilger <andreas.dilger@intel.com>
Date: Mon, 07 May 2018 10:54:48 +1000
Subject: [PATCH 03/10] staging: lustre: lu_object: discard extra lru count.
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Message-ID: <152565448808.30131.17399451482748227169.stgit@noble>
In-Reply-To: <152565436690.30131.2229703651041382739.stgit@noble>
References: <152565436690.30131.2229703651041382739.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599764738560394621?=
X-GMAIL-MSGID: =?utf-8?q?1599764738560394621?=
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

Reviewed-by: Andreas Dilger <andreas.dilger@dilger.ca>
Signed-off-by: NeilBrown <neilb@suse.com>
---
 drivers/staging/lustre/lustre/obdclass/lu_object.c |   27 +++++++++-----------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/lustre/lustre/obdclass/lu_object.c b/drivers/staging/lustre/lustre/obdclass/lu_object.c
index 83dacc413c32..bf5b309edeae 100644
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
@@ -188,10 +184,9 @@ void lu_object_put(const struct lu_env *env, struct lu_object *o)
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
@@ -239,7 +234,6 @@ void lu_object_unhash(const struct lu_env *env, struct lu_object *o)
 
 			list_del_init(&top->loh_lru);
 			bkt = cfs_hash_bd_extra_get(obj_hash, &bd);
-			bkt->lsb_lru_len--;
 			percpu_counter_dec(&site->ls_lru_len_counter);
 		}
 		cfs_hash_bd_del_locked(obj_hash, &bd, &top->loh_hash);
@@ -423,7 +417,6 @@ int lu_site_purge_objects(const struct lu_env *env, struct lu_site *s,
 			cfs_hash_bd_del_locked(s->ls_obj_hash,
 					       &bd2, &h->loh_hash);
 			list_move(&h->loh_lru, &dispose);
-			bkt->lsb_lru_len--;
 			percpu_counter_dec(&s->ls_lru_len_counter);
 			if (did_sth == 0)
 				did_sth = 1;
@@ -622,7 +615,6 @@ static struct lu_object *htable_lookup(struct lu_site *s,
 		lprocfs_counter_incr(s->ls_stats, LU_SS_CACHE_HIT);
 		if (!list_empty(&h->loh_lru)) {
 			list_del_init(&h->loh_lru);
-			bkt->lsb_lru_len--;
 			percpu_counter_dec(&s->ls_lru_len_counter);
 		}
 		return lu_object_top(h);
@@ -1835,19 +1827,24 @@ struct lu_site_stats {
 	unsigned int	lss_busy;
 };
 
-static void lu_site_stats_get(struct cfs_hash *hs,
+static void lu_site_stats_get(const struct lu_site *s,
 			      struct lu_site_stats *stats, int populated)
 {
+	struct cfs_hash *hs = s->ls_obj_hash;
 	struct cfs_hash_bd bd;
 	unsigned int i;
+	/*
+	 * percpu_counter_sum_positive() won't accept a const pointer
+	 * as it does modify the struct by taking a spinlock
+	 */
+	struct lu_site *s2 = (struct lu_site *)s;
 
+	stats->lss_busy += cfs_hash_size_get(hs) -
+		percpu_counter_sum_positive(&s2->ls_lru_len_counter);
 	cfs_hash_for_each_bucket(hs, &bd, i) {
-		struct lu_site_bkt_data *bkt = cfs_hash_bd_extra_get(hs, &bd);
 		struct hlist_head	*hhead;
 
 		cfs_hash_bd_lock(hs, &bd, 1);
-		stats->lss_busy  +=
-			cfs_hash_bd_count_get(&bd) - bkt->lsb_lru_len;
 		stats->lss_total += cfs_hash_bd_count_get(&bd);
 		stats->lss_max_search = max((int)stats->lss_max_search,
 					    cfs_hash_bd_depmax_get(&bd));
@@ -2040,7 +2037,7 @@ int lu_site_stats_print(const struct lu_site *s, struct seq_file *m)
 	struct lu_site_stats stats;
 
 	memset(&stats, 0, sizeof(stats));
-	lu_site_stats_get(s->ls_obj_hash, &stats, 1);
+	lu_site_stats_get(s, &stats, 1);
 
 	seq_printf(m, "%d/%d %d/%ld %d %d %d %d %d %d %d\n",
 		   stats.lss_busy,
