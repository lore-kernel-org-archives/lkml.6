Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F69C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 11:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF0232075E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 11:09:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF0232075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbeIDPeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 11:34:36 -0400
Received: from mga09.intel.com ([134.134.136.24]:22835 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbeIDPeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 11:34:36 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2018 04:09:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,329,1531810800"; 
   d="scan'208";a="87002770"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.32])
  by fmsmga001.fm.intel.com with ESMTP; 04 Sep 2018 04:09:54 -0700
Date:   Tue, 4 Sep 2018 14:09:52 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        sean.j.christopherson@intel.com, nhorman@redhat.com,
        npmccallum@redhat.com, linux-sgx@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, serge.ayoun@intel.com,
        suresh.b.siddha@intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v13 08/13] x86/sgx: Add wrappers for ENCLS leaf functions
Message-ID: <20180904110952.GD5423@linux.intel.com>
References: <20180827185507.17087-1-jarkko.sakkinen@linux.intel.com>
 <20180827185507.17087-9-jarkko.sakkinen@linux.intel.com>
 <CAHp75VdHmfx70=4jZnGZcgk5HTegDtizo7Uauk_bH43RpDXCfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdHmfx70=4jZnGZcgk5HTegDtizo7Uauk_bH43RpDXCfg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 06:01:26PM +0300, Andy Shevchenko wrote:
> On Mon, Aug 27, 2018 at 9:58 PM Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > Add wrappers for Intel(R) SGX ENCLS opcode leaf functions except
> > ENCLS(EINIT). ENCLS invokes privileged functions for managing (creation,
> > initialization and swapping) and debugging enclaves.
> 
> > +#define ENCLS_FAULT_FLAG 0x40000000UL
> > +#define ENCLS_FAULT_FLAG_ASM "$0x40000000"
> 
> Hmm... Why it can't have same name?
> 
> See, how _AC() macro is defined and being used.

Thanks, we'll migrate this to use _AC().

> > +#define ENCLS_TRAPNR(r) ((r) & ~ENCLS_FAULT_FLAG)
> 
> If result of macro is assigned to some variable and (r) by some reason
> is 32-bit type
> and you compile as 64-bit object, compiler will warn here.
> Please, check this is not the case in any of use of this macro.
> Otherwise you need a type casting, like
> 
> foo = bar & (u32)~BAR;
> 
> (or using typeof() might work)

Thanks for spotting this. I will check the use of this macro.

> 
> -- 
> With Best Regards,
> Andy Shevchenko

/Jarkko
