Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FC2C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65907205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:27:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65907205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbeH3SaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:30:16 -0400
Received: from mga14.intel.com ([192.55.52.115]:48899 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729035AbeH3SaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:30:16 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2018 07:27:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,307,1531810800"; 
   d="scan'208";a="258514348"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 30 Aug 2018 07:27:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id EA4FA110; Thu, 30 Aug 2018 17:27:39 +0300 (EEST)
Date:   Thu, 30 Aug 2018 17:27:39 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>, tglx@linutronix.de,
        mingo@kernel.org, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH 0/3] Add restrictions for kexec/kdump jumping between
 5-level and 4-level kernel
Message-ID: <20180830142739.gfpa23nvex7xbkkf@black.fi.intel.com>
References: <20180829141624.13985-1-bhe@redhat.com>
 <20180830135855.rylamc7mx2ur3tab@kshutemo-mobl1>
 <20180830141202.GA14702@192.168.1.2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830141202.GA14702@192.168.1.2>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 02:12:02PM +0000, Baoquan He wrote:
> On 08/30/18 at 04:58pm, Kirill A. Shutemov wrote:
> > On Wed, Aug 29, 2018 at 10:16:21PM +0800, Baoquan He wrote:
> > > This was suggested by Kirill several months ago, I worked out several
> > > patches to fix, then interrupted by other issues. So sort them out
> > > now and post for reviewing.
> > 
> > Thanks for doing this.
> > 
> > > The current upstream kernel supports 5-level paging mode and supports
> > > dynamically choosing paging mode during bootup according to kernel
> > > image, hardware and kernel parameter setting. This flexibility brings
> > > several issues for kexec/kdump:
> > > 1)
> > > Switching between paging modes, requires changes into target kernel.
> > > It means you cannot kexec() 4-level paging kernel from 5-level paging
> > > kernel if 4-level paging kernel doesn't include changes. 
> > > 
> > > 2)
> > > Switching from 5-level paging to 4-level paging kernel would fail, if
> > > kexec() put kernel image above 64TiB of memory.
> > 
> > I'm not entirely sure that 64TiB is the limit here. Technically, 4-level
> > paging allows to address 256TiB in 1-to-1 mapping. We just don't have
> > machines with that wide physical address space (which don't support
> > 5-level paging too).
> 
> Hmm, afaik, the MAX_PHYSMEM_BITS limits the maximum address space
> which physical RAM can mapped to. We have 256TB for the whole address
> space for 4-level paging, that includes user space and kernel space,
> it might not allow 256TB entirely for the direct mapping.
> And the direct mapping is only for physical RAM mapping, and
> kexec/kdump only cares about the physical RAM space and load them
> inside.
> 
> # define MAX_PHYSMEM_BITS       (pgtable_l5_enabled() ? 52 : 46)
> 
> Not sure if my understanding is right, please correct me if I am wrong.

IIRC, we only care about the place kexec puts the kernel before it gets
decompressed. After the decompression kernel will be put into the right
spot.

Decompression is done in early boot where we use 1-to-1 mapping (not a
usual kernel virtual memory layout). All 256TiB should be reachable.

Said all that, I think it's safer to stick with 64TiB.

For the whole patcheset:

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
