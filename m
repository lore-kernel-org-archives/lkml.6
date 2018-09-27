Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F66C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE2E0216F4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:30:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE2E0216F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbeI0TtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 15:49:06 -0400
Received: from mail.skyhub.de ([5.9.137.197]:51048 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727199AbeI0TtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 15:49:06 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qWKitO4PWmmh; Thu, 27 Sep 2018 15:30:47 +0200 (CEST)
Received: from zn.tnic (p200300EC2BC7FB00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bc7:fb00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 57D411EC068D;
        Thu, 27 Sep 2018 15:30:47 +0200 (CEST)
Date:   Thu, 27 Sep 2018 15:30:50 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        H Peter Anvin <hpa@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Stuart R . Anderson" <stuart.r.anderson@intel.com>,
        alan@linux.intel.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] x86/earlyprintk: Don't fail the pciserial device
 with incorrect class code
Message-ID: <20180927133050.GA19687@zn.tnic>
References: <20180927124320.13419-1-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180927124320.13419-1-feng.tang@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 08:43:20PM +0800, Feng Tang wrote:
> "pciserial" earlyprintk helps much on many modern x86 platforms,
> but unfortunately there are some platforms whose PCI UART devices
> have wrong PCI class code, which will be blocked by current check.
> 
> So loose the class code check by giving a warning message instead.
> This should be fine, as a developer who can give the accurate
> BDF should know whether it's a usable UART device.

BDF? No.

Please write it out what it means.

> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
>  arch/x86/kernel/early_printk.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/early_printk.c b/arch/x86/kernel/early_printk.c
> index 5e801c8..abe1d08 100644
> --- a/arch/x86/kernel/early_printk.c
> +++ b/arch/x86/kernel/early_printk.c
> @@ -265,7 +265,8 @@ static __init void early_pci_serial_init(char *s)
>  	if (((classcode >> 16 != PCI_CLASS_COMMUNICATION_MODEM) &&
>  	     (classcode >> 16 != PCI_CLASS_COMMUNICATION_SERIAL)) ||
>  	   (((classcode >> 8) & 0xff) != 0x02)) /* 16550 I/F at BAR0 */
> -		return;
> +		pr_warn("earlyprintk: classcode for pcidev %d:%d:%d shows it's not a UART like device, please check!\n",
> +			bus, slot, func);

So where did the return statement go?

What are you trying to do here? If the device is still an UART device
then we don't need the check at all as you're basically overriding it
and only the class code is wrong.

If so, why do we need the pr_warn at all? What can the user do about the
class code? Nothing, I'd say. I don't see her "fixing" PCI config space
so that the device has a correct class code.

But what happens if the user really supplies the wrong BDF? We end up
poking in PCI config space of *some* device and then the cat might catch
fire.

So it sounds to me like we need:

earlyprintk=pciserial,force,00:18.1,115200

where "force" allows the function to continue even if the classcode is
wrong. Or

earlyprintk=pciserial,i_know_what_im_doing,00:18.1,115200

:-)

Also, if you're going to use pr_* variants, convert the file to use
pr_fmt() - grep the kernel sources for examples.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
