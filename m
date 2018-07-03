Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA770C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70B8C2086B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:39:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70B8C2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933498AbeGCHjH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:39:07 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:50523 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932098AbeGCHjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:39:05 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07502902|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03296;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.CLeOjOO_1530603534;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CLeOjOO_1530603534)
          by smtp.aliyun-inc.com(10.147.40.44);
          Tue, 03 Jul 2018 15:38:54 +0800
Date:   Tue, 3 Jul 2018 15:38:54 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-arch@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Arnd Bergmann <arnd@arndb.de>, c-sky_gcc_upstream@c-sky.com,
        gnu-csky@mentor.com, thomas.petazzoni@bootlin.com,
        wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
Subject: Re: [PATCH V2 19/19] irqchip: add C-SKY irqchip drivers
Message-ID: <20180703073852.GA24133@guoren>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <b940404f1994ecb839fe6f09f6b6f3cfe81ee5fe.1530465326.git.ren_guo@c-sky.com>
 <CABGGiszccmOLMsLq4qRNjtq6hbR6XjP1P8Jj26kxQYhQUm14Eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABGGiszccmOLMsLq4qRNjtq6hbR6XjP1P8Jj26kxQYhQUm14Eg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 09:27:13PM -0600, Rob Herring wrote:
> Commit message needed.
Ok

> Do you mean "legacy"?
Yes, it's from arch/csky/Kconfig.debug, and I'll correct it in next
version patch.
 
> It would be better to make this run-time so you can support multiple
> platforms in one build. You should be able to determine this from DT.
The CSKY_VECIRQ_LEGACY means when cpu receive the IRQ, it will directly
enter into the exception vector entry indexed by IRQ number. Just some
old SOC need the feature. We reserve it just as we've mentioned in
arch/csky/Kconfig.debug:

config CSKY_VECIRQ_LEGENCY
	bool "Use legency IRQ vector for interrupt, it's for SOC bugfix."
	help
	  It's a deprecated method for arch/csky. Don't use it, unless your
	  SOC has bug.

As we need this config to setup the vector tables in
arch/csky/kernel/traps.c, "determine this from DT" isn't suitable for us.

> > +IRQCHIP_DECLARE(csky_intc_v1, "csky,intc-v1", csky_intc_v1_init);
> 
> DT bindings must be documented. And the vendor prefix must also be
> registered in vendor-prefixes.txt.
Ok, thx for the tips. I'll follow the rules.

> > +IRQCHIP_DECLARE(csky_intc_v2, "csky,intc-v2", csky_intc_v2_init);
> 
> And this one. Use of v1, v2, etc. is generally discouraged unless
> there is some strict versioning behind it. Most bindings use
> implementation specific compatible strings (which typically means the
> SoC name/number as part of it).

> > +IRQCHIP_DECLARE(nationalchip_intc_v1_ave, "nationalchip,intc-v1,ave", intc_init);
> 
> Here too. And your timers as well.
"csky,intc-v1/v2" are used in many SOCs, just like "arm,gic-v2/v3". So may I
change them like these?:
 csky,intc-v1 >>> csky,ck807-intc
                  csky,ck810-intc
                  csky,ck860-intc

 csky,intc-v2 >>> csky,ck860-mpintc

 nationalchip,intc-v1,ave >>> nationalchip,ck610-gx6605s-intc
 
> You'll also need to do cpu bindings as well especially for SMP.
Ok, thx for tips.

