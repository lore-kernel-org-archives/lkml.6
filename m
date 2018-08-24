Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6DEC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E8D221557
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:24:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E8D221557
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbeHXT7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 15:59:39 -0400
Received: from mga07.intel.com ([134.134.136.100]:10948 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727626AbeHXT7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 15:59:38 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Aug 2018 09:24:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,283,1531810800"; 
   d="scan'208";a="256972621"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.132])
  by fmsmga005.fm.intel.com with ESMTP; 24 Aug 2018 09:24:08 -0700
Date:   Fri, 24 Aug 2018 09:24:08 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Borislav Petkov <bp@suse.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: SEV guest regression in 4.18
Message-ID: <20180824162408.GA5491@linux.intel.com>
References: <3d46f44c-dd78-8fa9-02ac-8206676ffde9@amd.com>
 <20180821151938.GA31212@nazgul.tnic>
 <92e2b80c-0dcc-94be-8d3a-5e11e5cf2370@amd.com>
 <20180822081417.GB4069@nazgul.tnic>
 <20180822150033.GA14200@linux.intel.com>
 <4d6ee892-a34f-28b3-18b7-1c663eb281c6@amd.com>
 <9635ebf0-7c99-6edf-1240-8dec28036a70@redhat.com>
 <20180823152907.GA1488@linux.intel.com>
 <60acb594-abe3-912f-9702-2f34961e575d@redhat.com>
 <c565ae1c-c2f0-8a43-b1f5-404c2efe7c56@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c565ae1c-c2f0-8a43-b1f5-404c2efe7c56@amd.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 10:41:27AM -0500, Brijesh Singh wrote:
> 
> 
> On 08/23/2018 11:16 AM, Paolo Bonzini wrote:
> >On 23/08/2018 17:29, Sean Christopherson wrote:
> >>On Thu, Aug 23, 2018 at 01:26:55PM +0200, Paolo Bonzini wrote:
> >>>On 22/08/2018 22:11, Brijesh Singh wrote:
> >>>>
> >>>>Yes, this is one of approach I have in mind. It will avoid splitting
> >>>>the larger pages; I am thinking that early in boot code we can lookup
> >>>>for this special section and decrypt it in-place and probably maps with
> >>>>C=0. Only downside, it will increase data section footprint a bit
> >>>>because we need to align this section to PM_SIZE.
> >>>
> >>>If you can ensure it doesn't span a PMD, maybe it does not need to be
> >>>aligned; you could establish a C=0 mapping of the whole 2M around it.
> >>
> >>Wouldn't that result in exposing/leaking whatever code/data happened
> >>to reside on the same 2M page (or corrupting it if the entire page
> >>isn't decrypted)?  Or are you suggesting that we'd also leave the
> >>encrypted mapping intact?
> >
> >Yes, exactly the latter, because...
> 
> 
> Hardware does not enforce coherency between the encrypted and
> unencrypted mapping for the same physical page. So, creating a
> two mapping of same physical address will lead a possible data
> corruption.

But couldn't we avoid corruption by ensuring data accessed via the
unencrypted mapping is cache line aligned and sized?  The CPU could
speculatively bring the encrypted version into the cache but it
should never get into a modified state (barring a software bug, but
that would be a problem regardless of encryption).

> Note, SME creates two mapping of the same physical address to perform
> in-place encryption of kernel and initrd images; this is a special case
> and APM documents steps on how to do this.
> 
> 
> >
> >>Does hardware include the C-bit in the cache tag?
> >
> >... the C-bit is effectively part of the physical address and hence of
> >the cache tag.  The kernel is already relying on this to properly
> >encrypt/decrypt pages, if I remember correctly.
> >
> >Paolo
> >
