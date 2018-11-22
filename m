Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82922C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E91320645
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:21:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E91320645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403855AbeKVL54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 06:57:56 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:47426 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403829AbeKVL5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 06:57:55 -0500
Received: from localhost.localdomain (c-24-6-170-16.hsd1.ca.comcast.net [24.6.170.16])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 455D59D;
        Thu, 22 Nov 2018 01:20:58 +0000 (UTC)
Date:   Wed, 21 Nov 2018 17:20:55 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     stable@vger.kernel.org, Balbir Singh <bsingharora@gmail.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>,
        =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@suse.com>, torvalds@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v8 0/7] mm: Merge hmm into devm_memremap_pages, mark
 GPL-only
Message-Id: <20181121172055.91dc52fc0b985be85e640328@linux-foundation.org>
In-Reply-To: <154275556908.76910.8966087090637564219.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <154275556908.76910.8966087090637564219.stgit@dwillia2-desk3.amr.corp.intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Nov 2018 15:12:49 -0800 Dan Williams <dan.j.williams@intel.com> wrote:

> Changes since v7 [1]:
> At Maintainer Summit, Greg brought up a topic I proposed around
> EXPORT_SYMBOL_GPL usage. The motivation was considerations for when
> EXPORT_SYMBOL_GPL is warranted and the criteria for taking the
> exceptional step of reclassifying an existing export. Specifically, I
> wanted to make the case that although the line is fuzzy and hard to
> specify in abstract terms, it is nonetheless clear that
> devm_memremap_pages() and HMM (Heterogeneous Memory Management) have
> crossed it. The devm_memremap_pages() facility should have been
> EXPORT_SYMBOL_GPL from the beginning, and HMM as a derivative of that
> functionality should have naturally picked up that designation as well.
> 
> Contrary to typical rules, the HMM infrastructure was merged upstream
> with zero in-tree consumers. There was a promise at the time that those
> users would be merged "soon", but it has been over a year with no drivers
> arriving. While the Nouveau driver is about to belatedly make good on
> that promise it is clear that HMM was targeted first and foremost at an
> out-of-tree consumer.
> 
> HMM is derived from devm_memremap_pages(), a facility Christoph and I
> spearheaded to support persistent memory. It combines a device lifetime
> model with a dynamically created 'struct page' / memmap array for any
> physical address range. It enables coordination and control of the many
> code paths in the kernel built to interact with memory via 'struct page'
> objects. With HMM the integration goes even deeper by allowing device
> drivers to hook and manipulate page fault and page free events.
> 
> One interpretation of when EXPORT_SYMBOL is suitable is when it is
> exporting stable and generic leaf functionality.  The
> devm_memremap_pages() facility continues to see expanding use cases,
> peer-to-peer DMA being the most recent, with no clear end date when it
> will stop attracting reworks and semantic changes. It is not suitable to
> export devm_memremap_pages() as a stable 3rd party driver API due to the
> fact that it is still changing and manipulates core behavior. Moreover,
> it is not in the best interest of the long term development of the core
> memory management subsystem to permit any external driver to effectively
> define its own system-wide memory management policies with no
> encouragement to engage with upstream.
> 
> I am also concerned that HMM was designed in a way to minimize further
> engagement with the core-MM. That, with these hooks in place,
> device-drivers are free to implement their own policies without much
> consideration for whether and how the core-MM could grow to meet that
> need. Going forward not only should HMM be EXPORT_SYMBOL_GPL, but the
> core-MM should be allowed the opportunity and stimulus to change and
> address these new use cases as first class functionality.
> 

The arguments are compelling.  I apologize for not thinking of and/or
not being made aware of them at the time.

I'll take [7/7] (with all the above added to the changelog) with a view
to a 4.21-rc1 merge.  That gives us a couple of months for further
discussion.  Public discussion, please.

It should be noted that [7/7] has a cc:stable.
