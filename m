Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BABC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 951E720870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:14:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 951E720870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hazent.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbeLLPOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 10:14:49 -0500
Received: from salem.gmr.ssr.upm.es ([138.4.36.7]:44106 "EHLO
        salem.gmr.ssr.upm.es" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbeLLPOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 10:14:47 -0500
X-Greylist: delayed 509 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Dec 2018 10:14:45 EST
Received: by salem.gmr.ssr.upm.es (Postfix, from userid 1000)
        id 5AC86AC1057; Wed, 12 Dec 2018 16:06:12 +0100 (CET)
Date:   Wed, 12 Dec 2018 16:06:12 +0100
From:   Alvaro Gamez Machado <alvaro.gamez@hazent.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [RFC v2] pwm: Add Xilinx AXI Timer in PWM mode support
Message-ID: <20181212150610.GA17818@salem.gmr.ssr.upm.es>
References: <20180322135316.19685-1-alvaro.gamez@hazent.com>
 <20181212104241.GA17654@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212104241.GA17654@ulmo>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 11:42:41AM +0100, Thierry Reding wrote:
> Did any discussion regarding the above-mentioned issues ever ensue? How
> do you want to proceed? At the very least we'll need some sort of device
> tree binding for this driver, so perhaps start with a DT binding
> proposal and take it from there?

No, nothing ever came up about this.

When I sent v1 of this RFC patch I started using it on the application I
needed it for, so what I did was to copy standard DT binding for
xlnx,xps-timer-1.00.a (the one that arch/microblaze/kernel.c looks for) and
replace the compatible string with one I just came up with in the moment,
xlnx,axi-timer-2.0, but now I don't think this was a good name, and it'd
look better as xlnx,axi-pwm

This would be my preferred approach, choosing the driver to use for each
instance of the same IP core by changing the compatible string. I think it's
cleaner and less error prone, but I don't know if this is acceptable (two
identical hardware devices with different compatible strings).

For Xilinx IP cores there's an utility from Xilinx that generates DTS
entries, so leaving the rest of settings as they are could be acceptable,
meaning that DT binding for an AXI timer being used as a PWM driver would be
like this, where the only change is the compatible string:

pwm_0: timer@timer@41c10000 {
	clock-frequency = <83250000>; // Redundant given clocks property
	clocks = <&clk_bus_0>;
	compatible = "xlnx,axi-pwm";
	reg = <0x41c10000 0x10000>;
	xlnx,count-width = <0x20>; // Could be used as limiting factor
	xlnx,gen0-assert = <0x1>; // Not used
	xlnx,gen1-assert = <0x1>; // Not used
	xlnx,one-timer-only = <0x0>; // If 1, IP can't do PWM
	xlnx,trig0-assert = <0x1>; // Not used
	xlnx,trig1-assert = <0x1>; // Not used
}

Required properties:
- compatible: should be "xlnx,axi-pwm" or whatever we agree on
- reg: physical base address and length of the controller's registers
- clocks: This clock defines the base clock frequency of the PWM hardware
  system, the period and the duty_cycle of the PWM signal is a multiple of
  the base period.
- xlnx,one-timer-only: Should be 1.

Correct me if I'm mistaken, but clock-frequency is redundant both here and
in the timer definitions, right?

Property 'xlnx,one-timer-only' is also used by kernel.c to check that the IP
core was synthesized with two timers, needed also for PWM operation, so I'd
leave too with the same intent.

Thanks for your interest!

-- 
Alvaro G. M.
