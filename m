Return-Path: <christianvanbrauner@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524064881; cv=none;
        d=google.com; s=arc-20160816;
        b=UQXfNMTEhT5/L1isv/tV7jAnHEy7+SJlWIaG24y2Q475XBhdUEYuymrSLi2+l/HlgU
         d1yaKSnq9H4CU6yUiaUEJ4ze+Tx1aVFOQrowxDLSJA4TZ8jsxD4pkfKih/crGbaiyUvh
         CeL5JoU8YBCvRerU7ZOc2IWcwMcixto1lxpHftTtdKLG9MO+NBpGSI/ZFJ849odAnDi9
         MUjJP9aDKG1ocRi9q9/NRZcmUiCzsHrydzFOfxLIXWslQJFQCtuN1k90e4Lv186ddumk
         8kDHZk/g8SufAnR2jTeEBXI1r9x8zxKYDWMFciIoXRA84lfyV/Eh/0HcvhohwQI2S49x
         WrfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=0H9HXSKSR7k5vW1cd1XDErQqZPOVzDOGgC7WfO4KKkw=;
        b=uokLukoajasZ99x6DBUKS1aAmteca0IQi/8EQhipqzVfkgT0Tm6l7r9WoZvP+0cfwj
         xtB0KqGRDv058EcUMHD9b+xHxPFr0hRVm7rulp58BR8PNy4lOzUKpOJM6sIZPD3tpFtK
         5TBIoZucPMsMi7f8PXtJOUFpqxvX/6MM7oVVRwkjaBIb9sABNBsP1jDF+qcPubCE56Jh
         0uZBWLlaN+u5gmxpyLxTKAZfvXT0YJ6dlEJ+iacMoh8G/VWnArQFvOCjiKM6Gj9WDAaz
         C8SSaKtIBHeW0CPFY+E2ZF//bMynE8lwQtljKnyeIo8hdXSDSBUexN6XVf+RIKEA15bo
         EEHw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
X-Google-Smtp-Source: AIpwx4+u4xYHS4swizskQqsAEjLFqW5lNvnFhDp/VMAgmgPI9AZpbpvCLf8vi4hs+CnAr4fQoxLKTg==
From: Christian Brauner <christian.brauner@ubuntu.com>
To: ebiederm@xmission.com,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: avagin@virtuozzo.com,
	ktkhai@virtuozzo.com,
	serge@hallyn.com,
	gregkh@linuxfoundation.org,
	Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH net-next 2/2] netns: isolate seqnums to use per-netns locks
Date: Wed, 18 Apr 2018 17:21:06 +0200
Message-Id: <20180418152106.18519-3-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180418152106.18519-1-christian.brauner@ubuntu.com>
References: <20180418152106.18519-1-christian.brauner@ubuntu.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598097857058546891?=
X-GMAIL-MSGID: =?utf-8?q?1598097857058546891?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Now that it's possible to have a different set of uevents in different
network namespaces, per-network namespace uevent sequence numbers are
introduced. This increases performance as locking is now restricted to the
network namespace affected by the uevent rather than locking everything.

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

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 include/linux/kobject.h     |   3 --
 include/net/net_namespace.h |   3 ++
 kernel/ksysfs.c             |   3 +-
 lib/kobject_uevent.c        | 100 ++++++++++++++++++++++++++++--------
 net/core/net_namespace.c    |  13 +++++
 5 files changed, 98 insertions(+), 24 deletions(-)

diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index 7f6f93c3df9c..776391aea247 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -36,9 +36,6 @@
 extern char uevent_helper[];
 #endif
 
-/* counter to tag the uevent, read only except for the kobject core */
-extern u64 uevent_seqnum;
-
 /*
  * The actions here must match the index to the string array
  * in lib/kobject_uevent.c
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
index 46ba853656f6..83264edcecda 100644
--- a/kernel/ksysfs.c
+++ b/kernel/ksysfs.c
@@ -19,6 +19,7 @@
 #include <linux/sched.h>
 #include <linux/capability.h>
 #include <linux/compiler.h>
+#include <net/net_namespace.h>
 
 #include <linux/rcupdate.h>	/* rcu_expedited and rcu_normal */
 
@@ -33,7 +34,7 @@ static struct kobj_attribute _name##_attr = \
 static ssize_t uevent_seqnum_show(struct kobject *kobj,
 				  struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%llu\n", (unsigned long long)uevent_seqnum);
+	return sprintf(buf, "%llu\n", (unsigned long long)get_ns_uevent_seqnum_by_vpid());
 }
 KERNEL_ATTR_RO(uevent_seqnum);
 
diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index f5f5038787ac..796fd502c227 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -29,21 +29,38 @@
 #include <net/net_namespace.h>
 
 
-u64 uevent_seqnum;
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
@@ -253,6 +270,22 @@ static int kobj_bcast_filter(struct sock *dsk, struct sk_buff *skb, void *data)
 
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
@@ -308,18 +341,22 @@ static int kobject_uevent_net_broadcast(struct kobject *kobj,
 
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
 
@@ -327,11 +364,24 @@ static int kobject_uevent_net_broadcast(struct kobject *kobj,
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
@@ -339,6 +389,9 @@ static int kobject_uevent_net_broadcast(struct kobject *kobj,
 		/* ENOBUFS should be handled in userspace */
 		if (retval == -ENOBUFS || retval == -ESRCH)
 			retval = 0;
+
+		/* remove netns seqnum */
+		skb_trim(skb, env->buflen);
 	}
 	consume_skb(skb);
 #endif
@@ -510,14 +563,7 @@ int kobject_uevent_env(struct kobject *kobj, enum kobject_action action,
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
@@ -605,17 +651,18 @@ int add_uevent_var(struct kobj_uevent_env *env, const char *format, ...)
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
 
@@ -668,9 +715,15 @@ static int uevent_net_rcv_skb(struct sk_buff *skb, struct nlmsghdr *nlh,
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
@@ -708,6 +761,13 @@ static int uevent_net_init(struct net *net)
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
index a11e03f920d3..2f914804ef73 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -618,6 +618,19 @@ struct net *get_net_ns_by_pid(pid_t pid)
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
+
 static __net_init int net_ns_net_init(struct net *net)
 {
 #ifdef CONFIG_NET_NS
-- 
2.17.0
