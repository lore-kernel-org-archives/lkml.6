Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFB2C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15BE2218FC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbfAaShQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 13:37:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55440 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725777AbfAaShQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 13:37:16 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8EEC4CCB60;
        Thu, 31 Jan 2019 18:37:15 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BBCCD19492;
        Thu, 31 Jan 2019 18:37:13 +0000 (UTC)
From:   jglisse@redhat.com
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Michal Hocko <mhocko@kernel.org>, kvm@vger.kernel.org
Subject: [RFC PATCH 0/4] Restore change_pte optimization to its former glory
Date:   Thu, 31 Jan 2019 13:37:02 -0500
Message-Id: <20190131183706.20980-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 31 Jan 2019 18:37:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

This patchset is on top of my patchset to add context information to
mmu notifier [1] you can find a branch with everything [2]. I have not
tested it but i wanted to get the discussion started. I believe it is
correct but i am not sure what kind of kvm test i can run to exercise
this.

The idea is that since kvm will invalidate the secondary MMUs within
invalidate_range callback then the change_pte() optimization is lost.
With this patchset everytime core mm is using set_pte_at_notify() and
thus change_pte() get calls then we can ignore the invalidate_range
callback altogether and only rely on change_pte callback.

Note that this is only valid when either going from a read and write
pte to a read only pte with same pfn, or from a read only pte to a
read and write pte with different pfn. The other side of the story
is that the primary mmu pte is clear with ptep_clear_flush_notify
before the call to change_pte.

Also with the mmu notifier context information [1] you can further
optimize other cases like mprotect or write protect when forking. You
can use the new context information to infer that the invalidation is
for read only update of the primary mmu and update the secondary mmu
accordingly instead of clearing it and forcing fault even for read
access. I do not know if that is an optimization that would bear any
fruit for kvm. It does help for device driver. You can also optimize
the soft dirty update.

Cheers,
Jérôme


[1] https://lore.kernel.org/linux-fsdevel/20190123222315.1122-1-jglisse@redhat.com/T/#m69e8f589240e18acbf196a1c8aa1d6fc97bd3565
[2] https://cgit.freedesktop.org/~glisse/linux/log/?h=kvm-restore-change_pte

Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <mawilcox@microsoft.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: kvm@vger.kernel.org

Jérôme Glisse (4):
  uprobes: use set_pte_at() not set_pte_at_notify()
  mm/mmu_notifier: use unsigned for event field in range struct
  mm/mmu_notifier: set MMU_NOTIFIER_USE_CHANGE_PTE flag where
    appropriate
  kvm/mmu_notifier: re-enable the change_pte() optimization.

 include/linux/mmu_notifier.h | 21 +++++++++++++++++++--
 kernel/events/uprobes.c      |  3 +--
 mm/ksm.c                     |  6 ++++--
 mm/memory.c                  |  3 ++-
 virt/kvm/kvm_main.c          | 16 ++++++++++++++++
 5 files changed, 42 insertions(+), 7 deletions(-)

-- 
2.17.1

