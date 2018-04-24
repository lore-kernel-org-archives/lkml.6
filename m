Return-Path: <christianvanbrauner@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524602653; cv=none;
        d=google.com; s=arc-20160816;
        b=XqOy7tizs8+URxUubDJG2Z4we9Ds5ftg7EhkLIXqTfPF1Ua/hC0KdgY9ld/HH/Xew6
         5GBxVkux9mmB5VXqidRq6FmAxtBj0TAgT9i4fsHHScrbks79ddiyn0nHwaWHIFs0av9h
         lo4Wmg2KPclcn5Sb/yXHLGD3xLy7eoKBJS4Roe5mFAXthHoEGSIosFmBmU2ebbgBKEwX
         haxNOjU4J54Ykw3iWqnr/UXexK/RGgMhWAe4v77sN/H0A61AtF5JCboksuw8PmALuCTr
         oQKgoLzLXV+wpZAW7cvWUU8ddA4fEXUWdX3tLpDaRmlrY1dwZ1WSWa9po5WrSluwnSWd
         mqPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=dO76V0GMwCPCpeFfiDg4TQctQquEmmiBk4wjferQRL4=;
        b=MwzcSO1+HfD2yaWH4A0utDbB6N7H5oXuSWPiNLJJAWIB9WLBrVNzri3BI27hREQXc8
         38hGRNZ+vs+XueDQs5xcS9D2oD3CjJqCdKzhLspporM5DkbeItLHLb5qMAVoA1ND9Dsb
         CxDZqTiT/914+vPgIvVsBar2s7SjeiO3rbGbIIZ4kCmcEViHYuy6e39BUSIyoHNJaP8o
         pK4jII0lbpIqa5jiSInMEZ7CB0UywlLlhrUs7tCULCY1xlri6ndAP0qzmqoKOh2Pp/FF
         fkPzmtmhybGe1CEA8Ay93gPXUnwpoOa/667ZyZmKIzJBzizg9oE1I1DoJN/eJn3bhxUj
         61zg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
X-Google-Smtp-Source: AB8JxZpuq1VcLVd3Plnc6juAtuFEfD9JSsGW46nxuJ/R2lf9isgJr+5p8JYg9AgS6lRYumbLoJsrhw==
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
Subject: [PATCH net-next 1/2 v2] netns: restrict uevents
Date: Tue, 24 Apr 2018 22:43:34 +0200
Message-Id: <20180424204335.12904-2-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180424204335.12904-1-christian.brauner@ubuntu.com>
References: <20180424204335.12904-1-christian.brauner@ubuntu.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598661751720131852?=
X-GMAIL-MSGID: =?utf-8?q?1598661751720131852?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

commit 07e98962fa77 ("kobject: Send hotplug events in all network namespaces")

enabled sending hotplug events into all network namespaces back in 2010.
Over time the set of uevents that get sent into all network namespaces has
shrunk a little. We have now reached the point where hotplug events for all
devices that carry a namespace tag are filtered according to that
namespace. Specifically, they are filtered whenever the namespace tag of
the kobject does not match the namespace tag of the netlink socket. One
example are network devices. Uevents for network devices only show up in
the network namespaces these devices are moved to or created in.

However, any uevent for a kobject that does not have a namespace tag
associated with it will not be filtered and we will broadcast it into all
network namespaces. This behavior stopped making sense when user namespaces
were introduced.

This patch restricts uevents to the initial user namespace for a couple of
reasons that have been extensively discusses on the mailing list [1].
- Thundering herd:
  Broadcasting uevents into all network namespaces introduces significant
  overhead.
  All processes that listen to uevents running in non-initial user
  namespaces will end up responding to uevents that will be meaningless to
  them. Mainly, because non-initial user namespaces cannot easily manage
  devices unless they have a privileged host-process helping them out. This
  means that there will be a thundering herd of activity when there
  shouldn't be any.
- Uevents from non-root users are already filtered in userspace:
  Uevents are filtered by userspace in a user namespace because the
  received uid != 0. Instead the uid associated with the event will be
  65534 == "nobody" because the global root uid is not mapped.
  This means we can safely and without introducing regressions modify the
  kernel to not send uevents into all network namespaces whose owning user
  namespace is not the initial user namespace because we know that
  userspace will ignore the message because of the uid anyway. I have
  a) verified that is is true for every udev implementation out there b)
  that this behavior has been present in all udev implementations from the
  very beginning.
- Removing needless overhead/Increasing performance:
  Currently, the uevent socket for each network namespace is added to the
  global variable uevent_sock_list. The list itself needs to be protected
  by a mutex. So everytime a uevent is generated the mutex is taken on the
  list. The mutex is held *from the creation of the uevent (memory
  allocation, string creation etc. until all uevent sockets have been
  handled*. This is aggravated by the fact that for each uevent socket that
  has listeners the mc_list must be walked as well which means we're
  talking O(n^2) here. Given that a standard Linux workload usually has
  quite a lot of network namespaces and - in the face of containers - a lot
  of user namespaces this quickly becomes a performance problem (see
  "Thundering herd" above). By just recording uevent sockets of network
  namespaces that are owned by the initial user namespace we significantly
  increase performance in this codepath.
- Injecting uevents:
  There's a valid argument that containers might be interested in receiving
  device events especially if they are delegated to them by a privileged
  userspace process. One prime example are SR-IOV enabled devices that are
  explicitly designed to be handed of to other users such as VMs or
  containers.
  This use-case can now be correctly handled since
  commit 692ec06d7c92 ("netns: send uevent messages"). This commit
  introduced the ability to send uevents from userspace. As such we can let
  a sufficiently privileged (CAP_SYS_ADMIN in the owning user namespace of
  the network namespace of the netlink socket) userspace process make a
  decision what uevents should be sent. This removes the need to blindly
  broadcast uevents into all user namespaces and provides a performant and
  safe solution to this problem.
- Filtering logic:
  This patch filters by *owning user namespace of the network namespace a
  given task resides in* and not by user namespace of the task per se. This
  means if the user namespace of a given task is unshared but the network
  namespace is kept and is owned by the initial user namespace a listener
  that is opening the uevent socket in that network namespace can still
  listen to uevents.

[1]: https://lkml.org/lkml/2018/4/4/739
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
Changelog v1->v2:
* patch unchanged
Changelog v0->v1:
* patch unchanged
---
 lib/kobject_uevent.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index 15ea216a67ce..f5f5038787ac 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -703,9 +703,13 @@ static int uevent_net_init(struct net *net)
 
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
 
@@ -713,9 +717,11 @@ static void uevent_net_exit(struct net *net)
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
