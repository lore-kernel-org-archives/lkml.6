Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEEBC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6FC025DF8
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:14:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6FC025DF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933512AbeFYQOV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 12:14:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50882 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752330AbeFYQOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 12:14:19 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6044840711A9;
        Mon, 25 Jun 2018 16:14:18 +0000 (UTC)
Received: from hmswarspite.think-freely.org (ovpn-121-117.rdu2.redhat.com [10.10.121.117])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0A6682026D5B;
        Mon, 25 Jun 2018 16:14:17 +0000 (UTC)
Date:   Mon, 25 Jun 2018 12:14:16 -0400
From:   Neil Horman <nhorman@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        x86@kernel.org, platform-driver-x86@vger.kernel.org,
        dave.hansen@intel.com, npmccallum@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>,
        "open list:INTEL SGX" <intel-sgx-kernel-dev@lists.01.org>
Subject: Re: [PATCH v11 09/13] x86, sgx: basic routines for enclave page cache
Message-ID: <20180625161416.GC18878@hmswarspite.think-freely.org>
References: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com>
 <20180608171216.26521-10-jarkko.sakkinen@linux.intel.com>
 <1529500871.9779.58.camel@intel.com>
 <b8ea3787ae99637a8aae286ff90ac6889d8b55f4.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8ea3787ae99637a8aae286ff90ac6889d8b55f4.camel@linux.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 25 Jun 2018 16:14:18 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 25 Jun 2018 16:14:18 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'nhorman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 12:21:22PM +0300, Jarkko Sakkinen wrote:
> On Wed, 2018-06-20 at 06:21 -0700, Sean Christopherson wrote:
> > On Fri, 2018-06-08 at 19:09 +0200, Jarkko Sakkinen wrote:
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
> > > 
> > > Each subsystem that uses SGX must provide a set of callbacks for EPC
> > > pages that are used to reclaim, block and write an EPC page. Kernel
> > > takes the responsibility of maintaining LRU cache for them.
> > > 
> > > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > ---
> > >  arch/x86/include/asm/sgx.h      |  67 +++++
> > >  arch/x86/include/asm/sgx_arch.h | 224 ++++++++++++++++
> > >  arch/x86/kernel/cpu/intel_sgx.c | 443 +++++++++++++++++++++++++++++++-
> > >  3 files changed, 732 insertions(+), 2 deletions(-)
> > >  create mode 100644 arch/x86/include/asm/sgx_arch.h
> > 
> > ...
> > 
> > > +struct sgx_pcmd {
> > > +	struct sgx_secinfo secinfo;
> > > +	uint64_t enclave_id;
> > > +	uint8_t reserved[40];
> > > +	uint8_t mac[16];
> > > +};
> > 
> > sgx_pcmd has a 128-byte alignment requirement.  I think it's
> > worth specifying here as sgx_pcmd is small enough that it could
> > be put on the stack, e.g. by KVM when trapping and executing
> > ELD* on behalf of a guest VM.
> > 
> > In fact, it probably makes sense to add alightment attributes
> > to all SGX structs for self-documentation purposes, even though
> > many of them will never be allocated statically or on the stack.
> 
> I agree with this. It also documents stuff so that you don't have
> to look it up from the SDM.
> 
> Neil: this should also clear your concerns.
> 
Agreed
Neil

> /Jarkko
