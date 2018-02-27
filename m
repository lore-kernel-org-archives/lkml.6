Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-351074-1519705745-2-4333042138179030031
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519705744; b=YOwYdbnFj4FpdE9hPnaJV6gH6Sp63qKNNnV1On5F3wyxZBV
    m5bQZYqZZe0o0obrfI31Gs+ZUqusoLiJeCzMyCjj22Nzka7ChpNtNLYiYONIDZuL
    ImtFUJSR/O/BjRAPGc3bLtyLzD+cs+utDT+1KQr0EOaDkUwnRM21K1wUgAXB/dNx
    CDz70qTl5B7MAGm1hX4QC6gkLVeXvHrRYGCW45s0WJ7dFzDioTWO2DjAdQz4o2Lo
    HK21ur17sZLMSC9uSRJQOjcTRQuurDXRmJisq+Jj0mo95NGOS9JOnJfRph7z3pqW
    LMdiBhf1IEMXlqgXgApajxK7aFh21TrlhuHlqvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=arctest; t=1519705744; bh=WHwP/u0918fIW5UpHMhzl3gU6I
    znZuSN/SoECHSzPAM=; b=dRVph2sO/GEAh68b7jo6+7MAhd+i3XVpVRoKTC19Dr
    O3ZnDUUm2dy3Mfhm1m5ziwAXCkkHPOfyoxMkhJ8cHCrLuTV06xVljjwubXRzArQ6
    LwNDaHgUAnxtf6wQJbqOa1QcZbVMBufpOC0gxZa4YhOtdGMO7gIMN4xEB8xqKJLs
    tF7V07ppgMFhiALxLYvhKfDHDJOI6KhAGckPMcFORnjbCTq8Ersg2HWiXQ/pyy6e
    PEgM2ISPKT4jrm5LijEfeLe5PJNLSHOaIqZhR3p8wMomO7BmzJmvtowNvOZjEmOJ
    BS/Vgnm5Ph9axrzQBtcbuEnzDs9ua51x3NlYngxhJPIw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751798AbeB0E3B (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 23:29:01 -0500
Received: from mga04.intel.com ([192.55.52.120]:32545 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751591AbeB0E3A (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 26 Feb 2018 23:29:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,398,1515484800";
   d="scan'208";a="23442513"
Subject: [PATCH v4 00/12] vfio,
 dax: prevent long term filesystem-dax pins and other fixes
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: Jane Chu <jane.chu@oracle.com>,
        Haozhong Zhang <haozhong.zhang@intel.com>,
        Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>,
        kvm@vger.kernel.org, Matthew Wilcox <mawilcox@microsoft.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "supporter:XFS FILESYSTEM" <linux-xfs@vger.kernel.org>,
        linux-mm@kvack.org, Alex Williamson <alex.williamson@redhat.com>,
        Gerd Rausch <gerd.rausch@oracle.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.com>, linux-fsdevel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>
Date: Mon, 26 Feb 2018 20:19:54 -0800
Message-ID: <151970519370.26729.1011551137381425076.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.17.1-9-g687f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The following series implements...
Changes since v3 [1]:

* Kill IS_DAX() in favor of explicit IS_FSDAX() and IS_DEVDAX() helpers.
  Jan noted, "having IS_DAX() and IS_FSDAX() doing almost the same, just
  not exactly the same, is IMHO a recipe for confusion", and I agree. A
  nice side effect of this elimination is a cleanup to remove occasions of
  "#ifdef CONFIG_FS_DAX" in C files, it is all moved to header files
  now. (Jan)

---

The vfio interface, like RDMA, wants to setup long term (indefinite)
pins of the pages backing an address range so that a guest or userspace
driver can perform DMA to the with physical address. Given that this
pinning may lead to filesystem operations deadlocking in the
filesystem-dax case, the pinning request needs to be rejected.

The longer term fix for vfio, RDMA, and any other long term pin user, is
to provide a 'pin with lease' mechanism. Similar to the leases that are
hold for pNFS RDMA layouts, this userspace lease gives the kernel a way
to notify userspace that the block layout of the file is changing and
the kernel is revoking access to pinned pages.

Related to this change is the discovery that vma_is_fsdax() was causing
device-dax inode detection to fail. That lead to series of fixes and
cleanups to make sure that S_DAX is defined correctly in the
CONFIG_FS_DAX=n + CONFIG_DEV_DAX=y case.

---

Dan Williams (12):
      dax: fix vma_is_fsdax() helper
      dax: introduce IS_DEVDAX() and IS_FSDAX()
      ext2, dax: finish implementing dax_sem helpers
      ext2, dax: define ext2_dax_*() infrastructure in all cases
      ext4, dax: define ext4_dax_*() infrastructure in all cases
      ext2, dax: replace IS_DAX() with IS_FSDAX()
      ext4, dax: replace IS_DAX() with IS_FSDAX()
      xfs, dax: replace IS_DAX() with IS_FSDAX()
      mm, dax: replace IS_DAX() with IS_DEVDAX() or IS_FSDAX()
      fs, dax: kill IS_DAX()
      dax: fix S_DAX definition
      vfio: disable filesystem-dax page pinning


 drivers/vfio/vfio_iommu_type1.c |   18 ++++++++++++++--
 fs/ext2/ext2.h                  |    6 +++++
 fs/ext2/file.c                  |   19 +++++------------
 fs/ext2/inode.c                 |   10 ++++-----
 fs/ext4/file.c                  |   18 +++++-----------
 fs/ext4/inode.c                 |    4 ++--
 fs/ext4/ioctl.c                 |    2 +-
 fs/ext4/super.c                 |    2 +-
 fs/iomap.c                      |    2 +-
 fs/xfs/xfs_file.c               |   14 ++++++-------
 fs/xfs/xfs_ioctl.c              |    4 ++--
 fs/xfs/xfs_iomap.c              |    6 +++--
 fs/xfs/xfs_reflink.c            |    2 +-
 include/linux/dax.h             |   12 ++++++++---
 include/linux/fs.h              |   43 ++++++++++++++++++++++++++++-----------
 mm/fadvise.c                    |    3 ++-
 mm/filemap.c                    |    4 ++--
 mm/huge_memory.c                |    4 +++-
 mm/madvise.c                    |    3 ++-
 19 files changed, 102 insertions(+), 74 deletions(-)
