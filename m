Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A53DC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 06:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2261226FB7
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 06:29:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2261226FB7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753631AbeF1G3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 02:29:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59114 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751466AbeF1G3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 02:29:06 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7936540255D7;
        Thu, 28 Jun 2018 06:29:05 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 99BF62156880;
        Thu, 28 Jun 2018 06:29:00 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, pagupta@redhat.com,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Oscar Salvador <osalvador@techadventures.net>
Cc:     linux-mm@kvack.org, kirill.shutemov@linux.intel.com,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v6 0/5] mm/sparse: Optimize memmap allocation during sparse_init()
Date:   Thu, 28 Jun 2018 14:28:52 +0800
Message-Id: <20180628062857.29658-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 28 Jun 2018 06:29:05 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 28 Jun 2018 06:29:05 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v6 post.

In sparse_init(), two temporary pointer arrays, usemap_map and map_map
are allocated with the size of NR_MEM_SECTIONS. They are used to store
each memory section's usemap and mem map if marked as present. In
5-level paging mode, this will cost 512M memory though they will be
released at the end of sparse_init(). System with few memory, like
kdump kernel which usually only has about 256M, will fail to boot
because of allocation failure if CONFIG_X86_5LEVEL=y.

In this patchset, optimize the memmap allocation code to only use
usemap_map and map_map with the size of nr_present_sections. This
makes kdump kernel boot up with normal crashkernel='' setting when
CONFIG_X86_5LEVEL=y.

The old version can be found below:

v5:
http://lkml.kernel.org/r/20180627013116.12411-1-bhe@redhat.com
v4:
http://lkml.kernel.org/r/20180521101555.25610-1-bhe@redhat.com

v3:
https://lkml.org/lkml/2018/2/27/928

V1 can be found here:
https://www.spinics.net/lists/linux-mm/msg144486.html

Change log:
v5->v6:
  Oscar found the redundant "struct mem_section *ms" definition and
  in the old patch 2/4, after deferring the clearing of section_mem_map.
  Clean them up in this version.

  Pavel pointed out that allocating memmap together for one node at
  one time should be a default behaviour for all ARCH-es. And if failed
  on large memory, it will drop to the fallback to allocate memmap
  for one section at one time, it shoult not break anything. Add
  patch 5/5 to remove CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER and clean
  up the related codes.
v4->v5:
  Improve patch 3/4 log according to Dave's suggestion.

  Correct the wrong copy&paste of making 'nr_consumed_maps' to
  'alloc_usemap_and_memmap' mistakenly which is pointed out by
  Dave in patch 4/4 code comment.

  Otherwise, no code change in this version.
v3->v4:
  Improve according to Dave's three concerns which are in patch 0004:

  Rename variable 'idx_present' to 'nr_consumed_maps' which used to
  index the memmap and usemap of present sections.

  Add a check if 'nr_consumed_maps' goes beyond nr_present_sections.

  Add code comment above the final for_each_present_section_nr() to
  tell why 'nr_consumed_maps' need be increased in each iteration
  whether the 'ms->section_mem_map' need cleared or out.

v2->v3:
  Change nr_present_sections as __initdata and add code comment
  according to Andrew's suggestion.

  Change the local variable 'i' as idx_present which loops over the
  present sections, and improve the code. These are suggested by
  Dave and Pankaj.

  Add a new patch 0003 which adds a new parameter 'data_unit_size'
  to function alloc_usemap_and_memmap() in which we will update 'data'
  to make it point at new position. However its type 'void *' can't give
  us needed info to do that. Need pass the unit size in. So change code
  in patch 0004 accordingly. This is a code bug fix found when tested
  the memory deployed on multiple nodes.

v1-v2:
  Split out the nr_present_sections adding as a single patch for easier
  reviewing.

  Rewrite patch log according to Dave's suggestion.

  Fix code bug in patch 0002 reported by test robot.

Baoquan He (5):
  mm/sparse: Add a static variable nr_present_sections
  mm/sparsemem: Defer the ms->section_mem_map clearing
  mm/sparse: Add a new parameter 'data_unit_size' for
    alloc_usemap_and_memmap
  mm/sparse: Optimize memmap allocation during sparse_init()
  mm/sparse: Remove CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER

 mm/Kconfig          |   4 --
 mm/sparse-vmemmap.c |   9 ++---
 mm/sparse.c         | 109 ++++++++++++++++++++++++++++------------------------
 3 files changed, 62 insertions(+), 60 deletions(-)

-- 
2.13.6

