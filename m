Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3F1C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 568C42184C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfAWPgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 10:36:45 -0500
Received: from mga14.intel.com ([192.55.52.115]:27462 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbfAWPgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 10:36:44 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jan 2019 07:36:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,511,1539673200"; 
   d="scan'208";a="127956733"
Received: from rkazants-mobl.ccr.corp.intel.com (HELO localhost) ([10.249.254.156])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Jan 2019 07:36:40 -0800
Date:   Wed, 23 Jan 2019 17:36:38 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: Getting weird TPM error after rebasing my tree to
 security/next-general
Message-ID: <20190123153638.GA8727@linux.intel.com>
References: <20190118142559.GA4080@linux.intel.com>
 <1547849358.2794.90.camel@HansenPartnership.com>
 <20190120160413.GB30478@linux.intel.com>
 <20190122010218.GA26713@linux.intel.com>
 <20190122025836.GH25163@ziepe.ca>
 <20190122132910.GA2720@linux.intel.com>
 <CAHk-=wgdOfi+zVVfKDDqJMs2Y7Lq0uufmP8Hx8JzQFA9UzNrBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgdOfi+zVVfKDDqJMs2Y7Lq0uufmP8Hx8JzQFA9UzNrBw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 07:26:42AM +1300, Linus Torvalds wrote:
> On Wed, Jan 23, 2019 at 2:29 AM Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > > >
> > > > Fails on commit 170d13ca3a2fdaaa0283399247631b76b441cca2. Still works on
> > > > preceding commit a959dc88f9c8900296ccf13e2f3e1cbc555a8917.
> > >
> > > This changes the IO access pattern in memcpy_to/fromio.. Presumably
> > > CRB HW doesn't like the new 4 byte move? Swap each one in crb to
> > > memcpy to confirm..
> > >
> > > If the HW requires particular access patterns you can't use
> > > memcpy_to/fromio
> >
> > Did not have time to look at the commit at all but your deduction
> > is correct. I know it without testing.
> >
> > Memory controller will feed 1's on unaligned read from IO memory,
> > and as we can see from the TPM header, this change causes two of
> > those:
> 
> Funky. But how did it work before then?
> 
> The new memcpy_fromio() is designed to have _predictable_ access
> patterns. Not necessarily the best, but at least consistent.
> 
> Prevously, we used whatever random "memcpy()" implementation we
> happened to pick, which *could* be aligned (particularly "rep movsb" -
> absolutely horrible performance for MMIO, but by doing IO one byte at
> a time it was certainly aligned ;), but most of our x86 memcpy
> implementations don't actually try all that hard to align the source.
> And the manual version will actually copy things *backwards* for some
> cases.
> 
> Is it just that this particular hardware always happened to trigger
> the ERMS case (ie "rep movsb")?

This is the particular snippet in question:

memcpy_fromio(buf, priv->rsp, 6);
expected = be32_to_cpup((__be32 *) &buf[2]);
if (expected > count || expected < 6)
	return -EIO;

memcpy_fromio(&buf[6], &priv->rsp[6], expected - 6);

I guess it did in the first memcpy_fromio operation since it is less
than a quad word, right? Not sure why the 2nd memcpy_fromio() operation
has worked, though.

> Anyway, Jason is correct that if a device has particular IO pattern
> requirements, you shouldn't use "memcpy_fromio()" and friends, but
> it's interesting how it apparently *happened* to work before.
> 
>              Linus

Sure, I'll prepare a fix ASAP.

/Jarkko
