Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752100AbeDJSRo convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 14:17:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:58190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751490AbeDJSRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 14:17:43 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 880E221738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <a4451252-35e4-e63f-8cca-a072f90fa9ad@arm.com>
Cc: Jason Cooper <jason@lakedaemon.net>, linux-arm-msm@vger.kernel.org,
        Hanna Hawa <hannah@marvell.com>, Stephen Boyd <sboyd@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org
References: <20170320223614.1351-1-sboyd@codeaurora.org>
 <bac1e827-3860-d92c-7bb4-eaf9840c608f@arm.com>
 <20180410170155.6e07113d@windsurf>
 <a4451252-35e4-e63f-8cca-a072f90fa9ad@arm.com>
Message-ID: <152338426182.180276.1835672071236851795@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] irqchip/gic-v3: Support v2m frame backwards compatibility mode
Date: Tue, 10 Apr 2018 11:17:41 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Marc Zyngier (2018-04-10 08:23:00)
> On 10/04/18 16:01, Thomas Petazzoni wrote:
> 
> > In the upcoming Armada 8KP, we have a GICv3, which has built-in support
> > for memory-triggered SPIs, thanks to the GICD_SETSPI_NSR and
> > GICD_CLRSPI_NSR, and the ICU will directly use this GICv3
> > functionality. We would therefore very much like to have this GICv3
> > feature provided as a MSI controller, which as Marc said would require
> > supporting level-triggered MSIs.
> > 
> > Marc, let me know how we can collaborate on this topic. I'm able to
> > either test some preliminary patches, or work on such patches if
> > necessary (preferably with some initial directions).
> 
> I have a vague idea how to support this. Given that level-triggered MSIs
> have to be platform MSIs (because it is just madness otherwise), we can
> probably store an extra message in the struct platform_msi_desc for the
> "lower the line" write. On activation, you'd get two callbacks, probably
> with a flag of some sort to indicate whether this is for the rising or
> falling edge. The thing I'm unclear about so far is how to let the
> generic MSI layer know that we're dealing with such an interrupt without
> make a total mess of everything. It is probably done by marking the
> interrupt level triggered, but there are some corner cases.
> 
> And if that works, the PCI stuff will come for free (it is just a matter
> of implementing a new irqdomain on top of the base GICv3 one).
> 
> I'll try to spend some time on it in the coming couple of weeks, but
> will have to rely on you for the testing (as I don't have much in the
> way of HW).

I resent these patches late last year[1]. On the HW I had at the time we
were trying to support PCIe devices and we didn't need level interrupts.
I thought Marc had agreed to accept the patches without the level
interrupt support as long as we described the range of interrupts that
were supported but that doesn't seem to be the case anymore.

Anyway, this is mostly an FYI that I don't have the hardware to test
with anymore and I'm not going to keep sending patches on this topic.
Srini should have some hardware to test whatever solution you come up
with.

[1] http://lkml.kernel.org/r/20171127102408.6631-1-sboyd@codeaurora.org
