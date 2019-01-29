Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A64C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B1F214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbfA2Qyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 11:54:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:63803 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728233AbfA2Qyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 11:54:38 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2D4CA81F09;
        Tue, 29 Jan 2019 16:54:38 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-122-2.rdu2.redhat.com [10.10.122.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9E319102BCEB;
        Tue, 29 Jan 2019 16:54:36 +0000 (UTC)
From:   jglisse@redhat.com
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 00/10] HMM updates for 5.1
Date:   Tue, 29 Jan 2019 11:54:18 -0500
Message-Id: <20190129165428.3931-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 29 Jan 2019 16:54:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

This patchset improves the HMM driver API and add support for hugetlbfs
and DAX mirroring. The improvement motivation was to make the ODP to HMM
conversion easier [1]. Because we have nouveau bits schedule for 5.1 and
to avoid any multi-tree synchronization this patchset adds few lines of
inline function that wrap the existing HMM driver API to the improved
API. The nouveau driver was tested before and after this patchset and it
builds and works on both case so there is no merging issue [2]. The
nouveau bit are queue up for 5.1 so this is why i added those inline.

If this get merge in 5.1 the plans is to merge the HMM to ODP in 5.2 or
5.3 if testing shows any issues (so far no issues has been found with
limited testing but Mellanox will be running heavier testing for longer
time).

To avoid spamming mm i would like to not cc mm on ODP or nouveau patches,
however if people prefer to see those on mm mailing list then i can keep
it cced.

This is also what i intend to use as a base for AMD and Intel patches
(v2 with more thing of some rfc which were already posted in the past).

[1] https://cgit.freedesktop.org/~glisse/linux/log/?h=odp-hmm
[2] https://cgit.freedesktop.org/~glisse/linux/log/?h=hmm-for-5.1

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: Dan Williams <dan.j.williams@intel.com>

Jérôme Glisse (10):
  mm/hmm: use reference counting for HMM struct
  mm/hmm: do not erase snapshot when a range is invalidated
  mm/hmm: improve and rename hmm_vma_get_pfns() to hmm_range_snapshot()
  mm/hmm: improve and rename hmm_vma_fault() to hmm_range_fault()
  mm/hmm: improve driver API to work and wait over a range
  mm/hmm: add default fault flags to avoid the need to pre-fill pfns
    arrays.
  mm/hmm: add an helper function that fault pages and map them to a
    device
  mm/hmm: support hugetlbfs (snap shoting, faulting and DMA mapping)
  mm/hmm: allow to mirror vma of a file on a DAX backed filesystem
  mm/hmm: add helpers for driver to safely take the mmap_sem

 include/linux/hmm.h |  290 ++++++++++--
 mm/hmm.c            | 1060 +++++++++++++++++++++++++++++--------------
 2 files changed, 983 insertions(+), 367 deletions(-)

-- 
2.17.2

