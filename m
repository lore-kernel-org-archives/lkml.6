Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4DC8ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 21:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 632E620652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 21:57:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 632E620652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731921AbeGTWr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 18:47:58 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37664 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728214AbeGTWr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 18:47:58 -0400
Received: from 2.general.tyhicks.us.vpn ([10.172.64.53] helo=sec.l.tihix.com)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <tyhicks@canonical.com>)
        id 1fgdPF-0004ZT-2D; Fri, 20 Jul 2018 21:57:45 +0000
From:   Tyler Hicks <tyhicks@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Stephen Hemminger <stephen@networkplumber.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bridge@lists.linux-foundation.org,
        Linux Containers <containers@lists.linux-foundation.org>
Subject: [PATCH net-next v3 7/8] net: create reusable function for getting ownership info of sysfs inodes
Date:   Fri, 20 Jul 2018 21:56:53 +0000
Message-Id: <1532123814-1109-8-git-send-email-tyhicks@canonical.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532123814-1109-1-git-send-email-tyhicks@canonical.com>
References: <1532123814-1109-1-git-send-email-tyhicks@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make net_ns_get_ownership() reusable by networking code outside of core.
This is useful, for example, to allow bridge related sysfs files to be
owned by container root.

Add a function comment since this is a potentially dangerous function to
use given the way that kobject_get_ownership() works by initializing uid
and gid before calling .get_ownership().

Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
---
 include/net/net_namespace.h | 10 ++++++++++
 net/core/net-sysfs.c        | 18 ------------------
 net/core/net_namespace.c    | 28 ++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 18 deletions(-)

diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index a71264d75d7f..9b5fdc50519a 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -10,6 +10,7 @@
 #include <linux/workqueue.h>
 #include <linux/list.h>
 #include <linux/sysctl.h>
+#include <linux/uidgid.h>
 
 #include <net/flow.h>
 #include <net/netns/core.h>
@@ -170,6 +171,8 @@ extern struct net init_net;
 struct net *copy_net_ns(unsigned long flags, struct user_namespace *user_ns,
 			struct net *old_net);
 
+void net_ns_get_ownership(const struct net *net, kuid_t *uid, kgid_t *gid);
+
 void net_ns_barrier(void);
 #else /* CONFIG_NET_NS */
 #include <linux/sched.h>
@@ -182,6 +185,13 @@ static inline struct net *copy_net_ns(unsigned long flags,
 	return old_net;
 }
 
+static inline void net_ns_get_ownership(const struct net *net,
+					kuid_t *uid, kgid_t *gid)
+{
+	*uid = GLOBAL_ROOT_UID;
+	*gid = GLOBAL_ROOT_GID;
+}
+
 static inline void net_ns_barrier(void) {}
 #endif /* CONFIG_NET_NS */
 
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index ada065fc685e..0a95bcf64cdc 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -656,24 +656,6 @@ static const struct attribute_group wireless_group = {
 #define net_class_groups	NULL
 #endif /* CONFIG_SYSFS */
 
-static void net_ns_get_ownership(const struct net *net,
-				 kuid_t *uid, kgid_t *gid)
-{
-	if (net) {
-		kuid_t ns_root_uid = make_kuid(net->user_ns, 0);
-		kgid_t ns_root_gid = make_kgid(net->user_ns, 0);
-
-		if (uid_valid(ns_root_uid))
-			*uid = ns_root_uid;
-
-		if (gid_valid(ns_root_gid))
-			*gid = ns_root_gid;
-	} else {
-		*uid = GLOBAL_ROOT_UID;
-		*gid = GLOBAL_ROOT_GID;
-	}
-}
-
 #ifdef CONFIG_SYSFS
 #define to_rx_queue_attr(_attr) \
 	container_of(_attr, struct rx_queue_attribute, attr)
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index a11e03f920d3..738871af5efa 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -17,6 +17,7 @@
 #include <linux/user_namespace.h>
 #include <linux/net_namespace.h>
 #include <linux/sched/task.h>
+#include <linux/uidgid.h>
 
 #include <net/sock.h>
 #include <net/netlink.h>
@@ -448,6 +449,33 @@ struct net *copy_net_ns(unsigned long flags,
 	return net;
 }
 
+/**
+ * net_ns_get_ownership - get sysfs ownership data for @net
+ * @net: network namespace in question (can be NULL)
+ * @uid: kernel user ID for sysfs objects
+ * @gid: kernel group ID for sysfs objects
+ *
+ * Returns the uid/gid pair of root in the user namespace associated with the
+ * given network namespace.
+ */
+void net_ns_get_ownership(const struct net *net, kuid_t *uid, kgid_t *gid)
+{
+	if (net) {
+		kuid_t ns_root_uid = make_kuid(net->user_ns, 0);
+		kgid_t ns_root_gid = make_kgid(net->user_ns, 0);
+
+		if (uid_valid(ns_root_uid))
+			*uid = ns_root_uid;
+
+		if (gid_valid(ns_root_gid))
+			*gid = ns_root_gid;
+	} else {
+		*uid = GLOBAL_ROOT_UID;
+		*gid = GLOBAL_ROOT_GID;
+	}
+}
+EXPORT_SYMBOL_GPL(net_ns_get_ownership);
+
 static void unhash_nsid(struct net *net, struct net *last)
 {
 	struct net *tmp;
-- 
2.7.4

