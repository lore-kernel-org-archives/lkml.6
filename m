Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC05C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 22:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A36C020847
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 22:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="H61+d9MN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A36C020847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbeKBH7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 03:59:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:52096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727645AbeKBH7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 03:59:15 -0400
Received: from ebiggers-linuxstation.kir.corp.google.com (unknown [104.132.51.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1854720657;
        Thu,  1 Nov 2018 22:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541112856;
        bh=8oXeh8ch0WVipsToiNNxQ1kfeDC1Yl/AW0+9tP+T5TU=;
        h=From:To:Cc:Subject:Date:From;
        b=H61+d9MNBuqMfLh955oPb7d8Kn6hd30x6p2i99XgCTtpAW+v/IvDPE5t2fol94q3f
         uCiSxZ/mKb3jjKYjv9OKXJQIaDwNEi+5GIBmoi/55yYVB0sD3UB6FmWCaG9NCz7/DW
         X5+gaAXxdUKIn80rJ8cGRWTqmoIgDTuSQnR+OzH0=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>
Subject: [PATCH v2 00/12] fs-verity: read-only file-based authenticity protection
Date:   Thu,  1 Nov 2018 15:52:18 -0700
Message-Id: <20181101225230.88058-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patchset implements fs-verity for ext4 and f2fs.  fs-verity is
similar to dm-verity, but implemented on a per-file basis: a Merkle tree
is used to measure (hash) the file's data as it is paged in.  ext4 and
f2fs hide this Merkle tree beyond the end of the file, though other
filesystems might implement it differently in the future.  In general,
fs-verity is intended for use on writable filesystems; dm-verity is
still recommended on read-only ones.

Similar to fscrypt, most of the code is in fs/verity/, and not too many
filesystem-specific changes are needed.  The Merkle tree is written by
userspace before calling an ioctl to mark the file as a verity file; the
file then becomes read-only and the verity metadata is hidden or moved.

fs-verity provides a file measurement (hash) in constant time and
verifies data on-demand.  Thus, it is useful for efficiently verifying
the authenticity of large files of which only a small portion may be
accessed, such as Android application package (APK) files.  It may also
be useful in "audit" use cases where file hashes are logged.

fs-verity also provides better protection against malicious disks than
an ahead-of-time hash, since fs-verity re-verifies data each time it's
paged in.  Note, however, that any authenticity guarantee is still
dependent on verification of the file measurement and other relevant
metadata in a way that makes sense for the overall system; fs-verity is
only a tool to help with this.

This patchset doesn't yet include IMA support for fs-verity file
measurements.  This is planned and we'd like to collaborate with the IMA
maintainers.  Although fs-verity can be used on its own without IMA,
fs-verity is primarily a lower level feature (think of it as a way of
hashing a file), so some users may still need IMA's policy mechanism.
However, an optional in-kernel signature verification mechanism within
fs-verity itself is also included.

This patchset is based on Linus' tree as of today (commit 7c6c54b505b8a).
It can also be found in git at tag "fsverity_2018-11-01" of:

	https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git

fs-verity has a userspace utility:

	https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/fsverity-utils.git

xfstests for fs-verity can be found at branch "fsverity" of:

	https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/xfstests-dev.git

fs-verity is supported by e2fsprogs v1.44.4-2+ and f2fs-tools v1.11.0+.

Please see the documentation file Documentation/filesystems/fsverity.rst
(added by patch 1) for details; this cover letter only gave an overview.
Examples of setting up fs-verity protected files can also be found in
the README file of fsverity-utils.

Other useful references include:

    - LWN coverage of v1 patchset: https://lwn.net/Articles/763729/

    - Presentation at Linux Security Summit North America 2018:
        - Slides: https://schd.ws/hosted_files/lssna18/af/fs-verity%20slide%20deck.pdf
        - Video: https://www.youtube.com/watch?v=Aw5h6aBhu6M

    - Notes from discussion at LSFMM 2018: https://lwn.net/Articles/752614/

Changes since v1:

- Added documentation file.
- Require write permission for FS_IOC_ENABLE_VERITY, rather than
  CAP_SYS_ADMIN.
- Eliminated dependency on CONFIG_BLOCK and clarified that filesystems
  can verify a page at a time rather than a bio at a time.
- Fixed conditions for verifying holes.
- ext4 now only allows fs-verity on extent-based files.
- Eliminated most of the assumptions that the verity metadata is stored
  beyond EOF, in case filesystems want to do things differently.
- Other cleanups.

Eric Biggers (12):
  fs-verity: add a documentation file
  fs-verity: add setup code, UAPI, and Kconfig
  fs-verity: add MAINTAINERS file entry
  fs-verity: add data verification hooks for ->readpages()
  fs-verity: implement FS_IOC_ENABLE_VERITY ioctl
  fs-verity: implement FS_IOC_MEASURE_VERITY ioctl
  fs-verity: add SHA-512 support
  fs-verity: add CRC-32C support
  fs-verity: support builtin file signatures
  ext4: add basic fs-verity support
  ext4: add fs-verity read support
  f2fs: fs-verity support

 Documentation/filesystems/fsverity.rst | 583 ++++++++++++++++
 Documentation/filesystems/index.rst    |  11 +
 Documentation/ioctl/ioctl-number.txt   |   1 +
 MAINTAINERS                            |  11 +
 fs/Kconfig                             |   2 +
 fs/Makefile                            |   1 +
 fs/ext4/Kconfig                        |  20 +
 fs/ext4/ext4.h                         |  22 +-
 fs/ext4/file.c                         |   6 +
 fs/ext4/inode.c                        |  11 +
 fs/ext4/ioctl.c                        |  12 +
 fs/ext4/readpage.c                     | 209 +++++-
 fs/ext4/super.c                        | 100 ++-
 fs/ext4/sysfs.c                        |   6 +
 fs/f2fs/Kconfig                        |  20 +
 fs/f2fs/data.c                         |  43 +-
 fs/f2fs/f2fs.h                         |  17 +-
 fs/f2fs/file.c                         |  58 ++
 fs/f2fs/inode.c                        |   3 +-
 fs/f2fs/super.c                        |  30 +
 fs/f2fs/sysfs.c                        |  11 +
 fs/verity/Kconfig                      |  52 ++
 fs/verity/Makefile                     |   5 +
 fs/verity/fsverity_private.h           | 135 ++++
 fs/verity/hash_algs.c                  | 115 ++++
 fs/verity/ioctl.c                      | 164 +++++
 fs/verity/setup.c                      | 908 +++++++++++++++++++++++++
 fs/verity/signature.c                  | 187 +++++
 fs/verity/verify.c                     | 298 ++++++++
 include/linux/fs.h                     |   9 +
 include/linux/fsverity.h               | 112 +++
 include/uapi/linux/fsverity.h          |  98 +++
 32 files changed, 3218 insertions(+), 42 deletions(-)
 create mode 100644 Documentation/filesystems/fsverity.rst
 create mode 100644 fs/verity/Kconfig
 create mode 100644 fs/verity/Makefile
 create mode 100644 fs/verity/fsverity_private.h
 create mode 100644 fs/verity/hash_algs.c
 create mode 100644 fs/verity/ioctl.c
 create mode 100644 fs/verity/setup.c
 create mode 100644 fs/verity/signature.c
 create mode 100644 fs/verity/verify.c
 create mode 100644 include/linux/fsverity.h
 create mode 100644 include/uapi/linux/fsverity.h

-- 
2.19.1.568.g152ad8e336-goog

