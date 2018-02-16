Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750939AbeBPUeB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 15:34:01 -0500
Received: from rcdn-iport-5.cisco.com ([173.37.86.76]:37473 "EHLO
        rcdn-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750734AbeBPUd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 15:33:56 -0500
X-IronPort-AV: E=Sophos;i="5.46,520,1511827200";
   d="scan'208";a="139025476"
From: Taras Kondratiuk <takondra@cisco.com>
To: "H. Peter Anvin" <hpa@zytor.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Rob Landley <rob@landley.net>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        James McMechan <james.w.mcmechan@gmail.com>
Cc: initramfs@vger.kernel.org, Victor Kamensky <kamensky@cisco.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, xe-linux-external@cisco.com
Subject: [PATCH v3 00/15] extend initramfs archive format to support xattrs
Date: Fri, 16 Feb 2018 20:33:36 +0000
Message-Id: <1518813234-5874-1-git-send-email-takondra@cisco.com>
X-Mailer: git-send-email 2.7.4
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Authenticated-User: takondra@cisco.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many of the Linux security/integrity features are dependent on file
metadata, stored as extended attributes (xattrs), for making decisions.
These features need to be initialized during initcall and enabled as
early as possible for complete security coverage. 

Initramfs (tmpfs) supports xattrs, but newc CPIO archive format does not
support including them into the archive.

There are several ways to include xattrs for initramfs:

- Add TAR support. Complicated format and big headers looks like too
  much overhead.

- Include a file manifest containing the xattrs in the CPIO. Should be
  easy for initramfs because we can set xattrs at the end when all files
  are extracted, but extracting such archive in userspace will be more
  complicated. For example it may be necessary to set SELinux labels for
  directories before extracting files into them, so manifest has to be
  extracted first and then searched during each file extraction.

- Extend CPIO header to support xattrs. This seem to be the most
  straight forward way. It also allows to do other useful changes
  to CPIO format at the same time. E.g. increase filesize field to
  support files >4GB.

This patch set extends the existing newc CPIO archive format to include
xattrs in the initramfs.

The series is based on v4.16-rc1. cpio_xattr branch is available here:
https://github.com/kontar/linux/commits/cpio_xattr

=== Patch summary ===

Documentation:
[PATCH 01/15] Documentation: add newcx initramfs format description

Refactoring to simplify adding the new format:
[PATCH 02/15] initramfs: replace states with function pointers
[PATCH 03/15] initramfs: store file name in name_buf
[PATCH 04/15] initramfs: remove unnecessary symlinks processing shortcut
[PATCH 05/15] initramfs: move files creation into separate state
[PATCH 06/15] initramfs: separate reading cpio method from header
[PATCH 07/15] initramfs: split header layout information from parsing
function

Parse newxc format:
[PATCH 08/15] initramfs: add newcx format
[PATCH 09/15] initramfs: set extended attributes

Generate newcx cpio archive:
[PATCH 10/15] gen_init_cpio: move header formatting into function
[PATCH 11/15] gen_init_cpio: add newcx format
[PATCH 12/15] gen_init_cpio: set extended attributes for newcx
[PATCH 13/15] gen_initramfs_list.sh: add -x option to enable newcx

SELinux patches used for testing. They will be sent to SELinux
maintainers separately.
[PATCH 14/15] selinux: allow setxattr on rootfs so initramfs code can
set them
[PATCH 15/15] selinux: delay sid population for rootfs till init is
complete

=== Testing ===

gen_initramfs_list.sh can be used to generate newcx CPIO archive: if
CONFIG_INITRAMFS_NEWCX is enabled CONFIG_INITRAMFS_SOURCE will be packed
into newcx archive. It is enough for basic testing, but it is not
convenient for more complex setup.

Victor have prepared a test setup with SELinux-labeled initramfs based
on Poky(Yocto) with meta-selinux layer.

Repo manifest and build instructions:
https://github.com/victorkamensky/initramfs-xattrs-manifest

Reference cpio utility patch to support newcx format could be
found as part of poky/meta-selinux testing environment at

https://raw.githubusercontent.com/victorkamensky/initramfs-xattrs-poky/rocko/meta/recipes-extended/cpio/cpio-2.12/cpio-xattrs.patch

=== History ===

The patch set is based on Mimi's series from Jan 2015:
https://www.mail-archive.com/initramfs@vger.kernel.org/msg03971.html
Latest discussion I was able to find is from Dec 2015:
https://www.mail-archive.com/initramfs@vger.kernel.org/msg04198.html

Format changes:
- increased size of filesize to 64 bits to support files >4GB.
- increased mtime field size to have 64 bits of seconds and added a
  field for nanoseconds
- checksum field is replaced by xattrs_size field.

Other fields are left unchanged. See patch format description in the
patch #1.

v3 changes:
- added separate mtime nanosecond field

v2 changes:
- added documentation
- made format more consistent. In previous version a sequence of fields
  in newcx header was different for symlinks and regular files (for
  symlinks data field was before xattrs). It was caused by a flow
  shortcut during symlink entry parsing.
- removed unused checksum field in newcx header
- removed redundant xattrcount at the beginning of xattr section
  (xattrs_size is enough to determine the end of section).
- size of xattr entry in xattr section includes both name and value.
  This makes format more consistent and allows to jump over an entry
  without scanning for the end of name string first.
- streamlined the state machine to address the previous issue and make
  it easier to add the new format
- made header parsing data-driven to remove magic numbers and make it
  easier to add the new format
- eliminated unnecessary buffer allocation for every file name
- pass xattrs to gen_init_cpio via cpio_list file instead of reading
  them from files during packaging. This allows to set xattrs in CPIO
  even if they can't be set on a build machine.
- incorporated several bug fixes from Victor Kamensky for v1 series

Mimi Zohar (3):
  initramfs: separate reading cpio method from header
  initramfs: set extended attributes
  gen_initramfs_list.sh: add -x option to enable newcx format

Taras Kondratiuk (10):
  Documentation: add newcx initramfs format description
  initramfs: replace states with function pointers
  initramfs: store file name in name_buf
  initramfs: remove unnecessary symlinks processing shortcut
  initramfs: move files creation into separate state
  initramfs: split header layout information from parsing function
  initramfs: add newcx format
  gen_init_cpio: move header formatting into function
  gen_init_cpio: add newcx format
  gen_init_cpio: set extended attributes for newcx format

Victor Kamensky (2):
  selinux: allow setxattr on rootfs so initramfs code can set them
  selinux: delay sid population for rootfs till init is complete

 Documentation/early-userspace/buffer-format.txt |  46 ++-
 init/initramfs.c                                | 415 +++++++++++++++++-------
 scripts/gen_initramfs_list.sh                   |  13 +-
 security/selinux/hooks.c                        |  19 ++
 security/selinux/include/security.h             |   1 +
 usr/Kconfig                                     |  11 +
 usr/Makefile                                    |   3 +-
 usr/gen_init_cpio.c                             | 365 ++++++++++++++-------
 8 files changed, 632 insertions(+), 241 deletions(-)

-- 
2.10.3.dirty
