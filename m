Return-Path: <christianvanbrauner@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524479094; cv=none;
        d=google.com; s=arc-20160816;
        b=GiEKbtDLysshepDnW89aCWUVwk9hpDnsZK/t7+ot8bZiJBcA9EwL8A2AjxJzqSjCnR
         H/+Nl3O+wRKTJBB27ZQ9B5Oy3Jyr1JlQNDrKoc3DxFfPiA7R0vt4OdOFg+Ffiji71ZAa
         Ry/uEHJZie9w2zuVcYeqdcMIg8BccYAMeMu9JqjlRZiVb7fTErmuqr2yuubGo+/dCFHh
         +FoEL2N7SXcKgHtkf86P8e/fq/kk7Jd+zusCfuU6CLOId2g/0QuX/aDdZSKH/93QUslO
         8x39s08AocL7SBCgrcCHxAFgS+QxS/ZlNHIOt8zMfkXElS4/Da805DUu8vYavXDf7nvD
         XgOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:arc-authentication-results;
        bh=GS6j59Q+kjkcGKx/bRFLt2OV1aFBWcGIp5XN0QoEsrQ=;
        b=PZY7gRLtk+LGaqWfxnA9SouBpLMdYL1nhvRDHpeTQMthd/AETqDfSFb0PglyLN+442
         WwsAdzxCsM0YZ1sx2iF+8EMkgzxhm+pTO+Q9hLWJOZyVPIR/7Q+sV7oNCmBvOlvL1JrE
         DChTQBjRR/qgSl0hmbFnCi2wRa62mYZEA5s+yKTDua90DpSMUDT5wDryvIXMypVhbJ7/
         BJbYd+lo6uX1kGJlOV1LwdNJnH8reXb3S6pjM1xYpYAaYHFBB26nbfCP3WGb3MwXtsGc
         XGUtI/CPHfCDixa9LWBX81t2aDqmhN9Ow3LdnebD8XWgMqndqLu3jbK4bQFBSQ5WgJER
         G6qg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
X-Google-Smtp-Source: AIpwx4+ZgGvxBxtN39IJ+wbANmkAr8Zs92WNLOjIvpvaxfshFMfSlfla0MpFf4XUV6Hl2ttE/tYgqA==
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
Subject: [PATCH net-next 0/2 v1] netns: uevent performance tweaks
Date: Mon, 23 Apr 2018 12:24:41 +0200
Message-Id: <20180423102443.16627-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598532190721819657?=
X-GMAIL-MSGID: =?utf-8?q?1598532190721819657?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hey everyone,

This is v1 of "netns: uevent performance tweaks". Like Eric requested, I
did extensive testing that prove significant performance improvements
when using per-netns uevent sequence numbers with decoupled locks. The
results and test descriptions were added to the commit message of
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
