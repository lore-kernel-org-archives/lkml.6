Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE28ECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9EBF21566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:37:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9EBF21566
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390742AbeIUW1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 18:27:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34900 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389683AbeIUW1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 18:27:31 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C641E30A3139;
        Fri, 21 Sep 2018 16:37:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3567D600C8;
        Fri, 21 Sep 2018 16:37:49 +0000 (UTC)
Subject: [PATCH 0/5] VFS: Introduce filesystem information query syscall
 [ver #12]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-api@vger.kernel.org, torvalds@linux-foundation.org,
        dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mszeredi@redhat.com
Date:   Fri, 21 Sep 2018 17:37:48 +0100
Message-ID: <153754786825.19213.16907802981157370740.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 21 Sep 2018 16:37:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Al,

Here are a set of patches that adds a syscall, fsinfo(), that allows
attributes of a filesystem/superblock to be queried.  Attributes are of two
basic types: fixed-length structure and variable-length string.  Attributes
can also have multiple values in up to two dimensions.

Note that the attributes *are* allowed to vary depending on the specific
dentry that you're looking at.

I've tried to make the interface as light as possible, so integer/enum
attribute selector rather than string and the core does all the allocation and
extensibility support work rather than leaving that to the filesystems.  That
means sb->s_op->get_fsinfo() may assume that the provided buffer is always
present and always big enough.

Further, this removes the possibility of the filesystem gaining access to the
userspace buffer.


General superblock attributes include:

 - The amount of space/free space in a filesystem (as statfs()).
 - Filesystem identifiers (UUID, volume label, device numbers, ...)
 - The limits on a filesystem's capabilities
 - A variety single-bit flags indicating supported capabilities.
 - Information on supported statx fields and attributes and IOC flags.
 - Timestamp resolution and range.
 - Sources (as per mount(2), but fsconfig() allows multiple sources).
 - In-filesystem filename format information.
 - I/O parameters.
 - Filesystem parameters ("mount -o xxx"-type things).

Specific network superblock attributes include:

 - Cell and domain names.
 - Kerberos realm name.
 - Server names and addresses.

Filesystem configuration metadata attributes include:

 - Filesystem parameter type descriptions.
 - Name -> parameter mappings.
 - Simple enumeration name -> value mappings.

fsinfo() also permits you to retrieve information about what the fsinfo()
syscall itself supports, including the number of attibutes supported and the
number of capability bits supported.

The system is extensible:

 (1) New attributes can be added.  There is no requirement that a filesystem
     implement every attribute.  Note that the core VFS keeps a table of types
     and sizes so it can handle future extensibility rather than delegating
     this to the filesystems.

 (2) Structure-typed attributes can be made larger and have more information
     tacked on the end, provided it keeps the layout of the existing fields.
     If an older process asks for a shorter structure, it will only be given
     the bits it asks for.  If a newer process asks for a longer structure on
     an older kernel, the extra space will be set to 0.  In all cases, the
     size of the data available is returned.

     In essence, the size of a structure is that structure's version: a
     smaller size is an earlier version and a later version includes
     everything that the earlier version did.

 (3) New single-bit capability flags can be added.  This is a structure-typed
     attribute and, as such, (2) applies.  Any bits you wanted but the kernel
     doesn't support are automatically set to 0.

If a filesystem-specific attribute is added, it should just take up the next
number in the enumeration.  Currently, I do not intend that the number space
should be subdivided between interested parties.

fsinfo() may be called like the following, for example:

	struct fsinfo_params params = {
		.at_flags	= AT_SYMLINK_NOFOLLOW,
		.request	= FSINFO_ATTR_SERVER_ADDRESS;
		.Nth		= 2;
		.Mth		= 1;
	};
	struct fsinfo_server_address address;

	len = fsinfo(AT_FDCWD, "/kafs/grand.central.org/doc", &params,
		     &address, sizeof(address));

The above example would query a network filesystem, such as AFS or NFS, and
ask what the 2nd address (Mth) of the 3rd server (Nth) that the superblock is
using is.  Whereas:

	struct fsinfo_params params = {
		.at_flags	= AT_SYMLINK_NOFOLLOW,
		.request	= FSINFO_ATTR_CELL_NAME;
	};
	char cell_name[256];

	len = fsinfo(AT_FDCWD, "/kafs/grand.central.org/doc", &params,
		     &cell_name, sizeof(cell_name));

would retrieve the name of an AFS cell as a string.

fsinfo() can also be used to query a context from fsopen() or fspick():

	fd = fsopen("ext4", 0);
	struct fsinfo_params params = {
		.request	= FSINFO_ATTR_PARAM_DESCRIPTION;
	};
	struct fsinfo_param_description desc;
	fsinfo(fd, NULL, &params, &desc, sizeof(desc));

even if that context doesn't currently have a superblock attached (though if
there's no superblock attached, only filesystem-specific things like parameter
descriptions can be accessed).

The patches can be found here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git

on branch:

	fsinfo

===================
SIGNIFICANT CHANGES
===================

 ver #12:

 (*) Rename ->get_fsinfo() to ->fsinfo().

 (*) Pass the path through to to ->fsinfo() as it's needed for NFS to
     retrocalculate the source name.

 (*) Indicated which is the source parameter in the param-description
     attribute.

 (*) Dropped the realm attribute.

David
---
David Howells (5):
      vfs: syscall: Add fsinfo() to query filesystem information
      afs: Add fsinfo support
      vfs: Allow fsinfo() to query what's in an fs_context
      vfs: Allow fsinfo() to be used to query an fs parameter description
      vfs: Implement parameter value retrieval with fsinfo()


 arch/x86/entry/syscalls/syscall_32.tbl |    1 
 arch/x86/entry/syscalls/syscall_64.tbl |    1 
 fs/afs/internal.h                      |    1 
 fs/afs/super.c                         |  168 +++++++++
 fs/hugetlbfs/inode.c                   |   66 ++++
 fs/kernfs/mount.c                      |   16 +
 fs/statfs.c                            |  587 ++++++++++++++++++++++++++++++++
 include/linux/fs.h                     |    4 
 include/linux/fsinfo.h                 |   41 ++
 include/linux/kernfs.h                 |    2 
 include/linux/syscalls.h               |    4 
 include/uapi/linux/fsinfo.h            |  303 ++++++++++++++++
 kernel/cgroup/cgroup-v1.c              |   72 ++++
 kernel/cgroup/cgroup.c                 |   31 ++
 samples/vfs/Makefile                   |    6 
 samples/vfs/test-fs-query.c            |  138 +++++++
 samples/vfs/test-fsinfo.c              |  589 ++++++++++++++++++++++++++++++++
 17 files changed, 2028 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/fsinfo.h
 create mode 100644 include/uapi/linux/fsinfo.h
 create mode 100644 samples/vfs/test-fs-query.c
 create mode 100644 samples/vfs/test-fsinfo.c

