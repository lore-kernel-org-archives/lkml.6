Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08911C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1C7F20836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:25:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1C7F20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966189AbeFSNZ5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:25:57 -0400
Received: from mga04.intel.com ([192.55.52.120]:55231 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937149AbeFSNZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:25:56 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2018 06:25:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,243,1526367600"; 
   d="scan'208";a="51105786"
Received: from aluisell-mobl2.ger.corp.intel.com (HELO localhost) ([10.249.254.128])
  by orsmga006.jf.intel.com with ESMTP; 19 Jun 2018 06:25:35 -0700
Date:   Tue, 19 Jun 2018 16:25:34 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        sean.j.christopherson@intel.com, nhorman@redhat.com,
        npmccallum@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>,
        "open list:INTEL SGX" <intel-sgx-kernel-dev@lists.01.org>
Subject: Re: [PATCH v11 08/13] x86, sgx: added ENCLS wrappers
Message-ID: <20180619132534.GE5609@linux.intel.com>
References: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com>
 <20180608171216.26521-9-jarkko.sakkinen@linux.intel.com>
 <ff75a95a-c1fc-dfb7-ae5e-146278bee2b6@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff75a95a-c1fc-dfb7-ae5e-146278bee2b6@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 10:43:50AM -0700, Dave Hansen wrote:
> On 06/08/2018 10:09 AM, Jarkko Sakkinen wrote:
> > This commit adds wrappers for Intel(R) SGX ENCLS opcode functionality.
> 
> What's ENCLS?  I know what an opcode is, but I don't know what "opcode
> functionality" is.  Could you give us more than a single, cryptic
> sentence, please?

Sure.

> > +enum sgx_commands {
> > +	ECREATE	= 0x0,
> > +	EADD	= 0x1,
> > +	EINIT	= 0x2,
> > +	EREMOVE	= 0x3,
> > +	EDGBRD	= 0x4,
> > +	EDGBWR	= 0x5,
> > +	EEXTEND	= 0x6,
> > +	ELDU	= 0x8,
> > +	EBLOCK	= 0x9,
> > +	EPA	= 0xA,
> > +	EWB	= 0xB,
> > +	ETRACK	= 0xC,
> > +	EAUG	= 0xD,
> > +	EMODPR	= 0xE,
> > +	EMODT	= 0xF,
> > +};
> 
> Again, please differentiate hardware-defined values from
> software-defines ones.  Also, would it hurt to expand the acronyms a
> bit, like:
> 
> +	ELDU	= 0x8, /* LoaD Underpants */

Not a bad idea at all.

> > +#define SGX_FN(name, params...)		\
> > +{					\
> > +	void *epc;			\
> > +	int ret;			\
> > +	epc = sgx_get_page(epc_page);	\
> > +	ret = __##name(params);		\
> > +	sgx_put_page(epc);		\
> > +	return ret;			\
> > +}
> 
> Have I seen sgx_*_page() yet in this series?  This seems out of order.

Oops, thanks for spotting this out.

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
> Wow, that's hideous.
> 
> Can't you just do:
> 
> BUILD_SGX_FN(__sgx_emopt, foo)
> 
> static inline int sgx_emodt(struct sgx_secinfo *secinfo,
> 			    struct sgx_epc_page *epc_page)
> {
> 	return __sgx_emopt(secinfo, page);
> }
> 
> Also, this entire patch seems rather comment-free.  Was that intentional?

Something that I've ignored (big series) but I'll add comments to
the next version.

/Jarkko
