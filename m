Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932865AbeCMMSH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 08:18:07 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:42515 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752395AbeCMMSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 08:18:06 -0400
X-Google-Smtp-Source: AG47ELtPoILpGLzY32Cb1axi9BkRqjxspdLvz4p8Podna6jAxqgaFaGGcszClqIF0pMsd8BsbJDUDA==
From: Christian Brauner <christian.brauner@ubuntu.com>
To: viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        ebiederm@xmission.com, torvalds@linux-foundation.org
Cc: containers@lists.linux-foundation.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 0/4 v5] devpts: handle bind-mounts correctly
Date: Tue, 13 Mar 2018 13:17:09 +0100
Message-Id: <20180313121713.32551-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
