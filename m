Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E55C282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC985218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732656AbfAaM0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 07:26:11 -0500
Received: from mga07.intel.com ([134.134.136.100]:20557 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726153AbfAaM0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 07:26:11 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jan 2019 04:26:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,544,1539673200"; 
   d="scan'208";a="134732579"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.172])
  by orsmga001.jf.intel.com with ESMTP; 31 Jan 2019 04:26:07 -0800
Date:   Thu, 31 Jan 2019 14:26:06 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        tomas.winkler@intel.com
Subject: Re: Getting weird TPM error after rebasing my tree to
 security/next-general
Message-ID: <20190131122606.GA12470@linux.intel.com>
References: <20190118142559.GA4080@linux.intel.com>
 <1547849358.2794.90.camel@HansenPartnership.com>
 <20190120160413.GB30478@linux.intel.com>
 <20190122010218.GA26713@linux.intel.com>
 <20190122025836.GH25163@ziepe.ca>
 <20190122132910.GA2720@linux.intel.com>
 <CAHk-=wgdOfi+zVVfKDDqJMs2Y7Lq0uufmP8Hx8JzQFA9UzNrBw@mail.gmail.com>
 <20190123153638.GA8727@linux.intel.com>
 <CAHk-=whgoJ8aAYH37hnyFjZ8jbYyswyf9wZZ82tTFL5f2he+6g@mail.gmail.com>
 <20190129132016.GA1602@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129132016.GA1602@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 03:20:16PM +0200, Jarkko Sakkinen wrote:
> On Thu, Jan 24, 2019 at 07:43:30AM +1300, Linus Torvalds wrote:
> > On Thu, Jan 24, 2019 at 4:36 AM Jarkko Sakkinen
> > <jarkko.sakkinen@linux.intel.com> wrote:
> > > >
> > > > Is it just that this particular hardware always happened to trigger
> > > > the ERMS case (ie "rep movsb")?
> > >
> > > This is the particular snippet in question:
> > >
> > > memcpy_fromio(buf, priv->rsp, 6);
> > > expected = be32_to_cpup((__be32 *) &buf[2]);
> > > if (expected > count || expected < 6)
> > >         return -EIO;
> > 
> > Ok, strange.
> > 
> > So what *used* to happen is that the memcpy_fromio() would just expand
> > as a "memcpy()", and in this case, gcc would then inline the memcpy().
> > In fact, gcc does it as a 4-byte access and a two-byte access from
> > what I can tell.
> 
> I verified, and it is exactly as you stated:
> 
>    0xffffffff814aaa33 <+51>:	mov    (%rax),%edx
>    0xffffffff814aaa35 <+53>:	mov    %edx,0x0(%rbp)
>    0xffffffff814aaa38 <+56>:	movzwl 0x4(%rax),%eax
>    0xffffffff814aaa3c <+60>:	mov    %ax,0x4(%rbp)
> 
> And your new version does exactly the same thing to the first six bytes
> (with different opcode, but the same memory access pattern).

I think I have found the root cause:

memcpy_fromio(&__rsp_pa, &priv->regs_t->ctrl_rsp_pa, 8);

This is from crb_map_io(). This should be read as quad word.

I'll change it to ioread64() and see what happens. I don't know why it
even has used memcpy_fromio() in the first place. I guess, when I first
implemented the driver, I used that for no logical reason, and it has
worked since up until now.

/Jarkko
