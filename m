Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752112AbeERAXc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 20:23:32 -0400
Received: from a2nlsmtp01-03.prod.iad2.secureserver.net ([198.71.225.37]:54948
        "EHLO a2nlsmtp01-03.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751543AbeERAX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 20:23:29 -0400
x-originating-ip: 107.180.71.197
From: Long Li <longli@linuxonhyperv.com>
To: Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc: Long Li <longli@microsoft.com>
Subject: [RFC PATCH 00/09] Implement direct user I/O interfaces for RDMA
Date: Thu, 17 May 2018 17:22:05 -0700
Message-Id: <20180518002214.5657-1-longli@linuxonhyperv.com>
X-Mailer: git-send-email 2.17.0
Reply-To: longli@microsoft.com
X-CMAE-Envelope: MS4wfMhDLIYs8xHYq1k5o6aNxPJ67R1WRQW8Aqzrfn5hrfS2W328cbAEIQ6m+s4HT8jLyZInRoSt6s9Rurs4DgW7X53wBjUVUryZYgNzE2bxniBHJvEh1Bpo
 xHaHQGFJJJ/rahwaBbSu5SEbGBOO3qzdaEq9mAJQpmrLMft0nyjf7PxUtjiHoCtLunYNfWEe1YvCmPpKygRlhf03fX9IuJiU0pzAMCSUL7aGWU9AYrJaQkJX
 6i0AA+FceAgxUqZkwrg+C9LHKwy33uh49ZWIEBjyBXzi2iXjWWqw6EW010lftU5IWrtvMhovCXCzdTgDPztkE94tD1KOge4Q0nYPnVwClu+VF2T+R0CoaY9D
 SbtLG8XsR3cE995JEoP1eCJtXlf/IOrs31T0USTQO0XOakjlWNlSdPKf4GlCN/t3/y/d/PX8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Long Li <longli@microsoft.com>

This patchset implements direct user I/O through RDMA.

In normal code path (even with cache=none), CIFS copies I/O data from
user-space to kernel-space for security reasons.

With this patchset, a new mounting option is introduced to have CIFS pin the 
user-space buffer into memory and performs I/O through RDMA. This avoids memory
copy, at the cost of added security risk.

This patchset is RFC. The work is in progress, do not merge.


Long Li (9):
  Introduce offset for the 1st page in data transfer structures
  Change wdata alloc to support direct pages
  Change rdata alloc to support direct pages
  Change function to support offset when reading pages
  Change RDMA send to regonize page offset in the 1st page
  Change RDMA recv to support offset in the 1st page
  Support page offset in memory regsitrations
  Implement no-copy file I/O interfaces
  Introduce cache=rdma moutning option
 

 fs/cifs/cifs_fs_sb.h      |   2 +
 fs/cifs/cifsfs.c          |  19 +++
 fs/cifs/cifsfs.h          |   3 +
 fs/cifs/cifsglob.h        |   6 +
 fs/cifs/cifsproto.h       |   4 +-
 fs/cifs/cifssmb.c         |  10 +-
 fs/cifs/connect.c         |  13 +-
 fs/cifs/dir.c             |   5 +
 fs/cifs/file.c            | 351 ++++++++++++++++++++++++++++++++++++++++++----
 fs/cifs/inode.c           |   4 +-
 fs/cifs/smb2ops.c         |   2 +-
 fs/cifs/smb2pdu.c         |  22 ++-
 fs/cifs/smbdirect.c       | 132 ++++++++++-------
 fs/cifs/smbdirect.h       |   2 +-
 fs/read_write.c           |   7 +
 include/linux/ratelimit.h |   2 +-
 16 files changed, 489 insertions(+), 95 deletions(-)

-- 
2.7.4
