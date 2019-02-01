Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43922C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C3CF204EC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbfBAIMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 03:12:50 -0500
Received: from mga01.intel.com ([192.55.52.88]:32439 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbfBAIMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 03:12:49 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Feb 2019 00:12:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,547,1539673200"; 
   d="scan'208";a="296428940"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.172])
  by orsmga005.jf.intel.com with ESMTP; 01 Feb 2019 00:12:46 -0800
Date:   Fri, 1 Feb 2019 10:12:46 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     "Winkler, Tomas" <tomas.winkler@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: Getting weird TPM error after rebasing my tree to
 security/next-general
Message-ID: <20190201081246.GA5728@linux.intel.com>
References: <CAHk-=whgoJ8aAYH37hnyFjZ8jbYyswyf9wZZ82tTFL5f2he+6g@mail.gmail.com>
 <20190129132016.GA1602@linux.intel.com>
 <20190131122606.GA12470@linux.intel.com>
 <20190131160437.GA5629@linux.intel.com>
 <20190131170603.GA18349@linux.intel.com>
 <20190131183530.GA27112@linux.intel.com>
 <CAHk-=wj0pRLS9Z+_LKfiTvnnquGQjOySVuqiObC9sDXp8SCP0A@mail.gmail.com>
 <CAHk-=whEb14V981ziWmMdcqR40x5xfhhDCaB2JYcOBQHnHmsgw@mail.gmail.com>
 <CAHk-=whYtqGO7v7c=Ak0xQfonGVbC_1sRHfxS4xNO-Sa6mFevw@mail.gmail.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9DA8DA75@hasmsx108.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9DA8DA75@hasmsx108.ger.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 07:47:19PM +0000, Winkler, Tomas wrote:
> 
> > 
> > On Thu, Jan 31, 2019 at 10:52 AM Linus Torvalds <torvalds@linux-
> > foundation.org> wrote:
> > >
> > > I think what I should do is to just make "memcpy_*io()" do the "align
> > > naturally" thing.
> > >
> > > Let me cook up a patch for you to test.
> > 
> > Does this work for you?
> > 
> > I haven't tested it at all, but I verified that the generated code seems to make
> > at least some amount of sense.
> > 
> >                Linus
> 
> So dig into the spec and I think this is a bit relevant. 
> 
> TPM TCG according the spec requires that all buffer access is done
> sequentially from the start to end of the payload, Simply In case of
> skipping or going back the transaction is aborted.  The write
> transactions should be 1 or power of 2. So in general 6 byte read
> should not work. But I'm sure our hw really obey this restriction.

We could easily read the first 8 bytes instead of 6, and then check the
length. The benefit in doing that would be to be able to backport the
patch to stable kernels.

I'm fine with either solution.

Applying Linus' fix might anyway a good idea since given that tpm_crb
broke down, there is a finite probability that there might be some other
drivers that break down for similar reasons, but no one has noticed so
far.

Thus, I might even propose doing both...

/Jarkko
