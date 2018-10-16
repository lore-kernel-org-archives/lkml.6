Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECDDC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 100D720866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sr1Dcf4z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 100D720866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731478AbeJQBPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:15:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:33682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730396AbeJQBPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:15:07 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F20420658;
        Tue, 16 Oct 2018 17:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710621;
        bh=U+Bv1KNzR0eZp1Iq0KsYU/FXlScofngEaP3HBfjydN0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sr1Dcf4zIGsa4pOfkJGBS0SLVyrgBLJgrYBgCzdqjT/ThP7d33dfQE0ZB91F896vG
         GCGM8LvfZSnME2l8ZngZYM1l8dx2hys592tPKocHFx1CnpWaqVL2jUUOO36FFOKzR/
         lAE9ev1TSzMJ9J+RaWVvodZRWR3JJ7iV0Irdyuow=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sabrina Dubroca <sd@queasysnail.net>,
        Stefano Brivio <sbrivio@redhat.com>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 30/71] net: ipv4: update fnhe_pmtu when first hops MTU changes
Date:   Tue, 16 Oct 2018 19:09:27 +0200
Message-Id: <20181016170540.905851632@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170539.315587743@linuxfoundation.org>
References: <20181016170539.315587743@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sabrina Dubroca <sd@queasysnail.net>

[ Upstream commit af7d6cce53694a88d6a1bb60c9a239a6a5144459 ]

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/netdevice.h |    7 ++++++
 include/net/ip_fib.h      |    1 
 net/core/dev.c            |   28 +++++++++++++++++++++++--
 net/ipv4/fib_frontend.c   |   12 +++++++----
 net/ipv4/fib_semantics.c  |   50 ++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 92 insertions(+), 6 deletions(-)

--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2338,6 +2338,13 @@ struct netdev_notifier_info {
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
@@ -363,6 +363,7 @@ int ip_fib_check_default(__be32 gw, stru
 int fib_sync_down_dev(struct net_device *dev, unsigned long event, bool force);
 int fib_sync_down_addr(struct net_device *dev, __be32 local);
 int fib_sync_up(struct net_device *dev, unsigned int nh_flags);
+void fib_sync_mtu(struct net_device *dev, u32 orig_mtu);
 
 extern u32 fib_multipath_secret __read_mostly;
 
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1664,6 +1664,28 @@ int call_netdevice_notifiers(unsigned lo
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
 #ifdef CONFIG_NET_INGRESS
 static struct static_key ingress_needed __read_mostly;
 
@@ -6589,14 +6611,16 @@ int dev_set_mtu(struct net_device *dev,
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
@@ -1171,7 +1171,8 @@ static int fib_inetaddr_event(struct not
 static int fib_netdev_event(struct notifier_block *this, unsigned long event, void *ptr)
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
-	struct netdev_notifier_changeupper_info *info;
+	struct netdev_notifier_changeupper_info *upper_info = ptr;
+	struct netdev_notifier_info_ext *info_ext = ptr;
 	struct in_device *in_dev;
 	struct net *net = dev_net(dev);
 	unsigned int flags;
@@ -1206,16 +1207,19 @@ static int fib_netdev_event(struct notif
 			fib_sync_up(dev, RTNH_F_LINKDOWN);
 		else
 			fib_sync_down_dev(dev, event, false);
-		/* fall through */
+		rt_cache_flush(net);
+		break;
 	case NETDEV_CHANGEMTU:
+		fib_sync_mtu(dev, info_ext->ext.mtu);
 		rt_cache_flush(net);
 		break;
 	case NETDEV_CHANGEUPPER:
-		info = ptr;
+		upper_info = ptr;
 		/* flush all routes if dev is linked to or unlinked from
 		 * an L3 master device (e.g., VRF)
 		 */
-		if (info->upper_dev && netif_is_l3_master(info->upper_dev))
+		if (upper_info->upper_dev &&
+		    netif_is_l3_master(upper_info->upper_dev))
 			fib_disable_ip(dev, NETDEV_DOWN, true);
 		break;
 	}
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -1377,6 +1377,56 @@ int fib_sync_down_addr(struct net_device
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
 /* Event              force Flags           Description
  * NETDEV_CHANGE      0     LINKDOWN        Carrier OFF, not for scope host
  * NETDEV_DOWN        0     LINKDOWN|DEAD   Link down, not for scope host


