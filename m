Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751842AbeAaFgU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 00:36:20 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:51712 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751454AbeAaFgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 00:36:19 -0500
From: Mike Kravetz <mike.kravetz@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
        David Herrmann <dh.herrmann@gmail.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v2 0/3] restructure memfd code
Date: Tue, 30 Jan 2018 18:29:08 -0800
Message-Id: <20180131022911.23947-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.13.6
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8790 signatures=668657
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=740
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1801310072
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've had these patches sitting around for a few months.  They are not
critical, but might be desirable in some unusual configurations.  They
depend on code in mmotm and linux-next that is not yet upstream, and
apply to those repos.

With the addition of memfd hugetlbfs support, we now have the situation
where memfd depends on TMPFS -or- HUGETLBFS.  Previously, memfd was only
supported on tmpfs, so it made sense that the code resides in shmem.c.

This patch series moves the memfd code to separate files (memfd.c and
memfd.h).  It creates a new config option MEMFD_CREATE that is defined
if either TMPFS or HUGETLBFS is defined.

In the current code, memfd is only functional if TMPFS is defined.  If
HUGETLFS is defined and TMPFS is not defined, then memfd functionality
will not be available for hugetlbfs.  This does not cause BUGs, just a
potential lack of desired functionality.

When this was sent as a RFC, one comment suggested combining patches 2
and 3 so that we would not have 'new unused' files between patches.  If
this is desired, I can make the change.  For me, it is easier to read
as separate patches.

v2:
- Fixed sparse warnings inherited from existing code

Mike Kravetz (3):
  mm: hugetlbfs: move HUGETLBFS_I outside #ifdef CONFIG_HUGETLBFS
  mm: memfd: split out memfd for use by multiple filesystems
  mm: memfd: remove memfd code from shmem files and use new memfd files

 fs/Kconfig               |   3 +
 fs/fcntl.c               |   2 +-
 include/linux/hugetlb.h  |  27 ++--
 include/linux/memfd.h    |  16 +++
 include/linux/shmem_fs.h |  13 --
 mm/Makefile              |   1 +
 mm/memfd.c               | 342 +++++++++++++++++++++++++++++++++++++++++++++++
 mm/shmem.c               | 323 --------------------------------------------
 8 files changed, 379 insertions(+), 348 deletions(-)
 create mode 100644 include/linux/memfd.h
 create mode 100644 mm/memfd.c

-- 
2.13.6
