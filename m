Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61494C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 15:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19ECA20671
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 15:29:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19ECA20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbeHWS7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 14:59:34 -0400
Received: from mga02.intel.com ([134.134.136.20]:52097 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbeHWS7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 14:59:33 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Aug 2018 08:29:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,278,1531810800"; 
   d="scan'208";a="79516833"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.132])
  by fmsmga002.fm.intel.com with ESMTP; 23 Aug 2018 08:29:07 -0700
Date:   Thu, 23 Aug 2018 08:29:07 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Borislav Petkov <bp@suse.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: SEV guest regression in 4.18
Message-ID: <20180823152907.GA1488@linux.intel.com>
References: <20ad6cd5-394c-d3ae-d99c-b656d7ef8293@amd.com>
 <20180821083911.GF24940@nazgul.tnic>
 <3d46f44c-dd78-8fa9-02ac-8206676ffde9@amd.com>
 <20180821151938.GA31212@nazgul.tnic>
 <92e2b80c-0dcc-94be-8d3a-5e11e5cf2370@amd.com>
 <20180822081417.GB4069@nazgul.tnic>
 <20180822150033.GA14200@linux.intel.com>
 <4d6ee892-a34f-28b3-18b7-1c663eb281c6@amd.com>
 <9635ebf0-7c99-6edf-1240-8dec28036a70@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9635ebf0-7c99-6edf-1240-8dec28036a70@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 01:26:55PM +0200, Paolo Bonzini wrote:
> On 22/08/2018 22:11, Brijesh Singh wrote:
> > 
> > Yes, this is one of approach I have in mind. It will avoid splitting
> > the larger pages; I am thinking that early in boot code we can lookup
> > for this special section and decrypt it in-place and probably maps with
> > C=0. Only downside, it will increase data section footprint a bit
> > because we need to align this section to PM_SIZE.
> 
> If you can ensure it doesn't span a PMD, maybe it does not need to be
> aligned; you could establish a C=0 mapping of the whole 2M around it.

Wouldn't that result in exposing/leaking whatever code/data happened
to reside on the same 2M page (or corrupting it if the entire page
isn't decrypted)?  Or are you suggesting that we'd also leave the
encrypted mapping intact?  If it's the latter...

Does hardware include the C-bit in the cache tag?  I.e are the C=0 and
C=1 variations of the same PA treated as different cache lines?  If
so, we could also treat the unencrypted variation as a separate PA by
defining it to be (ACTUAL_PA | (1 << x86_phys_bits)), (re)adjusting
x86_phys_bits if necessary to get the kernel to allow the address.
init_memory_mapping() could then alias every PA with an unencrypted
VA mapping, which would allow the kernel to access any PA unencrypted
by using virt_to_phys() and phys_to_virt() to translate an encrypted
VA to an unencrypted VA.  It would mean doubling INIT_PGD_PAGE_COUNT,
but that'd be a one-time cost regardless of how many pages needed to
be accessed with C=0.

> Paolo
