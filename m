Return-Path: <christianvanbrauner@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520960135; cv=none;
        d=google.com; s=arc-20160816;
        b=HXYkMTInsU5SLAQHboeHRAixWWeo6hya6Cjt4Fki9D0sDV8fofaEY0VqwZSy0VtdMO
         w7qQILIrNfikgaIIZNmdfYd3HbdvUDUl+8jX5TusSfWfsIVHs7HT4Qpaj5E0GXR9ePyZ
         LoNRN3fzr/PqOBIzW8NC45dnDmdJvi45fJLA+4nF6r6re8AfwEdEpAi90uwweUJMh/rd
         cbxuqPm3U9UsWnHpRGR1FGpSKvKBLFBaYTFaKdzGQ28smRICcnNLCvwbzZYzYHr2eyQC
         NkFQ1O1ngw3BDaemX/27+stuTLrC5K5SKmRHSbG3Ok+dl/APgtcMXj7q8fUPvHTeInkm
         Xqeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=MZzD9JURBWXZsEsLOOHfaKXZY18Dk+GnHoxbJC/jYl0=;
        b=u4EcYZv8iGUV9TCmH5dRFr7pZ+vNtGpYJSKX76Zrl+hMVXqbtXVPbB1BZd2lJRTz6Q
         xVhyQ4Q+2XjHYA2MGHqXMm6GckTqb6BsG1aUyHvywJAFh+9xW05RwIMfyZrFsEuvGwJ4
         3n3fZsKo8amrvgPFXP83LTAT8iMuC+QWEUPdc4KVp1vUBSQ+TiURI5t6vb29l8+ruOov
         V6DOZo09a32F/G+S3JYMDSuQimx4fPMIiGRbPRpLoJBHIV8CB93jZQReQ1hrbiC59Q8W
         qrmNkfqbRigcXJOEouMdwXKZW0awYJeQPdCaWCi4q91bGkS4Y+iSjbBpk/7CIOO5Xdc7
         jjOQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
X-Google-Smtp-Source: AG47ELvI2C6Ifcek3xs8NCKPyWWx6+orPMZYxSDMJBVlw8S9eZVVrtv9Ood47eQaThpg4gWnq6d0xw==
From: Christian Brauner <christian.brauner@ubuntu.com>
To: viro@zeniv.linux.org.uk,
	linux-kernel@vger.kernel.org,
	ebiederm@xmission.com,
	torvalds@linux-foundation.org,
	gregkh@linuxfoundation.org
Cc: containers@lists.linux-foundation.org,
	Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 0/4 v5 RESEND] devpts: handle bind-mounts correctly
Date: Tue, 13 Mar 2018 17:55:23 +0100
Message-Id: <20180313165527.24038-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.15.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594842295484827893?=
X-GMAIL-MSGID: =?utf-8?q?1594842295484827893?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Resending to CC grekh.

Hey everyone,

This is the fith iteration of this patch. Per-patch changes are
summarized in the individual patches:

ChangeLog v4->v5:
* added non-functional patch to document devpts_mntget().
  Reason for putting this in a separate patch is that it allows you,
  Linus and Eric, to simply drop it if judged useless.
* reverse error handling logic to further simplify
* dput() dentry in the non-function patch. This was not really a problem
  since the following patch included a fix for it. But better to get it
  right in all individual patches.
* I did another rewrite of the problem analysis for
  posterity in the patch "Subject: [PATCH 2/3 v3] devpts: resolve devpts
  bind-mounts" and in this cover letter.

ChangeLog v3->v4:
* small logical simplifications
* add test that bind-mounts of /dev/pts/ptmx to locations that do not
  resolve to a valid slave pty path under the originating devpts mount
  fail

ChangeLog v2->v3:
* rewritten commit message to thoroughly analyse the problem for
  posterity in the patch "Subject: [PATCH 2/3 v3] devpts: resolve devpts
  bind-mounts" and in this cover letter.
* extended selftests to test for correct handling of /dev/pts/ptmx
  bind-mounts to /dev/ptmx and non-standard devpts mounts such as
  mount -t devpts devpts /mnt

ChangeLog v1->v2:
* see individual patches
ChangeLog v0->v1:
* see individual patches

Christian Brauner (4):
  devpts: hoist out check for DEVPTS_SUPER_MAGIC
  devpts: resolve devpts bind-mounts
  devpts: comment devpts_mntget()
  selftests: add devpts selftests

 fs/devpts/inode.c                                |  66 +++--
 tools/testing/selftests/Makefile                 |   1 +
 tools/testing/selftests/filesystems/.gitignore   |   1 +
 tools/testing/selftests/filesystems/Makefile     |   2 +-
 tools/testing/selftests/filesystems/devpts_pts.c | 313 +++++++++++++++++++++++
 5 files changed, 363 insertions(+), 20 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/devpts_pts.c

-- 
2.15.1
