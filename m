Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303E6C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 12:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBE0421837
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 12:43:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBE0421837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbeHDOnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 10:43:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34144 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbeHDOnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 10:43:51 -0400
Received: from localhost (ip-213-127-46-170.ip.prioritytelecom.net [213.127.46.170])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B1B44480;
        Sat,  4 Aug 2018 12:43:12 +0000 (UTC)
Date:   Sat, 4 Aug 2018 14:43:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     "Wu, Songjun" <songjun.wu@linux.intel.com>, hua.ma@linux.intel.com,
        yixin.zhu@linux.intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, linux-mips@linux-mips.org,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH v2 14/18] serial: intel: Add CCF support
Message-ID: <20180804124309.GB4920@kroah.com>
References: <20180803030237.3366-1-songjun.wu@linux.intel.com>
 <20180803030237.3366-15-songjun.wu@linux.intel.com>
 <20180803055640.GA32226@kroah.com>
 <763bba56-3701-7fe9-9b31-4710594b40d5@linux.intel.com>
 <20180803103023.GA6557@kroah.com>
 <3360edd2-f3d8-b860-13fa-ce680edbfd0a@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3360edd2-f3d8-b860-13fa-ce680edbfd0a@hauke-m.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 04, 2018 at 12:54:22PM +0200, Hauke Mehrtens wrote:
> On 08/03/2018 12:30 PM, Greg Kroah-Hartman wrote:
> > On Fri, Aug 03, 2018 at 03:33:38PM +0800, Wu, Songjun wrote:
> >>
> >>
> >> On 8/3/2018 1:56 PM, Greg Kroah-Hartman wrote:
> >>> On Fri, Aug 03, 2018 at 11:02:33AM +0800, Songjun Wu wrote:
> >>>> Previous implementation uses platform-dependent API to get the clock.
> >>>> Those functions are not available for other SoC which uses the same IP.
> >>>> The CCF (Common Clock Framework) have an abstraction based APIs for
> >>>> clock. In future, the platform specific code will be removed when the
> >>>> legacy soc use CCF as well.
> >>>> Change to use CCF APIs to get clock and rate. So that different SoCs
> >>>> can use the same driver.
> >>>>
> >>>> Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
> >>>> ---
> >>>>
> >>>> Changes in v2: None
> >>>>
> >>>>   drivers/tty/serial/lantiq.c | 11 +++++++++++
> >>>>   1 file changed, 11 insertions(+)
> >>>>
> >>>> diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
> >>>> index 36479d66fb7c..35518ab3a80d 100644
> >>>> --- a/drivers/tty/serial/lantiq.c
> >>>> +++ b/drivers/tty/serial/lantiq.c
> >>>> @@ -26,7 +26,9 @@
> >>>>   #include <linux/clk.h>
> >>>>   #include <linux/gpio.h>
> >>>> +#ifdef CONFIG_LANTIQ
> >>>>   #include <lantiq_soc.h>
> >>>> +#endif
> >>> That is never how you do this in Linux, you know better.
> >>>
> >>> Please go and get this patchset reviewed and signed-off-by from other
> >>> internal Intel kernel developers before resending it next time.  It is
> >>> their job to find and fix your basic errors like this, not ours.
> >> Thank you for your comment.
> >> Actually, we have discussed this issue internally.
> >> We put the reason why we use "#ifdef CONFIG_LANTIQ" preprocessor in commit
> >> message in "[PATCH v2 08/18] serial: intel: Get serial id from dts".
> >> Please refer the commit message below.
> >>
> >> "#ifdef CONFIG_LANTIQ" preprocessor is used because LTQ_EARLY_ASC
> >> macro is defined in lantiq_soc.h.
> >> lantiq_soc.h is in arch path for legacy product support.
> >>
> >> arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
> >>
> >> If "#ifdef preprocessor" is changed to
> >> "if (IS_ENABLED(CONFIG_LANTIQ))", when CONFIG_LANTIQ is not enabled,
> >> code using LTQ_EARLY_ASC is compiled.
> >> Compilation will fail for no LTQ_EARLY_ASC defined.
> > 
> > Sorry, but no.  Why is this one tiny driver/chip somehow more "special"
> > than all of the tens of thousands of other devices we support to warrent
> > it getting some sort of special exception to do things differently?
> > What happens to the next device that wants to do it this way?
> > 
> > Our coding style and rules are there for a reason, do not violate them
> > thinking your device is the only one that matters.
> > 
> > Do it properly, again, you all know better than this.
> > 
> > greg k-h
> > 
> Hi Greg,
> 
> The problem is that the Lantiq SoC code in arch/mips/lantiq does not use
> the common clock framework, but it uses the clk framework directly. It
> defines CONFIG_HAVE_CLK and CONFIG_CLKDEV_LOOKUP, but not
> CONFIG_COMMON_CLK. The xRX500 SoC which is being added here is about 2
> generations more recent than the VR9/xRX200 SoC which is the latest
> which is supported by the code in arch/mips/lantiq. With this new SoC we
> switched to the common clock framework. This driver is used by the older
> SoC and also by the new ones because this IP core is pretty similar in
> all the SoCs.
> This patch makes it possible to use it with the legacy lantiq code and
> also with the common clock framework. I see multiple options to fix this
> problem.
> 
> 1. The current approach to have it as a compile variant for a) legacy
> lantiq arch code without common clock framework and b) support for SoCs
> using the common clock framework.
> 2. Convert the lantiq arch code to the common clock framework. This
> would be a good approach, but it need some efforts.
> 3. Remove the arch/mips/lantiq code. There are still users of this code.
> 4. Use the old APIs also for the new xRX500 SoC, I do not like this
> approach.
> 5. Move lantiq_soc.h to somewhere in include/linux/ so it is globally
> available and provide some better wrapper code.

I don't really care what you do at this point in time, but you all
should know better than the crazy #ifdef is not allowed to try to
prevent/allow the inclusion of a .h file.  Checkpatch might have even
warned you about it, right?

So do it correctly, odds are #5 is correct, as that makes it work like
any other device in the kernel.  You are not unique here.

greg k-h
