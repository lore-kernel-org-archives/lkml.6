Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E1CC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 09:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0447215A4
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 09:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcLts9TW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0447215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387596AbeHGMCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 08:02:44 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41169 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbeHGMCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 08:02:43 -0400
Received: by mail-pf1-f194.google.com with SMTP id y10-v6so8328975pfn.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 02:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=V8hJoKyXaoUESl3aFsZMgQYMtfaGubDrCWRZkqTGBCQ=;
        b=CcLts9TWezIm/oNXNRDyYHypLN3RWF+KdPq3QDZlrWv2FLuNp5NH1qoTdd480MLiiM
         D9uulxDgEOAzlVqa/qDwcAkm2VK34zX29s2z9IHzWdY3Z643vBK2RAgBgF0b9iaNeYaU
         s1usdslDwJiQyfyPdXjaZ1/2AguoS6o0zUWFdDrzvSLOBeqhYXg7dcEH7fu1WA7FGdiY
         rF0+741TW/ZeE6Ab7u9fSQUNRqdL+gO74xWg7s2+KcaKlINZ8NoZGmJfNCampb53IgkM
         BbzjZflJG9oPQZnp6DMnLn5Xtio9bCPC6bxve9wN9JNltvfEz023q8QyXlzddR63fPWm
         oh0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=V8hJoKyXaoUESl3aFsZMgQYMtfaGubDrCWRZkqTGBCQ=;
        b=REtsS3t9cC9kmqDGWJxMGryvj1izZl8szDuKN9Snl9+Ye34ivLiziD5lTJM3li6E8/
         MK/3aNibBeJ0QEeqhNKdzH7EGSK5w5zGUQyMMIxst1hRH1XeCzgtYMObDl69UeZJ1X0w
         Nm35+HWFtxwzmu36q/QrvP8XHd8pQ6AhwyJkPXHyB388zAK9u8y/Tq63ImsZm5Tjsq1N
         3xXqMyFOtULtRyT+dfJSJlgB0qIL3YmZxT4u5zzz1cw/udcB2mfIWLIyVN/Q1n1mMD9Q
         P8WVnS+OLVnWraOId6Harr8QzR+849brdPB1lJf5olcP0OcNkKLjwF5EN7O7gtCw76r7
         +GLQ==
X-Gm-Message-State: AOUpUlEI80wi7GFQIolI0wh0Fubxu2S7W8kLinvZT/vR+Waatg0PWyNe
        FvYoc5zXjYx3bvJ1LlxT0845gvz+
X-Google-Smtp-Source: AAOMgpdyF3RN9qV7UBV6ZOBDJlrnMLBhzc3IsrwpAJt22lNZqHJkSLGj5BxOVGudEjB2ja4pB+WLqA==
X-Received: by 2002:a63:4d47:: with SMTP id n7-v6mr17929231pgl.270.1533635352482;
        Tue, 07 Aug 2018 02:49:12 -0700 (PDT)
Received: from localhost (outboundhk.mxmail.xiaomi.com. [207.226.244.123])
        by smtp.gmail.com with ESMTPSA id e73-v6sm3484080pfb.153.2018.08.07.02.49.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 02:49:11 -0700 (PDT)
From:   Geliang Tang <geliangtang@gmail.com>
To:     Phillip Lougher <phillip@squashfs.org.uk>
Cc:     Geliang Tang <geliangtang@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] squashfs/squashfs-tools: Add posix acl support
Date:   Tue,  7 Aug 2018 17:49:07 +0800
Message-Id: <cover.1533630854.git.geliangtang@gmail.com>
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
 fs/squashfs/Kconfig                    | 11 ++++
 fs/squashfs/Makefile                   |  1 +
 fs/squashfs/acl.c                      | 69 ++++++++++++++++++++++++++
 fs/squashfs/acl.h                      | 31 ++++++++++++
 fs/squashfs/inode.c                    |  4 +-
 fs/squashfs/namei.c                    |  6 ++-
 fs/squashfs/squashfs_fs.h              | 12 +++--
 fs/squashfs/super.c                    |  3 ++
 fs/squashfs/symlink.c                  |  6 ++-
 fs/squashfs/xattr.c                    | 31 +++++++++++-
 fs/squashfs/xattr.h                    |  8 +++
 12 files changed, 171 insertions(+), 13 deletions(-)
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

