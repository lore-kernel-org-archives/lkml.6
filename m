Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D05AC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAB1C2081C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BZzTAZOw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAB1C2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726041AbeLCXuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 18:50:21 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35356 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbeLCXuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 18:50:21 -0500
Received: by mail-pl1-f194.google.com with SMTP id p8so7300293plo.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 15:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=s73rrbIqaGFAevBl97sdq7eBRxeTo50uEC9Ji1MJ3AI=;
        b=BZzTAZOwijagSpqR2Ov38mgVq1VJf/q0Vv7qsZXJ+dvf//UAxWEK4DV4Ai18C2Xn/H
         invB9kwL7MK8rltZR4g6G6RA3SwM5lKlOHxY+lV/+YTw7tmlIwxJGlyXSv+4gN3HLlsN
         x5SNvEtRhQIvU3icI1sdGcuT/MAUzQrNonr+RHLMZjKpgxXAtJA4SMUgh2hv2JY1WEU0
         uK/nOWjSQrQfsK9BUp7pZ9cbsx9JYnAKmbdekGc/ZSd8Bzo1hP1tLzj/W92GqbCW0/i9
         3H9nQGBV3zFY0pHrT3e6PSN7bs7w9mKUbhNS2jNPnfE9Fkmk8RjAlP0sYv4v2GcdIkcg
         0ChQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=s73rrbIqaGFAevBl97sdq7eBRxeTo50uEC9Ji1MJ3AI=;
        b=SAYrJeKSDZEmGhI+0o/ILl8Qfz57jQuznwlSAhByBX2d9NWQaUuWQVKet7ZAXTML9r
         raZvHhpP8KE7ASQljTj3Eyi3WQ77RILLdkosmYPoIF/O+ldJq8JxigsDUgPBi1gfMhZd
         Fd09Tc2S2eGxInv1L4B6Pr/ySwNCp92xYhmC8vHpVn0lO4mfSp1dHaydngi7F52Y5rbZ
         YqsmzotOeYRw7mIJKiH32UgLAW8yJlgo2Bq2sGb3HzBpIPuYJmX2Uj/i25A0dfmJcVtg
         Vii96aFkce+Viy6UqLsubMXd0TVglqEN/us1M9bTPLtOzcT/AYW8IkGk0EfV7/yQh4ML
         elNw==
X-Gm-Message-State: AA+aEWZAgObSxu7oofGfXXzQLRIA6O1D/3EVnYAhFPGzb7DMLpGb8I3b
        Vlp4IfLHDA/I0rUI/GBjtPpHUg==
X-Google-Smtp-Source: AFSGD/VFWXzylVtLqquv1gk++wC/EZzp4vMBxaWkQgFBOAYJOVNAZK54xKkTvP0s9oj32+w6Y48hBg==
X-Received: by 2002:a17:902:6b46:: with SMTP id g6mr17961735plt.21.1543881020481;
        Mon, 03 Dec 2018 15:50:20 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id n70sm20485960pfi.185.2018.12.03.15.50.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 15:50:19 -0800 (PST)
Date:   Mon, 3 Dec 2018 15:50:18 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>
cc:     ying.huang@intel.com, Michal Hocko <mhocko@suse.com>,
        s.priebe@profihost.ag, mgorman@techsingularity.net,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu, Vlastimil Babka <vbabka@suse.cz>
Subject: [patch 0/2 for-4.20] mm, thp: fix remote access and allocation
 regressions
Message-ID: <alpine.DEB.2.21.1812031545080.161134@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a 13.9% of remote memory access regression and 40% remote
memory allocation regression on Haswell when the local node is fragmented
for hugepage sized pages and memory is being faulted with either the thp
defrag setting of "always" or has been madvised with MADV_HUGEPAGE.

The usecase that initially identified this issue were binaries that mremap
their .text segment to be backed by transparent hugepages on startup.
They do mmap(), madvise(MADV_HUGEPAGE), memcpy(), and mremap().

This requires a full revert and partial revert of commits merged during
the 4.20 rc cycle.  The full revert, of ac5b2c18911f ("mm: thp: relax
__GFP_THISNODE for MADV_HUGEPAGE mappings"), was anticipated to fix large
amounts of swap activity on the local zone when faulting hugepages by
falling back to remote memory.  This remote allocation causes the access
regression and, if fragmented, the allocation regression.

This patchset also fixes that issue by not attempting direct reclaim at
all when compaction fails to free a hugepage.  Note that if remote memory
was also low or fragmented that ac5b2c18911f ("mm: thp: relax
__GFP_THISNODE for MADV_HUGEPAGE mappings") would only have compounded the
problem it attempts to address by now thrashing all nodes instead of only
the local node.

The reverts for the stable trees will be different: just a straight revert
of commit ac5b2c18911f ("mm: thp: relax __GFP_THISNODE for MADV_HUGEPAGE
mappings") is likely needed.

Cross compiled for architectures with thp support and thp enabled:
arc (with ISA_ARCV2), arm (with ARM_LPAE), arm64, i386, mips64, powerpc, 
s390, sparc, x86_64.

Andrea, is this acceptable?
---
 drivers/gpu/drm/ttm/ttm_page_alloc.c     |    8 +++---
 drivers/gpu/drm/ttm/ttm_page_alloc_dma.c |    3 --
 include/linux/gfp.h                      |    3 +-
 include/linux/mempolicy.h                |    2 -
 mm/huge_memory.c                         |   41 +++++++++++--------------------
 mm/mempolicy.c                           |    7 +++--
 mm/page_alloc.c                          |   16 ++++++++++++
 7 files changed, 42 insertions(+), 38 deletions(-)
