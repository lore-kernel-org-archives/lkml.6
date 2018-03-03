Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2878775-1520035985-2-10706085317276082782
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520035984; b=Lt+qEj/YQDuYORrNz+sLdiDPAbrqyIoA7LpZEwVElBy/vGE
    YWKgx2C/IfOD9shl5oHH1mmFWi3mSNgyY2octINusRDyO1DOcCsILzp6oE7E1iSm
    rkKIBskl1FE1DjwjAN+SbKvto0lhWKULJ3G2l+ucAwWM8q5RkSZuYA7FbLx90H5W
    f/NNJPd1mn3Ca/phDx/a45D5YMHkJErkIt5+ppJHFLPfxBjG0tVnuVPqz8YCVrLu
    ejnPlCUVXuhoK4VKs8hn9URG4xGtzdrnfu6oLrGe9oKnisVu8pX0ouil5NGiniwv
    e5WxZwBEUsn/fQoMHhzHcaNmXZQAOP+a1I5JfIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:sender:list-id;
    s=arctest; t=1520035984; bh=xB6pRsgRc49+EjPMij0auvk8rq69Pbju5U5
    h5a8R76k=; b=QpIRzz6EHrjLwc0OD6HRaCMVlwSHSkcjr7t0uH042C6WHa49R7P
    3Z2a5XjcH2a3YdmEltrJqbMnLR1TVng3cYOOWEb06sKirDRS/2dMsvEBDjQ379cY
    L2Zc2N1fv8jvdcWHeNUCeiipVycP1VdCP1/aw0Vb8sqWjpOJ5wp+IDXxuLW/TLZI
    +s7lNspebKa/7siuJyhrCNiH0pQqlRpTYMIEzmnzGALU5ULEXZdUxcceS2K/lRni
    7glzfQBSrLDFl0WA9iMQ4ThRMZchqCLWZiGD9rHFA5BOA1Ycqc48VIt/RGDogQag
    s7yMR8znIyoxrvUtAUgxsyA30pXwBs8TWYg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935272AbeCCAMv (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 19:12:51 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60916 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935239AbeCCAMt (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 2 Mar 2018 19:12:49 -0500
From: Daniel Vacek <neelx@redhat.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Daniel Vacek <neelx@redhat.com>, stable@vger.kernel.org
Subject: [PATCH v3 2/2] mm/page_alloc: fix memmap_init_zone pageblock alignment
Date: Sat,  3 Mar 2018 01:12:26 +0100
Message-Id: <0485727b2e82da7efbce5f6ba42524b429d0391a.1520011945.git.neelx@redhat.com>
In-Reply-To: <cover.1520011944.git.neelx@redhat.com>
References: <1519908465-12328-1-git-send-email-neelx@redhat.com>
 <cover.1520011944.git.neelx@redhat.com>
In-Reply-To: <cover.1520011944.git.neelx@redhat.com>
References: <cover.1520011944.git.neelx@redhat.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
where possible") introduced a bug where move_freepages() triggers a
VM_BUG_ON() on uninitialized page structure due to pageblock alignment.
To fix this, simply align the skipped pfns in memmap_init_zone()
the same way as in move_freepages_block().

>From one of the RHEL reports:

crash> log | grep -e BUG -e RIP -e Call.Trace -e move_freepages_block -e rmqueue -e freelist -A1
kernel BUG at mm/page_alloc.c:1389!
invalid opcode: 0000 [#1] SMP 
--
RIP: 0010:[<ffffffff8118833e>]  [<ffffffff8118833e>] move_freepages+0x15e/0x160
RSP: 0018:ffff88054d727688  EFLAGS: 00010087
--
Call Trace:
 [<ffffffff811883b3>] move_freepages_block+0x73/0x80
 [<ffffffff81189e63>] __rmqueue+0x263/0x460
 [<ffffffff8118c781>] get_page_from_freelist+0x7e1/0x9e0
 [<ffffffff8118caf6>] __alloc_pages_nodemask+0x176/0x420
--
RIP  [<ffffffff8118833e>] move_freepages+0x15e/0x160
 RSP <ffff88054d727688>

crash> page_init_bug -v | grep RAM
<struct resource 0xffff88067fffd2f8>          1000 -        9bfff	System RAM (620.00 KiB)
<struct resource 0xffff88067fffd3a0>        100000 -     430bffff	System RAM (  1.05 GiB = 1071.75 MiB = 1097472.00 KiB)
<struct resource 0xffff88067fffd410>      4b0c8000 -     4bf9cfff	System RAM ( 14.83 MiB = 15188.00 KiB)
<struct resource 0xffff88067fffd480>      4bfac000 -     646b1fff	System RAM (391.02 MiB = 400408.00 KiB)
<struct resource 0xffff88067fffd560>      7b788000 -     7b7fffff	System RAM (480.00 KiB)
<struct resource 0xffff88067fffd640>     100000000 -    67fffffff	System RAM ( 22.00 GiB)

crash> page_init_bug | head -6
<struct resource 0xffff88067fffd560>      7b788000 -     7b7fffff	System RAM (480.00 KiB)
<struct page 0xffffea0001ede200>   1fffff00000000  0 <struct pglist_data 0xffff88047ffd9000> 1 <struct zone 0xffff88047ffd9800> DMA32          4096    1048575
<struct page 0xffffea0001ede200> 505736 505344 <struct page 0xffffea0001ed8000> 505855 <struct page 0xffffea0001edffc0>
<struct page 0xffffea0001ed8000>                0  0 <struct pglist_data 0xffff88047ffd9000> 0 <struct zone 0xffff88047ffd9000> DMA               1       4095
<struct page 0xffffea0001edffc0>   1fffff00000400  0 <struct pglist_data 0xffff88047ffd9000> 1 <struct zone 0xffff88047ffd9800> DMA32          4096    1048575
BUG, zones differ!

Note that this range follows two not populated sections 68000000-77ffffff
in this zone. 7b788000-7b7fffff is the first one after a gap. This makes
memmap_init_zone() skip all the pfns up to the beginning of this range.
But this range is not pageblock (2M) aligned. In fact no range has to be.

crash> kmem -p 77fff000 78000000 7b5ff000 7b600000 7b787000 7b788000
      PAGE        PHYSICAL      MAPPING       INDEX CNT FLAGS
ffffea0001e00000  78000000                0        0  0 0
ffffea0001ed7fc0  7b5ff000                0        0  0 0
ffffea0001ed8000  7b600000                0        0  0 0	<<<<
ffffea0001ede1c0  7b787000                0        0  0 0
ffffea0001ede200  7b788000                0        0  1 1fffff00000000

Top part of page flags should contain nodeid and zonenr, which is not
the case for page ffffea0001ed8000 here (<<<<).

crash> log | grep -o fffea0001ed[^\ ]* | sort -u
fffea0001ed8000
fffea0001eded20
fffea0001edffc0

crash> bt -r | grep -o fffea0001ed[^\ ]* | sort -u
fffea0001ed8000
fffea0001eded00
fffea0001eded20
fffea0001edffc0

Initialization of the whole beginning of the section is skipped up to the
start of the range due to the commit b92df1de5d28. Now any code calling
move_freepages_block() (like reusing the page from a freelist as in this
example) with a page from the beginning of the range will get the page
rounded down to start_page ffffea0001ed8000 and passed to move_freepages()
which crashes on assertion getting wrong zonenr.

>         VM_BUG_ON(page_zone(start_page) != page_zone(end_page));

Note, page_zone() derives the zone from page flags here.


>From similar machine before commit b92df1de5d28:

crash> kmem -p 77fff000 78000000 7b5ff000 7b600000 7b7fe000 7b7ff000
      PAGE        PHYSICAL      MAPPING       INDEX CNT FLAGS
fffff73941e00000  78000000                0        0  1 1fffff00000000
fffff73941ed7fc0  7b5ff000                0        0  1 1fffff00000000
fffff73941ed8000  7b600000                0        0  1 1fffff00000000
fffff73941edff80  7b7fe000                0        0  1 1fffff00000000
fffff73941edffc0  7b7ff000 ffff8e67e04d3ae0     ad84  1 1fffff00020068 uptodate,lru,active,mappedtodisk

All the pages since the beginning of the section are initialized.
move_freepages()' not gonna blow up.

The same machine with this fix applied:

crash> kmem -p 77fff000 78000000 7b5ff000 7b600000 7b7fe000 7b7ff000
      PAGE        PHYSICAL      MAPPING       INDEX CNT FLAGS
ffffea0001e00000  78000000                0        0  0 0
ffffea0001e00000  7b5ff000                0        0  0 0
ffffea0001ed8000  7b600000                0        0  1 1fffff00000000
ffffea0001edff80  7b7fe000                0        0  1 1fffff00000000
ffffea0001edffc0  7b7ff000 ffff88017fb13720        8  2 1fffff00020068 uptodate,lru,active,mappedtodisk

At least the bare minimum of pages is initialized preventing the crash as well.


Fixes: b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns where possible")
Signed-off-by: Daniel Vacek <neelx@redhat.com>
Cc: stable@vger.kernel.org
---
 mm/page_alloc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f2c57da5bbe5..eb27ccb50928 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5359,9 +5359,14 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 			/*
 			 * Skip to the pfn preceding the next valid one (or
 			 * end_pfn), such that we hit a valid pfn (or end_pfn)
-			 * on our next iteration of the loop.
+			 * on our next iteration of the loop. Note that it needs
+			 * to be pageblock aligned even when the region itself
+			 * is not. move_freepages_block() can shift ahead of
+			 * the valid region but still depends on correct page
+			 * metadata.
 			 */
-			pfn = memblock_next_valid_pfn(pfn) - 1;
+			pfn = (memblock_next_valid_pfn(pfn) &
+					~(pageblock_nr_pages-1)) - 1;
 #endif
 			continue;
 		}
-- 
2.16.2
