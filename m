Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03180ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 16:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B61D820869
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 16:04:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B61D820869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbeJTALc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 20:11:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56990 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbeJTALb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 20:11:31 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 545FB356F0;
        Fri, 19 Oct 2018 16:04:48 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-124-217.rdu2.redhat.com [10.10.124.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A9F0665314;
        Fri, 19 Oct 2018 16:04:47 +0000 (UTC)
From:   jglisse@redhat.com
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>
Subject: [PATCH 0/6] HMM updates, improvements and fixes v2
Date:   Fri, 19 Oct 2018 12:04:36 -0400
Message-Id: <20181019160442.18723-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 19 Oct 2018 16:04:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

[Andrew this is for 4.20, stable fixes as cc to stable]

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

Jérôme Glisse (4):
  mm/hmm: fix utf8 ...
  mm/hmm: properly handle migration pmd v3
  mm/hmm: use a structure for update callback parameters v2
  mm/hmm: invalidate device page table at start of invalidation

Ralph Campbell (2):
  mm/rmap: map_pte() was not handling private ZONE_DEVICE page properly
    v3
  mm/hmm: fix race between hmm_mirror_unregister() and mmu_notifier
    callback

 include/linux/hmm.h  |  33 +++++++----
 mm/hmm.c             | 134 +++++++++++++++++++++++++++++--------------
 mm/page_vma_mapped.c |  24 +++++++-
 3 files changed, 137 insertions(+), 54 deletions(-)

-- 
2.17.2

