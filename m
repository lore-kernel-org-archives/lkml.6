Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D44AECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BFF320856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:46:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BFF320856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zoho.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388225AbeGXJvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 05:51:25 -0400
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25311 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbeGXJvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 05:51:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id; 
  b=peO5eEQQNxo5DRgrdkgbDlqLwYR/rRvrUKA6uPJ1zc0anLOtMBZf3mbVZ7dI4PImb53xNENVW9Ox
    iKXTH6L19BwfYpcZhgPeZbun07OgeEewgqrNi9rjNJ+sgXtxD7rq  
Received: from YEHS1XR956R00D1.lenovo.com (123.120.61.139 [123.120.61.139]) by mx.zohomail.com
        with SMTPS id 1532421925666919.9876390822808; Tue, 24 Jul 2018 01:45:25 -0700 (PDT)
From:   Huaisheng Ye <yehs2007@zoho.com>
To:     linux-nvdimm@lists.01.org, dan.j.williams@intel.com
Cc:     ross.zwisler@linux.intel.com, willy@infradead.org,
        vishal.l.verma@intel.com, dave.jiang@intel.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        viro@zeniv.linux.org.uk, martin.petersen@oracle.com,
        axboe@kernel.dk, gregkh@linuxfoundation.org,
        bart.vanassche@wdc.com, jack@suse.cz, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        chengnt@lenovo.com, Huaisheng Ye <yehs1@lenovo.com>
Subject: [PATCH 0/5] Do not request a pointer kaddr when not required
Date:   Tue, 24 Jul 2018 16:45:05 +0800
Message-Id: <20180724084510.6104-1-yehs2007@zoho.com>
X-Mailer: git-send-email 2.17.0.windows.1
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huaisheng Ye <yehs1@lenovo.com>

Some functions within fs/dax and dax/super don't need to get kaddr from
direct_access. Assigning NULL to kaddr to ->direct_access() is more
straightforward and simple than offering a useless local pointer.

So all direct_access() need to check the validity of second rank pointer
kaddr for NULL assignment. If kaddr equals to NULL, it doesn't need to
calculate its value.

* This series are supplement to [PATCH v2 00/14]mm: Asynchronous +
  multithreaded memmap init for ZONE_DEVICE. [1]

[1]: https://lkml.org/lkml/2018/7/16/828

Huaisheng Ye (5):
  libnvdimm, pmem: Allow a NULL-kaddr to ->direct_access()
  tools/testing/nvdimm: Allow a NULL-kaddr to ->direct_access()
  s390, dcssblk: Allow a NULL-kaddr to ->direct_access()
  filesystem-dax: Do not request a pointer kaddr when not required
  dax/super: Do not request a pointer kaddr when not required

 drivers/dax/super.c             | 3 +--
 drivers/nvdimm/pmem.c           | 4 +++-
 drivers/s390/block/dcssblk.c    | 3 ++-
 fs/dax.c                        | 3 +--
 tools/testing/nvdimm/pmem-dax.c | 6 ++++--
 5 files changed, 11 insertions(+), 8 deletions(-)

-- 
1.8.3.1


