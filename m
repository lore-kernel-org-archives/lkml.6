Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6034C1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7554A213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:13:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7554A213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389323AbeGKVUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 17:20:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55802 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388905AbeGKVT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 17:19:59 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7DC40E66;
        Wed, 11 Jul 2018 21:13:45 +0000 (UTC)
Date:   Wed, 11 Jul 2018 14:13:44 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     osalvador@techadventures.net, mpe@ellerman.id.au,
        broonie@kernel.org, mhocko@suse.cz,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-next@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, mm-commits@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, bhe@redhat.com,
        aneesh.kumar@linux.ibm.com, khandual@linux.vnet.ibm.com
Subject: Re: Boot failures with
 "mm/sparse: Remove CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER" on powerpc (was
 Re: mmotm 2018-07-10-16-50 uploaded)
Message-Id: <20180711141344.10eb6d22b0ee1423cc94faf8@linux-foundation.org>
In-Reply-To: <CAGM2reYsSi5kDGtnTQASnp1v49T8Y+9o_pNxmSq-+m68QhF2Tg@mail.gmail.com>
References: <20180710235044.vjlRV%akpm@linux-foundation.org>
        <87lgai9bt5.fsf@concordia.ellerman.id.au>
        <20180711133737.GA29573@techadventures.net>
        <CAGM2reYsSi5kDGtnTQASnp1v49T8Y+9o_pNxmSq-+m68QhF2Tg@mail.gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2018 09:55:59 -0400 Pavel Tatashin <pasha.tatashin@oracle.com> wrote:

> On Wed, Jul 11, 2018 at 9:37 AM Oscar Salvador
> <osalvador@techadventures.net> wrote:
> >
> > On Wed, Jul 11, 2018 at 10:49:58PM +1000, Michael Ellerman wrote:
> > > akpm@linux-foundation.org writes:
> > > > The mm-of-the-moment snapshot 2018-07-10-16-50 has been uploaded to
> > > >
> > > >    http://www.ozlabs.org/~akpm/mmotm/
> > > ...
> > >
> > > > * mm-sparse-add-a-static-variable-nr_present_sections.patch
> > > > * mm-sparsemem-defer-the-ms-section_mem_map-clearing.patch
> > > > * mm-sparsemem-defer-the-ms-section_mem_map-clearing-fix.patch
> > > > * mm-sparse-add-a-new-parameter-data_unit_size-for-alloc_usemap_and_memmap.patch
> > > > * mm-sparse-optimize-memmap-allocation-during-sparse_init.patch
> > > > * mm-sparse-optimize-memmap-allocation-during-sparse_init-checkpatch-fixes.patch
> > >
> > > > * mm-sparse-remove-config_sparsemem_alloc_mem_map_together.patch
> > >
> > > This seems to be breaking my powerpc pseries qemu boots.
> > >
> > > The boot log with some extra debug shows eg:
> > >
> > >   $ make pseries_le_defconfig
> >
> > Could you please share the config?
> > I was not able to find such config in the kernel tree.

(top-posting repaired so I can reply to your email, add other people
and not confuse the heck out of them.  Please don't)

> I am OK, if this patch is removed from Baoquan's series. But, I would
> still like to get rid of CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER, I
> can work on this in my sparse_init re-write series. ppc64 should
> really fallback safely to small chunks allocs, and if it does not
> there is some existing bug. Michael please send the config that you
> used.

OK, I shall drop
mm-sparse-remove-config_sparsemem_alloc_mem_map_together.patch for now.

