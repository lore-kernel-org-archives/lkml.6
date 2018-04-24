Return-Path: <christianvanbrauner@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524602651; cv=none;
        d=google.com; s=arc-20160816;
        b=Ts6zJcmz9pDK7dDyzCvuRd5IKFtci4oECS42BWc4XjoFShyhJoBvVDMEEw2KlUJ2y4
         eTzbbWe7LDAHQsY8IRKbnnP8KCuXBWpuEhMvh5shP/wBLmuNa367SpHHADDKEO0e/FPJ
         3/9qsjKBnK7x1cUPh3yMusjIael+nyIlhSlrsxqj0W5X18fReveMtVo0sgnGMi2lxszJ
         G3jWc04F4s6w7r06ZB5Muo6ECoK3zzWVxH/psLjBlY5OUe3y87DBH7bnuHijpV7Ius73
         cMefkYNlkRG2+/rXj8TOedoD7jgUwGkvjgcFj0YqRodODbLNot6OWFIZnK7/COfvagQU
         bjvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:arc-authentication-results;
        bh=23wESFnk2QVAiPcIxflCs0zYmppkb4Zrje5nOWIiqGg=;
        b=XZnoq1JHRql7DlEh1JQs2460fZbfnTEwz4ncj+qmARrpKlXI99C8yB4jwx/8Y1yaHv
         zU/7WoOy9uZRn8y+3Iog/vTYnXP+x7iZyTqa7b6Nw0KXqiN5xua8MRkfx4qhgtXGdPgP
         scAOC7vWS7hD4HcPUoawaJ3YZbYpPV33jrASxI7ZEVj/q93DzAQbcqfD6CNIJxNtH+Y6
         E3JuqLGLMDrIS4tg3Le9UB+rYFYLyyfghlw8oQV4gLY37QVbWpY76guW0XG+2rVLfkQ3
         eJhy+zC8wKvBVv2/B6WqS8diRoHaYbPNHF7bOjQ6CUv4ZzNtug1atz9FntTWsirRKt4Q
         s0Gg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
X-Google-Smtp-Source: AIpwx48ew3T8TJAcVrDpVKweNjdKa/E3fFNFwN3mcL/TEM9SE7+qrKi/2u1Xw/Uj2BIo9IbD+ZrkuA==
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
Subject: [PATCH net-next 0/2 v2] netns: uevent performance tweaks
Date: Tue, 24 Apr 2018 22:43:33 +0200
Message-Id: <20180424204335.12904-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598661750124917564?=
X-GMAIL-MSGID: =?utf-8?q?1598661750124917564?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hey everyone,

This is v2 of "netns: uevent performance tweaks" which contains *no
functional changes* just a minor indendation fix as requested by David.

Like Eric requested, I did extensive testing that prove significant
performance improvements when using per-netns uevent sequence numbers
with decoupled locks. The results and test descriptions were added to
the commit message of
[PATCH 2/2 v1] netns: isolate seqnums to use per-netns locks.

This series deals with a bunch of performance improvements when sending
out uevents that have been extensively discussed here:
https://lkml.org/lkml/2018/4/10/592

- Only record uevent sockets from network namespaces owned by the
  initial user namespace in the global uevent socket list.
  Eric, this is the exact patch we agreed upon in
  https://lkml.org/lkml/2018/4/10/592.
  A very detailed rationale is present in the commit message for
  [PATCH 1/2] netns: restrict uevents
- Decouple the locking for network namespaces in the global uevent
  socket list from the locking for network namespaces not in the global
  uevent socket list.
  A very detailed rationale including performance test results is
  present in the commit message for
  [PATCH 2/2] netns: isolate seqnums to use per-netns locks

Thanks!
Christian

Christian Brauner (2):
  netns: restrict uevents
  netns: isolate seqnums to use per-netns locks

 include/linux/kobject.h     |   2 +
 include/net/net_namespace.h |   3 +
 kernel/ksysfs.c             |  11 +++-
 lib/kobject_uevent.c        | 122 ++++++++++++++++++++++++++++--------
 net/core/net_namespace.c    |  14 +++++
 5 files changed, 126 insertions(+), 26 deletions(-)

-- 
2.17.0
