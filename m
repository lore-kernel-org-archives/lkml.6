Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74A4C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 22:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B7C927F4F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 22:40:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B7C927F4F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936511AbeF2Wkj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 18:40:39 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:58951 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932511AbeF2Wki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 18:40:38 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0T3dXmHm_1530312021;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T3dXmHm_1530312021)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 30 Jun 2018 06:40:29 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     mhocko@kernel.org, willy@infradead.org, ldufour@linux.vnet.ibm.com,
        akpm@linux-foundation.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, tglx@linutronix.de,
        hpa@zytor.com
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC v3 PATCH 0/5] mm: zap pages with read mmap_sem in munmap for large mapping
Date:   Sat, 30 Jun 2018 06:39:40 +0800
Message-Id: <1530311985-31251-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Background:
Recently, when we ran some vm scalability tests on machines with large memory,
we ran into a couple of mmap_sem scalability issues when unmapping large memory
space, please refer to https://lkml.org/lkml/2017/12/14/733 and
https://lkml.org/lkml/2018/2/20/576.


History:
Then akpm suggested to unmap large mapping section by section and drop mmap_sem
at a time to mitigate it (see https://lkml.org/lkml/2018/3/6/784).

V1 patch series was submitted to the mailing list per Andrew’s suggestion
(see https://lkml.org/lkml/2018/3/20/786). Then I received a lot great feedback
and suggestions.

Then this topic was discussed on LSFMM summit 2018. In the summit, Michal Hock
suggested (also in the v1 patches review) to try "two phases" approach. Zapping
pages with read mmap_sem, then doing via cleanup with write mmap_sem (for
discussion detail, see https://lwn.net/Articles/753269/)


Changelog:
v2 —> v3:
* Refactor do_munmap code to extract the common part per Peter's sugestion
* Introduced VM_DEAD flag per Michal's suggestion. Just handled VM_DEAD in 
  x86's page fault handler for the time being. Other architectures will be covered
  once the patch series is reviewed
* Now lookup vma (find and split) and set VM_DEAD flag with write mmap_sem, then
  zap mapping with read mmap_sem, then clean up pgtables and vmas with write
  mmap_sem per Peter's suggestion

v1 —> v2:
* Re-implemented the code per the discussion on LSFMM summit

 
Regression and performance data:
Test is run on a machine with 32 cores of E5-2680 @ 2.70GHz and 384GB memory

Regression test with full LTP and trinity (munmap) with setting thresh to 4K in
the code (just for regression test only) so that the new code can be covered
better and trinity (munmap) test manipulates 4K mapping.

No regression issue is reported and the system survives under trinity (munmap)
test for 4 hours until I abort the test.

Throughput of page faults (#/s) with the below stress-ng test:
stress-ng --mmap 0 --mmap-bytes 80G --mmap-file --metrics --perf
--timeout 600s
        pristine         patched          delta
       89.41K/sec       97.29K/sec        +8.8%

The result is not very stable, and depends on timing. So, this is just for reference.


Yang Shi (5):
      uprobes: make vma_has_uprobes non-static
      mm: introduce VM_DEAD flag
      mm: refactor do_munmap() to extract the common part
      mm: mmap: zap pages with read mmap_sem for large mapping
      x86: check VM_DEAD flag in page fault

 arch/x86/mm/fault.c     |   4 ++
 include/linux/mm.h      |   6 +++
 include/linux/uprobes.h |   7 +++
 kernel/events/uprobes.c |   2 +-
 mm/mmap.c               | 243 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------
 5 files changed, 224 insertions(+), 38 deletions(-)

