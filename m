Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EEEC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76B9225687
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:16:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76B9225687
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754889AbeFYJQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 05:16:09 -0400
Received: from mga18.intel.com ([134.134.136.126]:47736 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754683AbeFYJQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 05:16:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2018 02:16:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,269,1526367600"; 
   d="scan'208";a="52654289"
Received: from jsakkine-mobl1.tm.intel.com (HELO sfriis-mobl.ger.corp.intel.com) ([10.237.50.42])
  by orsmga006.jf.intel.com with ESMTP; 25 Jun 2018 02:16:04 -0700
Message-ID: <b9c2c1866be84dc96ce1186c5242820f290517e0.camel@linux.intel.com>
Subject: Re: [PATCH v11 08/13] x86, sgx: added ENCLS wrappers
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        x86@kernel.org, platform-driver-x86@vger.kernel.org
Cc:     dave.hansen@intel.com, nhorman@redhat.com, npmccallum@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>,
        "open list:INTEL SGX" <intel-sgx-kernel-dev@lists.01.org>
Date:   Mon, 25 Jun 2018 12:16:03 +0300
In-Reply-To: <1529500355.9779.51.camel@intel.com>
References: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com>
         <20180608171216.26521-9-jarkko.sakkinen@linux.intel.com>
         <1529500355.9779.51.camel@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-06-20 at 06:12 -0700, Sean Christopherson wrote:
> On Fri, 2018-06-08 at 19:09 +0200, Jarkko Sakkinen wrote:
> > This commit adds wrappers for Intel(R) SGX ENCLS opcode functionality.
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > ---
> >  arch/x86/include/asm/sgx.h | 198 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 198 insertions(+)
> > 
> > diff --git a/arch/x86/include/asm/sgx.h b/arch/x86/include/asm/sgx.h
> > index fa3e6e0eb8af..a2f727f85b91 100644
> > --- a/arch/x86/include/asm/sgx.h
> > +++ b/arch/x86/include/asm/sgx.h
> > @@ -10,6 +10,10 @@
> >  #ifndef _ASM_X86_SGX_H
> >  #define _ASM_X86_SGX_H
> >  
> > +#include <asm/sgx_arch.h>
> > +#include <asm/asm.h>
> > +#include <linux/bitops.h>
> > +#include <linux/err.h>
> >  #include <linux/types.h>
> >  
> >  #define SGX_CPUID 0x12
> > @@ -20,6 +24,200 @@ enum sgx_cpuid {
> >  	SGX_CPUID_EPC_BANKS	= 2,
> >  };
> >  
> > +enum sgx_commands {
> 
> This should be something like "sgx_encls_leafs" and probably moved
> to sgx_arch.h (as Dave alluded to, these are architectural values).
> "sgx_commands" is not accurate (they're only the cpl0 "commands")
> and will have collision issues in the future, e.g. with the ENCLV
> instruction and its leafs.
> 
> > +	ECREATE	= 0x0,
> > +	EADD	= 0x1,
> > +	EINIT	= 0x2,
> > +	EREMOVE	= 0x3,
> > +	EDGBRD	= 0x4,
> > +	EDGBWR	= 0x5,
> > +	EEXTEND	= 0x6,
> 
> Even though it's not used in the code (yet...), I think ELDB,
> leaf 0x7, should be defined here for completeness.

Sure.

/Jarkko
