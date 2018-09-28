Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B680FC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 01:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 678012157C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 01:42:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 678012157C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbeI1IDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 04:03:41 -0400
Received: from mga02.intel.com ([134.134.136.20]:13827 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbeI1IDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 04:03:40 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Sep 2018 18:42:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,312,1534834800"; 
   d="scan'208";a="267589568"
Received: from shbuild888.sh.intel.com (HELO localhost) ([10.239.146.239])
  by fmsmga006.fm.intel.com with ESMTP; 27 Sep 2018 18:42:19 -0700
Date:   Fri, 28 Sep 2018 09:47:39 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        H Peter Anvin <hpa@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Stuart R . Anderson" <stuart.r.anderson@intel.com>,
        alan@linux.intel.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] x86/earlyprintk: Don't fail the pciserial device
 with incorrect class code
Message-ID: <20180928014739.owdi42l5q23f7uu7@shbuild888>
References: <20180927124320.13419-1-feng.tang@intel.com>
 <20180927133050.GA19687@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927133050.GA19687@zn.tnic>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Borislav,

Thanks for the review.

On Thu, Sep 27, 2018 at 03:30:50PM +0200, Borislav Petkov wrote:
> On Thu, Sep 27, 2018 at 08:43:20PM +0800, Feng Tang wrote:
> > "pciserial" earlyprintk helps much on many modern x86 platforms,
> > but unfortunately there are some platforms whose PCI UART devices
> > have wrong PCI class code, which will be blocked by current check.
> > 
> > So loose the class code check by giving a warning message instead.
> > This should be fine, as a developer who can give the accurate
> > BDF should know whether it's a usable UART device.
> 
> BDF? No.
> 
> Please write it out what it means.

Will do.

> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > ---
> >  arch/x86/kernel/early_printk.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kernel/early_printk.c b/arch/x86/kernel/early_printk.c
> > index 5e801c8..abe1d08 100644
> > --- a/arch/x86/kernel/early_printk.c
> > +++ b/arch/x86/kernel/early_printk.c
> > @@ -265,7 +265,8 @@ static __init void early_pci_serial_init(char *s)
> >  	if (((classcode >> 16 != PCI_CLASS_COMMUNICATION_MODEM) &&
> >  	     (classcode >> 16 != PCI_CLASS_COMMUNICATION_SERIAL)) ||
> >  	   (((classcode >> 8) & 0xff) != 0x02)) /* 16550 I/F at BAR0 */
> > -		return;
> > +		pr_warn("earlyprintk: classcode for pcidev %d:%d:%d shows it's not a UART like device, please check!\n",
> > +			bus, slot, func);
> 
> So where did the return statement go?
> 
> What are you trying to do here? If the device is still an UART device
> then we don't need the check at all as you're basically overriding it
> and only the class code is wrong.
> 
> If so, why do we need the pr_warn at all? What can the user do about the
> class code? Nothing, I'd say. I don't see her "fixing" PCI config space
> so that the device has a correct class code.

That's true. We can hardly do anything from OS side,

> 
> But what happens if the user really supplies the wrong BDF? We end up
> poking in PCI config space of *some* device and then the cat might catch
> fire.

Valid point, I can not argue on this :)

> 
> So it sounds to me like we need:
> 
> earlyprintk=pciserial,force,00:18.1,115200

I would follow this way, thanks

-Feng
