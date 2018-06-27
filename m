Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5075AC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 01:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1C8D26944
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 01:48:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1C8D26944
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754597AbeF0BsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 21:48:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43098 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753213AbeF0BsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 21:48:02 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 84A9081A8E54;
        Wed, 27 Jun 2018 01:48:01 +0000 (UTC)
Received: from localhost (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8880B1C66B;
        Wed, 27 Jun 2018 01:48:00 +0000 (UTC)
Date:   Wed, 27 Jun 2018 09:47:57 +0800
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, pagupta@redhat.com
Cc:     linux-mm@kvack.org, kirill.shutemov@linux.intel.com
Subject: Re: [PATCH v5 0/4] mm/sparse: Optimize memmap allocation during
 sparse_init()
Message-ID: <20180627014757.GC8970@localhost.localdomain>
References: <20180627013116.12411-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627013116.12411-1-bhe@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 27 Jun 2018 01:48:01 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 27 Jun 2018 01:48:01 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/27/18 at 09:31am, Baoquan He wrote:
> This is v4 post. V3 can be found here:
> https://lkml.org/lkml/2018/2/27/928

Sorry, forgot updating this part.

This is v5 post, v4 can be found here:
http://lkml.kernel.org/r/20180521101555.25610-1-bhe@redhat.com

> 
> V1 can be found here:
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
> 
> Change log:
> v4->v5:
>   Improve patch 3/4 log according to Dave's suggestion.
> 
>   Correct the wrong copy&paste of making 'nr_consumed_maps' to
>   'alloc_usemap_and_memmap' mistakenly which is pointed out by
>   Dave in patch 4/4 code comment.
> 
>   Otherwise, no code change in this version.
> v3->v4:
>   Improve according to Dave's three concerns which are in patch 0004:
> 
>   Rename variable 'idx_present' to 'nr_consumed_maps' which used to
>   index the memmap and usemap of present sections.
> 
>   Add a check if 'nr_consumed_maps' goes beyond nr_present_sections.
> 
>   Add code comment above the final for_each_present_section_nr() to
>   tell why 'nr_consumed_maps' need be increased in each iteration
>   whether the 'ms->section_mem_map' need cleared or out.
> 
> v2->v3:
>   Change nr_present_sections as __initdata and add code comment
>   according to Andrew's suggestion.
> 
>   Change the local variable 'i' as idx_present which loops over the
>   present sections, and improve the code. These are suggested by
>   Dave and Pankaj.
> 
>   Add a new patch 0003 which adds a new parameter 'data_unit_size'
>   to function alloc_usemap_and_memmap() in which we will update 'data'
>   to make it point at new position. However its type 'void *' can't give
>   us needed info to do that. Need pass the unit size in. So change code
>   in patch 0004 accordingly. This is a code bug fix found when tested
>   the memory deployed on multiple nodes.
> 
> v1-v2:
>   Split out the nr_present_sections adding as a single patch for easier
>   reviewing.
> 
>   Rewrite patch log according to Dave's suggestion.
> 
>   Fix code bug in patch 0002 reported by test robot.
> 
> Baoquan He (4):
>   mm/sparse: Add a static variable nr_present_sections
>   mm/sparsemem: Defer the ms->section_mem_map clearing
>   mm/sparse: Add a new parameter 'data_unit_size' for
>     alloc_usemap_and_memmap
>   mm/sparse: Optimize memmap allocation during sparse_init()
> 
>  mm/sparse-vmemmap.c |  6 ++---
>  mm/sparse.c         | 72 +++++++++++++++++++++++++++++++++++++++++------------
>  2 files changed, 59 insertions(+), 19 deletions(-)
> 
> -- 
> 2.13.6
> 
