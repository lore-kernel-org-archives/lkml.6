Return-Path: <christianvanbrauner@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521204657; cv=none;
        d=google.com; s=arc-20160816;
        b=MBB0gx1Y9NawQcGOFw1YPATRFvEZFeSf1ZC7XaRx/B+mO7m4niCrclq8vEzoTJv/p9
         g5E8+LbEBac0YCaGGQGcbtQyOjK7KgAk+LnRv/L/rFdPHD5geO50Kbq2zkydHpgd3R78
         qleskfAkFxJie8hmI2dEYL7Nqj4DAxFO0ND5P0dZHIqYA99SeKBJOMVsuB4B8naDpfBC
         6ePPoewKGOqa/PppX8q7y+J/+QrJLj4tEPnfIjd4VtemxmIRMF4H9dlBoxucLR8cPrJP
         H9IwcuR51rcuNJAlTiq+/mZrxYUbZi8y73hIThg1uprLURM14VQ+PZ8kC7eDGj6Nx5IC
         teUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=pcrGgpuVYaZ3vwBam6tlRHF23vwNdGOq/EZ7W0BgkFc=;
        b=GjObFDu+quiCb1UJxHS3vcenWOp1HJhlw2gYoSZTkdd5WpZznOqqlbr7EZZQIoTYNp
         9roKL9DM9rDI3fqc3Lp1IyCdCyWPQ9BfTuHqQ4ZGiNTLii12qaIIrrtxltcWrCKzLWmw
         ecjxsLcaWmjk4OYV11KAguJ2pauGRDksG9XU3Iwv8oVOvqNdJzShMpA88HM7mZeOTm9f
         MKd7Nj8TgnVEUrbD8yn8+4yqPAk2x+bZ1Uh9FHfOs+Oc8ByzbW/5xOwcpRc1C59hpV8K
         WQrYfJUdLmdcKnUPguOmL2Tr1g3f0iAiThDwHR0T3GPv2ZeOifzTVDneumwQH1RbWv6P
         aWTw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
X-Google-Smtp-Source: AG47ELuw0sFHO2BfR2gbBaxlvTTbXnZddBTS8/SZxjOMkPfwh8TC2VM4YNcBfQFYys0nnBS+Twrq/g==
From: Christian Brauner <christian.brauner@ubuntu.com>
To: ebiederm@xmission.com,
	gregkh@linuxfoundation.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: serge@hallyn.com,
	avagin@virtuozzo.com,
	ktkhai@virtuozzo.com,
	Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v2] netns: send uevent messages
Date: Fri, 16 Mar 2018 13:50:30 +0100
Message-Id: <20180316125030.23624-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.15.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595098694946431538?=
X-GMAIL-MSGID: =?utf-8?q?1595098694946431538?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch adds a receive method to NETLINK_KOBJECT_UEVENT netlink sockets
to allow sending uevent messages into the network namespace the socket
belongs to.

Currently non-initial network namespaces are already isolated and don't
receive uevents. There are a number of cases where it is beneficial for a
sufficiently privileged userspace process to send a uevent into a network
namespace.

One such use case would be debugging and fuzzing of a piece of software
which listens and reacts to uevents. By running a copy of that software
inside a network namespace, specific uevents could then be presented to it.
More concretely, this would allow for easy testing of udevd/ueventd.

This will also allow some piece of software to run components inside a
separate network namespace and then effectively filter what that software
can receive. Some examples of software that do directly listen to uevents
and that we have in the past attempted to run inside a network namespace
are rbd (CEPH client) or the X server.

Implementation:
The implementation has been kept as simple as possible from the kernel's
perspective. Specifically, a simple input method uevent_net_rcv() is added
to NETLINK_KOBJECT_UEVENT sockets which completely reuses existing
af_netlink infrastructure and does neither add an additional netlink family
nor requires any user-visible changes.

For example, by using netlink_rcv_skb() we can make use of existing netlink
infrastructure to report back informative error messages to userspace.

Furthermore, this implementation does not introduce any overhead for
existing uevent generating codepaths. The struct netns gets a new uevent
socket member that records the uevent socket associated with that network
namespace including its position in the uevent socket list. Since we record
the uevent socket for each network namespace in struct net we don't have to
walk the whole uevent socket list. Instead we can directly retrieve the
relevant uevent socket and send the message. At exit time we can now also
trivially remove the uevent socket from the uevent socket list. This keeps
the codepath very performant without introducing needless overhead and even
makes older codepaths faster.

Uevent sequence numbers are kept global. When a uevent message is sent to
another network namespace the implementation will simply increment the
global uevent sequence number and append it to the received uevent. This
has the advantage that the kernel will never need to parse the received
uevent message to replace any existing uevent sequence numbers. Instead it
is up to the userspace process to remove any existing uevent sequence
numbers in case the uevent message to be sent contains any.

Security:
In order for a caller to send uevent messages to a target network namespace
the caller must have CAP_SYS_ADMIN in the owning user namespace of the
target network namespace. Additionally, any received uevent message is
verified to not exceed size UEVENT_BUFFER_SIZE. This includes the space
needed to append the uevent sequence number.

Testing:
This patch has been tested and verified to work with the following udev
implementations:
1. CentOS 6 with udevd version 147
2. Debian Sid with systemd-udevd version 237
3. Android 7.1.1 with ueventd

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
Changelog v1->v2:
* Add the whole struct uevent_sock to struct net not just the socket
  member. Since struct uevent_sock records the position of the uevent
  socket in the uevent socket list we can trivially remove it from the
  uevent socket list during cleanup. This speeds up the old removal
  codepath. list_del() will hitl __list_del_entry_valid() in its call chain
  which will validate that the element is a member of the list. If it isn't
  it will take care that the list is not modified.
Changelog v0->v1:
* Hold mutex_lock() until uevent is sent to preserve uevent message
  ordering. See udev and commit for reference:

  commit 7b60a18da393ed70db043a777fd9e6d5363077c4
  Author: Andrew Vagin <avagin@openvz.org>
  Date:   Wed Mar 7 14:49:56 2012 +0400

      uevent: send events in correct order according to seqnum (v3)

      The queue handling in the udev daemon assumes that the events are
      ordered.
---
 include/linux/kobject.h     |  6 +++
 include/net/net_namespace.h |  4 +-
 lib/kobject_uevent.c        | 98 ++++++++++++++++++++++++++++++++++++++-------
 3 files changed, 93 insertions(+), 15 deletions(-)

diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index 7f6f93c3df9c..c572c7abc609 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -39,6 +39,12 @@ extern char uevent_helper[];
 /* counter to tag the uevent, read only except for the kobject core */
 extern u64 uevent_seqnum;
 
+/* uevent socket */
+struct uevent_sock {
+	struct list_head list;
+	struct sock *sk;
+};
+
 /*
  * The actions here must match the index to the string array
  * in lib/kobject_uevent.c
diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index f306b2aa15a4..abd7d91bffac 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -40,7 +40,7 @@ struct net_device;
 struct sock;
 struct ctl_table_header;
 struct net_generic;
-struct sock;
+struct uevent_sock;
 struct netns_ipvs;
 
 
@@ -79,6 +79,8 @@ struct net {
 	struct sock 		*rtnl;			/* rtnetlink socket */
 	struct sock		*genl_sock;
 
+	struct uevent_sock	*uevent_sock;		/* uevent socket */
+
 	struct list_head 	dev_base_head;
 	struct hlist_head 	*dev_name_head;
 	struct hlist_head	*dev_index_head;
diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index 9fe6ec8fda28..53e9123474c0 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -25,6 +25,7 @@
 #include <linux/uuid.h>
 #include <linux/ctype.h>
 #include <net/sock.h>
+#include <net/netlink.h>
 #include <net/net_namespace.h>
 
 
@@ -33,10 +34,6 @@ u64 uevent_seqnum;
 char uevent_helper[UEVENT_HELPER_PATH_LEN] = CONFIG_UEVENT_HELPER_PATH;
 #endif
 #ifdef CONFIG_NET
-struct uevent_sock {
-	struct list_head list;
-	struct sock *sk;
-};
 static LIST_HEAD(uevent_sock_list);
 #endif
 
@@ -602,12 +599,88 @@ int add_uevent_var(struct kobj_uevent_env *env, const char *format, ...)
 EXPORT_SYMBOL_GPL(add_uevent_var);
 
 #if defined(CONFIG_NET)
+static int uevent_net_broadcast(struct sock *usk, struct sk_buff *skb,
+				struct netlink_ext_ack *extack)
+{
+	int ret;
+	/* u64 to chars: 2^64 - 1 = 21 chars */
+	char buf[sizeof("SEQNUM=") + 21];
+	struct sk_buff *skbc;
+
+	/* bump and prepare sequence number */
+	ret = snprintf(buf, sizeof(buf), "SEQNUM=%llu", ++uevent_seqnum);
+	if (ret < 0 || (size_t)ret >= sizeof(buf))
+		return -ENOMEM;
+	ret++;
+
+	/* verify message does not overflow */
+	if ((skb->len + ret) > UEVENT_BUFFER_SIZE) {
+		NL_SET_ERR_MSG(extack, "uevent message too big");
+		return -EINVAL;
+	}
+
+	/* copy skb and extend to accommodate sequence number */
+	skbc = skb_copy_expand(skb, 0, ret, GFP_KERNEL);
+	if (!skbc)
+		return -ENOMEM;
+
+	/* append sequence number */
+	skb_put_data(skbc, buf, ret);
+
+	/* remove msg header */
+	skb_pull(skbc, NLMSG_HDRLEN);
+
+	/* set portid 0 to inform userspace message comes from kernel */
+	NETLINK_CB(skbc).portid = 0;
+	NETLINK_CB(skbc).dst_group = 1;
+
+	ret = netlink_broadcast(usk, skbc, 0, 1, GFP_KERNEL);
+	/* ENOBUFS should be handled in userspace */
+	if (ret == -ENOBUFS || ret == -ESRCH)
+		ret = 0;
+
+	return ret;
+}
+
+static int uevent_net_rcv_skb(struct sk_buff *skb, struct nlmsghdr *nlh,
+			      struct netlink_ext_ack *extack)
+{
+	int ret;
+	struct net *net;
+
+	if (!nlmsg_data(nlh))
+		return -EINVAL;
+
+	/*
+	 * Verify that we are allowed to send messages to the target
+	 * network namespace. The caller must have CAP_SYS_ADMIN in the
+	 * owning user namespace of the target network namespace.
+	 */
+	net = sock_net(NETLINK_CB(skb).sk);
+	if (!netlink_ns_capable(skb, net->user_ns, CAP_SYS_ADMIN)) {
+		NL_SET_ERR_MSG(extack, "missing CAP_SYS_ADMIN capability");
+		return -EPERM;
+	}
+
+	mutex_lock(&uevent_sock_mutex);
+	ret = uevent_net_broadcast(net->uevent_sock->sk, skb, extack);
+	mutex_unlock(&uevent_sock_mutex);
+
+	return ret;
+}
+
+static void uevent_net_rcv(struct sk_buff *skb)
+{
+	netlink_rcv_skb(skb, &uevent_net_rcv_skb);
+}
+
 static int uevent_net_init(struct net *net)
 {
 	struct uevent_sock *ue_sk;
 	struct netlink_kernel_cfg cfg = {
 		.groups	= 1,
-		.flags	= NL_CFG_F_NONROOT_RECV,
+		.input = uevent_net_rcv,
+		.flags	= NL_CFG_F_NONROOT_RECV
 	};
 
 	ue_sk = kzalloc(sizeof(*ue_sk), GFP_KERNEL);
@@ -621,6 +694,9 @@ static int uevent_net_init(struct net *net)
 		kfree(ue_sk);
 		return -ENODEV;
 	}
+
+	net->uevent_sock = ue_sk;
+
 	mutex_lock(&uevent_sock_mutex);
 	list_add_tail(&ue_sk->list, &uevent_sock_list);
 	mutex_unlock(&uevent_sock_mutex);
@@ -629,22 +705,16 @@ static int uevent_net_init(struct net *net)
 
 static void uevent_net_exit(struct net *net)
 {
-	struct uevent_sock *ue_sk;
+	struct uevent_sock *ue_sk = net->uevent_sock;
 
 	mutex_lock(&uevent_sock_mutex);
-	list_for_each_entry(ue_sk, &uevent_sock_list, list) {
-		if (sock_net(ue_sk->sk) == net)
-			goto found;
-	}
-	mutex_unlock(&uevent_sock_mutex);
-	return;
-
-found:
 	list_del(&ue_sk->list);
 	mutex_unlock(&uevent_sock_mutex);
 
 	netlink_kernel_release(ue_sk->sk);
 	kfree(ue_sk);
+
+	return;
 }
 
 static struct pernet_operations uevent_net_ops = {
-- 
2.15.1
