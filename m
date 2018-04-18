Return-Path: <christianvanbrauner@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524064879; cv=none;
        d=google.com; s=arc-20160816;
        b=aBr/cQkLtpLpAXVtNS0hUYE32VRlneZjo8heC0dEgh5RFL39/ZpJmXHednTNvUmP3Q
         W5lygus5byD5ZXgdxq3PAioKLS/bok0mVdhWfiC5x8xaWqOTvSOZlenEDahMRbvKDHSN
         lIOA4gYeMeNjqTs8hOBbAAzegHsojIwUuNlfBjT5Rl4xAUKddRC+t9bMyj2Zf6I+fsHa
         zX2SZt3l33Rc1b+N4BjeULWFleCB+2R2Px9tp5N/m87QGIfb+d2NB3iqUa4QbtX/T+6G
         NcKfh7HsfWACOcigBseFx3/wkG+r9n0JnqOONcRDNg/G5zTh65syO5Fv7/UG+4fokmsG
         p06Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=xaaVcz4wi1LINIQeDe2WVhcygNajPOwBcGjg4lF3keI=;
        b=IeiXdfyX68+1OeAW0eDQP8tioe6MBI7tv55dXCvWEOkMW+9BhbbKd5Xa+kZHCiV9iD
         JkiDSiCDbsKHvC2DM778/NnUlH+Bc5iZcXOtgakNR1+t7Uv/oMhuhlEw+7peos7ofTfV
         fzkMdazv8N/Jr629PZDZFDaB8L8C+d4G2BOQ6G3dfD/0g5aL9yb8tAePkDJ0gANg76oQ
         bp7JnMBUR7g99BNZVA0+LfVhcEVsOknH4YketPHq3XXUMsrJR1/jv4gdvPFhIFVcHutS
         ZLQMrbvNNMFbEArRGHWaJ5Fktr0RAWhWiDSv0e78jbvLDcH0omM4Gu+rPhTCB+YQgu/9
         L+Mw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
X-Google-Smtp-Source: AIpwx4/VbIHWSyXnxx2MHq3CHxZvcrdT2AsesmNty0K3bqpNoHORNXGA1Iz11nWF59uGBO89rD0SxQ==
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
Subject: [PATCH net-next 0/2] netns: uevent performance tweaks
Date: Wed, 18 Apr 2018 17:21:04 +0200
Message-Id: <20180418152106.18519-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.17.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598097854765368442?=
X-GMAIL-MSGID: =?utf-8?q?1598097854765368442?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hey,

This series deals with a bunch of performance improvements when sending out
uevents that have been extensively discussed here:
https://lkml.org/lkml/2018/4/10/592

- Only record uevent sockets from network namespaces owned by the
  initial user namespace in the global uevent socket list.
  Eric, this is the exact patch we agreed upon in
  https://lkml.org/lkml/2018/4/10/592.
  **A very detailed rationale is present in the commit message for
    [PATCH 1/2] netns: restrict uevents**
- Decouple the locking for network namespaces in the global uevent socket
  list from the locking for network namespaces not in the global uevent
  socket list.
  **A very detailed rationale is present in the commit message
    [PATCH 2/2] netns: isolate seqnums to use per-netns locks**

Thanks!
Christian

Christian Brauner (2):
  netns: restrict uevents
  netns: isolate seqnums to use per-netns locks

 include/linux/kobject.h     |   3 -
 include/net/net_namespace.h |   3 +
 kernel/ksysfs.c             |   3 +-
 lib/kobject_uevent.c        | 118 ++++++++++++++++++++++++++++--------
 net/core/net_namespace.c    |  13 ++++
 5 files changed, 110 insertions(+), 30 deletions(-)

-- 
2.17.0
