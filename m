Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A70C46461
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DE2220892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:16:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DE2220892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zoho.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbeG3IuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 04:50:17 -0400
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25482 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbeG3IuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 04:50:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id; 
  b=knHOh6YvevoSp9xI3qCJCtl+umkguSzLO38fhTaOsVIaaivoM65fYFGOaEb/3jX6epaTHa5+t2Rn
    6pJgDNTcOlxLfaRHAsUfbojLQWn1VDefmflXJ5h06FMgJMLz/oZ9  
Received: from YEHS1XR956R00D1.lenovo.com (221.219.122.69 [221.219.122.69]) by mx.zohomail.com
        with SMTPS id 1532934965421456.2684745169777; Mon, 30 Jul 2018 00:16:05 -0700 (PDT)
From:   Huaisheng Ye <yehs2007@zoho.com>
To:     linux-nvdimm@lists.01.org, dan.j.williams@intel.com
Cc:     ross.zwisler@linux.intel.com, willy@infradead.org,
        vishal.l.verma@intel.com, dave.jiang@intel.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        viro@zeniv.linux.org.uk, martin.petersen@oracle.com,
        axboe@kernel.dk, gregkh@linuxfoundation.org,
        bart.vanassche@wdc.com, jack@suse.cz, agk@redhat.com,
        snitzer@redhat.com, keescook@chromium.org, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, colyli@suse.de, chengnt@lenovo.com,
        Huaisheng Ye <yehs1@lenovo.com>
Subject: [PATCH v3 0/6] kaddr and pfn can be NULL to ->direct_access()
Date:   Mon, 30 Jul 2018 15:15:42 +0800
Message-Id: <20180730071548.9172-1-yehs2007@zoho.com>
X-Mailer: git-send-email 2.17.0.windows.1
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huaisheng Ye <yehs1@lenovo.com>

Changes since v2 [2]:
* Collect Martin and Mike's acks for dcssblk and dm-writecache;
* Rebase the series of patch to v4.18-rc7.

Changes since v1 [1]:
* Involve the previous patches for pfn can be NULL.
* Reword the patch descriptions according to Christian's comment.
* According to Ross's suggestion, replace local pointer dummy_addr
  with NULL within md/dm-writecache for direct_access.

[1]: https://lkml.org/lkml/2018/7/24/199
[2]: https://lkml.org/lkml/2018/7/25/581

Some functions within fs/dax, dax/super and md/dm-writecache don't
need to get local pointer kaddr or variable pfn from direct_access.
Assigning NULL to kaddr or pfn with ->direct_access() is more
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


