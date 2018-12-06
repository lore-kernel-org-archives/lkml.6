Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3882C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D6832081C
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:20:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D6832081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbeLFVUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:20:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49792 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbeLFVUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:20:31 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AD74C30001EA;
        Thu,  6 Dec 2018 21:20:31 +0000 (UTC)
Received: from sky.random (ovpn-122-73.rdu2.redhat.com [10.10.122.73])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E307B19C7B;
        Thu,  6 Dec 2018 21:20:28 +0000 (UTC)
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jann Horn <jannh@google.com>, Peter Xu <peterx@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH 0/1] userfaultfd: check VM_MAYWRITE was set after verifying the uffd is registered
Date:   Thu,  6 Dec 2018 16:20:27 -0500
Message-Id: <20181206212028.18726-1-aarcange@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 06 Dec 2018 21:20:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The juxtaposition with the other bugchecks didn't make it apparent
that the this WARN_ON was one line too soon.

An app trying to unregister a not-yet-registered range will trigger an
_harmless_ false positive WARN_ON. No real app would do that so it
went unnoticed during testing.

This should be applied on top of 29ec90660d68 ("userfaultfd:
shmem/hugetlbfs: only allow to register VM_MAYWRITE vmas") to shut off
the false positive warning.

Thanks,
Andrea

Andrea Arcangeli (1):
  userfaultfd: check VM_MAYWRITE was set after verifying the uffd is
    registered

 fs/userfaultfd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

