Return-Path: <christianvanbrauner@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522871368; cv=none;
        d=google.com; s=arc-20160816;
        b=GX+nSXp+y+ag1L439MpGnjrPCa+bJjoP9x6DJPjDoEDfIqytUDdEqvt+ocZXCdh8hv
         hdNTI/hF8JJnQdXSfAahn+qp49yHv3pXuRYIYWTzwvAeNivTlV9waZ4hB38xCvFdIanv
         yk/MvRIZKsZHKmqTZMdAQhAaB/bCstaP1hTM68ikTyCkvfJoZDtDVYD/8W9B1pcLH16P
         jpLIWxJBmF9/YUkVpw3NcERucm73jWo+TIlI280+Ej/PQnR05QqgiSoeyAsBhzHX0Kxb
         aIk4rBfRRH+3ipnTFDkwNj75P4LgPC9HX6yXAFz85T65KT3MpIcEmXApv8PI0SUcB9I+
         1Jnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=uVJpCRcUupMReUqVtPdh0PhAMceqFm/akBEN7vKMyAA=;
        b=c7KdNyM+T743bxaQYBLhnl4WGVQ1b36JuLM3l4GsHYks0eXTUC3Vf4ndufMFhQ74sw
         M4mq/txLWcjsb5aorI2HGZBHjEEwdHCR3xWJtRnNF+++4dnUIeg1oJBzxfICtWbmtzgL
         1VMm6jGCptrPXGSr0tcTdp2PmnzKCfnJvASf8VXhLMXD9e9BJKTqsRbVYnLPoVU9ckfa
         0ktZAzCoulbIpOyuwreNPvrcphMhCWxmckvywWCEeY6nGUlVhdl+8ux2JLZQM+NOgP0p
         pCGMG5DmA/rPZH09VHpd8bPWf7jNPhCV8Cm7VcZjHCadrOdtBfUvwU0Y9JoaA/W68ait
         ClEg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
X-Google-Smtp-Source: AIpwx49pdd3k2S1racU6jWWapX+OBSwNpOrOqmcNkuTSmqi3hdJ9hawuaCVY8ZH4NVjAiuU/B+iBDw==
From: Christian Brauner <christian.brauner@ubuntu.com>
To: ebiederm@xmission.com,
	davem@davemloft.net,
	gregkh@linuxfoundation.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: avagin@virtuozzo.com,
	ktkhai@virtuozzo.com,
	serge@hallyn.com,
	Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH net-next] netns: filter uevents correctly
Date: Wed,  4 Apr 2018 21:48:57 +0200
Message-Id: <20180404194857.29375-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.15.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596846368169451603?=
X-GMAIL-MSGID: =?utf-8?q?1596846368169451603?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

commit 07e98962fa77 ("kobject: Send hotplug events in all network namespaces")

enabled sending hotplug events into all network namespaces back in 2010.
Over time the set of uevents that get sent into all network namespaces has
shrunk. We have now reached the point where hotplug events for all devices
that carry a namespace tag are filtered according to that namespace.

Specifically, they are filtered whenever the namespace tag of the kobject
does not match the namespace tag of the netlink socket. One example are
network devices. Uevents for network devices only show up in the network
namespaces these devices are moved to or created in.

However, any uevent for a kobject that does not have a namespace tag
associated with it will not be filtered and we will *try* to broadcast it
into all network namespaces.

The original patchset was written in 2010 before user namespaces were a
thing. With the introduction of user namespaces sending out uevents became
partially isolated as they were filtered by user namespaces:

net/netlink/af_netlink.c:do_one_broadcast()

if (!net_eq(sock_net(sk), p->net)) {
        if (!(nlk->flags & NETLINK_F_LISTEN_ALL_NSID))
                return;

        if (!peernet_has_id(sock_net(sk), p->net))
                return;

        if (!file_ns_capable(sk->sk_socket->file, p->net->user_ns,
                             CAP_NET_BROADCAST))
        j       return;
}

The file_ns_capable() check will check whether the caller had
CAP_NET_BROADCAST at the time of opening the netlink socket in the user
namespace of interest. This check is fine in general but seems insufficient
to me when paired with uevents. The reason is that devices always belong to
the initial user namespace so uevents for kobjects that do not carry a
namespace tag should never be sent into another user namespace. This has
been the intention all along. But there's one case where this breaks,
namely if a new user namespace is created by root on the host and an
identity mapping is established between root on the host and root in the
new user namespace. Here's a reproducer:

 sudo unshare -U --map-root
 udevadm monitor -k
 # Now change to initial user namespace and e.g. do
 modprobe kvm
 # or
 rmmod kvm

will allow the non-initial user namespace to retrieve all uevents from the
host. This seems very anecdotal given that in the general case user
namespaces do not see any uevents and also can't really do anything useful
with them.

Additionally, it is now possible to send uevents from userspace. As such we
can let a sufficiently privileged (CAP_SYS_ADMIN in the owning user
namespace of the network namespace of the netlink socket) userspace process
make a decision what uevents should be sent.

This makes me think that we should simply ensure that uevents for kobjects
that do not carry a namespace tag are *always* filtered by user namespace
in kobj_bcast_filter(). Specifically:
- If the owning user namespace of the uevent socket is not init_user_ns the
  event will always be filtered.
- If the network namespace the uevent socket belongs to was created in the
  initial user namespace but was opened from a non-initial user namespace
  the event will be filtered as well.
Put another way, uevents for kobjects not carrying a namespace tag are now
always only sent to the initial user namespace. The regression potential
for this is near to non-existent since user namespaces can't really do
anything with interesting devices.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 lib/kobject_uevent.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index 15ea216a67ce..cb98cddb6e3b 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -251,7 +251,15 @@ static int kobj_bcast_filter(struct sock *dsk, struct sk_buff *skb, void *data)
 		return sock_ns != ns;
 	}
 
-	return 0;
+	/*
+	 * The kobject does not carry a namespace tag so filter by user
+	 * namespace below.
+	 */
+	if (sock_net(dsk)->user_ns != &init_user_ns)
+		return 1;
+
+	/* Check if socket was opened from non-initial user namespace. */
+	return sk_user_ns(dsk) != &init_user_ns;
 }
 #endif
 
-- 
2.15.1
