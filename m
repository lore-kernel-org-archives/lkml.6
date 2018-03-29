Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AIpwx49CEZVSHkKjQzOweJlhNh2xoE2XtWOry/DlMV+PieaiLUDXnI98D7E0zgNIeSaUc+7pN+BG
ARC-Seal: i=1; a=rsa-sha256; t=1522297730; cv=none;
        d=google.com; s=arc-20160816;
        b=bdMe3SkfGWXh7BsKysFzz+dTZa20yJlfmRbjQCKfFq5j8CdJwAhwy2sCejS7hwDZmd
         kvzE5xfGKMy6UdT0QALGHyZMf2IlbKjVRsxFP0INSjbdmDB2ebAMn+bOwNaJ75bBn/Il
         yZIpgMwsAC7MNKRc7RxHZKTLdbjux5RXIdHDHvjE4P/eeAT447Qx9YZqEEzTSyXBAiIu
         h+aVSVgpHy26eM2KNDesnxDM6ch5SzWdqRRKE26ou7i2zh5VtlUyZtrdT8CoZTEH1e+d
         syyX2kfywKZDmXR9/snKTX5MGmFxglIhC8EzXsntu/TIBCFDROnT58mvZdhpwjjgXhSX
         O4rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=/0JRv5wvk+wLv+0sZDJFX4qhrd9C2EWC8RPwrkY1fXs=;
        b=SLvueg4knpzVwFDIUIBRNC0Guuz8LKJzJJ/TsYQ5nEtlZAnxG7OGHcdle+N8Sbuz9l
         M2ndlEs7+9jzcRBo9GyOJaaxOsfPVX1xyKalBOiLLfXnclwRRlIIhz6dDFGlJjnA+pyV
         zwennCVCZlDosLWncBBCSD6pCG0rDj24oNrajr45vwWwl2dnv7pxw4+DA9RQUQMZAzsF
         +ee4vxn+FCdDEUM0kWOZF+wLYKOutzOFKetYz9AfxbMBr1y75WFa3/X/4DTuoHw1/Xk0
         +JNtFQy+hXNnL3FOVF2M8e+K766yfs4rDGIFrFVEtaIiAwHCz4LPDlu0AaZ+fTNQ1S+S
         U1MQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 James Simmons <jsimmons@infradead.org>,
 Andreas Dilger <andreas.dilger@intel.com>
Date: Thu, 29 Mar 2018 15:26:48 +1100
Subject: [PATCH 14/17] staging: lustre: discard cfs_duration_sec()
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Message-ID: <152229760877.27689.15086130563636138485.stgit@noble>
In-Reply-To: <152229732768.27689.4800156943561963977.stgit@noble>
References: <152229732768.27689.4800156943561963977.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596244865449305529?=
X-GMAIL-MSGID: =?utf-8?q?1596244865449305529?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

cfs_duration_sec() simply divides by HZ.
It is mostly used to report durations in debug messages.
Remove and just use X/HZ.

Signed-off-by: NeilBrown <neilb@suse.com>
Reviewed-by: James Simmons <jsimmons@infradead.org>
---
 .../lustre/include/linux/libcfs/linux/linux-time.h |    5 -----
 .../staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c    |    2 +-
 .../staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c |    5 ++---
 .../staging/lustre/lnet/klnds/socklnd/socklnd.c    |    4 ++--
 .../staging/lustre/lnet/klnds/socklnd/socklnd_cb.c |    4 ++--
 drivers/staging/lustre/lnet/libcfs/debug.c         |    2 +-
 drivers/staging/lustre/lnet/lnet/router.c          |    2 +-
 drivers/staging/lustre/lnet/lnet/router_proc.c     |    6 +++---
 drivers/staging/lustre/lustre/ldlm/ldlm_request.c  |    2 +-
 9 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/lustre/include/linux/libcfs/linux/linux-time.h b/drivers/staging/lustre/include/linux/libcfs/linux/linux-time.h
index ecb2126a9e6f..9a353c6cb85a 100644
--- a/drivers/staging/lustre/include/linux/libcfs/linux/linux-time.h
+++ b/drivers/staging/lustre/include/linux/libcfs/linux/linux-time.h
@@ -60,11 +60,6 @@
  * Generic kernel stuff
  */
 
-static inline long cfs_duration_sec(long d)
-{
-	return d / msecs_to_jiffies(MSEC_PER_SEC);
-}
-
 static inline int cfs_time_before_64(u64 t1, u64 t2)
 {
 	return (__s64)t2 - (__s64)t1 > 0;
diff --git a/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c b/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c
index d0ce37d72571..959e119384df 100644
--- a/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c
+++ b/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c
@@ -1068,7 +1068,7 @@ static void kiblnd_query(struct lnet_ni *ni, lnet_nid_t nid,
 
 	CDEBUG(D_NET, "Peer %s %p, alive %ld secs ago\n",
 	       libcfs_nid2str(nid), peer,
-	       last_alive ? cfs_duration_sec(now - last_alive) : -1);
+	       last_alive ? (now - last_alive) / HZ : -1);
 }
 
 static void kiblnd_free_pages(struct kib_pages *p)
diff --git a/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c b/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c
index 563ff5c972bf..b4a182d87ae7 100644
--- a/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c
+++ b/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c
@@ -3144,7 +3144,7 @@ kiblnd_check_txs_locked(struct kib_conn *conn, struct list_head *txs)
 		if (time_after_eq(jiffies, tx->tx_deadline)) {
 			CERROR("Timed out tx: %s, %lu seconds\n",
 			       kiblnd_queue2str(conn, txs),
-			       cfs_duration_sec(jiffies - tx->tx_deadline));
+			       (jiffies - tx->tx_deadline) / HZ);
 			return 1;
 		}
 	}
@@ -3206,8 +3206,7 @@ kiblnd_check_conns(int idx)
 			if (timedout) {
 				CERROR("Timed out RDMA with %s (%lu): c: %u, oc: %u, rc: %u\n",
 				       libcfs_nid2str(peer->ibp_nid),
-				       cfs_duration_sec(jiffies -
-							peer->ibp_last_alive),
+				       (jiffies - peer->ibp_last_alive) / HZ,
 				       conn->ibc_credits,
 				       conn->ibc_outstanding_credits,
 				       conn->ibc_reserved_credits);
diff --git a/drivers/staging/lustre/lnet/klnds/socklnd/socklnd.c b/drivers/staging/lustre/lnet/klnds/socklnd/socklnd.c
index 16c1ab0b0bd9..79b98cdd0f9d 100644
--- a/drivers/staging/lustre/lnet/klnds/socklnd/socklnd.c
+++ b/drivers/staging/lustre/lnet/klnds/socklnd/socklnd.c
@@ -1682,7 +1682,7 @@ ksocknal_destroy_conn(struct ksock_conn *conn)
 		       libcfs_id2str(conn->ksnc_peer->ksnp_id), conn->ksnc_type,
 		       &conn->ksnc_ipaddr, conn->ksnc_port,
 		       iov_iter_count(&conn->ksnc_rx_to), conn->ksnc_rx_nob_left,
-		       cfs_duration_sec(jiffies - last_rcv));
+		       (jiffies - last_rcv) / HZ);
 		lnet_finalize(conn->ksnc_peer->ksnp_ni,
 			      conn->ksnc_cookie, -EIO);
 		break;
@@ -1870,7 +1870,7 @@ ksocknal_query(struct lnet_ni *ni, lnet_nid_t nid, unsigned long *when)
 
 	CDEBUG(D_NET, "Peer %s %p, alive %ld secs ago, connect %d\n",
 	       libcfs_nid2str(nid), peer,
-	       last_alive ? cfs_duration_sec(now - last_alive) : -1,
+	       last_alive ? (now - last_alive) / HZ : -1,
 	       connect);
 
 	if (!connect)
diff --git a/drivers/staging/lustre/lnet/klnds/socklnd/socklnd_cb.c b/drivers/staging/lustre/lnet/klnds/socklnd/socklnd_cb.c
index 8ead1e02e854..14450fd5957a 100644
--- a/drivers/staging/lustre/lnet/klnds/socklnd/socklnd_cb.c
+++ b/drivers/staging/lustre/lnet/klnds/socklnd/socklnd_cb.c
@@ -751,7 +751,7 @@ ksocknal_find_connectable_route_locked(struct ksock_peer *peer)
 			       &route->ksnr_ipaddr,
 			       route->ksnr_connected,
 			       route->ksnr_retry_interval,
-			       cfs_duration_sec(route->ksnr_timeout - now));
+			       (route->ksnr_timeout - now) / HZ);
 			continue;
 		}
 
@@ -2439,7 +2439,7 @@ ksocknal_check_peer_timeouts(int idx)
 
 		CERROR("Total %d stale ZC_REQs for peer %s detected; the oldest(%p) timed out %ld secs ago, resid: %d, wmem: %d\n",
 		       n, libcfs_nid2str(peer->ksnp_id.nid), tx_stale,
-		       cfs_duration_sec(jiffies - deadline),
+		       (jiffies - deadline) / HZ,
 		       resid, conn->ksnc_sock->sk->sk_wmem_queued);
 
 		ksocknal_close_conn_and_siblings(conn, -ETIMEDOUT);
diff --git a/drivers/staging/lustre/lnet/libcfs/debug.c b/drivers/staging/lustre/lnet/libcfs/debug.c
index 1371224a8cb9..5862f0730dd0 100644
--- a/drivers/staging/lustre/lnet/libcfs/debug.c
+++ b/drivers/staging/lustre/lnet/libcfs/debug.c
@@ -126,7 +126,7 @@ static int param_get_delay(char *buffer, const struct kernel_param *kp)
 {
 	unsigned int d = *(unsigned int *)kp->arg;
 
-	return sprintf(buffer, "%u", (unsigned int)cfs_duration_sec(d * 100));
+	return sprintf(buffer, "%u", (unsigned int)(d * 100) / HZ);
 }
 
 unsigned int libcfs_console_max_delay;
diff --git a/drivers/staging/lustre/lnet/lnet/router.c b/drivers/staging/lustre/lnet/lnet/router.c
index 8baf35d56ca7..6267d5e4bbd6 100644
--- a/drivers/staging/lustre/lnet/lnet/router.c
+++ b/drivers/staging/lustre/lnet/lnet/router.c
@@ -1752,7 +1752,7 @@ lnet_notify(struct lnet_ni *ni, lnet_nid_t nid, int alive, unsigned long when)
 		CWARN("Ignoring prediction from %s of %s %s %ld seconds in the future\n",
 		      !ni ? "userspace" : libcfs_nid2str(ni->ni_nid),
 		      libcfs_nid2str(nid), alive ? "up" : "down",
-		      cfs_duration_sec(when - now));
+		      (when - now) / HZ);
 		return -EINVAL;
 	}
 
diff --git a/drivers/staging/lustre/lnet/lnet/router_proc.c b/drivers/staging/lustre/lnet/lnet/router_proc.c
index e4172311be68..015dccbc4a58 100644
--- a/drivers/staging/lustre/lnet/lnet/router_proc.c
+++ b/drivers/staging/lustre/lnet/lnet/router_proc.c
@@ -331,7 +331,7 @@ static int proc_lnet_routers(struct ctl_table *table, int write,
 			int alive_cnt = peer->lp_alive_count;
 			int alive = peer->lp_alive;
 			int pingsent = !peer->lp_ping_notsent;
-			int last_ping = cfs_duration_sec(now - peer->lp_ping_timestamp);
+			int last_ping = (now - peer->lp_ping_timestamp) / HZ;
 			int down_ni = 0;
 			struct lnet_route *rtr;
 
@@ -363,7 +363,7 @@ static int proc_lnet_routers(struct ctl_table *table, int write,
 					      nrefs, nrtrrefs, alive_cnt,
 					      alive ? "up" : "down", last_ping,
 					      pingsent,
-					      cfs_duration_sec(deadline - now),
+					      (deadline - now) / HZ,
 					      down_ni, libcfs_nid2str(nid));
 			LASSERT(tmpstr + tmpsiz - s > 0);
 		}
@@ -512,7 +512,7 @@ static int proc_lnet_peers(struct ctl_table *table, int write,
 				long delta;
 
 				delta = now - peer->lp_last_alive;
-				lastalive = cfs_duration_sec(delta);
+				lastalive = (delta) / HZ;
 
 				/* No need to mess up peers contents with
 				 * arbitrarily long integers - it suffices to
diff --git a/drivers/staging/lustre/lustre/ldlm/ldlm_request.c b/drivers/staging/lustre/lustre/ldlm/ldlm_request.c
index 187095022fb1..f573de9cf45d 100644
--- a/drivers/staging/lustre/lustre/ldlm/ldlm_request.c
+++ b/drivers/staging/lustre/lustre/ldlm/ldlm_request.c
@@ -1181,7 +1181,7 @@ static enum ldlm_policy_res ldlm_cancel_lrur_policy(struct ldlm_namespace *ns,
 
 	slv = ldlm_pool_get_slv(pl);
 	lvf = ldlm_pool_get_lvf(pl);
-	la = cfs_duration_sec(cur - lock->l_last_used);
+	la = (cur - lock->l_last_used) / HZ;
 	lv = lvf * la * unused;
 
 	/* Inform pool about current CLV to see it via debugfs. */
