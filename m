Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473D9C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 09:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 073A22086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 09:56:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 073A22086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbeIDOUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 10:20:37 -0400
Received: from mga18.intel.com ([134.134.136.126]:51860 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbeIDOUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 10:20:36 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2018 02:56:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,329,1531810800"; 
   d="scan'208";a="254342269"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.32])
  by orsmga005.jf.intel.com with ESMTP; 04 Sep 2018 02:56:08 -0700
Date:   Tue, 4 Sep 2018 12:56:05 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        sean.j.christopherson@intel.com, nhorman@redhat.com,
        npmccallum@redhat.com, linux-sgx@vger.kernel.org,
        suresh.b.siddha@intel.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, serge.ayoun@intel.com,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v13 06/13] x86/sgx: Detect Intel SGX
Message-ID: <20180904095605.GB5423@linux.intel.com>
References: <20180827185507.17087-1-jarkko.sakkinen@linux.intel.com>
 <20180827185507.17087-7-jarkko.sakkinen@linux.intel.com>
 <CAHp75VeN7QoftgkqP-L6JRZi=MRpQkVioBLP7VDLwH=rpnEp_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VeN7QoftgkqP-L6JRZi=MRpQkVioBLP7VDLwH=rpnEp_w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 05:26:43PM +0300, Andy Shevchenko wrote:
> On Mon, Aug 27, 2018 at 9:57 PM Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > From: Sean Christopherson <sean.j.christopherson@intel.com>
> >
> > Intel(R) SGX is a set of CPU instructions that can be used by applications
> > to set aside private regions of code and data. The code outside the enclave
> > is disallowed to access the memory inside the enclave by the CPU access
> > control.
> >
> > Add a check for SGX to arch/x86 and a new config option, INTEL_SGX_CORE.
> > Expose a boolean variable 'sgx_enabled' to query whether or not the SGX
> > support is available.
> 
> > +       prompt "Intel SGX core functionality"
> > +       def_bool n
> 
> Default 'default' is 'n'. Perhaps changing prompt to bool will make it
> one line less.

Sure!

> > +#include <asm/sgx.h>
> > +#include <asm/sgx_pr.h>
> 
> Don't we put linux/* followed by asm/* ?

Yes.

> 
> > +#include <linux/freezer.h>
> > +#include <linux/highmem.h>
> > +#include <linux/kthread.h>
> > +#include <linux/ratelimit.h>
> > +#include <linux/sched/signal.h>
> > +#include <linux/slab.h>
> 
> -- 
> With Best Regards,
> Andy Shevchenko

/Jarkko
