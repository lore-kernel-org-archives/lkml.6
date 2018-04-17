Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751337AbeDQFtM convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 01:49:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:34256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750765AbeDQFtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 01:49:10 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A2CC21726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Russell King <linux@armlinux.org.uk>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180416175743.20826-1-jbrunet@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180416175743.20826-1-jbrunet@baylibre.com>
Message-ID: <152394414961.51482.3707791896217213422@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 0/3] clk: add duty cycle support
Date: Mon, 16 Apr 2018 22:49:09 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2018-04-16 10:57:40)
> This patchset adds the possibility to control the duty cycle ratio of a
> clock within the clock framework.
> 
> This useful when the duty cycle ratio depends on another parameter
> controlled by the clock framework. For example, the duty cycle ratio may
> depends on the value of a divider (ratio = N / div).
> 
> This is also useful if the related clock is part of large tree. In this
> case, using CCF to control the clock tree and the PWM framework for the
> duty cycle would be a nightmare for the provider and the consumer.

Can you please Cc the PWM maintainer on this patch series?

> 
> A clock provider is not required to implement the operation to set and get
> the duty cycle. If it does not implement .get_duty_cycle(), the ratio is
> assumed to be 50%.
> 
> This series also provides pass-through operations ready to be used for
> clock which don't resample the clock signal (such as gates and muxes).
> This is provided to make things easier for consumers. Clocks are usually
> made of several elements, like a composite clocks with a mux, a divider,
> and a gate. With the pass-through ops set on the gate, the consumer does
> not need to be aware that the duty cycle is actually controlled by the
> divider, it can continue to use the clock through the gate, as usual.  The
> simple propagation will stop at the first clock which resample the signal
> (such as a divider).
> 
> Patch 2 and 3 add the pass-through ops to the generic gate and mux ops.  In
> this first version, it is unconditional, but maybe we should provide a flag
> to let people decide what is best for them ?
> 
> The series has been developed to handled the sample clocks provided by
> audio clock controller of amlogic's A113 SoC. To support i2s modes, this
> clock need to have a 50% duty cycle ratio, while it should be just one
> pulse of the parent clock in dsp modes.

Cool. I've heard rumblings from some other SoC manufacturers that they
want duty cycle control via the clk framework but nothing came of it, so
thanks for picking this up.

> 
> PS: Checkpatch complains heavily about the white space in the trace header
> file. I believe I have respected the style already used in this
> file. Please let me know if it should be done differently.

The trace file looks fine. Ignore checkpatch.
