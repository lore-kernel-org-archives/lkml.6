Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1970EC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBAF323F7D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:33:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBAF323F7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752709AbeGDRdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 13:33:42 -0400
Received: from mga11.intel.com ([192.55.52.93]:36083 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752277AbeGDRdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 13:33:40 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2018 10:33:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,306,1526367600"; 
   d="scan'208";a="68694930"
Received: from saamir-mobl.ger.corp.intel.com (HELO localhost) ([10.252.34.242])
  by fmsmga004.fm.intel.com with ESMTP; 04 Jul 2018 10:33:34 -0700
Date:   Wed, 4 Jul 2018 20:33:33 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com,
        linux-sgx@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 08/13] x86/sgx: wrappers for ENCLS opcode leaf
 functions
Message-ID: <20180704173333.GI6724@linux.intel.com>
References: <20180703182118.15024-1-jarkko.sakkinen@linux.intel.com>
 <20180703182118.15024-9-jarkko.sakkinen@linux.intel.com>
 <alpine.DEB.2.21.1807032149300.1816@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1807032149300.1816@nanos.tec.linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 10:16:12PM +0200, Thomas Gleixner wrote:
> On Tue, 3 Jul 2018, Jarkko Sakkinen wrote:
> 
> > This commit adds wrappers for Intel(R) SGX ENCLS opcode leaf functions
> 
> Add...
> 
> > except for ENCLS(EINIT). The ENCLS instruction invokes the privileged
> > functions for managing (creation, initialization and swapping) and
> > debugging enclaves.
> >  
> > +#define IS_ENCLS_FAULT(r) ((r) & 0xffff0000)
> > +#define ENCLS_FAULT_VECTOR(r) ((r) >> 16)
> > +
> > +#define ENCLS_TO_ERR(r) (IS_ENCLS_FAULT(r) ? -EFAULT :		\
> > +			(r) == SGX_UNMASKED_EVENT ? -EINTR :	\
> > +			(r) == SGX_MAC_COMPARE_FAIL ? -EIO :	\
> > +			(r) == SGX_ENTRYEPOCH_LOCKED ? -EBUSY : -EPERM)
> 
> Inlines please along with proper comments.
> 
> > +#define __encls_ret_N(rax, inputs...)			\
> > +	({						\
> > +	int ret;					\
> > +	asm volatile(					\
> > +	"1: .byte 0x0f, 0x01, 0xcf;\n\t"		\
> > +	"2:\n"						\
> > +	".section .fixup,\"ax\"\n"			\
> > +	"3: shll $16,%%eax\n"				\
> 
> SHLL ??? _All_ the macro maze needs proper comments.

Yeah, agreed.

> > +	"   jmp 2b\n"					\
> > +	".previous\n"					\
> > +	_ASM_EXTABLE_FAULT(1b, 3b)			\
> > +	: "=a"(ret)					\
> > +	: "a"(rax), inputs				\
> > +	: "memory");					\
> > +	ret;						\
> > +	})
> 
> ....
> 
> > +static inline int __emodt(struct sgx_secinfo *secinfo, void *epc)
> > +{
> > +	return __encls_ret_2(EMODT, secinfo, epc);
> > +}
> > +
> >  #define SGX_MAX_EPC_BANKS 8
> >  
> >  #define SGX_EPC_BANK(epc_page) \
> > @@ -39,4 +190,29 @@ extern bool sgx_lc_enabled;
> >  void *sgx_get_page(struct sgx_epc_page *ptr);
> >  void sgx_put_page(void *epc_page_ptr);
> 
> > +#define SGX_FN(name, params...)		\
> > +{					\
> > +	void *epc;			\
> > +	int ret;			\
> > +	epc = sgx_get_page(epc_page);	\
> > +	ret = __##name(params);		\
> > +	sgx_put_page(epc);		\
> 
> This whole get/put magic is totally pointless. The stuff is 64bit only, so
> all it needs is the address, because 'put' is a noop on 64bit.

I did some early/proto versions of SGX code with 32-bit environment. I
guess it is better to strip this stuff simply off.

> 
> > +	return ret;			\
> > +}
> > +
> > +#define BUILD_SGX_FN(fn, name)				\
> > +static inline int fn(struct sgx_epc_page *epc_page)	\
> > +	SGX_FN(name, epc)
> > +BUILD_SGX_FN(sgx_eremove, eremove)
> > +BUILD_SGX_FN(sgx_eblock, eblock)
> > +BUILD_SGX_FN(sgx_etrack, etrack)
> > +BUILD_SGX_FN(sgx_epa, epa)
> > +
> > +static inline int sgx_emodpr(struct sgx_secinfo *secinfo,
> > +			     struct sgx_epc_page *epc_page)
> > +	SGX_FN(emodpr, secinfo, epc)
> > +static inline int sgx_emodt(struct sgx_secinfo *secinfo,
> > +			    struct sgx_epc_page *epc_page)
> > +	SGX_FN(emodt, secinfo, epc)
> 
> Bah this is really unreadable crap. What's so horribly wrong with writing
> this simply as:
> 
> static inline int sgx_eremove(struct sgx_epc_page *epc_page)
> {
> 	return __encls_ret_1(EREMOVE, epc_page_addr(epc_page));
> }
> 
> static inline int sgx_emodt(struct sgx_secinfo *secinfo,
> 			    struct sgx_epc_page *epc_page)
> {
> 	return __encls_ret_2(EREMOVE, secinfo, epc_page_addr(epc_page));
> }
> 
> instead of all these completely pointless meta functions and build macro
> maze around it.
> 
> Why? Because then every function which is actually used in code has a
> proper prototype instead of nongrepable magic and a gazillion of wrappers.

I do agree with you as I would NAK this kind of code from TPM
because this is basically stuff that needs to be written only once
(maybe some minor fixes later on but anyway) and after that the
unrolled form is easier to maintain and debug.

I will do as you adviced.

> Thanks,
> 
> 	tglx

Thank you!

/Jarkko
