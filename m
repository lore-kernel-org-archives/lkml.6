Return-Path: <christianvanbrauner@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524824728; cv=none;
        d=google.com; s=arc-20160816;
        b=hQiYTvFavL3JIAas7xFqxlHX9czd/S978npW49aymeSESovHrCroRm1/k6yPnMLJZl
         DiOJbmrMj/aFkPsYBrWx1BrV99deeO0i+szizDvAV6CJ2XQJghrWpzrhQiI1mAnAQRt7
         yHuiQbkbr2tGYxjVvpwYFjCUdM1tl2Ay3hZJ0NV5ektSAnqS7CBT4GSxXtGinLkVNghO
         Jg4p5Cmd+GAMaB/2BWaYNLWAJylCdHYF5oilUwTU7n7Ea0LFTxVWIWTRwq0zpVHRCrm9
         ApC7QDQC5luI3y6Yq9jCroZ7HpaIKWcBlfXskIoIQeiqc/oLa9L0AeBp5KxB+lgx2cRN
         ijqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=V70ocO4NjNsTiKx44lIDPiNHPUOsJIKQfMf5UO6eqR0=;
        b=PdfWEf3QpuxqoUs9/qPFsojfJSiHVjvllPHw5jYn76jcGbxoPDQs2+Uw9D+Tzm+Lpp
         GFNDOTJxcB0YaHhjmOzDC1X3v60LyqQF1HyPym3Yt/UitQi1QOKZjnX8vkhaAoLwHDnV
         EKcZ/dbhDgj9IHw5xxS3RmQj47Ea6OZGBo8ew4uBrH7MZ/iHEARIXdhNuGtWOio+yRRY
         UCQqWm4farDa54QC82OHga/n12WDgHGWJkzlo7hlPi8t+iUGetnTvo4OUm3iFwv9mW7x
         GV/Z/b1NgTPwvKnvxqjnu4Dc3Wx0Yc+dF/Zix30HzjH8VFGF8uT2/RJSXK7SZMXXJwMZ
         kwOw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
X-Google-Smtp-Source: AB8JxZpCObLouF2tNEEDLVb0s3uok8B5GM89ZcycwuLz+mVGfq3ohwzrUJOqtNISJhRdqZTupAcYzA==
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
Subject: [PATCH net-next 0/2] netns: uevent filtering
Date: Fri, 27 Apr 2018 12:23:04 +0200
Message-Id: <20180427102306.8617-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.17.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598894614112495880?=
X-GMAIL-MSGID: =?utf-8?q?1598894614112495880?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hey everyone,

This is the new approach to uevent filtering as discussed (see the
threads in [1], [2], and [3]).

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

 lib/kobject_uevent.c | 175 ++++++++++++++++++++++++++++++-------------
 1 file changed, 123 insertions(+), 52 deletions(-)

-- 
2.17.0
