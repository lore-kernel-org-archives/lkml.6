Return-Path: <christianvanbrauner@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524824730; cv=none;
        d=google.com; s=arc-20160816;
        b=qlwG784tC44C2SAUS4UnnjdFvcG7luJw29dTKHyJ5OINHNdYw7tT+ObgyISWbHC6uu
         zFNkWpQ7i4lZ4l7h5NG2/LklM+bQZIEn1KJxGoqZWOXim0x5yBtObanZlYR7zb34K+V7
         7XK3PBtQk+J87Bc5c08s2vD0iJXytmq375fXk82TBwCx2vrICMpf+8fQFRRHE1uEafIi
         qsn9PD3n64Mh6mGV/VUv3nnPb4vKG3DKzpIZDnZnSMbVsddn0iF2K59vPKKAE+yzRyp7
         A3zm9Av5E/kkQQrgS/jSFu2t8lyXycPQjXDUTT8fsOMcpRvNLOqWaF1bjAF6fHpWHxav
         hlWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=wMM9vIiTpJ5EZ3dfDyuC7kZtddGGgcNMyTZ15+a57To=;
        b=UJ57uM6Fn6sHGI62t2NPahYfSRl0U0Z3E8gKCu1s45cgkBa67vwgDeaZq5Aa0uYq3F
         2M034SFSUBbTcRxxVnj4rQvmxv3S3XfU55LvRfCS7L0K4GIn4Gm/SL1BlB8Yj/06P594
         u/4qcMBBUdXCP1Eujeb0CNJwq0BUpWpbwKLgnDfFNKQuTvnMtJntBOwWxXtWGp+VdBr5
         2IqSAc6UBZxxU5vxiuvJw768uRzpyGG5l86yjgAJgQ03S2mhq/i96CFhHukqy5kledzL
         LtRgi6ypXO0ljoAdl/WHoO390KJwgYpUwJx67dJQb013a10eeXZMjuVC4Z2ZmU745GsH
         Bbgg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
X-Google-Smtp-Source: AB8JxZr4XRmCg6phA9eprVOKDHdzbMKaug+wWXoNQYSuhJgpUO0JajgCXDBmJX3lCvwhI+hbqyptWA==
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
Subject: [PATCH net-next 2/2 v3] netns: restrict uevents
Date: Fri, 27 Apr 2018 12:23:06 +0200
Message-Id: <20180427102306.8617-3-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427102306.8617-1-christian.brauner@ubuntu.com>
References: <20180427102306.8617-1-christian.brauner@ubuntu.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598894617083131162?=
X-GMAIL-MSGID: =?utf-8?q?1598894617083131162?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

commit 07e98962fa77 ("kobject: Send hotplug events in all network namespaces")

enabled sending hotplug events into all network namespaces back in 2010.
Over time the set of uevents that get sent into all network namespaces has
shrunk. We have now reached the point where hotplug events for all devices
that carry a namespace tag are filtered according to that namespace.
Specifically, they are filtered whenever the namespace tag of the kobject
does not match the namespace tag of the netlink socket.
Currently, only network devices carry namespace tags (i.e. network
namespace tags). Hence, uevents for network devices only show up in the
network namespace such devices are created in or moved to.

However, any uevent for a kobject that does not have a namespace tag
associated with it will not be filtered and we will broadcast it into all
network namespaces. This behavior stopped making sense when user namespaces
were introduced.

This patch simplifies and fixes couple of things:
- Split codepath for sending uevents by kobject namespace tags:
  1. Untagged kobjects - uevent_net_broadcast_untagged():
     Untagged kobjects will be broadcast into all uevent sockets recorded
     in uevent_sock_list, i.e. into all network namespacs owned by the
     intial user namespace.
  2. Tagged kobjects - uevent_net_broadcast_tagged():
     Tagged kobjects will only be broadcast into the network namespace they
     were tagged with.
  Handling of tagged kobjects in 2. does not cause any semantic changes.
  This is just splitting out the filtering logic that was handled by
  kobj_bcast_filter() before.
  Handling of untagged kobjects in 1. will cause a semantic change. The
  reasons why this is needed and ok have been discussed in [1]. Here is a
  short summary:
  - Userspace ignores uevents from network namespaces that are not owned by
    the intial user namespace:
    Uevents are filtered by userspace in a user namespace because the
    received uid != 0. Instead the uid associated with the event will be
    65534 == "nobody" because the global root uid is not mapped.
    This means we can safely and without introducing regressions modify the
    kernel to not send uevents into all network namespaces whose owning
    user namespace is not the initial user namespace because we know that
    userspace will ignore the message because of the uid anyway.
    I have a) verified that is is true for every udev implementation out
    there b) that this behavior has been present in all udev
    implementations from the very beginning.
  - Thundering herd:
    Broadcasting uevents into all network namespaces introduces significant
    overhead.
    All processes that listen to uevents running in non-initial user
    namespaces will end up responding to uevents that will be meaningless
    to them. Mainly, because non-initial user namespaces cannot easily
    manage devices unless they have a privileged host-process helping them
    out. This means that there will be a thundering herd of activity when
    there shouldn't be any.
  - Removing needless overhead/Increasing performance:
    Currently, the uevent socket for each network namespace is added to the
    global variable uevent_sock_list. The list itself needs to be protected
    by a mutex. So everytime a uevent is generated the mutex is taken on
    the list. The mutex is held *from the creation of the uevent (memory
    allocation, string creation etc. until all uevent sockets have been
    handled*. This is aggravated by the fact that for each uevent socket
    that has listeners the mc_list must be walked as well which means we're
    talking O(n^2) here. Given that a standard Linux workload usually has
    quite a lot of network namespaces and - in the face of containers - a
    lot of user namespaces this quickly becomes a performance problem (see
    "Thundering herd" above). By just recording uevent sockets of network
    namespaces that are owned by the initial user namespace we
    significantly increase performance in this codepath.
  - Injecting uevents:
    There's a valid argument that containers might be interested in
    receiving device events especially if they are delegated to them by a
    privileged userspace process. One prime example are SR-IOV enabled
    devices that are explicitly designed to be handed of to other users
    such as VMs or containers.
    This use-case can now be correctly handled since
    commit 692ec06d7c92 ("netns: send uevent messages"). This commit
    introduced the ability to send uevents from userspace. As such we can
    let a sufficiently privileged (CAP_SYS_ADMIN in the owning user
    namespace of the network namespace of the netlink socket) userspace
    process make a decision what uevents should be sent. This removes the
    need to blindly broadcast uevents into all user namespaces and provides
    a performant and safe solution to this problem.
  - Filtering logic:
    This patch filters by *owning user namespace of the network namespace a
    given task resides in* and not by user namespace of the task per se.
    This means if the user namespace of a given task is unshared but the
    network namespace is kept and is owned by the initial user namespace a
    listener that is opening the uevent socket in that network namespace
    can still listen to uevents.
- Fix permission for tagged kobjects:
  Network devices that are created or moved into a network namespace that
  is owned by a non-initial user namespace currently are send with
  INVALID_{G,U}ID in their credentials. This means that all current udev
  implementations in userspace will ignore the uevent they receive for
  them. This has lead to weird bugs whereby new devices showing up in such
  network namespaces were not recognized and did not get IPs assigned etc.
  This patch adjusts the permission to the appropriate {g,u}id in the
  respective user namespace. This way udevd is able to correctly handle
  such devices.
- Simplify filtering logic:
  do_one_broadcast() already ensures that only listeners in mc_list receive
  uevents that have the same network namespace as the uevent socket itself.
  So the filtering logic in kobj_bcast_filter is not needed (see [3]). This
  patch therefore removes kobj_bcast_filter() and replaces
  netlink_broadcast_filtered() with the simpler netlink_broadcast()
  everywhere.

[1]: https://lkml.org/lkml/2018/4/4/739
[2]: https://lkml.org/lkml/2018/4/26/767
[3]: https://lkml.org/lkml/2018/4/26/738
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 lib/kobject_uevent.c | 140 ++++++++++++++++++++++++++++++-------------
 1 file changed, 99 insertions(+), 41 deletions(-)

diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index c3cb110f663b..d8ce5e6d83af 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -22,6 +22,7 @@
 #include <linux/socket.h>
 #include <linux/skbuff.h>
 #include <linux/netlink.h>
+#include <linux/uidgid.h>
 #include <linux/uuid.h>
 #include <linux/ctype.h>
 #include <net/sock.h>
@@ -231,30 +232,6 @@ int kobject_synth_uevent(struct kobject *kobj, const char *buf, size_t count)
 	return r;
 }
 
-#ifdef CONFIG_NET
-static int kobj_bcast_filter(struct sock *dsk, struct sk_buff *skb, void *data)
-{
-	struct kobject *kobj = data, *ksobj;
-	const struct kobj_ns_type_operations *ops;
-
-	ops = kobj_ns_ops(kobj);
-	if (!ops && kobj->kset) {
-		ksobj = &kobj->kset->kobj;
-		if (ksobj->parent != NULL)
-			ops = kobj_ns_ops(ksobj->parent);
-	}
-
-	if (ops && ops->netlink_ns && kobj->ktype->namespace) {
-		const void *sock_ns, *ns;
-		ns = kobj->ktype->namespace(kobj);
-		sock_ns = ops->netlink_ns(dsk);
-		return sock_ns != ns;
-	}
-
-	return 0;
-}
-#endif
-
 #ifdef CONFIG_UEVENT_HELPER
 static int kobj_usermode_filter(struct kobject *kobj)
 {
@@ -296,6 +273,7 @@ static void cleanup_uevent_env(struct subprocess_info *info)
 }
 #endif
 
+#ifdef CONFIG_NET
 static struct sk_buff *alloc_uevent_skb(struct kobj_uevent_env *env,
 					const char *action_string,
 					const char *devpath)
@@ -321,15 +299,13 @@ static struct sk_buff *alloc_uevent_skb(struct kobj_uevent_env *env,
 	return skb;
 }
 
-static int kobject_uevent_net_broadcast(struct kobject *kobj,
-					struct kobj_uevent_env *env,
-					const char *action_string,
-					const char *devpath)
+static int uevent_net_broadcast_untagged(struct kobj_uevent_env *env,
+					 const char *action_string,
+					 const char *devpath)
 {
-	int retval = 0;
-#if defined(CONFIG_NET)
 	struct sk_buff *skb = NULL;
 	struct uevent_sock *ue_sk;
+	int retval = 0;
 
 	/* send netlink message */
 	list_for_each_entry(ue_sk, &uevent_sock_list, list) {
@@ -345,19 +321,95 @@ static int kobject_uevent_net_broadcast(struct kobject *kobj,
 				continue;
 		}
 
-		retval = netlink_broadcast_filtered(uevent_sock, skb_get(skb),
-						    0, 1, GFP_KERNEL,
-						    kobj_bcast_filter,
-						    kobj);
+		retval = netlink_broadcast(uevent_sock, skb_get(skb), 0, 1,
+					   GFP_KERNEL);
 		/* ENOBUFS should be handled in userspace */
 		if (retval == -ENOBUFS || retval == -ESRCH)
 			retval = 0;
 	}
 	consume_skb(skb);
-#endif
+
 	return retval;
 }
 
+static int uevent_net_broadcast_tagged(struct sock *usk,
+				       struct kobj_uevent_env *env,
+				       const char *action_string,
+				       const char *devpath)
+{
+	struct user_namespace *owning_user_ns = sock_net(usk)->user_ns;
+	struct sk_buff *skb = NULL;
+	int ret;
+
+	skb = alloc_uevent_skb(env, action_string, devpath);
+	if (!skb)
+		return -ENOMEM;
+
+	/* fix credentials */
+	if (owning_user_ns != &init_user_ns) {
+		struct netlink_skb_parms *parms = &NETLINK_CB(skb);
+		kuid_t root_uid;
+		kgid_t root_gid;
+
+		/* fix uid */
+		root_uid = make_kuid(owning_user_ns, 0);
+		if (!uid_valid(root_uid))
+			root_uid = GLOBAL_ROOT_UID;
+		parms->creds.uid = root_uid;
+
+		/* fix gid */
+		root_gid = make_kgid(owning_user_ns, 0);
+		if (!gid_valid(root_gid))
+			root_gid = GLOBAL_ROOT_GID;
+		parms->creds.gid = root_gid;
+	}
+
+	ret = netlink_broadcast(usk, skb, 0, 1, GFP_KERNEL);
+	/* ENOBUFS should be handled in userspace */
+	if (ret == -ENOBUFS || ret == -ESRCH)
+		ret = 0;
+
+	return ret;
+}
+#endif
+
+static int kobject_uevent_net_broadcast(struct kobject *kobj,
+					struct kobj_uevent_env *env,
+					const char *action_string,
+					const char *devpath)
+{
+	int ret = 0;
+
+#ifdef CONFIG_NET
+	const struct kobj_ns_type_operations *ops;
+	const struct net *net = NULL;
+
+	ops = kobj_ns_ops(kobj);
+	if (!ops && kobj->kset) {
+		struct kobject *ksobj = &kobj->kset->kobj;
+		if (ksobj->parent != NULL)
+			ops = kobj_ns_ops(ksobj->parent);
+	}
+
+	/* kobjects currently only carry network namespace tags and they
+	 * are the only tag relevant here since we want to decide which
+	 * network namespaces to broadcast the uevent into.
+	 */
+	if (ops && ops->netlink_ns && kobj->ktype->namespace)
+		if (ops->type == KOBJ_NS_TYPE_NET)
+			net = kobj->ktype->namespace(kobj);
+
+	if (!net)
+		ret = uevent_net_broadcast_untagged(env, action_string,
+						    devpath);
+	else
+		ret = uevent_net_broadcast_tagged(net->uevent_sock->sk, env,
+						  action_string, devpath);
+#endif
+
+	return ret;
+}
+
 static void zap_modalias_env(struct kobj_uevent_env *env)
 {
 	static const char modalias_prefix[] = "MODALIAS=";
@@ -716,9 +768,13 @@ static int uevent_net_init(struct net *net)
 
 	net->uevent_sock = ue_sk;
 
-	mutex_lock(&uevent_sock_mutex);
-	list_add_tail(&ue_sk->list, &uevent_sock_list);
-	mutex_unlock(&uevent_sock_mutex);
+	/* Restrict uevents to initial user namespace. */
+	if (sock_net(ue_sk->sk)->user_ns == &init_user_ns) {
+		mutex_lock(&uevent_sock_mutex);
+		list_add_tail(&ue_sk->list, &uevent_sock_list);
+		mutex_unlock(&uevent_sock_mutex);
+	}
+
 	return 0;
 }
 
@@ -726,9 +782,11 @@ static void uevent_net_exit(struct net *net)
 {
 	struct uevent_sock *ue_sk = net->uevent_sock;
 
-	mutex_lock(&uevent_sock_mutex);
-	list_del(&ue_sk->list);
-	mutex_unlock(&uevent_sock_mutex);
+	if (sock_net(ue_sk->sk)->user_ns == &init_user_ns) {
+		mutex_lock(&uevent_sock_mutex);
+		list_del(&ue_sk->list);
+		mutex_unlock(&uevent_sock_mutex);
+	}
 
 	netlink_kernel_release(ue_sk->sk);
 	kfree(ue_sk);
-- 
2.17.0
