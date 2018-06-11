Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id UGHqMTSUHlvAKgAAmS7hNA
	; Mon, 11 Jun 2018 15:24:46 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4EBE4607A4; Mon, 11 Jun 2018 15:24:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id CC64960385;
	Mon, 11 Jun 2018 15:24:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CC64960385
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932770AbeFKPYn (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 11:24:43 -0400
Received: from mga12.intel.com ([192.55.52.136]:3969 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932533AbeFKPYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 11:24:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2018 08:24:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,502,1520924400";
   d="scan'208";a="46263737"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.135])
  by fmsmga007.fm.intel.com with ESMTP; 11 Jun 2018 08:24:41 -0700
Message-ID: <1528730681.9779.42.camel@intel.com>
Subject: Re: [PATCH v11 06/13] crypto: aesni: add minimal build option for
 SGX LE
From: Sean Christopherson <sean.j.christopherson@intel.com>
To: Dave Hansen <dave.hansen@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        x86@kernel.org, platform-driver-x86@vger.kernel.org
Cc: nhorman@redhat.com, npmccallum@redhat.com,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:CRYPTO API" <linux-crypto@vger.kernel.org>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
        <linux-kernel@vger.kernel.org>
Date: Mon, 11 Jun 2018 08:24:41 -0700
In-Reply-To: <00750c65-27b5-7851-19f5-9a712686dfb2@intel.com>
References: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com>
         <20180608171216.26521-7-jarkko.sakkinen@linux.intel.com>
         <00750c65-27b5-7851-19f5-9a712686dfb2@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-06-08 at 10:27 -0700, Dave Hansen wrote:
> On 06/08/2018 10:09 AM, Jarkko Sakkinen wrote:
> > 
> > --- a/arch/x86/crypto/aesni-intel_asm.S
> > +++ b/arch/x86/crypto/aesni-intel_asm.S
> > @@ -45,6 +45,8 @@
> >  #define MOVADQ	movaps
> >  #define MOVUDQ	movups
> >  
> > +#ifndef AESNI_INTEL_MINIMAL
> > +
> >  #ifdef __x86_64__
> >  
> >  # constants in mergeable sections, linker can reorder and merge
> > @@ -133,6 +135,8 @@ ALL_F:      .octa 0xffffffffffffffffffffffffffffffff
> >  #define keysize 2*15*16(%arg1)
> >  #endif
> >  
> > +#endif /* AESNI_INTEL_MINIMAL */
> > +
> I'd really prefer that these get moved into a separate file rather than
> a scattered set of #ifdefs.  This just seem fragile to me.
> 
> Can we have a "aesni-intel_asm-minimal.S"?  Or, at least bunch the
> minimal set of things *together*?

A separate file doesn't seem appropriate because there is no criteria
for including code in the "minimal" build beyond "this code happens to
be needed by SGX".  I considered having SGX somewhere in the define
but opted for AESNI_INTEL_MINIMAL on the off chance that the minimal
build was useful for something other than SGX.

I'm not opposed to bunching the minimal stuff together, my intent was
simply to disturb the code as little as possible.
