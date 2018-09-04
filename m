Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2527C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 09:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D5D82077C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 09:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D5D82077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbeIDOXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 10:23:52 -0400
Received: from mga12.intel.com ([192.55.52.136]:9551 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbeIDOXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 10:23:52 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2018 02:59:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,329,1531810800"; 
   d="scan'208";a="80709610"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.32])
  by orsmga003.jf.intel.com with ESMTP; 04 Sep 2018 02:59:25 -0700
Date:   Tue, 4 Sep 2018 12:59:23 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        sean.j.christopherson@intel.com, nhorman@redhat.com,
        npmccallum@redhat.com, linux-sgx@vger.kernel.org,
        serge.ayoun@intel.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, suresh.b.siddha@intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v13 07/13] x86/sgx: Add data structures for tracking the
 EPC pages
Message-ID: <20180904095923.GC5423@linux.intel.com>
References: <20180827185507.17087-1-jarkko.sakkinen@linux.intel.com>
 <20180827185507.17087-8-jarkko.sakkinen@linux.intel.com>
 <CAHp75VcjKkJR4_H-acbVm3BwA4tVR8gUtkg9STqOK2UG20Tvgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VcjKkJR4_H-acbVm3BwA4tVR8gUtkg9STqOK2UG20Tvgg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 05:41:53PM +0300, Andy Shevchenko wrote:
> On Mon, Aug 27, 2018 at 9:58 PM Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > Add data structures to track Enclave Page Cache (EPC) pages.  EPC is
> > divided into multiple banks (1-N) of which addresses and sizes can be
> > enumerated with CPUID by the OS.
> >
> > On NUMA systems a node can have at most bank. A bank can be at most part of
> > two nodes. SGX supports both nodes with a single memory controller and also
> > sub-cluster nodes with severals memory controllers on a single die.
> 
> > -#include <asm/sgx.h>
> > -#include <asm/sgx_pr.h>
> >  #include <linux/freezer.h>
> >  #include <linux/highmem.h>
> >  #include <linux/kthread.h>
> > +#include <linux/pagemap.h>
> >  #include <linux/ratelimit.h>
> >  #include <linux/sched/signal.h>
> > +#include <linux/shmem_fs.h>
> >  #include <linux/slab.h>
> > +#include <asm/sgx.h>
> > +#include <asm/sgx_pr.h>
> 
> Squash issues?

Yes :-/

> > +       va = ioremap_cache(addr, size);
> > +       if (!va)
> > +               return -ENOMEM;
> 
> I'm not sure this is a right API. Do we operate with memory? Does it
> have I/O side effects?
> If no, memremap() would be better to use.

Had this idea a long time ago but had forgotten it. EPC is from caching
perspective like regular memory.

> -- 
> With Best Regards,
> Andy Shevchenko
> 

/Jarkko
