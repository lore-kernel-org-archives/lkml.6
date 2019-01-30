Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D16CC169C4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 02:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E3232184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 02:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="gjQv14xg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbfA3CZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 21:25:22 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:49162 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727990AbfA3CZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 21:25:20 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 4C7148781F;
        Wed, 30 Jan 2019 15:25:17 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1548815117;
        bh=D5QaqGKOetgx6E1UtzmNF8NDDqU7mPwGS/Xlj5gfkwo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=gjQv14xgs86GdLpgoQQeHRzkO5cQwv5TilYcbSutpkgE9uUGmQUm9H3DCNuIkAyiH
         vYSwek00PqQlBNATgi9CmJtCxKAWyYE8TxgqClNWCzSjsNoKqwsIVyPpfe65b9OhVE
         LN5+56ciBiVgSCVdy07epk+oZcyvTt9m/5/TwR0DN9dsHxTJ+YNiPAF4g6XTk5YeGc
         KwE54RXVr/rjemFzaB4TKgGm1SjoPZkr2rSKQ9TbmdhZWCy2sbNkAfw6cXHF4w9Vph
         kJ/HIfHbUFFtMGHU25RJ6FB936YRfIuZnkrh4/rm2wjewBUevQfV2+gzpu8WZNBvsA
         Rc/Ay3oJrdb3g==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5c510b0d0000>; Wed, 30 Jan 2019 15:25:17 +1300
Received: from callums-dl.ws.atlnz.lc (callums-dl.ws.atlnz.lc [10.33.22.12])
        by smtp (Postfix) with ESMTP id F289213EEFB;
        Wed, 30 Jan 2019 15:25:22 +1300 (NZDT)
Received: by callums-dl.ws.atlnz.lc (Postfix, from userid 1764)
        id 12B883A041A; Wed, 30 Jan 2019 15:25:17 +1300 (NZDT)
From:   Callum Sinclair <callum.sinclair@alliedtelesis.co.nz>
To:     davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        nikolay@cumulusnetworks.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Callum Sinclair <callum.sinclair@alliedtelesis.co.nz>
Subject: [PATCH] ipmr: ip6mr: Create new sockopt to clear mfc cache only
Date:   Wed, 30 Jan 2019 15:25:09 +1300
Message-Id: <20190130022509.25303-2-callum.sinclair@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190130022509.25303-1-callum.sinclair@alliedtelesis.co.nz>
References: <20190130022509.25303-1-callum.sinclair@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the only way to clear the mfc cache was to delete the entries
one by one using the MRT_DEL_MFC socket option or to destroy and
recreate the socket.

Create a new socket option which will clear the multicast forwarding
cache on the socket without destroying the socket.

Signed-off-by: Callum Sinclair <callum.sinclair@alliedtelesis.co.nz>
---
 include/uapi/linux/mroute.h  |  3 ++-
 include/uapi/linux/mroute6.h |  3 ++-
 net/ipv4/ipmr.c              | 41 +++++++++++++++++++++-----------
 net/ipv6/ip6mr.c             | 45 +++++++++++++++++++++++-------------
 4 files changed, 60 insertions(+), 32 deletions(-)

diff --git a/include/uapi/linux/mroute.h b/include/uapi/linux/mroute.h
index 5d37a9ccce63..8a0beb885cd9 100644
--- a/include/uapi/linux/mroute.h
+++ b/include/uapi/linux/mroute.h
@@ -28,7 +28,8 @@
 #define MRT_TABLE	(MRT_BASE+9)	/* Specify mroute table ID		*/
 #define MRT_ADD_MFC_PROXY	(MRT_BASE+10)	/* Add a (*,*|G) mfc entry	*/
 #define MRT_DEL_MFC_PROXY	(MRT_BASE+11)	/* Del a (*,*|G) mfc entry	*/
-#define MRT_MAX		(MRT_BASE+11)
+#define MRT_DEL_MFC_ALL		(MRT_BASE+12)	/* Del all multicast entries	*/
+#define MRT_MAX		(MRT_BASE+12)
=20
 #define SIOCGETVIFCNT	SIOCPROTOPRIVATE	/* IP protocol privates */
 #define SIOCGETSGCNT	(SIOCPROTOPRIVATE+1)
diff --git a/include/uapi/linux/mroute6.h b/include/uapi/linux/mroute6.h
index 9999cc006390..7def70cdf571 100644
--- a/include/uapi/linux/mroute6.h
+++ b/include/uapi/linux/mroute6.h
@@ -31,7 +31,8 @@
 #define MRT6_TABLE	(MRT6_BASE+9)	/* Specify mroute table ID		*/
 #define MRT6_ADD_MFC_PROXY	(MRT6_BASE+10)	/* Add a (*,*|G) mfc entry	*/
 #define MRT6_DEL_MFC_PROXY	(MRT6_BASE+11)	/* Del a (*,*|G) mfc entry	*/
-#define MRT6_MAX	(MRT6_BASE+11)
+#define MRT6_DEL_MFC_ALL	(MRT6_BASE+12)	/* Del all multicast entries	*/
+#define MRT6_MAX	(MRT6_BASE+12)
=20
 #define SIOCGETMIFCNT_IN6	SIOCPROTOPRIVATE	/* IP protocol privates */
 #define SIOCGETSGCNT_IN6	(SIOCPROTOPRIVATE+1)
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index ddbf8c9a1abb..bbbce5ec8a0c 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1298,22 +1298,10 @@ static int ipmr_mfc_add(struct net *net, struct m=
r_table *mrt,
 	return 0;
 }
=20
-/* Close the multicast socket, and clear the vif tables etc */
-static void mroute_clean_tables(struct mr_table *mrt, bool all)
+/* Clear the vif tables */
+static void mroute_clean_cache(struct mr_table *mrt, bool all)
 {
-	struct net *net =3D read_pnet(&mrt->net);
 	struct mr_mfc *c, *tmp;
-	struct mfc_cache *cache;
-	LIST_HEAD(list);
-	int i;
-
-	/* Shut down all active vif entries */
-	for (i =3D 0; i < mrt->maxvif; i++) {
-		if (!all && (mrt->vif_table[i].flags & VIFF_STATIC))
-			continue;
-		vif_delete(mrt, i, 0, &list);
-	}
-	unregister_netdevice_many(&list);
=20
 	/* Wipe the cache */
 	list_for_each_entry_safe(c, tmp, &mrt->mfc_cache_list, list) {
@@ -1340,6 +1328,24 @@ static void mroute_clean_tables(struct mr_table *m=
rt, bool all)
 	}
 }
=20
+/* Close the multicast socket, and clear the vif tables etc */
+static void mroute_clean_tables(struct mr_table *mrt, bool all)
+{
+	struct net *net =3D read_pnet(&mrt->net);
+	LIST_HEAD(list);
+	int i;
+
+	/* Shut down all active vif entries */
+	for (i =3D 0; i < mrt->maxvif; i++) {
+		if (!all && (mrt->vif_table[i].flags & VIFF_STATIC))
+			continue;
+		vif_delete(mrt, i, 0, &list);
+	}
+	unregister_netdevice_many(&list);
+
+	mroute_clean_cache (mrt, all);
+}
+
 /* called from ip_ra_control(), before an RCU grace period,
  * we dont need to call synchronize_rcu() here
  */
@@ -1482,6 +1488,13 @@ int ip_mroute_setsockopt(struct sock *sk, int optn=
ame, char __user *optval,
 					   sk =3D=3D rtnl_dereference(mrt->mroute_sk),
 					   parent);
 		break;
+	case MRT_DEL_MFC_ALL:
+		rtnl_lock();
+		ipmr_for_each_table(mrt, net) {
+			mroute_clean_cache(mrt, true);
+		}
+		rtnl_unlock();
+		break;
 	/* Control PIM assert. */
 	case MRT_ASSERT:
 		if (optlen !=3D sizeof(val)) {
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 30337b38274b..64631f85dcf4 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1492,25 +1492,11 @@ static int ip6mr_mfc_add(struct net *net, struct =
mr_table *mrt,
 	return 0;
 }
=20
-/*
- *	Close the multicast socket, and clear the vif tables etc
- */
-
-static void mroute_clean_tables(struct mr_table *mrt, bool all)
+/* Clear the vif tables */
+static void mroute_clean_cache(struct mr_table *mrt, bool all)
 {
 	struct mr_mfc *c, *tmp;
-	LIST_HEAD(list);
-	int i;
-
-	/* Shut down all active vif entries */
-	for (i =3D 0; i < mrt->maxvif; i++) {
-		if (!all && (mrt->vif_table[i].flags & VIFF_STATIC))
-			continue;
-		mif6_delete(mrt, i, 0, &list);
-	}
-	unregister_netdevice_many(&list);
=20
-	/* Wipe the cache */
 	list_for_each_entry_safe(c, tmp, &mrt->mfc_cache_list, list) {
 		if (!all && (c->mfc_flags & MFC_STATIC))
 			continue;
@@ -1535,6 +1521,26 @@ static void mroute_clean_tables(struct mr_table *m=
rt, bool all)
 		spin_unlock_bh(&mfc_unres_lock);
 	}
 }
+/*
+ *	Close the multicast socket, and clear the vif tables etc
+ */
+
+static void mroute_clean_tables(struct mr_table *mrt, bool all)
+{
+	LIST_HEAD(list);
+	int i;
+
+	/* Shut down all active vif entries */
+	for (i =3D 0; i < mrt->maxvif; i++) {
+		if (!all && (mrt->vif_table[i].flags & VIFF_STATIC))
+			continue;
+		mif6_delete(mrt, i, 0, &list);
+	}
+	unregister_netdevice_many(&list);
+
+	/* Wipe the cache */
+	mroute_clean_cache(mrt, all);
+}
=20
 static int ip6mr_sk_init(struct mr_table *mrt, struct sock *sk)
 {
@@ -1703,6 +1709,13 @@ int ip6_mroute_setsockopt(struct sock *sk, int opt=
name, char __user *optval, uns
 					    parent);
 		rtnl_unlock();
 		return ret;
+	case MRT6_DEL_MFC_ALL:
+		rtnl_lock();
+		ip6mr_for_each_table(mrt, net) {
+			mroute_clean_cache(mrt, true);
+		}
+		rtnl_unlock();
+		return 0;
=20
 	/*
 	 *	Control PIM assert (to activate pim will activate assert)
--=20
2.20.1

