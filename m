Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C43DC004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 13:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5857920833
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 13:11:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5857920833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbeI3Toa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 15:44:30 -0400
Received: from mga11.intel.com ([192.55.52.93]:12806 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728380AbeI3To3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 15:44:29 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Sep 2018 06:11:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,324,1534834800"; 
   d="scan'208";a="237307441"
Received: from shbuild888.sh.intel.com (HELO localhost) ([10.239.146.239])
  by orsmga004.jf.intel.com with ESMTP; 30 Sep 2018 06:10:54 -0700
Date:   Sun, 30 Sep 2018 21:16:19 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        H Peter Anvin <hpa@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Stuart R . Anderson" <stuart.r.anderson@intel.com>,
        alan@linux.intel.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/earlyprintk: Add a force option for pciserial
 device
Message-ID: <20180930131619.jecqh4umrkmifavb@shbuild888>
References: <20180928094008.23138-1-feng.tang@intel.com>
 <20180929163458.GA25608@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180929163458.GA25608@zn.tnic>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Borislav,

On Sat, Sep 29, 2018 at 06:34:58PM +0200, Borislav Petkov wrote:
> On Fri, Sep 28, 2018 at 05:40:08PM +0800, Feng Tang wrote:
> > "pciserial" earlyprintk helps much on many modern x86 platforms,
> > but unfortunately there are still some platforms whose PCI UART
> > devices have wrong PCI class code, which will be blocked by current
> > class code check.
> > 
> > Add a option "force" so that developer could still use a UART device
> > even it has wrong class code, with format "",B:D.F,force,baud". And
> 
> This new parameter and its meaning needs to be documented where
> pciserial is documented.

Ok, will change the kernel-parameters.txt in next version.

> 
> > the original format ",B:D.F,baud" is kept unchanged.
> > 
> > Suggested-by: Borislav Petkov <bp@alien8.de>
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > ---
> >  arch/x86/kernel/early_printk.c | 26 ++++++++++++++++++++------
> >  1 file changed, 20 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/early_printk.c b/arch/x86/kernel/early_printk.c
> > index 5e801c8..35d0f66 100644
> > --- a/arch/x86/kernel/early_printk.c
> > +++ b/arch/x86/kernel/early_printk.c
> > @@ -213,8 +213,10 @@ static unsigned int mem32_serial_in(unsigned long addr, int offset)
> >   * early_pci_serial_init()
> >   *
> >   * This function is invoked when the early_printk param starts with "pciserial"
> > - * The rest of the param should be ",B:D.F,baud" where B, D & F describe the
> > - * location of a PCI device that must be a UART device.
> > + * The rest of the param should be ",B:D.F,baud" or ",B:D.F,force,baud", where
> > + * B, D & F describe the location of a PCI device that must be a UART device,
> > + * "force" is optional and means insisting using a UART device with a wrong
> > + * pci class code.
> >   */
> >  static __init void early_pci_serial_init(char *s)
> >  {
> > @@ -224,6 +226,7 @@ static __init void early_pci_serial_init(char *s)
> >  	u32 classcode, bar0;
> >  	u16 cmdreg;
> >  	char *e;
> > +	int force = 0;
> >  
> >  
> >  	/*
> > @@ -252,6 +255,15 @@ static __init void early_pci_serial_init(char *s)
> >  	if (*s == ',')
> >  		s++;
> >  
> > +	/* User may insist to use a UART device with wrong class code */
> > +	if (!strncmp(s, "force", 5)) {
> > +		force = 1;
> > +		s += 5;
> > +
> > +		if (*s == ',')
> > +			s++;
> 
> No, you need to force the presence of "," otherwise cmdlines like this:
> 
> earlyprintk=pciserial,0:XX.X,forcedoodoo
> 
> work too.

Got your point. As the following [,baudrate] is also optional, and this
"force" could be the last option for pciserial. The check may be

	if (!strncmp(s, "force,", 6) || !strncmp(s, "force ", 6)) {
		force = 1;
		s += 6;
	}


> > +	}
> > +
> >  	/*
> >  	 * Second, find the device from the BDF
> >  	 */
> > @@ -262,10 +274,12 @@ static __init void early_pci_serial_init(char *s)
> >  	/*
> >  	 * Verify it is a UART type device
> >  	 */
> > -	if (((classcode >> 16 != PCI_CLASS_COMMUNICATION_MODEM) &&
> > -	     (classcode >> 16 != PCI_CLASS_COMMUNICATION_SERIAL)) ||
> > -	   (((classcode >> 8) & 0xff) != 0x02)) /* 16550 I/F at BAR0 */
> > -		return;
> > +	if (!force) {
> > +		if (((classcode >> 16 != PCI_CLASS_COMMUNICATION_MODEM) &&
> > +		     (classcode >> 16 != PCI_CLASS_COMMUNICATION_SERIAL)) ||
> > +		   (((classcode >> 8) & 0xff) != 0x02)) /* 16550 I/F at BAR0 */
> > +			return;
> 
> Move the force check in here ^

Do you mean this? 

	if (((classcode >> 16 != PCI_CLASS_COMMUNICATION_MODEM) &&
	     (classcode >> 16 != PCI_CLASS_COMMUNICATION_SERIAL)) ||
	   (((classcode >> 8) & 0xff) != 0x02)) /* 16550 I/F at BAR0 */ {
		if (!force)
			return;
	}

Thanks,
Feng


