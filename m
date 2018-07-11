Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D468C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0109120652
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:50:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0109120652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732831AbeGKMyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 08:54:15 -0400
Received: from ozlabs.org ([203.11.71.1]:50399 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbeGKMyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 08:54:15 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41Qf6b58VSzB4MN;
        Wed, 11 Jul 2018 22:49:59 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     akpm@linux-foundation.org, broonie@kernel.org, mhocko@suse.cz,
        sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, bhe@redhat.com,
        pasha.tatashin@oracle.com,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Boot failures with "mm/sparse: Remove CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER" on powerpc (was Re: mmotm 2018-07-10-16-50 uploaded)
In-Reply-To: <20180710235044.vjlRV%akpm@linux-foundation.org>
References: <20180710235044.vjlRV%akpm@linux-foundation.org>
Date:   Wed, 11 Jul 2018 22:49:58 +1000
Message-ID: <87lgai9bt5.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

akpm@linux-foundation.org writes:
> The mm-of-the-moment snapshot 2018-07-10-16-50 has been uploaded to
>
>    http://www.ozlabs.org/~akpm/mmotm/
...

> * mm-sparse-add-a-static-variable-nr_present_sections.patch
> * mm-sparsemem-defer-the-ms-section_mem_map-clearing.patch
> * mm-sparsemem-defer-the-ms-section_mem_map-clearing-fix.patch
> * mm-sparse-add-a-new-parameter-data_unit_size-for-alloc_usemap_and_memmap.patch
> * mm-sparse-optimize-memmap-allocation-during-sparse_init.patch
> * mm-sparse-optimize-memmap-allocation-during-sparse_init-checkpatch-fixes.patch

> * mm-sparse-remove-config_sparsemem_alloc_mem_map_together.patch

This seems to be breaking my powerpc pseries qemu boots.

The boot log with some extra debug shows eg:

  $ make pseries_le_defconfig
  $ qemu-system-ppc64 -nographic -vga none -M pseries -m 2G -kernel vmlinux 
  ...
  vmemmap_populate f000000000000000..f000000000004000, node 0
        * f000000000000000..f000000001000000 allocated at c00000007e000000
  hash__vmemmap_create_mapping: start 0xf000000000000000 size 0x1000000 phys 0x7e000000
  vmemmap_populate f000000000000000..f000000000008000, node 0
        * f000000000000000..f000000001000000 allocated at c00000007d000000
  hash__vmemmap_create_mapping: start 0xf000000000000000 size 0x1000000 phys 0x7d000000
  vmemmap_populate f000000000000000..f00000000000c000, node 0
        * f000000000000000..f000000001000000 allocated at c00000007c000000
  hash__vmemmap_create_mapping: start 0xf000000000000000 size 0x1000000 phys 0x7c000000
  vmemmap_populate f000000000000000..f000000000010000, node 0
        * f000000000000000..f000000001000000 allocated at c00000007b000000
  hash__vmemmap_create_mapping: start 0xf000000000000000 size 0x1000000 phys 0x7b000000
  vmemmap_populate f000000000000000..f000000000014000, node 0
        * f000000000000000..f000000001000000 allocated at c00000007a000000
  hash__vmemmap_create_mapping: start 0xf000000000000000 size 0x1000000 phys 0x7a000000
  vmemmap_populate f000000000000000..f000000000018000, node 0
        * f000000000000000..f000000001000000 allocated at c000000079000000
  hash__vmemmap_create_mapping: start 0xf000000000000000 size 0x1000000 phys 0x79000000
  vmemmap_populate f000000000000000..f00000000001c000, node 0
        * f000000000000000..f000000001000000 allocated at c000000078000000
  hash__vmemmap_create_mapping: start 0xf000000000000000 size 0x1000000 phys 0x78000000
  vmemmap_populate f000000000000000..f000000000020000, node 0
        * f000000000000000..f000000001000000 allocated at c000000077000000
  hash__vmemmap_create_mapping: start 0xf000000000000000 size 0x1000000 phys 0x77000000
  vmemmap_populate f000000000000000..f000000000024000, node 0
        * f000000000000000..f000000001000000 allocated at c000000076000000
  hash__vmemmap_create_mapping: start 0xf000000000000000 size 0x1000000 phys 0x76000000
  hash__vmemmap_create_mapping: failed -1

  <repeated many times>

Then there's lots of other warnings about bad page states and eventually
a NULL deref and we panic().


The problem seems to be that we're calling down into
hash__vmemmap_create_mapping() for every call to vmemmap_populate(),
whereas previously we would only call hash__vmemmap_create_mapping()
once because our vmemmap_populated() would return true.

There's actually a comment in sparse_init() that says:

	 * powerpc need to call sparse_init_one_section right after each
	 * sparse_early_mem_map_alloc, so allocate usemap_map at first.

So changing that behaviour does seem to be the problem.

I assume that comment is talking about the fact that we use pfn_valid()
in vmemmap_populated().

I'm not clear on how to fix it though.

Any ideas?

cheers
