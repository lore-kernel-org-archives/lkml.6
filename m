Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44BEECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 11:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78BAA21531
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 11:24:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78BAA21531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389848AbeIURNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 13:13:18 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:42581 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727554AbeIURNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 13:13:18 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08647366|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e01e01542;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.Ctsi8GD_1537529083;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.Ctsi8GD_1537529083)
          by smtp.aliyun-inc.com(10.147.41.158);
          Fri, 21 Sep 2018 19:24:44 +0800
Date:   Fri, 21 Sep 2018 19:24:43 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     tglx@linutronix.de, robh+dt@kernel.org, mark.rutland@arm.com,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, c-sky_gcc_upstream@c-sky.com,
        green.hu@gmail.com
Subject: Re: [PATCH V8 1/2] clocksource: add gx6605s SOC system timer
Message-ID: <20180921112443.GA17701@guoren>
References: <cover.1537412072.git.ren_guo@c-sky.com>
 <4d409a1fdecf1c376e8cc6b55308cd3c522047b0.1537412072.git.ren_guo@c-sky.com>
 <6c31f9b2-d536-1cee-8024-b52eb862fd9d@linaro.org>
 <20180920233103.GA8891@guoren-Inspiron-7460>
 <271900ce-0019-b96d-7833-4ea5ae0721a6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <271900ce-0019-b96d-7833-4ea5ae0721a6@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 01:57:27AM +0200, Daniel Lezcano wrote:
> On 21/09/2018 01:31, Guo Ren wrote:
> > On Thu, Sep 20, 2018 at 06:06:19PM +0200, Daniel Lezcano wrote:
> >> On 20/09/2018 10:03, Guo Ren wrote:
> >>> Changelog:
> >>>  - Add License and Copyright
> >>>  - Use timer-of framework
> >>>  - Change name with upstream feedback
> >>>  - Use clksource_mmio framework
> >>>
> >>> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> >>> ---
> >>>  drivers/clocksource/Kconfig         |   8 ++
> >>>  drivers/clocksource/Makefile        |   1 +
> >>>  drivers/clocksource/timer-gx6605s.c | 150 ++++++++++++++++++++++++++++++++++++
> >>>  3 files changed, 159 insertions(+)
> >>>  create mode 100644 drivers/clocksource/timer-gx6605s.c
> >>>
> >>> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> >>> index a11f4ba..6d0f18d 100644
> >>> --- a/drivers/clocksource/Kconfig
> >>> +++ b/drivers/clocksource/Kconfig
> >>> @@ -620,4 +620,12 @@ config RISCV_TIMER
> >>>  	  is accessed via both the SBI and the rdcycle instruction.  This is
> >>>  	  required for all RISC-V systems.
> >>>  
> >>> +config GX6605S_TIMER
> >>> +	bool "Gx6605s SOC system timer driver"
> >>> +	depends on CSKY
> >>> +	select CLKSRC_MMIO
> >>> +	select TIMER_OF
> >>> +	help
> >>> +	  This option enables support for gx6605s SOC's timer.
> >>> +
> >>>  endmenu
> >>
> >> Please make the option not visible as default. There are currently two
> >> approaches look at MTK_TIMER and SPRD_TIMER.
> > Em ... (ot sure why COMPILE_TEST?):
> > 	bool "Gx6605s SOC system timer driver" if COMPILE_TEST
> > Hmm?
> 
> Because by enabling the COMPILE_TEST, you give the opportunity to
> someone without the hardware to cross-compile test your driver and catch
> errors very soon before the changes hit your tree.
> 
> There are several Continuous Integration loop around running the latest
> changes in the kernel (kernelci, 01.org, etc ...) and all drivers with
> this flag are compiled tested.
> 
> If the option is not set, the timer is silently selected by your
> platform's Kconfig only, without giving the opportunity to an non-expert
> user to unselect the timer leading to, maybe, an unbootable board.
> 
I got it, thx for the reply.

Best Regards
 Guo Ren
