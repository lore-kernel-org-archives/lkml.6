Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7562C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9723218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZuGlb3r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbfAYJPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 04:15:03 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46313 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfAYJPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 04:15:02 -0500
Received: by mail-pf1-f193.google.com with SMTP id c73so4455396pfe.13;
        Fri, 25 Jan 2019 01:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FbI8qPnX2F/LGRgTat4HpktMCj9gcTU3iSbEH/KXDUc=;
        b=JZuGlb3rjUPgDC+ICtYylSTuKaF/UaKL0enoSSbmq84oo3wpm5ikUVSHelKjTGpXk/
         oOQpcZ5T5Q5MAMkc/Mr5nuLVmjNltXLWlSEwGjznYJWihif4PiZHL2+k8r6ygRf+3zeU
         IIc5F6t3FUDNGv9GExs38oa7OE/cZuAEUnWO5wsxd6k9hqpGNXo3exvOcHnMhAN8f7Zo
         A5bzwkQej6bmoMO8f4ZwV1zDHhWVLkNQpl5yBxPR8+tEQUNhlPq5cSJkjV8VOViCKYo1
         PiFSEtJ7lWBMnWellfTf//VAHLrlZcbp+8Z4upgiYsccGWj3FwknvkEACWS2y8jJf9IQ
         PQuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FbI8qPnX2F/LGRgTat4HpktMCj9gcTU3iSbEH/KXDUc=;
        b=VGxBkUgzBCjZEEMdHtzF5gjT4OfllC/J/lwUbt6UQi67Kehe7wQIYCA89hkBtLCEgI
         VUTMDzaBmOFrlL0+xUmTYtZLybsSw70vD0vn93htePyKc2cRHfH+K4ClMjPC3EgOqQdn
         Kne6AHY5KEKo9d/Ljb+KzBCtaj6eEXs08h4QxB7l/veXNKqmIl+dk8yk/JcngsO7DDwR
         tFK49SPk59gEEyi5E2LXtxk/RCy9o9ddWy+komgzoCYDvc74j3RkwkgoCoy7qZCgXg02
         ig2Z4lqb2xauP3O2OQoRWPKHMUZJd+mXWMh1zVkWpO/pbugSJJF3TEUehhmysncuD9vE
         yfUw==
X-Gm-Message-State: AJcUukes3R0Aj1ENy0apkp5xS8LAFull0XXBPnVEGsJgNn7OjxKuvMXj
        1XW0wEacIwOW5Zd9D1/mUnU=
X-Google-Smtp-Source: ALg8bN572fgQ7BVpqWtVPeZCZjesYfhvM9ihap+krtcgDncCdIJHkaS71kJu69nxdXZGDMW0GRtN3Q==
X-Received: by 2002:a63:8c6:: with SMTP id 189mr9273242pgi.322.1548407701432;
        Fri, 25 Jan 2019 01:15:01 -0800 (PST)
Received: from localhost ([43.224.245.181])
        by smtp.gmail.com with ESMTPSA id w184sm29625319pgd.34.2019.01.25.01.15.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 01:15:00 -0800 (PST)
From:   Geliang Tang <geliangtang@gmail.com>
To:     Phillip Lougher <phillip@squashfs.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Coly Li <colyli@suse.de>
Cc:     Geliang Tang <geliangtang@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/2] squashfs/squashfs-tools: Add posix acl support
Date:   Fri, 25 Jan 2019 17:14:48 +0800
Message-Id: <cover.1548406694.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we use mksquashfs tool to create a squashfs image from the files which
have POSIX ACLs(Access Control Lists), we get these errors:

Unrecognised xattr prefix system.posix_acl_access
Unrecognised xattr prefix system.posix_acl_default

This patcheset adds posix acl support to squashfs to fix this problem. Patch
#1 for kerenl tree and patch #2 for squashfs-tools tree.

---

Testcase:

$ mkdir root
$ getfacl root
  # file: root
  # owner: tgl
  # group: tgl
  user::rwx
  group::r-x
  other::r-x
$ setfacl -m u:tgl:rw root
$ setfacl -m d:tgl:rw root
$ getfacl root
  # file: root
  # owner: tgl
  # group: tgl
  user::rwx
  user:tgl:rw-
  group::r-x
  mask::rwx
  other::r-x
  default:user::rwx
  default:user:tgl:rw-
  default:group::r-x
  default:mask::rwx
  default:other::r-x
$ getfattr -m . -d root
  # file: root
  system.posix_acl_access=0sAgAAAAEABwD/////AgAGAOgDAAAEAAUA/////xAABwD/////IAAFAP////8=
  system.posix_acl_default=0sAgAAAAEABwD/////AgAGAOgDAAAEAAUA/////xAABwD/////IAAFAP////8=

$ mksquashfs root root.img
$ sudo mount root.img /mnt/squash/

$ cd /mnt
$ getfacl squash
  # file: squash
  # owner: tgl
  # group: tgl
  user::rwx
  user:tgl:rw-
  group::r-x
  mask::rwx
  other::r-x
  default:user::rwx
  default:user:tgl:rw-
  default:group::r-x
  default:mask::rwx
  default:other::r-x
$ getfattr -m . -d squash
  # file: squash
  system.posix_acl_access=0sAgAAAAEABwD/////AgAGAOgDAAAEAAUA/////xAABwD/////IAAFAP////8=
  system.posix_acl_default=0sAgAAAAEABwD/////AgAGAOgDAAAEAAUA/////xAABwD/////IAAFAP////8=

---

Geliang Tang (1):
  squashfs: Add posix acl support

 Documentation/filesystems/squashfs.txt |  2 -
 fs/squashfs/Kconfig                    | 11 +++++
 fs/squashfs/Makefile                   |  1 +
 fs/squashfs/acl.c                      | 56 ++++++++++++++++++++++++++
 fs/squashfs/acl.h                      | 18 +++++++++
 fs/squashfs/inode.c                    |  4 +-
 fs/squashfs/namei.c                    |  6 ++-
 fs/squashfs/squashfs_fs.h              | 12 +++---
 fs/squashfs/super.c                    |  3 ++
 fs/squashfs/symlink.c                  |  6 ++-
 fs/squashfs/xattr.c                    | 31 +++++++++++++-
 fs/squashfs/xattr.h                    |  8 ++++
 12 files changed, 145 insertions(+), 13 deletions(-)
 create mode 100644 fs/squashfs/acl.c
 create mode 100644 fs/squashfs/acl.h

---

Geliang Tang (1):
  squashfs-tools: Add posix acl support

 squashfs-tools/read_xattrs.c |  2 ++
 squashfs-tools/squashfs_fs.h | 12 +++++++-----
 2 files changed, 9 insertions(+), 5 deletions(-)

-- 
2.17.1

