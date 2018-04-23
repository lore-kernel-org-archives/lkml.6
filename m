Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754756AbeDWKZF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 06:25:05 -0400
Received: from mail-wr0-f175.google.com ([209.85.128.175]:39800 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754689AbeDWKY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 06:24:57 -0400
X-Google-Smtp-Source: AIpwx4/jT/07uY20XCEFmNf8vKKZZ5vqdkuVjEmeju4YeaTdHkJvfqkY9nG1ueObLKuH2vTIbYUb+g==
From: Christian Brauner <christian.brauner@ubuntu.com>
To: ebiederm@xmission.com, davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: avagin@virtuozzo.com, ktkhai@virtuozzo.com, serge@hallyn.com,
        gregkh@linuxfoundation.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH net-next 2/2 v1] netns: isolate seqnums to use per-netns locks
Date: Mon, 23 Apr 2018 12:24:43 +0200
Message-Id: <20180423102443.16627-3-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180423102443.16627-1-christian.brauner@ubuntu.com>
References: <20180423102443.16627-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that it's possible to have a different set of uevents in different
network namespaces, per-network namespace uevent sequence numbers are
introduced. This increases performance as locking is now restricted to the
network namespace affected by the uevent rather than locking everything.
Testing revealed significant performance improvements. For details see
"Testing" below.

Since commit 692ec06 ("netns: send uevent messages") network namespaces not
owned by the intial user namespace can be sent uevents from a sufficiently
privileged userspace process.
In order to send a uevent into a network namespace not owned by the initial
user namespace we currently still need to take the *global mutex* that
locks the uevent socket list even though the list *only contains network
namespaces owned by the initial user namespace*. This needs to be done
because the uevent counter is a global variable. Taking the global lock is
performance sensitive since a user on the host can spawn a pool of n
process that each create their own new user and network namespaces and then
go on to inject uevents in parallel into the network namespace of all of
these processes. This can have a significant performance impact for the
host's udevd since it means that there can be a lot of delay between a
device being added and the corresponding uevent being sent out and
available for processing by udevd. It also means that each network
namespace not owned by the initial user namespace which userspace has sent
a uevent to will need to wait until the lock becomes available.

Implementation:
This patch gives each network namespace its own uevent sequence number.
Each network namespace not owned by the initial user namespace receives its
own mutex. The struct uevent_sock is opaque to callers outside of kobject.c
so the mutex *can* and *is* only ever accessed in lib/kobject.c. In this
file it is clearly documented which lock has to be taken. All network
namespaces owned by the initial user namespace will still share the same
lock since they are all served sequentially via the uevent socket list.
This decouples the locking and ensures that the host retrieves uevents as
fast as possible even if there are a lot of uevents injected into network
namespaces not owned by the initial user namespace.  In addition, each
network namespace not owned by the initial user namespace does not have to
wait on any other network namespace not sharing the same user namespace.

Testing:
Two 4.17-rc1 test kernels were compiled. One with per netns uevent seqnums
with decoupled locking and one without. To ensure that testing made sense
both kernels carried the patch to remove network namespaces not owned by
the initial user namespace from the uevent socket list.
Three tests were constructed. All of them showed significant performance
improvements with per-netns uevent sequence numbers and decoupled locking.

 # Testcase 1:
   Only Injecting Uevents into network namespaces not owned by the initial
   user namespace.
   - created 1000 new user namespace + network namespace pairs
   - opened a uevent listener in each of those namespace pairs
   - injected uevents into each of those network namespaces 10,000 times
     meaning 10,000,000 (10 million) uevents were injected. (The high
     number of uevent injections should get rid of a lot of jitter.)
     The injection was done by fork()ing 1000 uevent injectors in a simple
     for-loop to ensure that uevents were injected in parallel.
   - mean transaction time was calculated:
     - *without* uevent sequence number namespacing: 67 μs
     - *with* uevent sequence number namespacing:    55 μs
     - makes a difference of:                        12 μs
   - a t-test was performed on the two data vectors which revealed
     shows significant performance improvements:
     Welch Two Sample t-test
     data:  x1 and y1
     t = 405.16, df = 18883000, p-value < 2.2e-16
     alternative hypothesis: true difference in means is not equal to 0
     95 percent confidence interval:
     12.14949 12.26761
     sample estimates:
     mean of x mean of y
     68.48594  56.27739

 # Testcase 2:
   Injecting Uevents into network namespaces not owned by the initial user
   namespace and network namespaces owned by the initial user namespace.
   - created 500 new user namespace + network namespace pairs
   - created 500 new network namespace pairs
   - opened a uevent listener in each of those namespace pairs
   - injected uevents into each of those network namespaces 10,000 times
     meaning 10,000,000 (10 million) uevents were injected. (The high
     number of uevent injections should get rid of a lot of jitter.)
     The injection was done by fork()ing 1000 uevent injectors in a simple
     for-loop to ensure that uevents were injected in parallel.
   - mean transaction time was calculated:
     - *without* uevent sequence number namespacing: 572 μs
     - *with* uevent sequence number namespacing:    514 μs
     - makes a difference of:                         58 μs
   - a t-test was performed on the two data vectors which revealed
     shows significant performance improvements:
     Welch Two Sample t-test
     data:  x2 and y2
     t = 38.685, df = 19682000, p-value < 2.2e-16
     alternative hypothesis: true difference in means is not equal to 0
     95 percent confidence interval:
     55.10630 60.98815
     sample estimates:
     mean of x mean of y
     572.9684  514.9211

 # Testcase 3:
   Created 500 new user namespace + network namespace pairs *without uevent
   listeners*
   - created 500 new network namespace pairs *without uevent listeners*
   - injected uevents into each of those network namespaces 10,000 times
     meaning 10,000,000 (10 million) uevents were injected. (The high number
     of uevent injections should get rid of a lot of jitter.)
     The injection was done by fork()ing 1000 uevent injectors in a simple
     for-loop to ensure that uevents were injected in parallel.
    - mean transaction time was calculated:
      - *without* uevent sequence number namespacing: 206 μs
      - *with* uevent sequence number namespacing:    163 μs
      - makes a difference of:                         43 μs
    - a t-test was performed on the two data vectors which revealed
      shows significant performance improvements:
      Welch Two Sample t-test
      data:  x3 and y3
      t = 58.37, df = 17711000, p-value < 2.2e-16
      alternative hypothesis: true difference in means is not equal to 0
      95 percent confidence interval:
      41.77860 44.68178
      sample estimates:
      mean of x mean of y
      207.2632  164.0330

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
Changelog v0->v1:
* add detailed test results to the commit message
* account for kernels compiled without CONFIG_NET
---
 include/linux/kobject.h     |   2 +
 include/net/net_namespace.h |   3 ++
 kernel/ksysfs.c             |  11 +++-
 lib/kobject_uevent.c        | 104 +++++++++++++++++++++++++++++-------
 net/core/net_namespace.c    |  14 +++++
 5 files changed, 114 insertions(+), 20 deletions(-)

diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index 7f6f93c3df9c..4e608968907f 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -36,8 +36,10 @@
 extern char uevent_helper[];
 #endif
 
+#ifndef CONFIG_NET
 /* counter to tag the uevent, read only except for the kobject core */
 extern u64 uevent_seqnum;
+#endif
 
 /*
  * The actions here must match the index to the string array
diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index 47e35cce3b64..e4e171b1ba69 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -85,6 +85,8 @@ struct net {
 	struct sock		*genl_sock;
 
 	struct uevent_sock	*uevent_sock;		/* uevent socket */
+	/* counter to tag the uevent, read only except for the kobject core */
+	u64                     uevent_seqnum;
 
 	struct list_head 	dev_base_head;
 	struct hlist_head 	*dev_name_head;
@@ -189,6 +191,7 @@ extern struct list_head net_namespace_list;
 
 struct net *get_net_ns_by_pid(pid_t pid);
 struct net *get_net_ns_by_fd(int fd);
+u64 get_ns_uevent_seqnum_by_vpid(void);
 
 #ifdef CONFIG_SYSCTL
 void ipx_register_sysctl(void);
diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
index 46ba853656f6..075ec814381b 100644
--- a/kernel/ksysfs.c
+++ b/kernel/ksysfs.c
@@ -19,6 +19,7 @@
 #include <linux/sched.h>
 #include <linux/capability.h>
 #include <linux/compiler.h>
+#include <net/net_namespace.h>
 
 #include <linux/rcupdate.h>	/* rcu_expedited and rcu_normal */
 
@@ -33,7 +34,15 @@ static struct kobj_attribute _name##_attr = \
 static ssize_t uevent_seqnum_show(struct kobject *kobj,
 				  struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%llu\n", (unsigned long long)uevent_seqnum);
+	u64 seqnum;
+
+	#ifdef CONFIG_NET
+		seqnum = get_ns_uevent_seqnum_by_vpid();
+	#else
+		seqnum = uevent_seqnum;
+	#endif
+
+	return sprintf(buf, "%llu\n", (unsigned long long)seqnum);
 }
 KERNEL_ATTR_RO(uevent_seqnum);
 
diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index f5f5038787ac..5da20def556d 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -29,21 +29,42 @@
 #include <net/net_namespace.h>
 
 
+#ifndef CONFIG_NET
 u64 uevent_seqnum;
+#endif
+
 #ifdef CONFIG_UEVENT_HELPER
 char uevent_helper[UEVENT_HELPER_PATH_LEN] = CONFIG_UEVENT_HELPER_PATH;
 #endif
 
+/*
+ * Size a buffer needs to be in order to hold the largest possible sequence
+ * number stored in a u64 including \0 byte: 2^64 - 1 = 21 chars.
+ */
+#define SEQNUM_BUFSIZE (sizeof("SEQNUM=") + 21)
 struct uevent_sock {
 	struct list_head list;
 	struct sock *sk;
+	/*
+	 * This mutex protects uevent sockets and the uevent counter of
+	 * network namespaces *not* owned by init_user_ns.
+	 * For network namespaces owned by init_user_ns this lock is *not*
+	 * valid instead the global uevent_sock_mutex must be used!
+	 */
+	struct mutex sk_mutex;
 };
 
 #ifdef CONFIG_NET
 static LIST_HEAD(uevent_sock_list);
 #endif
 
-/* This lock protects uevent_seqnum and uevent_sock_list */
+/*
+ * This mutex protects uevent sockets and the uevent counter of network
+ * namespaces owned by init_user_ns.
+ * For network namespaces not owned by init_user_ns this lock is *not*
+ * valid instead the network namespace specific sk_mutex in struct
+ * uevent_sock must be used!
+ */
 static DEFINE_MUTEX(uevent_sock_mutex);
 
 /* the strings here must match the enum in include/linux/kobject.h */
@@ -253,6 +274,22 @@ static int kobj_bcast_filter(struct sock *dsk, struct sk_buff *skb, void *data)
 
 	return 0;
 }
+
+static bool can_hold_seqnum(const struct kobj_uevent_env *env, size_t len)
+{
+	if (env->envp_idx >= ARRAY_SIZE(env->envp)) {
+		WARN(1, KERN_ERR "Failed to append sequence number. "
+		     "Too many uevent variables\n");
+		return false;
+	}
+
+	if ((env->buflen + len) > UEVENT_BUFFER_SIZE) {
+		WARN(1, KERN_ERR "Insufficient space to append sequence number\n");
+		return false;
+	}
+
+	return true;
+}
 #endif
 
 #ifdef CONFIG_UEVENT_HELPER
@@ -308,18 +345,22 @@ static int kobject_uevent_net_broadcast(struct kobject *kobj,
 
 	/* send netlink message */
 	list_for_each_entry(ue_sk, &uevent_sock_list, list) {
+		/* bump sequence number */
+		u64 seqnum = ++sock_net(ue_sk->sk)->uevent_seqnum;
 		struct sock *uevent_sock = ue_sk->sk;
+		char buf[SEQNUM_BUFSIZE];
 
 		if (!netlink_has_listeners(uevent_sock, 1))
 			continue;
 
 		if (!skb) {
-			/* allocate message with the maximum possible size */
+			/* calculate header length */
 			size_t len = strlen(action_string) + strlen(devpath) + 2;
 			char *scratch;
 
+			/* allocate message with the maximum possible size */
 			retval = -ENOMEM;
-			skb = alloc_skb(len + env->buflen, GFP_KERNEL);
+			skb = alloc_skb(len + env->buflen + SEQNUM_BUFSIZE, GFP_KERNEL);
 			if (!skb)
 				continue;
 
@@ -327,11 +368,24 @@ static int kobject_uevent_net_broadcast(struct kobject *kobj,
 			scratch = skb_put(skb, len);
 			sprintf(scratch, "%s@%s", action_string, devpath);
 
+			/* add env */
 			skb_put_data(skb, env->buf, env->buflen);
 
 			NETLINK_CB(skb).dst_group = 1;
 		}
 
+		/* prepare netns seqnum */
+		retval = snprintf(buf, SEQNUM_BUFSIZE, "SEQNUM=%llu", seqnum);
+		if (retval < 0 || retval >= SEQNUM_BUFSIZE)
+			continue;
+		retval++;
+
+		if (!can_hold_seqnum(env, retval))
+			continue;
+
+		/* append netns seqnum */
+		skb_put_data(skb, buf, retval);
+
 		retval = netlink_broadcast_filtered(uevent_sock, skb_get(skb),
 						    0, 1, GFP_KERNEL,
 						    kobj_bcast_filter,
@@ -339,8 +393,13 @@ static int kobject_uevent_net_broadcast(struct kobject *kobj,
 		/* ENOBUFS should be handled in userspace */
 		if (retval == -ENOBUFS || retval == -ESRCH)
 			retval = 0;
+
+		/* remove netns seqnum */
+		skb_trim(skb, env->buflen);
 	}
 	consume_skb(skb);
+#else
+	uevent_seqnum++;
 #endif
 	return retval;
 }
@@ -510,14 +569,7 @@ int kobject_uevent_env(struct kobject *kobj, enum kobject_action action,
 	}
 
 	mutex_lock(&uevent_sock_mutex);
-	/* we will send an event, so request a new sequence number */
-	retval = add_uevent_var(env, "SEQNUM=%llu", (unsigned long long)++uevent_seqnum);
-	if (retval) {
-		mutex_unlock(&uevent_sock_mutex);
-		goto exit;
-	}
-	retval = kobject_uevent_net_broadcast(kobj, env, action_string,
-					      devpath);
+	retval = kobject_uevent_net_broadcast(kobj, env, action_string, devpath);
 	mutex_unlock(&uevent_sock_mutex);
 
 #ifdef CONFIG_UEVENT_HELPER
@@ -605,17 +657,18 @@ int add_uevent_var(struct kobj_uevent_env *env, const char *format, ...)
 EXPORT_SYMBOL_GPL(add_uevent_var);
 
 #if defined(CONFIG_NET)
-static int uevent_net_broadcast(struct sock *usk, struct sk_buff *skb,
+static int uevent_net_broadcast(struct uevent_sock *ue_sk, struct sk_buff *skb,
 				struct netlink_ext_ack *extack)
 {
-	/* u64 to chars: 2^64 - 1 = 21 chars */
-	char buf[sizeof("SEQNUM=") + 21];
+	struct sock *usk = ue_sk->sk;
+	char buf[SEQNUM_BUFSIZE];
 	struct sk_buff *skbc;
 	int ret;
 
 	/* bump and prepare sequence number */
-	ret = snprintf(buf, sizeof(buf), "SEQNUM=%llu", ++uevent_seqnum);
-	if (ret < 0 || (size_t)ret >= sizeof(buf))
+	ret = snprintf(buf, SEQNUM_BUFSIZE, "SEQNUM=%llu",
+		       ++sock_net(ue_sk->sk)->uevent_seqnum);
+	if (ret < 0 || ret >= SEQNUM_BUFSIZE)
 		return -ENOMEM;
 	ret++;
 
@@ -668,9 +721,15 @@ static int uevent_net_rcv_skb(struct sk_buff *skb, struct nlmsghdr *nlh,
 		return -EPERM;
 	}
 
-	mutex_lock(&uevent_sock_mutex);
-	ret = uevent_net_broadcast(net->uevent_sock->sk, skb, extack);
-	mutex_unlock(&uevent_sock_mutex);
+	if (net->user_ns == &init_user_ns)
+		mutex_lock(&uevent_sock_mutex);
+	else
+		mutex_lock(&net->uevent_sock->sk_mutex);
+	ret = uevent_net_broadcast(net->uevent_sock, skb, extack);
+	if (net->user_ns == &init_user_ns)
+		mutex_unlock(&uevent_sock_mutex);
+	else
+		mutex_unlock(&net->uevent_sock->sk_mutex);
 
 	return ret;
 }
@@ -708,6 +767,13 @@ static int uevent_net_init(struct net *net)
 		mutex_lock(&uevent_sock_mutex);
 		list_add_tail(&ue_sk->list, &uevent_sock_list);
 		mutex_unlock(&uevent_sock_mutex);
+	} else {
+		/*
+		 * Uevent sockets and counters for network namespaces
+		 * not owned by the initial user namespace have their
+		 * own mutex.
+		 */
+		mutex_init(&ue_sk->sk_mutex);
 	}
 
 	return 0;
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index a11e03f920d3..8894638f5150 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -618,6 +618,20 @@ struct net *get_net_ns_by_pid(pid_t pid)
 }
 EXPORT_SYMBOL_GPL(get_net_ns_by_pid);
 
+u64 get_ns_uevent_seqnum_by_vpid(void)
+{
+	pid_t cur_pid;
+	struct net *net;
+
+	cur_pid = task_pid_vnr(current);
+	net = get_net_ns_by_pid(cur_pid);
+	if (IS_ERR(net))
+		return 0;
+
+	return net->uevent_seqnum;
+}
+EXPORT_SYMBOL_GPL(get_ns_uevent_seqnum_by_vpid);
+
 static __net_init int net_ns_net_init(struct net *net)
 {
 #ifdef CONFIG_NET_NS
-- 
2.17.0
