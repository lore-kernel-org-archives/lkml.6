Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C50BC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 13:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1A0321770
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 13:38:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1A0321770
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389253AbeHGPwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 11:52:45 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40278 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732639AbeHGPwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 11:52:45 -0400
Received: by mail-wr1-f67.google.com with SMTP id h15-v6so15828966wrs.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 06:38:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ziiB6gTLMB/9gD7iUir7Jkrz77ZVyEAUugNoYTMtqI4=;
        b=lIrMDQXstWLxIJneYuhq5qzWmo7GENJjou1mPfUtqxuj6aVU9u1Hyk6vhmKzVOUYRx
         hz5jpXmV7eEjlUPjdbvpiyh0qyKN0JXgG7bPx8aG0CxV/r5E1/+8GBBQqWvE9hYhUXk2
         xq7ELKYvqEOtAatrbgpe2vuwpar7IztifKSzATfl/9WmYhwSLisKXj+tALq75T9wRrYf
         QAYKfiLjg0EZkjGEI+pJ+MzDgE8xrsLeE8MGcWbQCL1gRJN7CkoitKSVTXbG1reXspmW
         /1DfmikW8hFriw4ZyLjnJlfMUwW0t3Z165f8+kms0VcsxNdyiNmw77T2dAcRm2U+haqc
         MOpw==
X-Gm-Message-State: AOUpUlHYOeS6uopWdquRPn7l404v5zZEguoq+TE/qNglYH9Oggh59k3Z
        DXKCT/96b90fgOJ00aGz4yI=
X-Google-Smtp-Source: AAOMgpf7fANP11lgrtFRUP6qFhGyNJ80bMVAfpO2UeBXljkJsx2B6Nn95d1BiwfehPXjAcyBCp1u1Q==
X-Received: by 2002:adf:dd07:: with SMTP id a7-v6mr13300491wrm.2.1533649101248;
        Tue, 07 Aug 2018 06:38:21 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id f17-v6sm1015503wrs.1.2018.08.07.06.38.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 06:38:20 -0700 (PDT)
Received: from d104.suse.de (charybdis-ext.suse.de [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id A6174124545;
        Tue,  7 Aug 2018 15:38:19 +0200 (CEST)
From:   osalvador@techadventures.net
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, dan.j.williams@intel.com,
        pasha.tatashin@oracle.com, jglisse@redhat.com, david@redhat.com,
        yasu.isimatu@gmail.com, logang@deltatee.com, dave.jiang@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>
Subject: [RFC PATCH 0/3] Do not touch pages in remove_memory path
Date:   Tue,  7 Aug 2018 15:37:54 +0200
Message-Id: <20180807133757.18352-1-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

This tries to fix [1], which was reported by David Hildenbrand, and also
does some cleanups/refactoring.

I am sending this as RFC to see if the direction I am going is right before
spending more time into it.
And also to gather feedback about hmm/zone_device stuff.
The code compiles and I tested it successfully with normal memory-hotplug operations.

Here we go:

With the following scenario:

1) We add memory
2) We do not online it
3) We remove the memory

an invalid access is being made to those pages.

The reason is that the pages are initialized in online_pages() path:

        /   online_pages
        |    move_pfn_range
ONLINE  |     move_pfn_range_to_zone
PAGES   |      ...
        |      memmap_init_zone

But depending on our policy about onlining the pages by default, we might not
online them right after having added the memory, and so, those pages might be
left unitialized.

This is a problem because we access those pages in arch_remove_memory:

...
if (altmap)
        page += vmem_altmap_offset(altmap);
        zone = page_zone(page);
...

So we are accessing unitialized data basically.


Currently, we need to have the zone from arch_remove_memory to all the way down
because

1) we call __remove_zone zo shrink spanned pages from pgdat/zone
2) we get the pgdat from the zone

Number 1 can be fixed by moving __remove_zone back to offline_pages(), where it should be.
This, besides fixing the bug, will make the code more consistent because all the reveserse
operations from online_pages() will be made in offline_pages().

Number 2 can be fixed by passing nid instead of zone.

The tricky part of all this is the hmm code and the zone_device stuff.

Fixing the calls to arch_remove_memory in the arch code is easy, but arch_remove_memory
is being used in:

kernel/memremap.c: devm_memremap_pages_release()
mm/hmm.c:          hmm_devmem_release()

I did my best to get my head around this, but my knowledge in that area is 0, so I am pretty sure
I did not get it right.

The thing is:

devm_memremap_pages(), which is the counterpart of devm_memremap_pages_release(),
calls arch_add_memory(), and then calls move_pfn_range_to_zone() (to ZONE_DEVICE).
So it does not go through online_pages().
So there I call shrink_pages() (it does pretty much as __remove_zone) before calling
to arch_remove_memory.
But as I said, I do now if that is right.

[1] https://patchwork.kernel.org/patch/10547445/

Oscar Salvador (3):
  mm/memory_hotplug: Add nid parameter to arch_remove_memory
  mm/memory_hotplug: Create __shrink_pages and move it to offline_pages
  mm/memory_hotplug: Refactor shrink_zone/pgdat_span

 arch/ia64/mm/init.c            |   6 +-
 arch/powerpc/mm/mem.c          |  13 +--
 arch/s390/mm/init.c            |   2 +-
 arch/sh/mm/init.c              |   6 +-
 arch/x86/mm/init_32.c          |   6 +-
 arch/x86/mm/init_64.c          |  10 +--
 include/linux/memory_hotplug.h |   8 +-
 kernel/memremap.c              |   9 +-
 mm/hmm.c                       |   6 +-
 mm/memory_hotplug.c            | 190 +++++++++++++++++++++--------------------
 mm/sparse.c                    |   4 +-
 11 files changed, 127 insertions(+), 133 deletions(-)

-- 
2.13.6

