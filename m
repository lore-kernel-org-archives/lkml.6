Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753443AbeEURgE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 13:36:04 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45240 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753193AbeEURgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 13:36:02 -0400
From: Gabriel Krisman Bertazi <krisman@collabora.co.uk>
To: viro@ZenIV.linux.org.uk
Cc: jra@google.com, tytso@mit.edu, olaf@sgi.com, darrick.wong@oracle.com,
        kernel@lists.collabora.co.uk, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, jack@suse.cz, linux-kernel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.co.uk>
Subject: [PATCH v2 00/15] NLS refactor and UTF-8 normalization
Date: Mon, 21 May 2018 14:36:02 -0300
Message-Id: <20180521173617.31625-1-krisman@collabora.co.uk>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Archive of previous versions:
  https://www.spinics.net/lists/linux-fsdevel/msg125523.html

The goal of this patchset is to adapt the NLS subsystem to support
full UTF-8 normalization and casefold operations for specific versions
of unicode.  There are many use cases of this feature and, while my
specific interest is on case-insensitiveness for local filesystems, I am
aware this might be in the wishlist of people working on SMB, NFS and
others.

The first part of the patchset refactors the NLS subsytem to allow
multiple tables of the same encoding (differentiated by the version) in
an inexpensive way.  It also create hooks for some higher-level
operations, like comparisons and normalization.  A new interface is
exported to request a specific version of the charset.

The second part of the patchset introduces the utf8 normalization code
as a new NLS charset.  It is implemented as a separated charset, called
utf8n to preserve curent behavior of the nls_utf8 charset.  The
normalization core is provided by the SGI patches from 2014, which I
refactored, adapted and updated to unicode 10.0.0.

The last patch is a test module, which does some sanity check on the
normalization code when it is loaded.

As usual, the unicode source files are not part of the patch because
they are too big and would bounce the emails.  Which means that kbuild
will complain about not being able to generate ucd/*.txt files.

Kbuild will also complain about code that is just being moved, which I'm
not going to fix at this time. please refer to v1, for more information.

If you are interested in fetching everything with minimal effort, you
can clone a branch from:

  https://gitlab.collabora.com/krisman/linux.git -b nls-merge-int

Changes since v1:
      - Fix nls_base.ko module build

Gabriel Krisman Bertazi (11):
  nls: Wrap uni2char/char2uni callers
  nls: Wrap charset field access
  nls: Wrap charset hooks in ops structure
  nls: Split default charset from NLS core
  nls: Split struct nls_charset from struct nls_table
  nls: Add support for multiple versions of an encoding
  nls: Add new interface for string comparisons
  nls: Let charsets define the behavior of tolower/toupper
  nls: Add optional normalization and casefold hooks
  nls: utf8norm: Integrate utf8norm code with NLS subsystem
  nls: utf8norm: Introduce test module for utf8norm implementation

Olaf Weber (4):
  nls: utf8norm: Add unicode character database files
  scripts: add trie generator for UTF-8
  nls: utf8norm: Introduce code for UTF-8 normalization
  nls: utf8norm: reduce the size of utf8data[]

 drivers/staging/ncpfs/ioctl.c         |   13 +-
 drivers/staging/ncpfs/ncplib_kernel.c |    8 +-
 fs/befs/linuxvfs.c                    |    8 +-
 fs/cifs/cifs_unicode.c                |   15 +-
 fs/cifs/cifsfs.c                      |    2 +-
 fs/cifs/connect.c                     |    2 +-
 fs/cifs/dir.c                         |    7 +-
 fs/fat/dir.c                          |   13 +-
 fs/fat/inode.c                        |    6 +-
 fs/fat/namei_vfat.c                   |    6 +-
 fs/hfs/super.c                        |    6 +-
 fs/hfs/trans.c                        |    9 +-
 fs/hfsplus/options.c                  |    2 +-
 fs/hfsplus/unicode.c                  |    6 +-
 fs/isofs/inode.c                      |    5 +-
 fs/isofs/joliet.c                     |    3 +-
 fs/jfs/jfs_unicode.c                  |    9 +-
 fs/jfs/super.c                        |    3 +-
 fs/nls/Kconfig                        |   13 +
 fs/nls/Makefile                       |   19 +
 fs/nls/mac-celtic.c                   |   34 +-
 fs/nls/mac-centeuro.c                 |   34 +-
 fs/nls/mac-croatian.c                 |   34 +-
 fs/nls/mac-cyrillic.c                 |   34 +-
 fs/nls/mac-gaelic.c                   |   34 +-
 fs/nls/mac-greek.c                    |   34 +-
 fs/nls/mac-iceland.c                  |   34 +-
 fs/nls/mac-inuit.c                    |   34 +-
 fs/nls/mac-roman.c                    |   34 +-
 fs/nls/mac-romanian.c                 |   34 +-
 fs/nls/mac-turkish.c                  |   34 +-
 fs/nls/nls_ascii.c                    |   34 +-
 fs/nls/nls_core.c                     |  137 +
 fs/nls/nls_cp1250.c                   |   34 +-
 fs/nls/nls_cp1251.c                   |   34 +-
 fs/nls/nls_cp1255.c                   |   36 +-
 fs/nls/nls_cp437.c                    |   34 +-
 fs/nls/nls_cp737.c                    |   34 +-
 fs/nls/nls_cp775.c                    |   34 +-
 fs/nls/nls_cp850.c                    |   34 +-
 fs/nls/nls_cp852.c                    |   34 +-
 fs/nls/nls_cp855.c                    |   34 +-
 fs/nls/nls_cp857.c                    |   34 +-
 fs/nls/nls_cp860.c                    |   34 +-
 fs/nls/nls_cp861.c                    |   34 +-
 fs/nls/nls_cp862.c                    |   34 +-
 fs/nls/nls_cp863.c                    |   34 +-
 fs/nls/nls_cp864.c                    |   34 +-
 fs/nls/nls_cp865.c                    |   34 +-
 fs/nls/nls_cp866.c                    |   34 +-
 fs/nls/nls_cp869.c                    |   34 +-
 fs/nls/nls_cp874.c                    |   36 +-
 fs/nls/nls_cp932.c                    |   36 +-
 fs/nls/nls_cp936.c                    |   36 +-
 fs/nls/nls_cp949.c                    |   36 +-
 fs/nls/nls_cp950.c                    |   36 +-
 fs/nls/{nls_base.c => nls_default.c}  |  124 +-
 fs/nls/nls_euc-jp.c                   |   29 +-
 fs/nls/nls_iso8859-1.c                |   34 +-
 fs/nls/nls_iso8859-13.c               |   34 +-
 fs/nls/nls_iso8859-14.c               |   34 +-
 fs/nls/nls_iso8859-15.c               |   34 +-
 fs/nls/nls_iso8859-2.c                |   34 +-
 fs/nls/nls_iso8859-3.c                |   34 +-
 fs/nls/nls_iso8859-4.c                |   34 +-
 fs/nls/nls_iso8859-5.c                |   34 +-
 fs/nls/nls_iso8859-6.c                |   34 +-
 fs/nls/nls_iso8859-7.c                |   34 +-
 fs/nls/nls_iso8859-9.c                |   34 +-
 fs/nls/nls_koi8-r.c                   |   34 +-
 fs/nls/nls_koi8-ru.c                  |   30 +-
 fs/nls/nls_koi8-u.c                   |   34 +-
 fs/nls/nls_utf8.c                     |   34 +-
 fs/nls/nls_utf8n-core.c               |  291 +++
 fs/nls/nls_utf8n-norm.c               |  797 ++++++
 fs/nls/nls_utf8n-selftest.c           |  307 +++
 fs/nls/ucd/README                     |   33 +
 fs/nls/utf8n.h                        |  117 +
 fs/ntfs/inode.c                       |    2 +-
 fs/ntfs/super.c                       |    6 +-
 fs/ntfs/unistr.c                      |   13 +-
 fs/udf/super.c                        |    3 +-
 fs/udf/unicode.c                      |    4 +-
 include/linux/nls.h                   |  126 +-
 scripts/Makefile                      |    1 +
 scripts/mkutf8data.c                  | 3464 +++++++++++++++++++++++++
 86 files changed, 6772 insertions(+), 545 deletions(-)
 create mode 100644 fs/nls/nls_core.c
 rename fs/nls/{nls_base.c => nls_default.c} (89%)
 create mode 100644 fs/nls/nls_utf8n-core.c
 create mode 100644 fs/nls/nls_utf8n-norm.c
 create mode 100644 fs/nls/nls_utf8n-selftest.c
 create mode 100644 fs/nls/ucd/README
 create mode 100644 fs/nls/utf8n.h
 create mode 100644 scripts/mkutf8data.c

-- 
2.17.0
