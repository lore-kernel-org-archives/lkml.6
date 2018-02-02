Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2943005-1517591166-2-6397228815957101938
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517591165; b=imoUEiD3oD/NZuVRO3v0wmy2lAE1LwPSWzsahwkTJp2isQn
    Vril3Q58parNWZ7Ba+OTk8LvH1cNakzdR13X4ocf+D2CkmipQ92mgQOSUd8wal2m
    tXpxsx/gVAfMcVJzjr1k41HdfN/rbw1D/QPW3hAA3u4eLH7Dq98M1svsdZdj3y3I
    Q5pm1Tm2Hk1jRTmbe41c9INH+4HXPST05oDVW3XlklbfnSXq74DgpAa9RT14lsZY
    LaAi7q4R9EXU+SVmt/lsc1urfowozyUzVOnrkyL0IMOQPxXuU/UFym1IYmQOPl9W
    5g29UJJjoga5UyYvH5LonTiF4vBakd+lid808xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591165; bh=l9BXXbl92NZAB8azifWfuj9hQ6
    RThW4ISjeNIDPUhkw=; b=K8xl3cM8z3QtZOjfdnE44CBEYj4lv1ylF4J/Gu8C9b
    5sND4HCPjpHKeQyktFyFGnhiINLlPl2jcBEKsQgNkd38JZli6ZlaC50Abv/iM97L
    Pxw31VwYv4abFkd5Jc/liZQ+qyr8mhh/x9JdIBcj4yVQnPtBsqQ/YTwFTdU3pzcR
    CKtiV+Y1J5p2HaWJ/qqOrR56Uulvfu3S4BqUCuFZbJScy4mNy5qScM3zGxDeg7/a
    Jj9Tj3jwLXrn87zmh6zPIzVSaiURx16WZrMHRVtdyv9in/PTS1I08KwKDNcsWGN2
    TAFR7BB4pRjjywPkwki1nXqzCrnU3U7XmSWqEtbk7XzA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752836AbeBBRGC (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:06:02 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36662 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753028AbeBBRF6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:05:58 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Eremin <Dmitry.Eremin@intel.com>,
        Andreas Dilger <andreas.dilger@intel.com>
Subject: [PATCH 4.9 71/86] staging: lustre: separate a connection destroy from free struct kib_conn
Date: Fri,  2 Feb 2018 17:58:31 +0100
Message-Id: <20180202140829.222638408@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Eremin <dmitry.eremin@intel.com>

commit 9b046013e5837f8a58453d1e9f8e01d03adb7fe7 upstream.

The logic of the original commit 4d99b2581eff ("staging: lustre: avoid
intensive reconnecting for ko2iblnd") was assumed conditional free of
struct kib_conn if the second argument free_conn in function
kiblnd_destroy_conn(struct kib_conn *conn, bool free_conn) is true.
But this hunk of code was dropped from original commit. As result the logic
works wrong and current code use struct kib_conn after free.

> drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c
> 3317  kiblnd_destroy_conn(conn, !peer);
>                           ^^^^ Freed always (but should be conditionally)
> 3318
> 3319  spin_lock_irqsave(lock, flags);
> 3320  if (!peer)
> 3321      continue;
> 3322
> 3323  conn->ibc_peer = peer;
>       ^^^^^^^^^^^^^^ Use after free
> 3324  if (peer->ibp_reconnected < KIB_RECONN_HIGH_RACE)
> 3325      list_add_tail(&conn->ibc_list,
>                          ^^^^^^^^^^^^^^ Use after free
> 3326                    &kiblnd_data.kib_reconn_list);
> 3327  else
> 3328      list_add_tail(&conn->ibc_list,
>                          ^^^^^^^^^^^^^^ Use after free
> 3329                    &kiblnd_data.kib_reconn_wait);

To avoid confusion this fix moved the freeing a struct kib_conn outside of
the function kiblnd_destroy_conn() and free as it was intended in original
commit.

Fixes: 4d99b2581eff ("staging: lustre: avoid intensive reconnecting for ko2iblnd")
Signed-off-by: Dmitry Eremin <Dmitry.Eremin@intel.com>
Reviewed-by: Andreas Dilger <andreas.dilger@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c    |    7 +++----
 drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.h    |    2 +-
 drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c |    6 ++++--
 3 files changed, 8 insertions(+), 7 deletions(-)

--- a/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c
+++ b/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c
@@ -824,14 +824,15 @@ struct kib_conn *kiblnd_create_conn(stru
 	return conn;
 
  failed_2:
-	kiblnd_destroy_conn(conn, true);
+	kiblnd_destroy_conn(conn);
+	LIBCFS_FREE(conn, sizeof(*conn));
  failed_1:
 	LIBCFS_FREE(init_qp_attr, sizeof(*init_qp_attr));
  failed_0:
 	return NULL;
 }
 
-void kiblnd_destroy_conn(struct kib_conn *conn, bool free_conn)
+void kiblnd_destroy_conn(struct kib_conn *conn)
 {
 	struct rdma_cm_id *cmid = conn->ibc_cmid;
 	struct kib_peer *peer = conn->ibc_peer;
@@ -894,8 +895,6 @@ void kiblnd_destroy_conn(struct kib_conn
 		rdma_destroy_id(cmid);
 		atomic_dec(&net->ibn_nconns);
 	}
-
-	LIBCFS_FREE(conn, sizeof(*conn));
 }
 
 int kiblnd_close_peer_conns_locked(struct kib_peer *peer, int why)
--- a/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.h
+++ b/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.h
@@ -1018,7 +1018,7 @@ int  kiblnd_close_peer_conns_locked(stru
 struct kib_conn *kiblnd_create_conn(struct kib_peer *peer,
 				    struct rdma_cm_id *cmid,
 				    int state, int version);
-void kiblnd_destroy_conn(struct kib_conn *conn, bool free_conn);
+void kiblnd_destroy_conn(struct kib_conn *conn);
 void kiblnd_close_conn(struct kib_conn *conn, int error);
 void kiblnd_close_conn_locked(struct kib_conn *conn, int error);
 
--- a/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c
+++ b/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c
@@ -3323,11 +3323,13 @@ kiblnd_connd(void *arg)
 			spin_unlock_irqrestore(lock, flags);
 			dropped_lock = 1;
 
-			kiblnd_destroy_conn(conn, !peer);
+			kiblnd_destroy_conn(conn);
 
 			spin_lock_irqsave(lock, flags);
-			if (!peer)
+			if (!peer) {
+				kfree(conn);
 				continue;
+			}
 
 			conn->ibc_peer = peer;
 			if (peer->ibp_reconnected < KIB_RECONN_HIGH_RACE)
