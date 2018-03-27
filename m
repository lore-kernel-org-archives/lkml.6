Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx495ykxCG8ZMS7ntN5AveHLEXbJkt3WD9CCdf59IbEyHSYjKYw5BX03KjJeCN19FKYp+S5kk
ARC-Seal: i=1; a=rsa-sha256; t=1522168534; cv=none;
        d=google.com; s=arc-20160816;
        b=ByDdMXwsFzZP+QFSLvrICTW4gllHUp0mKkwmC1X5kfTePSxqIYUOlNHXtdzRkN2v/j
         eymJTYUTDE7Y/aG1XbZBkhFaHjwlwtA6RGP4q1DjkExVrb5QrF/L4SiLDIOeEYUXFesA
         rwCxdZ/Kpbb1VERWrfgnKhNs70e6VuMQWm5XKWxl0wgCIU54VOMXl5E5jcNfjVvlAI9n
         qjdYzOMaToXqCEWdYqYF/4/fDsbVUU1geR9iEFWR2TTPiGyhag8LG6xzc/EK1pOSqZ11
         KKnugJc6CoPVDi0YMTvCsYlGaQYhDk6Qckce+TCQ7/30cyckxQ4GClVetx6Jl23aJi9Q
         kDbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=8h1QetpOnUL3s7bggFN92xLnkH0gs04cEJ/kxYy/0W8=;
        b=EBv1ccJwbfSQcegnZsxQUB1p8BnNHRjk5+6dw9miA/ZVW3BGnBlkQrZ1CXyHfFpwsO
         Q43ihg3jUyD+tdO5DZwgmGFTyhTEOVo3A2pLkufLCHIGPTz3JDmuV3nJgHcEZbHzintd
         zvnRo0GBN3UTjw5hmk84s3aJ1V54hWBn/ym+Wl+CfIgqrzV6QgF1tEImOrG9y0NilCIK
         HYHOrUTOxE8ynoaRQAZUt3bzBOeQN622RC1PXbAW7pg9KmxqOKus4UGyV+ECaUaHxwUa
         bAOWiNeoGZ+ic2TSvVSi9NrzM2dlcqvOgFxAu1cge8zh+Py5ufUs3N5ZG/Uj6XD0nkw8
         /T6Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Frank Sorenson <fsorenso@redhat.com>,
	Jeff Layton <jlayton@redhat.com>,
	"J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 4.14 044/101] nfsd: remove blocked locks on client teardown
Date: Tue, 27 Mar 2018 18:27:16 +0200
Message-Id: <20180327162752.719581649@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109125375429370?=
X-GMAIL-MSGID: =?utf-8?q?1596109392959979733?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeff Layton <jlayton@redhat.com>

commit 68ef3bc3166468678d5e1fdd216628c35bd1186f upstream.

We had some reports of panics in nfsd4_lm_notify, and that showed a
nfs4_lockowner that had outlived its so_client.

Ensure that we walk any leftover lockowners after tearing down all of
the stateids, and remove any blocked locks that they hold.

With this change, we also don't need to walk the nbl_lru on nfsd_net
shutdown, as that will happen naturally when we tear down the clients.

Fixes: 76d348fadff5 (nfsd: have nfsd4_lock use blocking locks for v4.1+ locks)
Reported-by: Frank Sorenson <fsorenso@redhat.com>
Signed-off-by: Jeff Layton <jlayton@redhat.com>
Cc: stable@vger.kernel.org # 4.9
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfsd/nfs4state.c |   62 ++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 43 insertions(+), 19 deletions(-)

--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -263,6 +263,35 @@ free_blocked_lock(struct nfsd4_blocked_l
 	kfree(nbl);
 }
 
+static void
+remove_blocked_locks(struct nfs4_lockowner *lo)
+{
+	struct nfs4_client *clp = lo->lo_owner.so_client;
+	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
+	struct nfsd4_blocked_lock *nbl;
+	LIST_HEAD(reaplist);
+
+	/* Dequeue all blocked locks */
+	spin_lock(&nn->blocked_locks_lock);
+	while (!list_empty(&lo->lo_blocked)) {
+		nbl = list_first_entry(&lo->lo_blocked,
+					struct nfsd4_blocked_lock,
+					nbl_list);
+		list_del_init(&nbl->nbl_list);
+		list_move(&nbl->nbl_lru, &reaplist);
+	}
+	spin_unlock(&nn->blocked_locks_lock);
+
+	/* Now free them */
+	while (!list_empty(&reaplist)) {
+		nbl = list_first_entry(&reaplist, struct nfsd4_blocked_lock,
+					nbl_lru);
+		list_del_init(&nbl->nbl_lru);
+		posix_unblock_lock(&nbl->nbl_lock);
+		free_blocked_lock(nbl);
+	}
+}
+
 static int
 nfsd4_cb_notify_lock_done(struct nfsd4_callback *cb, struct rpc_task *task)
 {
@@ -1854,6 +1883,7 @@ static __be32 mark_client_expired_locked
 static void
 __destroy_client(struct nfs4_client *clp)
 {
+	int i;
 	struct nfs4_openowner *oo;
 	struct nfs4_delegation *dp;
 	struct list_head reaplist;
@@ -1883,6 +1913,16 @@ __destroy_client(struct nfs4_client *clp
 		nfs4_get_stateowner(&oo->oo_owner);
 		release_openowner(oo);
 	}
+	for (i = 0; i < OWNER_HASH_SIZE; i++) {
+		struct nfs4_stateowner *so, *tmp;
+
+		list_for_each_entry_safe(so, tmp, &clp->cl_ownerstr_hashtbl[i],
+					 so_strhash) {
+			/* Should be no openowners at this point */
+			WARN_ON_ONCE(so->so_is_open_owner);
+			remove_blocked_locks(lockowner(so));
+		}
+	}
 	nfsd4_return_all_client_layouts(clp);
 	nfsd4_shutdown_callback(clp);
 	if (clp->cl_cb_conn.cb_xprt)
@@ -6275,6 +6315,7 @@ nfsd4_release_lockowner(struct svc_rqst
 	}
 	spin_unlock(&clp->cl_lock);
 	free_ol_stateid_reaplist(&reaplist);
+	remove_blocked_locks(lo);
 	nfs4_put_stateowner(&lo->lo_owner);
 
 	return status;
@@ -7060,6 +7101,8 @@ nfs4_state_destroy_net(struct net *net)
 		}
 	}
 
+	WARN_ON(!list_empty(&nn->blocked_locks_lru));
+
 	for (i = 0; i < CLIENT_HASH_SIZE; i++) {
 		while (!list_empty(&nn->unconf_id_hashtbl[i])) {
 			clp = list_entry(nn->unconf_id_hashtbl[i].next, struct nfs4_client, cl_idhash);
@@ -7126,7 +7169,6 @@ nfs4_state_shutdown_net(struct net *net)
 	struct nfs4_delegation *dp = NULL;
 	struct list_head *pos, *next, reaplist;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
-	struct nfsd4_blocked_lock *nbl;
 
 	cancel_delayed_work_sync(&nn->laundromat_work);
 	locks_end_grace(&nn->nfsd4_manager);
@@ -7147,24 +7189,6 @@ nfs4_state_shutdown_net(struct net *net)
 		nfs4_put_stid(&dp->dl_stid);
 	}
 
-	BUG_ON(!list_empty(&reaplist));
-	spin_lock(&nn->blocked_locks_lock);
-	while (!list_empty(&nn->blocked_locks_lru)) {
-		nbl = list_first_entry(&nn->blocked_locks_lru,
-					struct nfsd4_blocked_lock, nbl_lru);
-		list_move(&nbl->nbl_lru, &reaplist);
-		list_del_init(&nbl->nbl_list);
-	}
-	spin_unlock(&nn->blocked_locks_lock);
-
-	while (!list_empty(&reaplist)) {
-		nbl = list_first_entry(&reaplist,
-					struct nfsd4_blocked_lock, nbl_lru);
-		list_del_init(&nbl->nbl_lru);
-		posix_unblock_lock(&nbl->nbl_lock);
-		free_blocked_lock(nbl);
-	}
-
 	nfsd4_client_tracking_exit(net);
 	nfs4_state_destroy_net(net);
 }
