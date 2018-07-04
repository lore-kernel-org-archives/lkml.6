Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3EF9C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BB0B208B1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:40:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BB0B208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zoho.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752881AbeGDQkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 12:40:21 -0400
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25350 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752251AbeGDQkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 12:40:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id; 
  b=ZMtc74Y0gZVqU/pBlnoQapt7HWwUyFG4id2Hb6OCh9zBCCV/ZE0+KnDHOPzIb2kiU/Vz4bzn3Uyr
    qAksFck/Ucj+9xgvBQT3w13GCabCzFyO7fvYHjeZDQHBytWLbnS8  
Received: from YEHS1XR956R00D1.lenovo.com (123.120.80.137 [123.120.80.137]) by mx.zohomail.com
        with SMTPS id 1530722383924679.1339281655171; Wed, 4 Jul 2018 09:39:43 -0700 (PDT)
From:   Huaisheng Ye <yehs2007@zoho.com>
To:     linux-nvdimm@lists.01.org, dan.j.williams@intel.com
Cc:     ross.zwisler@linux.intel.com, willy@infradead.org,
        vishal.l.verma@intel.com, dave.jiang@intel.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        viro@zeniv.linux.org.uk, martin.petersen@oracle.com,
        axboe@kernel.dk, gregkh@linuxfoundation.org,
        bart.vanassche@wdc.com, jack@suse.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, colyli@suse.de, chengnt@lenovo.com,
        Huaisheng Ye <yehs1@lenovo.com>
Subject: [PATCH v2 0/4] Assigning NULL to gfn of dax_direct_access if useless
Date:   Thu,  5 Jul 2018 00:38:19 +0800
Message-Id: <20180704163823.9980-1-yehs2007@zoho.com>
X-Mailer: git-send-email 2.17.0.windows.1
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huaisheng Ye <yehs1@lenovo.com>

Changes since v1 [1]:
* Collect Jan's reviewed-by.
* According to Dan's suggestion, update the unit test infrastructure
  tools/testing/nvdimm/pmem-dax.c for checking the validity of gfn.

[1]: https://lkml.org/lkml/2018/7/4/81

---

Some functions within fs/dax don't need to get gfn from direct_access.
Assigning NULL to gfn of dax_direct_access is more intuitive and simple
than offering a useless local variable.

So all direct_access need to check the validity of pointer pfn for NULL
assignment. If pfn equals to NULL, it doesn't need to calculate its value.

---

Huaisheng Ye (4):
  nvdimm/pmem: check the validity of the pointer pfn
  nvdimm/pmem-dax: check the validity of the pointer pfn
  s390/block/dcssblk: check the validity of the pointer pfn
  fs/dax: Assign NULL to gfn of dax_direct_access if useless

 drivers/nvdimm/pmem.c           | 3 ++-
 drivers/s390/block/dcssblk.c    | 3 ++-
 fs/dax.c                        | 9 +++------
 tools/testing/nvdimm/pmem-dax.c | 6 ++++--
 4 files changed, 11 insertions(+), 10 deletions(-)

-- 
1.8.3.1


