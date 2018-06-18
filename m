Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2350C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 23:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64EDB20693
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 23:34:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64EDB20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937042AbeFRXep (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 19:34:45 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:42827 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S937024AbeFRXeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 19:34:44 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07402;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0T2yMyYn_1529364870;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T2yMyYn_1529364870)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 19 Jun 2018 07:34:36 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     mhocko@kernel.org, willy@infradead.org, ldufour@linux.vnet.ibm.com,
        akpm@linux-foundation.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC v2 0/2] mm: zap pages with read mmap_sem in munmap for large mapping
Date:   Tue, 19 Jun 2018 07:34:14 +0800
Message-Id: <1529364856-49589-1-git-send-email-yang.shi@linux.alibaba.com>
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

So, I came up with the V2 patch series per this suggestion. Here I don't call
madvise(MADV_DONTNEED) directly since it is a little different from what munmap
does, so I use unmap_region() as what do_munmap() does.
The patches may need more cleanup and refactor, but it sounds better to let the
community start review the patches early to make sure I'm on the right track.


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

The number looks a little bit better than v1.


Yang Shi (2):
      uprobes: make vma_has_uprobes non-static
      mm: mmap: zap pages with read mmap_sem for large mapping

 include/linux/uprobes.h |   7 ++++
 kernel/events/uprobes.c |   2 +-
 mm/mmap.c               | 148 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 155 insertions(+), 2 deletions(-)
