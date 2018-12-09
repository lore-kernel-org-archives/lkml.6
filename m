Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E501C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C20CF20661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:20:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C20CF20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbeLIWT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:19:59 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35436 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726555AbeLIVzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:25 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72o-0002iZ-6W; Sun, 09 Dec 2018 21:55:22 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72l-0003gU-7a; Sun, 09 Dec 2018 21:55:19 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Sabrina Dubroca" <sd@queasysnail.net>,
        "David S. Miller" <davem@davemloft.net>,
        "Stefano Brivio" <sbrivio@redhat.com>,
        "David Ahern" <dsahern@gmail.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.118781123@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 310/328] net: ipv4: update fnhe_pmtu when first hop's
 MTU changes
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Sabrina Dubroca <sd@queasysnail.net>

commit af7d6cce53694a88d6a1bb60c9a239a6a5144459 upstream.

Since commit 5aad1de5ea2c ("ipv4: use separate genid for next hop
exceptions"), exceptions get deprecated separately from cached
routes. In particular, administrative changes don't clear PMTU anymore.

As Stefano described in commit e9fa1495d738 ("ipv6: Reflect MTU changes
on PMTU of exceptions for MTU-less routes"), the PMTU discovered before
the local MTU change can become stale:
 - if the local MTU is now lower than the PMTU, that PMTU is now
   incorrect
 - if the local MTU was the lowest value in the path, and is increased,
   we might discover a higher PMTU

Similarly to what commit e9fa1495d738 did for IPv6, update PMTU in those
cases.

If the exception was locked, the discovered PMTU was smaller than the
minimal accepted PMTU. In that case, if the new local MTU is smaller
than the current PMTU, let PMTU discovery figure out if locking of the
exception is still needed.

To do this, we need to know the old link MTU in the NETDEV_CHANGEMTU
notifier. By the time the notifier is called, dev->mtu has been
changed. This patch adds the old MTU as additional information in the
notifier structure, and a new call_netdevice_notifiers_u32() function.

Fixes: 5aad1de5ea2c ("ipv4: use separate genid for next hop exceptions")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Reviewed-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.16:
 - Pass net_device argument to call_netdevice_notifiers_info()
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1867,6 +1867,13 @@ struct netdev_notifier_info {
 	struct net_device *dev;
 };
 
+struct netdev_notifier_info_ext {
+	struct netdev_notifier_info info; /* must be first */
+	union {
+		u32 mtu;
+	} ext;
+};
+
 struct netdev_notifier_change_info {
 	struct netdev_notifier_info info; /* must be first */
 	unsigned int flags_changed;
--- a/include/net/ip_fib.h
+++ b/include/net/ip_fib.h
@@ -293,6 +293,7 @@ int ip_fib_check_default(__be32 gw, stru
 int fib_sync_down_dev(struct net_device *dev, int force);
 int fib_sync_down_addr(struct net *net, __be32 local);
 int fib_sync_up(struct net_device *dev);
+void fib_sync_mtu(struct net_device *dev, u32 orig_mtu);
 void fib_select_multipath(struct fib_result *res);
 
 /* Exported by fib_trie.c */
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1598,6 +1598,28 @@ int call_netdevice_notifiers(unsigned lo
 }
 EXPORT_SYMBOL(call_netdevice_notifiers);
 
+/**
+ *	call_netdevice_notifiers_mtu - call all network notifier blocks
+ *	@val: value passed unmodified to notifier function
+ *	@dev: net_device pointer passed unmodified to notifier function
+ *	@arg: additional u32 argument passed to the notifier function
+ *
+ *	Call all network notifier blocks.  Parameters and return value
+ *	are as for raw_notifier_call_chain().
+ */
+static int call_netdevice_notifiers_mtu(unsigned long val,
+					struct net_device *dev, u32 arg)
+{
+	struct netdev_notifier_info_ext info = {
+		.info.dev = dev,
+		.ext.mtu = arg,
+	};
+
+	BUILD_BUG_ON(offsetof(struct netdev_notifier_info_ext, info) != 0);
+
+	return call_netdevice_notifiers_info(val, dev, &info.info);
+}
+
 static struct static_key netstamp_needed __read_mostly;
 #ifdef HAVE_JUMP_LABEL
 static atomic_t netstamp_needed_deferred;
@@ -5688,14 +5710,16 @@ int dev_set_mtu(struct net_device *dev,
 	err = __dev_set_mtu(dev, new_mtu);
 
 	if (!err) {
-		err = call_netdevice_notifiers(NETDEV_CHANGEMTU, dev);
+		err = call_netdevice_notifiers_mtu(NETDEV_CHANGEMTU, dev,
+						   orig_mtu);
 		err = notifier_to_errno(err);
 		if (err) {
 			/* setting mtu back and notifying everyone again,
 			 * so that they have a chance to revert changes.
 			 */
 			__dev_set_mtu(dev, orig_mtu);
-			call_netdevice_notifiers(NETDEV_CHANGEMTU, dev);
+			call_netdevice_notifiers_mtu(NETDEV_CHANGEMTU, dev,
+						     new_mtu);
 		}
 	}
 	return err;
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -1046,6 +1046,7 @@ static int fib_inetaddr_event(struct not
 static int fib_netdev_event(struct notifier_block *this, unsigned long event, void *ptr)
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+	struct netdev_notifier_info_ext *info_ext = ptr;
 	struct in_device *in_dev;
 	struct net *net = dev_net(dev);
 
@@ -1074,6 +1075,9 @@ static int fib_netdev_event(struct notif
 		fib_disable_ip(dev, 0);
 		break;
 	case NETDEV_CHANGEMTU:
+		fib_sync_mtu(dev, info_ext->ext.mtu);
+		rt_cache_flush(net);
+		break;
 	case NETDEV_CHANGE:
 		rt_cache_flush(net);
 		break;
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -1122,6 +1122,56 @@ int fib_sync_down_addr(struct net *net,
 	return ret;
 }
 
+/* Update the PMTU of exceptions when:
+ * - the new MTU of the first hop becomes smaller than the PMTU
+ * - the old MTU was the same as the PMTU, and it limited discovery of
+ *   larger MTUs on the path. With that limit raised, we can now
+ *   discover larger MTUs
+ * A special case is locked exceptions, for which the PMTU is smaller
+ * than the minimal accepted PMTU:
+ * - if the new MTU is greater than the PMTU, don't make any change
+ * - otherwise, unlock and set PMTU
+ */
+static void nh_update_mtu(struct fib_nh *nh, u32 new, u32 orig)
+{
+	struct fnhe_hash_bucket *bucket;
+	int i;
+
+	bucket = rcu_dereference_protected(nh->nh_exceptions, 1);
+	if (!bucket)
+		return;
+
+	for (i = 0; i < FNHE_HASH_SIZE; i++) {
+		struct fib_nh_exception *fnhe;
+
+		for (fnhe = rcu_dereference_protected(bucket[i].chain, 1);
+		     fnhe;
+		     fnhe = rcu_dereference_protected(fnhe->fnhe_next, 1)) {
+			if (fnhe->fnhe_mtu_locked) {
+				if (new <= fnhe->fnhe_pmtu) {
+					fnhe->fnhe_pmtu = new;
+					fnhe->fnhe_mtu_locked = false;
+				}
+			} else if (new < fnhe->fnhe_pmtu ||
+				   orig == fnhe->fnhe_pmtu) {
+				fnhe->fnhe_pmtu = new;
+			}
+		}
+	}
+}
+
+void fib_sync_mtu(struct net_device *dev, u32 orig_mtu)
+{
+	unsigned int hash = fib_devindex_hashfn(dev->ifindex);
+	struct hlist_head *head = &fib_info_devhash[hash];
+	struct fib_nh *nh;
+
+	hlist_for_each_entry(nh, head, nh_hash) {
+		if (nh->nh_dev == dev)
+			nh_update_mtu(nh, dev->mtu, orig_mtu);
+	}
+}
+
 int fib_sync_down_dev(struct net_device *dev, int force)
 {
 	int ret = 0;

