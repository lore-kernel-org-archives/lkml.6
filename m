Return-Path: <christianvanbrauner@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524943238; cv=none;
        d=google.com; s=arc-20160816;
        b=w7jW7cv+6UXKDrGb2flDBARNtWHNrNdWV4fMDuNEU5cEapX5kp8S+uo/TVOgDFJyiV
         ejsundt++UKVICu/REJrtf9n0pnuGZJGwKyr0k/vt7MA0MQL2N3kxTPZqSn01r8/A1KZ
         TFvcSeho7NyrduiZ5MeyKqSQTGm9jSUWlTLrsN/zgMxgCiTJw7/xJma1b+JpdJAOep+G
         Qm342kImKNMpNKpJMGFz54yKGzZ1bOkg0nmIpDO78oqN4NP7k9VSpIOrMI//5vRMfw1r
         bJCxklnpg+yxGTrTGE9hrqB83Pfe5QKfarHgxbdzgv/RYXheMIEHJGfWQFNumhk3FxB3
         RE9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=gv0NkPiM9qWp82J3+glvchwO5qJiu0H4d+WEOYBgDwk=;
        b=I5Fd9oAmZVXKrO+3ftNs5e2Aex+CfZTlkNHdW7Cspyad6N2WXgzoPktiwe9z/65anX
         ZKrarc1caE6t6haOkJU7oNyOHLBdMcNzADZZHuBQDHlCPfzq6xxFwq/RCJDzvKKR5ZT2
         KHV7KgnRBHDWt2SCh2jek1PoeMQvdEFbp6ic1GQaaicBDZU2PAaEZ7PwO+eUz59UlBD6
         IaVSmAnaI6WVEbHMp2WzoNnsJhxd4aMGzok+XtM2sVzzEvuf7UgDxxORIup/J4yezO+2
         vsD3DBNNcVjTW+m9jI/ZHV5O9FjqCNWae0UmmjQ8yIjX/sIdjirwz66Mv0YUsDDYdtWf
         fvWw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
X-Google-Smtp-Source: AB8JxZrzwpqmjM0kGDHvIWZOZb0pw4V+umiNJW4aAx8z42HyzuF87MZW0hB8l8Wyc9GxLrOpWb2Yeg==
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
Subject: [PATCH net-next 0/2 v4] netns: uevent filtering
Date: Sat, 28 Apr 2018 21:20:23 +0200
Message-Id: <20180428192025.2075-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.17.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599018881448203807?=
X-GMAIL-MSGID: =?utf-8?q?1599018881448203807?=
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

 lib/kobject_uevent.c | 180 ++++++++++++++++++++++++++++++-------------
 1 file changed, 128 insertions(+), 52 deletions(-)

-- 
2.17.0
