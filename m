Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA4DC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 16:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4353C20882
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 16:35:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4353C20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbeI2XED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 19:04:03 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36896 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728382AbeI2XED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 19:04:03 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id x5-sMQShA3Lc; Sat, 29 Sep 2018 18:34:58 +0200 (CEST)
Received: from zn.tnic (p200300EC2BD81000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bd8:1000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9E0C11EC04A6;
        Sat, 29 Sep 2018 18:34:58 +0200 (CEST)
Date:   Sat, 29 Sep 2018 18:34:58 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        H Peter Anvin <hpa@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Stuart R . Anderson" <stuart.r.anderson@intel.com>,
        alan@linux.intel.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/earlyprintk: Add a force option for pciserial
 device
Message-ID: <20180929163458.GA25608@zn.tnic>
References: <20180928094008.23138-1-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180928094008.23138-1-feng.tang@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 05:40:08PM +0800, Feng Tang wrote:
> "pciserial" earlyprintk helps much on many modern x86 platforms,
> but unfortunately there are still some platforms whose PCI UART
> devices have wrong PCI class code, which will be blocked by current
> class code check.
> 
> Add a option "force" so that developer could still use a UART device
> even it has wrong class code, with format "",B:D.F,force,baud". And

This new parameter and its meaning needs to be documented where
pciserial is documented.

> the original format ",B:D.F,baud" is kept unchanged.
> 
> Suggested-by: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
>  arch/x86/kernel/early_printk.c | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kernel/early_printk.c b/arch/x86/kernel/early_printk.c
> index 5e801c8..35d0f66 100644
> --- a/arch/x86/kernel/early_printk.c
> +++ b/arch/x86/kernel/early_printk.c
> @@ -213,8 +213,10 @@ static unsigned int mem32_serial_in(unsigned long addr, int offset)
>   * early_pci_serial_init()
>   *
>   * This function is invoked when the early_printk param starts with "pciserial"
> - * The rest of the param should be ",B:D.F,baud" where B, D & F describe the
> - * location of a PCI device that must be a UART device.
> + * The rest of the param should be ",B:D.F,baud" or ",B:D.F,force,baud", where
> + * B, D & F describe the location of a PCI device that must be a UART device,
> + * "force" is optional and means insisting using a UART device with a wrong
> + * pci class code.
>   */
>  static __init void early_pci_serial_init(char *s)
>  {
> @@ -224,6 +226,7 @@ static __init void early_pci_serial_init(char *s)
>  	u32 classcode, bar0;
>  	u16 cmdreg;
>  	char *e;
> +	int force = 0;
>  
>  
>  	/*
> @@ -252,6 +255,15 @@ static __init void early_pci_serial_init(char *s)
>  	if (*s == ',')
>  		s++;
>  
> +	/* User may insist to use a UART device with wrong class code */
> +	if (!strncmp(s, "force", 5)) {
> +		force = 1;
> +		s += 5;
> +
> +		if (*s == ',')
> +			s++;

No, you need to force the presence of "," otherwise cmdlines like this:

earlyprintk=pciserial,0:XX.X,forcedoodoo

work too.

> +	}
> +
>  	/*
>  	 * Second, find the device from the BDF
>  	 */
> @@ -262,10 +274,12 @@ static __init void early_pci_serial_init(char *s)
>  	/*
>  	 * Verify it is a UART type device
>  	 */
> -	if (((classcode >> 16 != PCI_CLASS_COMMUNICATION_MODEM) &&
> -	     (classcode >> 16 != PCI_CLASS_COMMUNICATION_SERIAL)) ||
> -	   (((classcode >> 8) & 0xff) != 0x02)) /* 16550 I/F at BAR0 */
> -		return;
> +	if (!force) {
> +		if (((classcode >> 16 != PCI_CLASS_COMMUNICATION_MODEM) &&
> +		     (classcode >> 16 != PCI_CLASS_COMMUNICATION_SERIAL)) ||
> +		   (((classcode >> 8) & 0xff) != 0x02)) /* 16550 I/F at BAR0 */
> +			return;

Move the force check in here ^

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
