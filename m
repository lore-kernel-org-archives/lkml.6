Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF521C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FF0C20867
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:18:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FF0C20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbeICXjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 19:39:37 -0400
Received: from mga03.intel.com ([134.134.136.65]:3636 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727955AbeICXjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 19:39:36 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2018 12:18:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,326,1531810800"; 
   d="scan'208";a="80568132"
Received: from fonsecan-mobl.ger.corp.intel.com (HELO localhost) ([10.249.36.49])
  by orsmga003.jf.intel.com with ESMTP; 03 Sep 2018 12:17:57 -0700
Date:   Mon, 3 Sep 2018 22:17:56 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        sean.j.christopherson@intel.com, nhorman@redhat.com,
        npmccallum@redhat.com, linux-sgx@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v13 04/13] x86/sgx: Architectural structures
Message-ID: <20180903191756.GB13497@linux.intel.com>
References: <20180827185507.17087-1-jarkko.sakkinen@linux.intel.com>
 <20180827185507.17087-5-jarkko.sakkinen@linux.intel.com>
 <CAHp75VchsQXGRrcrcB06w68PzUZb5NJLo2B_ZKf6ZLqyBbvWhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VchsQXGRrcrcB06w68PzUZb5NJLo2B_ZKf6ZLqyBbvWhA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 04:16:42PM +0300, Andy Shevchenko wrote:
> On Mon, Aug 27, 2018 at 9:57 PM Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > Add arch/x86/include/asm/sgx_arch.h, which contains definitions for the
> > architectural data structures used by the CPU to implement the SGX.
> 
> > +/**
> > + * enum sgx_encls_leaves - ENCLS leaf functions
> > + * %ECREATE:   Create an enclave.
> > + * %EADD:      Add a page to an enclave.
> > + * %EINIT:     Launch an enclave.
> > + * %EREMOVE:   Remove a page from an enclave.
> > + * %EDBGRD:    Read a word from an enclve (peek).
> > + * %EDBGWR:    Write a word to an enclave (poke).
> > + * %EEXTEND:   Measure 256 bytes of an added enclave page.
> > + * %ELDB:      Load a swapped page in blocked state.
> > + * %ELDU:      Load a swapped page in unblocked state.
> > + * %EBLOCK:    Change page state to blocked i.e. entering hardware threads
> > + *             cannot access it and create new TLB entries.
> > + * %EPA:       Create a Version Array (VA) page used to store isvsvn number
> > + *             for a swapped EPC page.
> > + * %EWB:       Swap an enclave page to the regular memory. Checks that all
> > + *             threads have exited that were in the previous shoot-down
> > + *             sequence.
> > + * %ETRACK:    Start a new shoot down sequence. Used to together with EBLOCK
> > + *             to make sure that a page is safe to swap.
> > + */
> > +enum sgx_encls_leaves {
> > +       ECREATE = 0x0,
> > +       EADD    = 0x1,
> > +       EINIT   = 0x2,
> > +       EREMOVE = 0x3,
> > +       EDGBRD  = 0x4,
> > +       EDGBWR  = 0x5,
> > +       EEXTEND = 0x6,
> > +       ELDB    = 0x7,
> > +       ELDU    = 0x8,
> > +       EBLOCK  = 0x9,
> > +       EPA     = 0xA,
> > +       EWB     = 0xB,
> > +       ETRACK  = 0xC,
> > +       EAUG    = 0xD,
> > +       EMODPR  = 0xE,
> > +       EMODT   = 0xF,
> > +};
> 
> Hmm... This E prefix confuses me with (system wide) error codes. Has
> it been discussed before? If so, can you point on the conclusion why
> the current format is good?

That is how they are prefixed in the SDM.

> > +enum sgx_miscselect {
> > +       SGX_MISC_EXINFO         = 0x01,
> > +};
> > +
> > +#define SGX_MISC_RESERVED_MASK 0xFFFFFFFFFFFFFFFEULL
> 
> Any idea why we are not using BIT_ULL() / BIT() and GENMASK_ULL() /
> GENMASK() in the code?

No good reason. I'll change it.

> > +enum sgx_attribute {
> > +       SGX_ATTR_DEBUG          = 0x02,
> > +       SGX_ATTR_MODE64BIT      = 0x04,
> > +       SGX_ATTR_PROVISIONKEY   = 0x10,
> > +       SGX_ATTR_EINITTOKENKEY  = 0x20,
> > +};
> > +
> > +#define SGX_ATTR_RESERVED_MASK 0xFFFFFFFFFFFFFFC9ULL
> 
> Some times listing explicitly not-reserved bits might be better and
> figuring out reserved mask is a simple ~ operation.

Yea, agreed.

> > +enum sgx_tcs_flags {
> > +       SGX_TCS_DBGOPTIN        = 0x01,
> > +};
> > +
> > +#define SGX_TCS_RESERVED_MASK 0xFFFFFFFFFFFFFFFEULL
> 
> > +#define SGX_SECINFO_PERMISSION_MASK    0x0000000000000007ULL
> > +#define SGX_SECINFO_PAGE_TYPE_MASK     0x000000000000FF00ULL
> > +#define SGX_SECINFO_RESERVED_MASK      0xFFFFFFFFFFFF00F8ULL
> 
> So, something like
> 
> MASK1 GENMASK_ULL
> MASK2 GENMASK_ULL
> MASK3 ~(MASK1  | MASK2)
> 
> ?

Definitely. I think it is just a matter of legacy why they are like they
are :-) These constants have gone over long time and they are not
usually places where you have to look for regressions. Thanks for
spotting these.

> 
> -- 
> With Best Regards,
> Andy Shevchenko

/Jarkko
