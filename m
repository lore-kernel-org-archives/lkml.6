Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DC7C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 19:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F7CA208EB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 19:26:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F7CA208EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbeHXXBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 19:01:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53312 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726617AbeHXXBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 19:01:49 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 323A2804B9F4;
        Fri, 24 Aug 2018 19:25:52 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-122-125.rdu2.redhat.com [10.10.122.125])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B377D2026D6D;
        Fri, 24 Aug 2018 19:25:51 +0000 (UTC)
From:   jglisse@redhat.com
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>
Subject: [PATCH 0/7] HMM updates, improvements and fixes
Date:   Fri, 24 Aug 2018 15:25:42 -0400
Message-Id: <20180824192549.30844-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 24 Aug 2018 19:25:52 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 24 Aug 2018 19:25:52 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jglisse@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

Few fixes that only affect HMM users. Improve the synchronization call
back so that we match was other mmu_notifier listener do and add proper
support to the new blockable flags in the process.

For curious folks here are branches to leverage HMM in various existing
device drivers:

https://cgit.freedesktop.org/~glisse/linux/log/?h=hmm-nouveau-v01
https://cgit.freedesktop.org/~glisse/linux/log/?h=hmm-radeon-v00
https://cgit.freedesktop.org/~glisse/linux/log/?h=hmm-intel-v00

More to come (amd gpu, Mellanox, ...)

I expect more of the preparatory work for nouveau will be merge in 4.20
(like we have been doing since 4.16) and i will wait until this patchset
is upstream before pushing the patches that actualy make use of HMM (to
avoid complex tree inter-dependency).

Jérôme Glisse (5):
  mm/hmm: fix utf8 ...
  mm/hmm: properly handle migration pmd
  mm/hmm: use a structure for update callback parameters
  mm/hmm: invalidate device page table at start of invalidation
  mm/hmm: proper support for blockable mmu_notifier

Ralph Campbell (2):
  mm/rmap: map_pte() was not handling private ZONE_DEVICE page properly
  mm/hmm: fix race between hmm_mirror_unregister() and mmu_notifier
    callback

 include/linux/hmm.h  |  37 +++++++----
 mm/hmm.c             | 150 ++++++++++++++++++++++++++++++-------------
 mm/page_vma_mapped.c |   9 +++
 3 files changed, 142 insertions(+), 54 deletions(-)

-- 
2.17.1

