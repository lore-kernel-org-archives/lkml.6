Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2943005-1517591602-2-12753997856240179119
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
    t=1517591602; b=Lz4Sz2dc3z9AzUDTDbbp9PZT6NxZ1+Zq/Cd3WTMduHvVTdv
    G22g9+DhcQmaRfzfxgos9v4A+PXtqyMjxDyNlqWCYw7El/bIaBUHLrY6NmlBEtLy
    D2n/pOWhjUFVNyGqMJdFThPCwLe7OwxltLt/hcVcQqHnyDMqyLobGUA8mna/ps9Q
    JY5Ki0v896IN/v9DZS7oTd/8afAZJpZSXNJIPORGgRkxO9pCpzbanAFXdgFqA9xv
    y78xGd3iehegpRnlWs4tLtgrykWx49A7XDONlkaDPpdNvho6M7UnBXBCpkcnfijU
    r6u+Q43hYiMpPY+kqWqPI9C7THWSVScRm8ebmNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591602; bh=KYg5x2P/Em/pIXGHQ/z0i/M6A2
    Au/UV5nB+U/87S1xc=; b=m3CqRQa23Sj3EZ9gysmFXhlevyYIAjdoHi+DDJU6ig
    qSMPqpsE4pHfqj5jUde1Uj3RmzKaEawPKpvBzJfdyQfvJ0IR5V28Zu7AvxNKSgkr
    Yi5gfkuRuj1mIWPL3KhNjwP0lF2m+VcO3fKyOWyoJzrPgtt3oevpMP0YAI3uBgw7
    iAUzujA0EjttIzAOs1bZF2ou7W+aNRZmlgcm2aJ/jS60jpny4IMWyfib2EkO8TRU
    pfTh9bkEl2crrcZ6XYlB11x7wzkIKheqeyu/H3DXP4jRW0ww2GWKbuiwC0KcPKvZ
    JD9gYDJEuPtxAu5MKQFaea3Wr2eDDRFqtDNfsE+Wmwug==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753500AbeBBRNI (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:13:08 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:39210 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752803AbeBBRNE (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:13:04 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Eremin <Dmitry.Eremin@intel.com>,
        Andreas Dilger <andreas.dilger@intel.com>
Subject: [PATCH 4.14 129/156] staging: lustre: separate a connection destroy from free struct kib_conn
Date: Fri,  2 Feb 2018 17:58:30 +0100
Message-Id: <20180202140846.210308851@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -825,14 +825,15 @@ struct kib_conn *kiblnd_create_conn(stru
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
@@ -895,8 +896,6 @@ void kiblnd_destroy_conn(struct kib_conn
 		rdma_destroy_id(cmid);
 		atomic_dec(&net->ibn_nconns);
 	}
-
-	LIBCFS_FREE(conn, sizeof(*conn));
 }
 
 int kiblnd_close_peer_conns_locked(struct kib_peer *peer, int why)
--- a/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.h
+++ b/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.h
@@ -1015,7 +1015,7 @@ int  kiblnd_close_peer_conns_locked(stru
 struct kib_conn *kiblnd_create_conn(struct kib_peer *peer,
 				    struct rdma_cm_id *cmid,
 				    int state, int version);
-void kiblnd_destroy_conn(struct kib_conn *conn, bool free_conn);
+void kiblnd_destroy_conn(struct kib_conn *conn);
 void kiblnd_close_conn(struct kib_conn *conn, int error);
 void kiblnd_close_conn_locked(struct kib_conn *conn, int error);
 
--- a/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c
+++ b/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c
@@ -3313,11 +3313,13 @@ kiblnd_connd(void *arg)
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
