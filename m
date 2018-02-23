Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2252784-1519370929-2-3936954938542647843
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519370929; b=EYcor0/CbaMMgbu0tzE95jY86+2vEyoICL/5MhrQYds30VQ
    00scPtGZj57gpcVKqhhe67c0pqaYCSAgUyk2iQ33tiMAzDXcx4NP5VxFJSqH3uP2
    psWrcdcKxlOfbFcrpqt6tiNJD5tMl7sWQtszZfuaN3LczmZEC98hZsaLIJH5JREm
    KNZWB3oDUnqbKYK1lSbpmwIZy5lvClmAeriBbBkq0G44SiXG1nVDnqqaN25n+Kzp
    SxrZdbFvAZ6Od06fdlUmKh6aE//wKIRML4YxWRHqvle2IXyFrBUgOI7xnR4FjNPz
    VwLLFysGRKSW1do7pBmrTxou2A9AxkqY3HGiNXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=arctest; t=1519370929; bh=0ORCC4MeCu57nX9nLmqZqtxAo5
    jvk5cofyhMJJ3dkBo=; b=YGVSSno3yZrLijzYLWrvwVkMjlvgOPFNQvoOOXjx3/
    DN78gen2DAaGaLc24NLVRQocMcoCsjBVwds75sJ0EdcFLUY8+h14s8DMmq/oMHJ8
    rWv8+bWZHveOSSprZtHql5394cwwaHvueLU273anPafjNgYMuA6Ks2Eiqd74Rfej
    K8XvC73JOrtAN3DMMBFtbiBVlA+NmzBa8eE6vwa2l/hXNx5ov3wSoeMqU3/73MkG
    Xj4+PCAMEx3bM6g8qMx/DDR91ifo71T7phEzLmxcAZg3r8sMCCOgVbfHavTjkZo1
    hSg7FWQvxw+qg9JOYx3lRwZaDkHbmxePzprzUDTTe0uA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751547AbeBWH0r (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 02:26:47 -0500
Received: from mga14.intel.com ([192.55.52.115]:41439 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751539AbeBWH0q (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 23 Feb 2018 02:26:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,382,1515484800";
   d="scan'208";a="19818330"
Subject: [PATCH v2 0/5] vfio,
 dax: prevent long term filesystem-dax pins and other fixes
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: Haozhong Zhang <haozhong.zhang@intel.com>,
        Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, linux-mm@kvack.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Gerd Rausch <gerd.rausch@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        kbuild test robot <fengguang.wu@intel.com>,
        Christoph Hellwig <hch@lst.de>
Date: Thu, 22 Feb 2018 23:17:40 -0800
Message-ID: <151937026001.18973.12034171121582300402.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.17.1-9-g687f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Changes since v1 [1]:

* Fix the detection of device-dax file instances in vma_is_fsdax().
  (Haozhong, Gerd)

* Fix compile breakage in the FS_DAX=n and DEV_DAX=y case. (0day robot)

[1]: https://lists.01.org/pipermail/linux-nvdimm/2018-February/014046.html

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

---

Dan Williams (5):
      dax: fix vma_is_fsdax() helper
      dax: fix dax_mapping() definition in the FS_DAX=n + DEV_DAX=y case
      dax: fix S_DAX definition
      dax: short circuit vma_is_fsdax() in the CONFIG_FS_DAX=n case
      vfio: disable filesystem-dax page pinning


 drivers/vfio/vfio_iommu_type1.c |   18 +++++++++++++++---
 include/linux/dax.h             |    9 ++++++---
 include/linux/fs.h              |    6 ++++--
 3 files changed, 25 insertions(+), 8 deletions(-)
