Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85CCECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE35820825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:52:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE35820825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbeKIC2l convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 21:28:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:49364 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726862AbeKIC2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 21:28:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6A50FAFF4;
        Thu,  8 Nov 2018 16:52:18 +0000 (UTC)
Date:   Thu, 8 Nov 2018 17:52:17 +0100
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Huacai Chen <chenhc@lemote.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, rppt@linux.vnet.ibm.com
Subject: Re: [[PATCH]] mips: Fix switch to NO_BOOTMEM for SGI-IP27/loongons3
 NUMA
Message-Id: <20181108175217.f55065d6115edbafd6aa3487@suse.de>
In-Reply-To: <20181108161823.GB15707@rapoport-lnx>
References: <20181108144428.28149-1-tbogendoerfer@suse.de>
        <20181108161823.GB15707@rapoport-lnx>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Nov 2018 18:18:23 +0200
Mike Rapoport <rppt@linux.ibm.com> wrote:

> On Thu, Nov 08, 2018 at 03:44:28PM +0100, Thomas Bogendoerfer wrote:
> > Commit bcec54bf3118 ("mips: switch to NO_BOOTMEM") broke SGI-IP27
> > and NUMA enabled loongson3 by doing memblock_set_current_limit()
> > before max_low_pfn has been evaluated. Both platforms need to do the
> > memblock_set_current_limit() in platform specific code. For
> > consistency the call to memblock_set_current_limit() is moved
> > to the common bootmem_init(), where max_low_pfn is calculated
> > for non NUMA enabled platforms.
> [..]
> 
> As for SGI-IP27, the initialization of max_low_pfn as late as in
> paging_init() seems to be broken because it's value is used in
> arch_mem_init() and in finalize_initrd() anyway.

well, the patch is tested on real hardware and the first caller of
a memblock_alloc* function is in a function called by free_area_init_nodes().

> AFAIU, both platforms set max_low_pfn to last available pfn, so it seems we
> can simply do
> 
> 	max_low_pfn = PFN_PHYS(memblock_end_of_DRAM())
> 
> in the prom_meminit() function for both platforms and drop the loop
> evaluating max_low_pfn in paging_init().

sounds like a better plan. I'll prepare a new patch.

Thomas.

-- 
SUSE Linux GmbH
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
