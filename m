Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753006AbeBVJLm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 04:11:42 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57822 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752643AbeBVJLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 04:11:41 -0500
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org, dave.hansen@intel.com
Cc: linux-mm@kvack.org, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, mhocko@suse.com, tglx@linutronix.de,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 0/3] mm/sparse: Optimize memmap allocation during sparse_init()
Date: Thu, 22 Feb 2018 17:11:27 +0800
Message-Id: <20180222091130.32165-1-bhe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v2 post. V1 can be found here:
https://www.spinics.net/lists/linux-mm/msg144486.html

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

Baoquan He (3):
  mm/sparse: Add a static variable nr_present_sections
  mm/sparsemem: Defer the ms->section_mem_map clearing
  mm/sparse: Optimize memmap allocation during sparse_init()

 mm/sparse-vmemmap.c |  9 +++++----
 mm/sparse.c         | 54 +++++++++++++++++++++++++++++++++++------------------
 2 files changed, 41 insertions(+), 22 deletions(-)

-- 
2.13.6
