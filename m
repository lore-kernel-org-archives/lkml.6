Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0B1C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7638120880
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:15:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7638120880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbeIZCYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 22:24:22 -0400
Received: from mail.bootlin.com ([62.4.15.54]:53824 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbeIZCYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 22:24:22 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B42632072B; Tue, 25 Sep 2018 22:15:05 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 835CB2075C;
        Tue, 25 Sep 2018 22:14:55 +0200 (CEST)
Date:   Tue, 25 Sep 2018 22:14:56 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexander Dahl <ada@thorsis.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/7] clocksource: rework Atmel TCB timer driver
Message-ID: <20180925201456.GD3112@piout.net>
References: <20180913113024.3571-1-alexandre.belloni@bootlin.com>
 <5f19043a-3be3-e25a-849f-6ca610ed6da2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f19043a-3be3-e25a-849f-6ca610ed6da2@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/09/2018 13:29:48+0200, Daniel Lezcano wrote:
> On 13/09/2018 13:30, Alexandre Belloni wrote:
> > Hi,
> > 
> > This series reworks the Atmel TCB drivers. It introduces a new driver to handle
> > the clocksource and clockevent devices.
> > 
> > This is necessary because:
> >  - the current tcb_clksrc driver is probed too late to be able to be used at
> >    boot and we now have SoCs that don't have a PIT. They currently are not able
> >    to boot a mainline kernel.
> >  - using the PIT doesn't work well with preempt-rt because its interrupt is
> >    shared (in particular with the UART and their interrupt flags are
> >    incompatible)
> 
> You say for rt the PIT is not suitable because of the shared irq but in
> the driver, the interrupt is flagged as shared.
> 

Well, it is not simply sharing the interrupt that is an issue, it is the
mismatch between the PIT and the UART interrupt flags and that only
happens when using preempt-rt.

But still, the TCB is flagged as shared because it may be shared between
multiple TCB channels (it is the case for the more recent SoCs).
However, what happens is that the DBGU UART is always enabled on the
boards so when using the PIT, the interrupt is always shared. But, for
the TCB, the only driver currently able to use the interrupt is the
clockevent driver so the interrupt as almost no chance to actually be
shared.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
