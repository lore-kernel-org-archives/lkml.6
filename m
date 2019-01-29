Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF69C282D0
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56ECD20882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfA2NUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 08:20:20 -0500
Received: from mga06.intel.com ([134.134.136.31]:59450 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbfA2NUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 08:20:20 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2019 05:20:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,537,1539673200"; 
   d="scan'208";a="138829651"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.127])
  by fmsmga002.fm.intel.com with ESMTP; 29 Jan 2019 05:20:17 -0800
Date:   Tue, 29 Jan 2019 15:20:16 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: Getting weird TPM error after rebasing my tree to
 security/next-general
Message-ID: <20190129132016.GA1602@linux.intel.com>
References: <20190118142559.GA4080@linux.intel.com>
 <1547849358.2794.90.camel@HansenPartnership.com>
 <20190120160413.GB30478@linux.intel.com>
 <20190122010218.GA26713@linux.intel.com>
 <20190122025836.GH25163@ziepe.ca>
 <20190122132910.GA2720@linux.intel.com>
 <CAHk-=wgdOfi+zVVfKDDqJMs2Y7Lq0uufmP8Hx8JzQFA9UzNrBw@mail.gmail.com>
 <20190123153638.GA8727@linux.intel.com>
 <CAHk-=whgoJ8aAYH37hnyFjZ8jbYyswyf9wZZ82tTFL5f2he+6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whgoJ8aAYH37hnyFjZ8jbYyswyf9wZZ82tTFL5f2he+6g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 07:43:30AM +1300, Linus Torvalds wrote:
> On Thu, Jan 24, 2019 at 4:36 AM Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> > >
> > > Is it just that this particular hardware always happened to trigger
> > > the ERMS case (ie "rep movsb")?
> >
> > This is the particular snippet in question:
> >
> > memcpy_fromio(buf, priv->rsp, 6);
> > expected = be32_to_cpup((__be32 *) &buf[2]);
> > if (expected > count || expected < 6)
> >         return -EIO;
> 
> Ok, strange.
> 
> So what *used* to happen is that the memcpy_fromio() would just expand
> as a "memcpy()", and in this case, gcc would then inline the memcpy().
> In fact, gcc does it as a 4-byte access and a two-byte access from
> what I can tell.

I verified, and it is exactly as you stated:

   0xffffffff814aaa33 <+51>:	mov    (%rax),%edx
   0xffffffff814aaa35 <+53>:	mov    %edx,0x0(%rbp)
   0xffffffff814aaa38 <+56>:	movzwl 0x4(%rax),%eax
   0xffffffff814aaa3c <+60>:	mov    %ax,0x4(%rbp)

And your new version does exactly the same thing to the first six bytes
(with different opcode, but the same memory access pattern).

/Jarkko
