Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980E3ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B4E82087C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:08:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B4E82087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387792AbeGMQXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 12:23:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38416 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729784AbeGMQXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 12:23:37 -0400
Received: from 2.general.tyhicks.us.vpn ([10.172.64.53] helo=sec.ubuntu-ci)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <tyhicks@canonical.com>)
        id 1fe0cD-0006pX-Rv; Fri, 13 Jul 2018 16:08:18 +0000
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
Subject: [PATCH net-next v2 6/7] net: Create reusable function for getting ownership info of sysfs inodes
Date:   Fri, 13 Jul 2018 16:05:48 +0000
Message-Id: <1531497949-1766-7-git-send-email-tyhicks@canonical.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531497949-1766-1-git-send-email-tyhicks@canonical.com>
References: <1531497949-1766-1-git-send-email-tyhicks@canonical.com>
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
 include/net/net_namespace.h |  7 +++++++
 net/core/net-sysfs.c        | 15 ---------------
 net/core/net_namespace.c    | 25 +++++++++++++++++++++++++
 3 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index a71264d75d7f..a257710527ce 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -170,6 +170,8 @@ extern struct net init_net;
 struct net *copy_net_ns(unsigned long flags, struct user_namespace *user_ns,
 			struct net *old_net);
 
+void net_ns_get_ownership(const struct net *net, kuid_t *uid, kgid_t *gid);
+
 void net_ns_barrier(void);
 #else /* CONFIG_NET_NS */
 #include <linux/sched.h>
@@ -182,6 +184,11 @@ static inline struct net *copy_net_ns(unsigned long flags,
 	return old_net;
 }
 
+static inline void net_ns_get_ownership(const struct net *net,
+					kuid_t *uid, kgid_t *gid)
+{
+}
+
 static inline void net_ns_barrier(void) {}
 #endif /* CONFIG_NET_NS */
 
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 41d84c40fe51..a3ad8108d296 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -656,21 +656,6 @@ static const struct attribute_group wireless_group = {
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
-	}
-}
-
 #ifdef CONFIG_SYSFS
 #define to_rx_queue_attr(_attr) \
 	container_of(_attr, struct rx_queue_attribute, attr)
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index a11e03f920d3..5257875fa84d 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -448,6 +448,31 @@ struct net *copy_net_ns(unsigned long flags,
 	return net;
 }
 
+/**
+ * net_ns_get_ownership - get sysfs ownership data for @net
+ * @net: network namespace in question (can be NULL)
+ * @uid: kernel user ID for sysfs objects (must be GLOBAL_ROOT_UID)
+ * @gid: kernel group ID for sysfs objects (must be GLOBAL_ROOT_GID)
+ *
+ * Returns the uid/gid pair of root in the user namespace associated with the
+ * given network namespace. The caller must initialize @uid and @gid to
+ * GLOBAL_ROOT_UID/GLOBAL_ROOT_GID before calling this function.
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
+	}
+}
+EXPORT_SYMBOL_GPL(net_ns_get_ownership);
+
 static void unhash_nsid(struct net *net, struct net *last)
 {
 	struct net *tmp;
-- 
2.7.4

