Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753080AbeBVJPv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 04:15:51 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54446 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752892AbeBVJPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 04:15:50 -0500
Date: Thu, 22 Feb 2018 17:15:46 +0800
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org, dave.hansen@intel.com
Cc: linux-mm@kvack.org, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, mhocko@suse.com, tglx@linutronix.de
Subject: Re: [PATCH v2 0/3] mm/sparse: Optimize memmap allocation during
 sparse_init()
Message-ID: <20180222091546.GA693@localhost.localdomain>
References: <20180222091130.32165-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222091130.32165-1-bhe@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/22/18 at 05:11pm, Baoquan He wrote:
> This is v2 post. V1 can be found here:
> https://www.spinics.net/lists/linux-mm/msg144486.html
> 
> In sparse_init(), two temporary pointer arrays, usemap_map and map_map
> are allocated with the size of NR_MEM_SECTIONS. They are used to store
> each memory section's usemap and mem map if marked as present. In
> 5-level paging mode, this will cost 512M memory though they will be
> released at the end of sparse_init(). System with few memory, like
> kdump kernel which usually only has about 256M, will fail to boot
> because of allocation failure if CONFIG_X86_5LEVEL=y.
> 
> In this patchset, optimize the memmap allocation code to only use
> usemap_map and map_map with the size of nr_present_sections. This
> makes kdump kernel boot up with normal crashkernel='' setting when
> CONFIG_X86_5LEVEL=y.

Sorry, forgot adding the change log.

v1-v2:
  Split out the nr_present_sections adding as a single patch for easier
  reviewing.

  Rewrite patch log according to Dave's suggestion.

  Fix code bug in patch 0002 reported by test robot.

> 
> Baoquan He (3):
>   mm/sparse: Add a static variable nr_present_sections
>   mm/sparsemem: Defer the ms->section_mem_map clearing
>   mm/sparse: Optimize memmap allocation during sparse_init()
> 
>  mm/sparse-vmemmap.c |  9 +++++----
>  mm/sparse.c         | 54 +++++++++++++++++++++++++++++++++++------------------
>  2 files changed, 41 insertions(+), 22 deletions(-)
> 
> -- 
> 2.13.6
> 
