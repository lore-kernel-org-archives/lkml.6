Return-Path: <christianvanbrauner@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521157251; cv=none;
        d=google.com; s=arc-20160816;
        b=V5GoLtuYBgcYh1LI+FoWeN+6oijVuYx0Wd/VdpfFib9t0nS3U8dN3OpMVvZZuSC4/x
         7mGnLI44Xj2ARdsVgDUjgcYc5eXSTPiJN4PRjK+ZwYyjNj0ysGSHKutrPLHyghzR6wTv
         5BeDC36eWEvTNvOgjgqNWRdSdf70Advn+mhEhMul6XBOu1PB8dqaJ7KwgfK3ka1nS0nA
         yE3H5R0wcL5ihS+ut0x35DFvnE70HzVT2YbtgVZ3RlY5uMD7nTGJCX2vby2w6l3KL+oC
         /dh/NL4u64pvVFn1W8YF15ZuVNoWhAzXXABZzp1SScXukhmK69ZAwQPeEISzTPX3D90s
         4oYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=+K5bOFimXxThoQkmWyOyysUWWVB53ny8sxHQOthZBOA=;
        b=Ms2nS4x87RLoXBCQ8FANYkPQV+gFsdkBuEr6CSye+dhmzTDXU13AcshJLDC1CVuuaC
         l8lA7RSekgTsfliRf9K6MJvAZIXgP+DkK1IkNSPJPOQ62ZdvwTxa0r+FtDfyvXqojg0M
         tsHGqzvahv4c00FkzhNy5s/uIxrsgVQWL8TZenU+BUicvsyS1oHqIb3Vl4vYKtC4KueF
         9PwJ+7Vsv+kvxj0DSHtRLKzOJWSelSMdOLkbQpejMz1//cvvboSZQ1EnJXFt9aq3gw5I
         y2UcLRcfzFgd3R1R8OmMEvXRRueudS/wnwYmcfNmJ48k7oJJMJPW6gMUNCFhHKIMV13p
         0Mtw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
X-Google-Smtp-Source: AG47ELskZpDguWZzX0WyfscyzFP5vOGaNLAC2d5dyTk+v1s49EAa9wE/+9KK1TRGi0luZ5UKoJnaTA==
From: Christian Brauner <christian.brauner@ubuntu.com>
To: ebiederm@xmission.com,
	gregkh@linuxfoundation.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: serge@hallyn.com,
	avagin@virtuozzo.com,
	Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v1] netns: send uevent messages
Date: Fri, 16 Mar 2018 00:39:36 +0100
Message-Id: <20180315233936.30594-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.15.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595048985962121648?=
X-GMAIL-MSGID: =?utf-8?q?1595048985962121648?=
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
namespace. Since we record the uevent socket for each network namespace in
struct net we don't have to walk the whole uevent socket list.
Instead we can directly retrieve the relevant uevent socket and send the
message. This keeps the codepath very performant without introducing
needless overhead.

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
 include/net/net_namespace.h |  1 +
 lib/kobject_uevent.c        | 82 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index f306b2aa15a4..467bde763a9b 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -78,6 +78,7 @@ struct net {
 
 	struct sock 		*rtnl;			/* rtnetlink socket */
 	struct sock		*genl_sock;
+	struct sock		*uevent_sock;		/* uevent socket */
 
 	struct list_head 	dev_base_head;
 	struct hlist_head 	*dev_name_head;
diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index 9fe6ec8fda28..5a07798359a1 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -25,6 +25,7 @@
 #include <linux/uuid.h>
 #include <linux/ctype.h>
 #include <net/sock.h>
+#include <net/netlink.h>
 #include <net/net_namespace.h>
 
 
@@ -602,12 +603,88 @@ int add_uevent_var(struct kobj_uevent_env *env, const char *format, ...)
 EXPORT_SYMBOL_GPL(add_uevent_var);
 
 #if defined(CONFIG_NET)
+static int uevent_net_send(struct sock *usk, struct sk_buff *skb,
+			   struct netlink_ext_ack *extack)
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
+static int uevent_rcv_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
+			  struct netlink_ext_ack *extack)
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
+	ret = uevent_net_send(net->uevent_sock, skb, extack);
+	mutex_unlock(&uevent_sock_mutex);
+
+	return ret;
+}
+
+static void uevent_net_rcv(struct sk_buff *skb)
+{
+	netlink_rcv_skb(skb, &uevent_rcv_msg);
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
@@ -621,6 +698,9 @@ static int uevent_net_init(struct net *net)
 		kfree(ue_sk);
 		return -ENODEV;
 	}
+
+	net->uevent_sock = ue_sk->sk;
+
 	mutex_lock(&uevent_sock_mutex);
 	list_add_tail(&ue_sk->list, &uevent_sock_list);
 	mutex_unlock(&uevent_sock_mutex);
-- 
2.15.1
