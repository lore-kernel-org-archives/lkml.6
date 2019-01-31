Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C014C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A4620881
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbfAaUpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 15:45:17 -0500
Received: from mga17.intel.com ([192.55.52.151]:47279 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbfAaUpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 15:45:16 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jan 2019 12:45:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,545,1539673200"; 
   d="scan'208";a="114310298"
Received: from rkazants-mobl.ccr.corp.intel.com (HELO localhost) ([10.249.254.212])
  by orsmga008.jf.intel.com with ESMTP; 31 Jan 2019 12:45:11 -0800
Date:   Thu, 31 Jan 2019 22:45:10 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     tomas.winkler@intel.com, Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: Getting weird TPM error after rebasing my tree to
 security/next-general
Message-ID: <20190131204510.GA354@linux.intel.com>
References: <20190122132910.GA2720@linux.intel.com>
 <CAHk-=wgdOfi+zVVfKDDqJMs2Y7Lq0uufmP8Hx8JzQFA9UzNrBw@mail.gmail.com>
 <20190123153638.GA8727@linux.intel.com>
 <CAHk-=whgoJ8aAYH37hnyFjZ8jbYyswyf9wZZ82tTFL5f2he+6g@mail.gmail.com>
 <20190129132016.GA1602@linux.intel.com>
 <20190131122606.GA12470@linux.intel.com>
 <20190131160437.GA5629@linux.intel.com>
 <20190131170603.GA18349@linux.intel.com>
 <20190131183530.GA27112@linux.intel.com>
 <CAHk-=wj0pRLS9Z+_LKfiTvnnquGQjOySVuqiObC9sDXp8SCP0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj0pRLS9Z+_LKfiTvnnquGQjOySVuqiObC9sDXp8SCP0A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 10:51:03AM -0800, Linus Torvalds wrote:
> On Thu, Jan 31, 2019 at 10:35 AM Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > OK, so the length of the response is not trashed, but only the error
> > code. The attached patch fully fixes the issue.
> >
> > Here's the header again:
> >
> > struct tpm_output_header {
> >         __be16  tag;
> >         __be32  length;
> >         __be32  return_code;
> > } __packed;
> >
> > The first to fields *are* read correctly and the last field get 1's
> > (thus TPM error -1).
> 
> Ok, so this makes sense, even though that patch is (I think) completely wrong.

I don't disagree on that :-) Just pinpointed the location where it
fails.

> What happens is that the 32-bit fields are mis-aligned: the "tag" is
> obviously properly 16-bit aligned, but then both "length" and
> "return_code" are 32-bit fields that are only aligned on a 16-bit
> alignment.
> 
> What happens is that first you copy the two first fields:
> 
>         memcpy_fromio(buf, priv->rsp, 6);
> 
> which copies "tag" and "length", but it copies them by reading then as
> a 4-byte and then 2-byte value (in that order). So it actually reads
> 'tag' and 'first two bytes of 'length', and then the second access
> reads the last two bytes of 'length'
> 
> And it all works, because the accesses are aligned by address of
> access, even though they are *not* aligned in the 'struct
> tpm_output_header' fields.

Right, they are still naturally aligned accesses.

> But then later on, when you read 'return_code', and do
> 
>         memcpy_fromio(&buf[6], &priv->rsp[6], expected - 6);
> 
> you now do a 4-byte memcpy at offset 6. So it does a 4-byte access,
> bit it's not 4-byte aligned.
> 
> Honestly, memcpy() itself shouldn't have worked *either*, but you
> lucked out. Gcc doesn't know that it's a 4-byte access, so it actually
> calls out to the memcpy() routine. And that one happened to be "rep
> movsb" on your machine. And that happened to work.

I understand what you mean. Just surprised that this hasn't failed
before to anyone (the same driver has been even successfully used
on ARM64 with TrustZone based fTPM implementation). It has been in
for three years now.

> But it's really not supposed to work, and it really *wouldn't* have
> worked if somebody disabled the rep-string functions.
> 
> In fact, we have another patch (that isn't applied) that makes even
> the memcpy_erms() just call the sw version of memcpy() for short
> copies (because "rep movsb" is slow for those cases). That would also
> have broken your driver.
> 
>                Linus

/Jarkko
