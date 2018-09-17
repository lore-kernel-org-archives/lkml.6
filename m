Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5DAECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81824214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:36:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81824214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbeIQODR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 10:03:17 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:54240 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727166AbeIQODR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 10:03:17 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07658547|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03298;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.Cruj.ud_1537173385;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.Cruj.ud_1537173385)
          by smtp.aliyun-inc.com(10.147.43.230);
          Mon, 17 Sep 2018 16:36:25 +0800
Date:   Mon, 17 Sep 2018 16:36:25 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Rob Herring <robh@kernel.org>
Cc:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V5 2/3] dt-bindings: interrupt-controller: C-SKY APB intc
Message-ID: <20180917083623.GA1069@guoren>
References: <a70337117db84f6e1091d0b3fc28acb691ac9b35.1537087118.git.ren_guo@c-sky.com>
 <162f7f98697cd9d806a1a843c6177bb943ea2b33.1537087118.git.ren_guo@c-sky.com>
 <20180917062336.GA20555@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180917062336.GA20555@bogus>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 02:23:36AM -0400, Rob Herring wrote:
> On Sun, Sep 16, 2018 at 04:50:03PM +0800, Guo Ren wrote:
> > Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> 
> Needs a commit description.
> 
> > ---
> >  .../interrupt-controller/csky,apb-intc.txt         | 70 ++++++++++++++++++++++
> >  1 file changed, 70 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt
> > new file mode 100644
> > index 0000000..be7c3d1
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt
> > @@ -0,0 +1,70 @@
> > +==============================
> > +C-SKY APB Interrupt Controller
> > +==============================
> > +
> > +C-SKY APB Interrupt Controller is a simple soc interrupt controller
> > +on the apb bus and we only use it as root irq controller.
> > +
> > + - csky,apb-intc is used in a lot of csky fpgas and socs, it support 64 irq nums.
> > + - csky,dual-apb-intc consists of 2 apb-intc and 128 irq nums supported.
> > + - csky,gx6605s-intc is gx6605s soc internal irq interrupt controller, 64 irq nums.
> 
> Is there a relationship between csky,gx6605s-intc and csky,apb-intc?
They all use pending register to get irq num and use enable register to
mask/unmask.

> > +        - support-pulse-signal:
> > +                Usage: select
> > +		Description: to support pulse signal flag
> 
> What is this for?
This is a level-triger interrupt controller at first, but we want it
to support pulse signal. It means that when the pulse signal coming,
the pending register will hold signals without clear the IFR reg.

Some C-SKY cpu's socs need this feature to support pulse interrupt
signal.

> > +	intc: interrupt-controller@500000 {
> > +		compatible = "csky,apb-intc";
> > +		#interrupt-cells = <1>;
> > +		reg = <0x00500000 0x400>;
> > +		interrupt-controller;
> > +	};
> Not really worth 2 examples for just 1 property difference.
Ok.
I'll retain the above, because only a few socs use support-pulse-signal.
