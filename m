Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C23C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 06:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FA8B21473
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 06:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZOfCGLr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FA8B21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727712AbeJLNbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 09:31:16 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46784 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbeJLNbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 09:31:16 -0400
Received: by mail-pg1-f194.google.com with SMTP id a5-v6so5293829pgv.13;
        Thu, 11 Oct 2018 23:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cZ1AXSWVx5qIXKJkpNxR1YF2WNb3O6AfPd8aPBSPd/k=;
        b=hZOfCGLrxItFDNoIqYqAhFpMMmHrHUhNGnDx9fUAOQEoBuwGc5OWgy6ENPQ/hLOPJL
         +W7Q5JsvEGzN589OUBO9YC+4f30p+OR57WJvqOX0C2bAVxcKKywKDl6wESVAXAcjEpx4
         WRNorGJfrZPjzHLhfeDvSzzzb0ozj8T6sjnbj4NK/vgHVDiKQB3MLUDDVLZvGbQqaHcT
         XT2TILtP+w3+j6qP8L3PbFNdl0D7+OGLnvwz1dzusMjrNQKgpv2m5gVX2zvuzUoK3D+A
         Q9H7aDypjRyGMFY9r9q54FHnsYed2ta4KXaRcvzwrHAEs4o9JI3j4VukNx5Royc3tDIL
         R4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cZ1AXSWVx5qIXKJkpNxR1YF2WNb3O6AfPd8aPBSPd/k=;
        b=HQ3OU2ZawibM2rn+mrTnjuhCmQuaQc7clQAa+0JGseSi/oLg+lrPd+bxmpwz9OQa7n
         Nu/X081OcCO366iIcaNSMRqFKgmFd7jZ8a/ggtCwRJIERodcIfuIOehqnyg46l8Z+mNQ
         xXged463mAPs0dcw/0da47InRZRn2lYpuARObauSIYxYHFxVMd/Og69rPsWWvMhe27rf
         xBzHu9DPCqJrD70dei9Pg4rqw8P3Vnhwz7w7BQTcwmjLVAZAyTjulpT6HArH9ItqBUO/
         uiFyEQ4vw4CnVt/+x8Z0PfUByYAYE64gZXqg0Aegl6FHER75hQu1+ySlySg0UMj0CRLj
         tLGQ==
X-Gm-Message-State: ABuFfojtoYi/sL7vIn2dHcCdRUKF4YxA29cy5yUVRDBjpkCYLpHUD3Sn
        FOYlUj8srFMxi3rBpMfzkyE=
X-Google-Smtp-Source: ACcGV62fHxutcyfMHw4gEjMQtKnPR8JAQTuzw+ycKT5rZRe5RTPjTXGO5BACq+wtzXDY8v2gq8oWpg==
X-Received: by 2002:a63:c20f:: with SMTP id b15-v6mr4252901pgd.13.1539324027458;
        Thu, 11 Oct 2018 23:00:27 -0700 (PDT)
Received: from blueforge.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id z3-v6sm368579pfm.150.2018.10.11.23.00.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 23:00:26 -0700 (PDT)
From:   john.hubbard@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 0/6] RFC: gup+dma: tracking dma-pinned pages
Date:   Thu, 11 Oct 2018 23:00:08 -0700
Message-Id: <20181012060014.10242-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

Here is an updated proposal for tracking pages that have had
get_user_pages*() called on them. This is in support of fixing the problem
discussed in [1]. This RFC only shows how to set up a reliable
PageDmaPinned flag. What to *do* with that flag is left for a later
discussion.

I'm providing this in order to help the discussion about patches 1-3, which
I'm hoping to check in first. The sequence would be:

    -- apply patches 1-3, convert the rest of the subsystems to call
       put_user_page*(), then

    -- apply patches 4-6, then

    -- Apply more patches, to actually use the new PageDmaPinned flag.

One question up front is, "how do we ensure that either put_user_page()
or put_page() are called, depending on whether the page came from
get_user_pages() or not?". From this series, you can see that:

    -- It's possible to assert within put_user_page(), that we are in the
       right place.

    -- It's less clear that there is a way to assert within put_page(),
       because put_page() is called from put_user_page(), and PageDmaPinned
       may or may not be set--either case is valid.

       Opinions and ideas are welcome there.

This is a lightly tested example (it boots up on x86_64, and just lets the
dma-pinned pages leak, in all non-infiniband cases...which is all cases, on
my particular test computer). This series just does the following:

a) Provides the put_user_page*() routines that have been discussed in
   another thread (patch 2).

b) Provides a single example of converting some code (infiniband) to use
   those routines (patch 3).

c) Connects up get_user_pages*() to use the new refcounting and flags
   fieldsj (patches 4-6)

[1] https://lwn.net/Articles/753027/ : "The Trouble with get_user_pages()"

John Hubbard (6):
  mm: get_user_pages: consolidate error handling
  mm: introduce put_user_page*(), placeholder versions
  infiniband/mm: convert put_page() to put_user_page*()
  mm: introduce page->dma_pinned_flags, _count
  mm: introduce zone_gup_lock, for dma-pinned pages
  mm: track gup pages with page->dma_pinned_* fields

 drivers/infiniband/core/umem.c              |   7 +-
 drivers/infiniband/core/umem_odp.c          |   2 +-
 drivers/infiniband/hw/hfi1/user_pages.c     |  11 +-
 drivers/infiniband/hw/mthca/mthca_memfree.c |   6 +-
 drivers/infiniband/hw/qib/qib_user_pages.c  |  11 +-
 drivers/infiniband/hw/qib/qib_user_sdma.c   |   6 +-
 drivers/infiniband/hw/usnic/usnic_uiom.c    |   7 +-
 include/linux/mm.h                          |   9 ++
 include/linux/mm_types.h                    |  22 +++-
 include/linux/mmzone.h                      |   6 +
 include/linux/page-flags.h                  |  47 +++++++
 mm/gup.c                                    |  93 +++++++++++---
 mm/memcontrol.c                             |   7 +
 mm/page_alloc.c                             |   1 +
 mm/swap.c                                   | 134 ++++++++++++++++++++
 15 files changed, 319 insertions(+), 50 deletions(-)

-- 
2.19.1

