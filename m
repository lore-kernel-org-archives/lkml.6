Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DDAC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D613204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:29:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D613204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zoho.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbeGYRmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 13:42:02 -0400
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25476 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728557AbeGYRmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 13:42:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id; 
  b=aV/9QE9mzcksi9RQ982PkR6fOWTxeBmZRa5EG9AlJVRnenjEcIc8DtWb4pI3+TBdf3RoMYIkfu9U
    n0zjz2A81S23QBJY5as9RFwLMMbxqPru+BKLLuNPglPWzzPqO5PK  
Received: from YEHS1XR956R00D1.lenovo.com (114.245.13.10 [114.245.13.10]) by mx.zohomail.com
        with SMTPS id 15325361439801006.2989965103092; Wed, 25 Jul 2018 09:29:03 -0700 (PDT)
From:   Huaisheng Ye <yehs2007@zoho.com>
To:     linux-nvdimm@lists.01.org, dan.j.williams@intel.com
Cc:     ross.zwisler@linux.intel.com, willy@infradead.org,
        vishal.l.verma@intel.com, dave.jiang@intel.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        viro@zeniv.linux.org.uk, martin.petersen@oracle.com,
        axboe@kernel.dk, gregkh@linuxfoundation.org,
        bart.vanassche@wdc.com, jack@suse.cz, agk@redhat.com,
        snitzer@redhat.com, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, chengnt@lenovo.com, colyli@suse.de,
        Huaisheng Ye <yehs1@lenovo.com>
Subject: [PATCH v2 0/6] kaddr and pfn can be NULL to ->direct_access()
Date:   Thu, 26 Jul 2018 00:28:43 +0800
Message-Id: <20180725162849.8320-1-yehs2007@zoho.com>
X-Mailer: git-send-email 2.17.0.windows.1
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huaisheng Ye <yehs1@lenovo.com>

Changes since v1 [1]:
* Involve the previous patches for pfn can be NULL.
* Reword the patch descriptions according to Christian's comment.
* According to Ross's suggestion, replace local pointer dummy_addr
  with NULL within md/dm-writecache for direct_access.

[1]: https://lkml.org/lkml/2018/7/24/199

Some functions within fs/dax, dax/super and md/dm-writecache don't
need to get local pointer kaddr or variable pfn from direct_access.
Assigning NULL to kaddr or pfn to ->direct_access() is more
straightforward and simple than offering a useless local pointer or
variable.

So all ->direct_access() need to check the validity of pointer kaddr
and pfn for NULL assignment. If either of them is equal to NULL, that
is to say callers may have no need for kaddr or pfn, so this series of
patch are prepared for allowing them to pass in NULL instead of having
to pass in a local pointer or variable that they then just throw away.

Huaisheng Ye (6):
  libnvdimm, pmem: kaddr and pfn can be NULL to ->direct_access()
  s390, dcssblk: kaddr and pfn can be NULL to ->direct_access()
  tools/testing/nvdimm: kaddr and pfn can be NULL to ->direct_access()
  dax/super: Do not request a pointer kaddr when not required
  md/dm-writecache: Don't request pointer dummy_addr when not required
  filesystem-dax: Do not request kaddr and pfn when not required

 drivers/dax/super.c             |  3 +--
 drivers/md/dm-writecache.c      |  3 +--
 drivers/nvdimm/pmem.c           |  7 +++++--
 drivers/s390/block/dcssblk.c    |  8 +++++---
 fs/dax.c                        | 13 ++++---------
 tools/testing/nvdimm/pmem-dax.c | 12 ++++++++----
 6 files changed, 24 insertions(+), 22 deletions(-)

-- 
1.8.3.1


