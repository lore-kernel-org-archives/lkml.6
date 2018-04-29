Return-Path: <christianvanbrauner@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524998669; cv=none;
        d=google.com; s=arc-20160816;
        b=mve9hN1i/haOp73Wirpk6HMg7jKunQTgkWu+W946eFGB78AGhg8/Ajpto7cJiGrHCC
         CKssD6DhtTb5aZ3yg9STDArxxLwpPvwvDD4juGUDHtXcLQzBxgv77tRa03sqOLWhJbLu
         lJFSktdrwDciNN5DpJmhc+WzahgCH26cTJyN/47PK7W4vObhtxetIAOzv9/vLeOwI/Ba
         yKhO2k15koArKW5iJDXQJOGxcfV1t+FUrPR4/Zm2FAbJCXczilOo6nqiHws8O3CKu7TO
         n3/9KoRuk9Ed8zyb3xr5IoBZmEH+B0+T7IJqyH2JGFYx2wvNS/aVYWnWE3UqnMknvRFw
         pJHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=o3CuPu/A7bn9JDnxCDKdqix8t//wkOSeFW9DSBwci9c=;
        b=qIOQdMc49Q3NsbzfuxBowbMdIRx7BpJaiUl0FXQmDtv+Erxd6/UifpEg588c8+kX37
         asjxLHf+QfKT/atIUxneEJ1kkHvt6EKZ4QarO6HcPruCaeBToho+bz/G0QFqYjWj+7lY
         FG3J80tCeDdBXWafKa4xhgHdWiBnknRZnoo+r8OtbZODeMwy+a903WQ5cp2zIGrpLC8B
         QcHBOE+sPcRjcIAZNy18SIRSTsjrXjIDNDkRNlqmy/Z7fUJ254+PlW1vBwlWO8qPfo4K
         32y0w2xPpJStU938w53S2zpB5NuwikoCt+r/fu1HqF62tET+mxkR57ud9CmT+ORqSRaf
         BImA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
X-Google-Smtp-Source: AB8JxZpMjc3L8RMGue8wbgQK0ubiXyj/X3/EFEverB8BzgBeBfAICFz0h634aBwJYbWTJ1uCN3xjDw==
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
Subject: [PATCH net-next 0/2 v5] netns: uevent filtering
Date: Sun, 29 Apr 2018 12:44:10 +0200
Message-Id: <20180429104412.22445-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.17.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599077004828533491?=
X-GMAIL-MSGID: =?utf-8?q?1599077004828533491?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hey everyone,

This is the new approach to uevent filtering as discussed (see the
threads in [1], [2], and [3]). It only contains *non-functional
changes*.

This series deals with with fixing up uevent filtering logic:
- uevent filtering logic is simplified
- locking time on uevent_sock_list is minimized
- tagged and untagged kobjects are handled in separate codepaths
- permissions for userspace are fixed for network device uevents in
  network namespaces owned by non-initial user namespaces
  Udev is now able to see those events correctly which it wasn't before.
  For example, moving a physical device into a network namespace not
  owned by the initial user namespaces before gave:

  root@xen1:~# udevadm --debug monitor -k
  calling: monitor
  monitor will print the received events for:
  KERNEL - the kernel uevent

  sender uid=65534, message ignored
  sender uid=65534, message ignored
  sender uid=65534, message ignored
  sender uid=65534, message ignored
  sender uid=65534, message ignored

  and now after the discussion and solution in [3] correctly gives:

  root@xen1:~# udevadm --debug monitor -k
  calling: monitor
  monitor will print the received events for:
  KERNEL - the kernel uevent

  KERNEL[625.301042] add      /devices/pci0000:00/0000:00:02.0/0000:01:00.1/net/enp1s0f1 (net)
  KERNEL[625.301109] move     /devices/pci0000:00/0000:00:02.0/0000:01:00.1/net/enp1s0f1 (net)
  KERNEL[625.301138] move     /devices/pci0000:00/0000:00:02.0/0000:01:00.1/net/eth1 (net)
  KERNEL[655.333272] remove /devices/pci0000:00/0000:00:02.0/0000:01:00.1/net/eth1 (net)

Thanks!
Christian

[1]: https://lkml.org/lkml/2018/4/4/739
[2]: https://lkml.org/lkml/2018/4/26/767
[3]: https://lkml.org/lkml/2018/4/26/738

Christian Brauner (2):
  uevent: add alloc_uevent_skb() helper
  netns: restrict uevents

 lib/kobject_uevent.c | 178 ++++++++++++++++++++++++++++++-------------
 1 file changed, 126 insertions(+), 52 deletions(-)

-- 
2.17.0
