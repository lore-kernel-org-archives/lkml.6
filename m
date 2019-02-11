Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F88AC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 417E7217FA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388551AbfBKURG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 15:17:06 -0500
Received: from mga14.intel.com ([192.55.52.115]:16955 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727302AbfBKURE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 15:17:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2019 12:17:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,360,1544515200"; 
   d="scan'208";a="319498277"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga005.fm.intel.com with ESMTP; 11 Feb 2019 12:17:03 -0800
From:   ira.weiny@intel.com
To:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Daniel Borkmann <daniel@iogearbox.net>,
        Davidlohr Bueso <dave@stgolabs.net>, netdev@vger.kernel.org
Cc:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH 0/3] Add gup fast + longterm and use it in HFI1
Date:   Mon, 11 Feb 2019 12:16:40 -0800
Message-Id: <20190211201643.7599-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

NOTE: This series depends on my clean up patch to remove the write parameter
from gup_fast_permitted()[1]

HFI1 uses get_user_pages_fast() due to it performance advantages.  Like RDMA,
HFI1 pages can be held for a significant time.  But get_user_pages_fast() does
not protect against mapping of FS DAX pages.

Introduce a get_user_pages_fast_longterm() which retains the performance while
also adding the FS DAX checks.  XDP has also shown interest in using this
functionality.[2]

[1] https://lkml.org/lkml/2019/2/11/237
[2] https://lkml.org/lkml/2019/2/11/1789

Ira Weiny (3):
  mm/gup: Change "write" parameter to flags
  mm/gup: Introduce get_user_pages_fast_longterm()
  IB/HFI1: Use new get_user_pages_fast_longterm()

 drivers/infiniband/hw/hfi1/user_pages.c |   2 +-
 include/linux/mm.h                      |   8 ++
 mm/gup.c                                | 152 ++++++++++++++++--------
 3 files changed, 114 insertions(+), 48 deletions(-)

-- 
2.20.1

