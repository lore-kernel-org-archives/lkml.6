Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74501C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 03:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29E5C20836
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 03:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="Ri6nad+L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbfBLDNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 22:13:15 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:40504 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbfBLDNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 22:13:11 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 5A4BE8365A;
        Tue, 12 Feb 2019 16:13:05 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1549941185;
        bh=PFF/6nepg1M3198GQRvjdDv8dPsYVaoeW5lYd1GqYcU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Ri6nad+LbT95yt/7ClWfMc1wPZ4OGKILPUYkKTewusqJZclNfOBLRTwryoIHMm2xF
         KMtEO9AUIb/lpX4I2Xn2e5OQwIKvyUCK39TbxghSloHyNa1uee+9qfRkgqbDR9L5Jm
         36C7LOZLmpwTaylZDM99XOtl7jdup68vqVYKUlpzDV1/KXoZ3mdZOhNjAM6SG8W4Ke
         B60GLAeRmjFw1B/jkk0nAYCkZWwc+SiE5CuJ1okyYwKi64qhoAR5RxSYWvypfRMck3
         BwXiC0JRUBMFusot9bEH4IkHPgT7LX6r2/9823MZ6iDcYlZrSrnCm8oTRFXwulXory
         mRvz7541MXWtA==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5c6239b90001>; Tue, 12 Feb 2019 16:12:57 +1300
Received: from callums-dl.ws.atlnz.lc (callums-dl.ws.atlnz.lc [10.33.22.12])
        by smtp (Postfix) with ESMTP id 4A08A13EF01;
        Tue, 12 Feb 2019 16:12:57 +1300 (NZDT)
Received: by callums-dl.ws.atlnz.lc (Postfix, from userid 1764)
        id 3F1773AA212; Tue, 12 Feb 2019 16:12:57 +1300 (NZDT)
From:   Callum Sinclair <callum.sinclair@alliedtelesis.co.nz>
To:     davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        nikolay@cumulusnetworks.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     nicolas.dichtel@6wind.com,
        Callum Sinclair <callum.sinclair@alliedtelesis.co.nz>
Subject: [PATCH net-next v4] ipmr: ip6mr: Create new sockopt to clear mfc cache or vifs
Date:   Tue, 12 Feb 2019 16:12:55 +1300
Message-Id: <20190212031255.16121-2-callum.sinclair@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212031255.16121-1-callum.sinclair@alliedtelesis.co.nz>
References: <20190212031255.16121-1-callum.sinclair@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the only way to clear the forwarding cache was to delete the
entries one by one using the MRT_DEL_MFC socket option or to destroy and
recreate the socket.

Create a new socket option which with the use of optional flags can
clear any combination of multicast entries (static or not static) and
multicast vifs (static or not static).

Calling the new socket option MRT_FLUSH with the flags MRT_FLUSH_MFC and
MRT_FLUSH_VIFS will clear all entries and vifs on the socket except for
static entries.

Signed-off-by: Callum Sinclair <callum.sinclair@alliedtelesis.co.nz>
---
v1 -> v2:
  Implemented additional flags for static entries
v2 -> v3:
  Cleaned up flag logic so any combination of routes can be cleared.
  Fixed style errors
  Fixed incorrect flag values
v3 -> v4:
  Fixed style errors
  Fixed incorrect flag (MRT_FLUSH was used instead of MRT_FLUSH_VIFS)

 include/uapi/linux/mroute.h  |  9 ++++-
 include/uapi/linux/mroute6.h |  9 ++++-
 net/ipv4/ipmr.c              | 73 ++++++++++++++++++++-------------
 net/ipv6/ip6mr.c             | 78 +++++++++++++++++++++++-------------
 4 files changed, 112 insertions(+), 57 deletions(-)

diff --git a/include/uapi/linux/mroute.h b/include/uapi/linux/mroute.h
index 5d37a9ccce63..11c8c1fc1124 100644
--- a/include/uapi/linux/mroute.h
+++ b/include/uapi/linux/mroute.h
@@ -28,12 +28,19 @@
 #define MRT_TABLE	(MRT_BASE+9)	/* Specify mroute table ID		*/
 #define MRT_ADD_MFC_PROXY	(MRT_BASE+10)	/* Add a (*,*|G) mfc entry	*/
 #define MRT_DEL_MFC_PROXY	(MRT_BASE+11)	/* Del a (*,*|G) mfc entry	*/
-#define MRT_MAX		(MRT_BASE+11)
+#define MRT_FLUSH	(MRT_BASE+12)	/* Flush all mfc entries and/or vifs	*/
+#define MRT_MAX		(MRT_BASE+12)
=20
 #define SIOCGETVIFCNT	SIOCPROTOPRIVATE	/* IP protocol privates */
 #define SIOCGETSGCNT	(SIOCPROTOPRIVATE+1)
 #define SIOCGETRPF	(SIOCPROTOPRIVATE+2)
=20
+/* MRT_FLUSH optional flags */
+#define MRT_FLUSH_MFC	1	/* Flush multicast entries */
+#define MRT_FLUSH_MFC_STATIC	2	/* Flush static multicast entries */
+#define MRT_FLUSH_VIFS	4	/* Flush multicast vifs */
+#define MRT_FLUSH_VIFS_STATIC	8	/* Flush static multicast vifs */
+
 #define MAXVIFS		32
 typedef unsigned long vifbitmap_t;	/* User mode code depends on this lot=
 */
 typedef unsigned short vifi_t;
diff --git a/include/uapi/linux/mroute6.h b/include/uapi/linux/mroute6.h
index 9999cc006390..ac84ef11b29c 100644
--- a/include/uapi/linux/mroute6.h
+++ b/include/uapi/linux/mroute6.h
@@ -31,12 +31,19 @@
 #define MRT6_TABLE	(MRT6_BASE+9)	/* Specify mroute table ID		*/
 #define MRT6_ADD_MFC_PROXY	(MRT6_BASE+10)	/* Add a (*,*|G) mfc entry	*/
 #define MRT6_DEL_MFC_PROXY	(MRT6_BASE+11)	/* Del a (*,*|G) mfc entry	*/
-#define MRT6_MAX	(MRT6_BASE+11)
+#define MRT6_FLUSH	(MRT6_BASE+12)	/* Flush all mfc entries and/or vifs	*=
/
+#define MRT6_MAX	(MRT6_BASE+12)
=20
 #define SIOCGETMIFCNT_IN6	SIOCPROTOPRIVATE	/* IP protocol privates */
 #define SIOCGETSGCNT_IN6	(SIOCPROTOPRIVATE+1)
 #define SIOCGETRPF	(SIOCPROTOPRIVATE+2)
=20
+/* MRT6_FLUSH optional flags */
+#define MRT6_FLUSH_MFC	1	/* Flush multicast entries */
+#define MRT6_FLUSH_MFC_STATIC	2	/* Flush static multicast entries */
+#define MRT6_FLUSH_VIFS	4	/* Flushing multicast vifs */
+#define MRT6_FLUSH_VIFS_STATIC	8	/* Flush static multicast vifs */
+
 #define MAXMIFS		32
 typedef unsigned long mifbitmap_t;	/* User mode code depends on this lot=
 */
 typedef unsigned short mifi_t;
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index e536970557dd..a232645d3335 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -110,7 +110,7 @@ static int ipmr_cache_report(struct mr_table *mrt,
 static void mroute_netlink_event(struct mr_table *mrt, struct mfc_cache =
*mfc,
 				 int cmd);
 static void igmpmsg_netlink_event(struct mr_table *mrt, struct sk_buff *=
pkt);
-static void mroute_clean_tables(struct mr_table *mrt, bool all);
+static void mroute_clean_tables(struct mr_table *mrt, int flags);
 static void ipmr_expire_process(struct timer_list *t);
=20
 #ifdef CONFIG_IP_MROUTE_MULTIPLE_TABLES
@@ -415,7 +415,8 @@ static struct mr_table *ipmr_new_table(struct net *ne=
t, u32 id)
 static void ipmr_free_table(struct mr_table *mrt)
 {
 	del_timer_sync(&mrt->ipmr_expire_timer);
-	mroute_clean_tables(mrt, true);
+	mroute_clean_tables(mrt, MRT_FLUSH_VIFS | MRT_FLUSH_VIFS_STATIC |
+					  MRT_FLUSH_MFC | MRT_FLUSH_MFC_STATIC);
 	rhltable_destroy(&mrt->mfc_hash);
 	kfree(mrt);
 }
@@ -1296,7 +1297,7 @@ static int ipmr_mfc_add(struct net *net, struct mr_=
table *mrt,
 }
=20
 /* Close the multicast socket, and clear the vif tables etc */
-static void mroute_clean_tables(struct mr_table *mrt, bool all)
+static void mroute_clean_tables(struct mr_table *mrt, int flags)
 {
 	struct net *net =3D read_pnet(&mrt->net);
 	struct mr_mfc *c, *tmp;
@@ -1305,35 +1306,42 @@ static void mroute_clean_tables(struct mr_table *=
mrt, bool all)
 	int i;
=20
 	/* Shut down all active vif entries */
-	for (i =3D 0; i < mrt->maxvif; i++) {
-		if (!all && (mrt->vif_table[i].flags & VIFF_STATIC))
-			continue;
-		vif_delete(mrt, i, 0, &list);
+	if (flags & (MRT_FLUSH_VIFS | MRT_FLUSH_VIFS_STATIC)) {
+		for (i =3D 0; i < mrt->maxvif; i++) {
+			if (((mrt->vif_table[i].flags & VIFF_STATIC) &&
+			     !(flags & MRT_FLUSH_VIFS_STATIC)) ||
+			    (!(mrt->vif_table[i].flags & VIFF_STATIC) && !(flags & MRT_FLUSH_=
VIFS)))
+				continue;
+			vif_delete(mrt, i, 0, &list);
+		}
+		unregister_netdevice_many(&list);
 	}
-	unregister_netdevice_many(&list);
=20
 	/* Wipe the cache */
-	list_for_each_entry_safe(c, tmp, &mrt->mfc_cache_list, list) {
-		if (!all && (c->mfc_flags & MFC_STATIC))
-			continue;
-		rhltable_remove(&mrt->mfc_hash, &c->mnode, ipmr_rht_params);
-		list_del_rcu(&c->list);
-		cache =3D (struct mfc_cache *)c;
-		call_ipmr_mfc_entry_notifiers(net, FIB_EVENT_ENTRY_DEL, cache,
-					      mrt->id);
-		mroute_netlink_event(mrt, cache, RTM_DELROUTE);
-		mr_cache_put(c);
-	}
-
-	if (atomic_read(&mrt->cache_resolve_queue_len) !=3D 0) {
-		spin_lock_bh(&mfc_unres_lock);
-		list_for_each_entry_safe(c, tmp, &mrt->mfc_unres_queue, list) {
-			list_del(&c->list);
+	if (flags & (MRT_FLUSH_MFC | MRT_FLUSH_MFC_STATIC)) {
+		list_for_each_entry_safe(c, tmp, &mrt->mfc_cache_list, list) {
+			if (((c->mfc_flags & MFC_STATIC) && !(flags & MRT_FLUSH_MFC_STATIC)) =
||
+			    (!(c->mfc_flags & MFC_STATIC) && !(flags & MRT_FLUSH_MFC)))
+				continue;
+			rhltable_remove(&mrt->mfc_hash, &c->mnode, ipmr_rht_params);
+			list_del_rcu(&c->list);
 			cache =3D (struct mfc_cache *)c;
+			call_ipmr_mfc_entry_notifiers(net, FIB_EVENT_ENTRY_DEL, cache,
+						      mrt->id);
 			mroute_netlink_event(mrt, cache, RTM_DELROUTE);
-			ipmr_destroy_unres(mrt, cache);
+			mr_cache_put(c);
+		}
+
+		if (atomic_read(&mrt->cache_resolve_queue_len) !=3D 0) {
+			spin_lock_bh(&mfc_unres_lock);
+			list_for_each_entry_safe(c, tmp, &mrt->mfc_unres_queue, list) {
+				list_del(&c->list);
+				cache =3D (struct mfc_cache *)c;
+				mroute_netlink_event(mrt, cache, RTM_DELROUTE);
+				ipmr_destroy_unres(mrt, cache);
+			}
+			spin_unlock_bh(&mfc_unres_lock);
 		}
-		spin_unlock_bh(&mfc_unres_lock);
 	}
 }
=20
@@ -1354,7 +1362,7 @@ static void mrtsock_destruct(struct sock *sk)
 						    NETCONFA_IFINDEX_ALL,
 						    net->ipv4.devconf_all);
 			RCU_INIT_POINTER(mrt->mroute_sk, NULL);
-			mroute_clean_tables(mrt, false);
+			mroute_clean_tables(mrt, MRT_FLUSH_VIFS | MRT_FLUSH_MFC);
 		}
 	}
 	rtnl_unlock();
@@ -1479,6 +1487,17 @@ int ip_mroute_setsockopt(struct sock *sk, int optn=
ame, char __user *optval,
 					   sk =3D=3D rtnl_dereference(mrt->mroute_sk),
 					   parent);
 		break;
+	case MRT_FLUSH:
+		if (optlen !=3D sizeof(val)) {
+			ret =3D -EINVAL;
+			break;
+		}
+		if (get_user(val, (int __user *)optval)) {
+			ret =3D -EFAULT;
+			break;
+		}
+		mroute_clean_tables(mrt, val);
+		break;
 	/* Control PIM assert. */
 	case MRT_ASSERT:
 		if (optlen !=3D sizeof(val)) {
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index cc01aa3f2b5e..b0d8989540a3 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -97,7 +97,7 @@ static void mr6_netlink_event(struct mr_table *mrt, str=
uct mfc6_cache *mfc,
 static void mrt6msg_netlink_event(struct mr_table *mrt, struct sk_buff *=
pkt);
 static int ip6mr_rtm_dumproute(struct sk_buff *skb,
 			       struct netlink_callback *cb);
-static void mroute_clean_tables(struct mr_table *mrt, bool all);
+static void mroute_clean_tables(struct mr_table *mrt, int flags);
 static void ipmr_expire_process(struct timer_list *t);
=20
 #ifdef CONFIG_IPV6_MROUTE_MULTIPLE_TABLES
@@ -393,7 +393,8 @@ static struct mr_table *ip6mr_new_table(struct net *n=
et, u32 id)
 static void ip6mr_free_table(struct mr_table *mrt)
 {
 	del_timer_sync(&mrt->ipmr_expire_timer);
-	mroute_clean_tables(mrt, true);
+	mroute_clean_tables(mrt, MRT6_FLUSH_VIFS | MRT6_FLUSH_VIFS_STATIC |
+					  MRT6_FLUSH_MFC | MRT6_FLUSH_MFC_STATIC);
 	rhltable_destroy(&mrt->mfc_hash);
 	kfree(mrt);
 }
@@ -1496,42 +1497,49 @@ static int ip6mr_mfc_add(struct net *net, struct =
mr_table *mrt,
  *	Close the multicast socket, and clear the vif tables etc
  */
=20
-static void mroute_clean_tables(struct mr_table *mrt, bool all)
+static void mroute_clean_tables(struct mr_table *mrt, int flags)
 {
 	struct mr_mfc *c, *tmp;
 	LIST_HEAD(list);
 	int i;
=20
 	/* Shut down all active vif entries */
-	for (i =3D 0; i < mrt->maxvif; i++) {
-		if (!all && (mrt->vif_table[i].flags & VIFF_STATIC))
-			continue;
-		mif6_delete(mrt, i, 0, &list);
+	if (flags & (MRT6_FLUSH_VIFS | MRT6_FLUSH_VIFS_STATIC)) {
+		for (i =3D 0; i < mrt->maxvif; i++) {
+			if (((mrt->vif_table[i].flags & VIFF_STATIC) &&
+			     !(flags & MRT6_FLUSH_VIFS_STATIC)) ||
+			    (!(mrt->vif_table[i].flags & VIFF_STATIC) && !(flags & MRT6_FLUSH=
_VIFS)))
+				continue;
+			mif6_delete(mrt, i, 0, &list);
+		}
+		unregister_netdevice_many(&list);
 	}
-	unregister_netdevice_many(&list);
=20
 	/* Wipe the cache */
-	list_for_each_entry_safe(c, tmp, &mrt->mfc_cache_list, list) {
-		if (!all && (c->mfc_flags & MFC_STATIC))
-			continue;
-		rhltable_remove(&mrt->mfc_hash, &c->mnode, ip6mr_rht_params);
-		list_del_rcu(&c->list);
-		call_ip6mr_mfc_entry_notifiers(read_pnet(&mrt->net),
-					       FIB_EVENT_ENTRY_DEL,
-					       (struct mfc6_cache *)c, mrt->id);
-		mr6_netlink_event(mrt, (struct mfc6_cache *)c, RTM_DELROUTE);
-		mr_cache_put(c);
-	}
+	if (flags & (MRT6_FLUSH_MFC | MRT6_FLUSH_MFC_STATIC)) {
+		list_for_each_entry_safe(c, tmp, &mrt->mfc_cache_list, list) {
+			if (((c->mfc_flags & MFC_STATIC) && !(flags & MRT6_FLUSH_MFC_STATIC))=
 ||
+			    (!(c->mfc_flags & MFC_STATIC) && !(flags & MRT6_FLUSH_MFC)))
+				continue;
+			rhltable_remove(&mrt->mfc_hash, &c->mnode, ip6mr_rht_params);
+			list_del_rcu(&c->list);
+			call_ip6mr_mfc_entry_notifiers(read_pnet(&mrt->net),
+						       FIB_EVENT_ENTRY_DEL,
+										   (struct mfc6_cache *)c, mrt->id);
+			mr6_netlink_event(mrt, (struct mfc6_cache *)c, RTM_DELROUTE);
+			mr_cache_put(c);
+		}
=20
-	if (atomic_read(&mrt->cache_resolve_queue_len) !=3D 0) {
-		spin_lock_bh(&mfc_unres_lock);
-		list_for_each_entry_safe(c, tmp, &mrt->mfc_unres_queue, list) {
-			list_del(&c->list);
-			mr6_netlink_event(mrt, (struct mfc6_cache *)c,
-					  RTM_DELROUTE);
-			ip6mr_destroy_unres(mrt, (struct mfc6_cache *)c);
+		if (atomic_read(&mrt->cache_resolve_queue_len) !=3D 0) {
+			spin_lock_bh(&mfc_unres_lock);
+			list_for_each_entry_safe(c, tmp, &mrt->mfc_unres_queue, list) {
+				list_del(&c->list);
+				mr6_netlink_event(mrt, (struct mfc6_cache *)c,
+						  RTM_DELROUTE);
+				ip6mr_destroy_unres(mrt, (struct mfc6_cache *)c);
+			}
+			spin_unlock_bh(&mfc_unres_lock);
 		}
-		spin_unlock_bh(&mfc_unres_lock);
 	}
 }
=20
@@ -1587,7 +1595,7 @@ int ip6mr_sk_done(struct sock *sk)
 						     NETCONFA_IFINDEX_ALL,
 						     net->ipv6.devconf_all);
=20
-			mroute_clean_tables(mrt, false);
+			mroute_clean_tables(mrt, MRT6_FLUSH_VIFS | MRT6_FLUSH_MFC);
 			err =3D 0;
 			break;
 		}
@@ -1703,6 +1711,20 @@ int ip6_mroute_setsockopt(struct sock *sk, int opt=
name, char __user *optval, uns
 		rtnl_unlock();
 		return ret;
=20
+	case MRT6_FLUSH:
+	{
+		int flags;
+
+		if (optlen !=3D sizeof(flags))
+			return -EINVAL;
+		if (get_user(flags, (int __user *)optval))
+			return -EFAULT;
+		rtnl_lock();
+		mroute_clean_tables(mrt, flags);
+		rtnl_unlock();
+		return 0;
+	}
+
 	/*
 	 *	Control PIM assert (to activate pim will activate assert)
 	 */
--=20
2.20.1

