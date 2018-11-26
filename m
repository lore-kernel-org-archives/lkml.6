Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A86C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6649820862
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:35:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6649820862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbeK0E3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 23:29:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43500 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726781AbeK0E3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 23:29:45 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 198D8307EA83;
        Mon, 26 Nov 2018 17:34:58 +0000 (UTC)
Received: from sky.random (ovpn-120-160.rdu2.redhat.com [10.10.120.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 45DCE1057FA2;
        Mon, 26 Nov 2018 17:34:53 +0000 (UTC)
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jann Horn <jannh@google.com>, Peter Xu <peterx@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH 0/5] userfaultfd shmem updates
Date:   Mon, 26 Nov 2018 12:34:47 -0500
Message-Id: <20181126173452.26955-1-aarcange@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Mon, 26 Nov 2018 17:34:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Jann found two bugs in the userfaultfd shmem MAP_SHARED backend: the
lack of the VM_MAYWRITE check and the lack of i_size checks.

Then looking into the above we also fixed the MAP_PRIVATE case.

Hugh by source review also found a data loss source if UFFDIO_COPY is
used on shmem MAP_SHARED PROT_READ mappings (the production usages
incidentally run with PROT_READ|PROT_WRITE, so the data loss couldn't
happen in those production usages like with QEMU).

The whole patchset is marked for stable.

We verified QEMU postcopy live migration with guest running on shmem
MAP_PRIVATE run as well as before after the fix of shmem
MAP_PRIVATE. Regardless if it's shmem or hugetlbfs or MAP_PRIVATE or
MAP_SHARED, QEMU unconditionally invokes a punch hole if the guest
mapping is filebacked and a MADV_DONTNEED too (needed to get rid of
the MAP_PRIVATE COWs and for the anon backend).

Thank you,
Andrea

Andrea Arcangeli (5):
  userfaultfd: use ENOENT instead of EFAULT if the atomic copy user
    fails
  userfaultfd: shmem: allocate anonymous memory for MAP_PRIVATE shmem
  userfaultfd: shmem/hugetlbfs: only allow to register VM_MAYWRITE vmas
  userfaultfd: shmem: add i_size checks
  userfaultfd: shmem: UFFDIO_COPY: set the page dirty if VM_WRITE is not
    set

 fs/userfaultfd.c | 15 ++++++++++++
 mm/hugetlb.c     |  2 +-
 mm/shmem.c       | 31 +++++++++++++++++++++---
 mm/userfaultfd.c | 62 +++++++++++++++++++++++++++++++++++-------------
 4 files changed, 90 insertions(+), 20 deletions(-)

