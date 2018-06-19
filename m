Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47194C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B76D20652
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:19:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B76D20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937915AbeFSPTi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:19:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54068 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S937471AbeFSPTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:19:36 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B75A88780F;
        Tue, 19 Jun 2018 15:19:35 +0000 (UTC)
Received: from neilslaptop.think-freely.org (wlan-196-105.bos.redhat.com [10.16.196.105])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3BDC42026D68;
        Tue, 19 Jun 2018 15:19:34 +0000 (UTC)
Date:   Tue, 19 Jun 2018 11:19:33 -0400
From:   Neil Horman <nhorman@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org,
        sean.j.christopherson@intel.com, npmccallum@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>,
        "open list:INTEL SGX" <intel-sgx-kernel-dev@lists.01.org>
Subject: Re: [PATCH v11 09/13] x86, sgx: basic routines for enclave page cache
Message-ID: <20180619151933.GD3666@neilslaptop.think-freely.org>
References: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com>
 <20180608171216.26521-10-jarkko.sakkinen@linux.intel.com>
 <3c1b04d6-6e93-efaa-1890-101b7fd9784c@intel.com>
 <20180619145753.GB8034@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619145753.GB8034@linux.intel.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 19 Jun 2018 15:19:35 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 19 Jun 2018 15:19:35 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'nhorman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 05:57:53PM +0300, Jarkko Sakkinen wrote:
> On Fri, Jun 08, 2018 at 11:24:12AM -0700, Dave Hansen wrote:
> > On 06/08/2018 10:09 AM, Jarkko Sakkinen wrote:
> > > SGX has a set of data structures to maintain information about the enclaves
> > > and their security properties. BIOS reserves a fixed size region of
> > > physical memory for these structures by setting Processor Reserved Memory
> > > Range Registers (PRMRR). This memory area is called Enclave Page Cache
> > > (EPC).
> > > 
> > > This commit implements the basic routines to allocate and free pages from
> > > different EPC banks. There is also a swapper thread ksgxswapd for EPC pages
> > > that gets woken up by sgx_alloc_page() when we run below the low watermark.
> > > The swapper thread continues swapping pages up until it reaches the high
> > > watermark.
> > 
> > Yay!  A new memory manager in arch-specific code.
> > 
> > > Each subsystem that uses SGX must provide a set of callbacks for EPC
> > > pages that are used to reclaim, block and write an EPC page. Kernel
> > > takes the responsibility of maintaining LRU cache for them.
> > 
> > What does a "subsystem that uses SGX" mean?  Do we have one of those
> > already?
> 
> Driver and KVM.
> 
> > > +struct sgx_secs {
> > > +	uint64_t size;
> > > +	uint64_t base;
> > > +	uint32_t ssaframesize;
> > > +	uint32_t miscselect;
> > > +	uint8_t reserved1[SGX_SECS_RESERVED1_SIZE];
> > > +	uint64_t attributes;
> > > +	uint64_t xfrm;
> > > +	uint32_t mrenclave[8];
> > > +	uint8_t reserved2[SGX_SECS_RESERVED2_SIZE];
> > > +	uint32_t mrsigner[8];
> > > +	uint8_t	reserved3[SGX_SECS_RESERVED3_SIZE];
> > > +	uint16_t isvvprodid;
> > > +	uint16_t isvsvn;
> > > +	uint8_t reserved4[SGX_SECS_RESERVED4_SIZE];
> > > +};
> > 
> > This is a hardware structure, right?  Doesn't it need to be packed?
> 
> Everything is aligned properly in this struct.
> 
I don't think you can guarantee that.  I understand that the reserved size is
likely computed to turn those u8's into 32/64 byte regions, but the uint16t
isvvprodid and isvsvn might get padded to 32 or 64 bytes in software dependent
on the processor you build for.

And even so, its suceptible to being
misaligned if a new version of the hardware adds or removes elements.  Adding a
packed attribute seems like a safe approach (or at least a no-op in the current
state)

Neil
