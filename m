Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A80C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39402205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="fve4w6Gv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39402205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbeJPXyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 19:54:35 -0400
Received: from smtprelay4.synopsys.com ([198.182.47.9]:41608 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbeJPXyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 19:54:35 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id B8F9E24E08C3;
        Tue, 16 Oct 2018 09:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1539705808; bh=vv3ywCtAV6J1iVElZqAnV51xx8osfdwKhY4bziFFPEU=;
        h=From:To:CC:Subject:Date:References:From;
        b=fve4w6Gvel7KjLG2CEZ76YOU5Z7Y0hwE3Kl/8b15LuljIvPKj/y9MvOJyGD5dW2SO
         P0XUp4Zu9n01NWcX88+ByhAJMhBCctzOEF5B/KylI18vkee024JyRiDOBurUFOT0Sy
         OIOHXpcZXcJU8joiIHvniiF8aqcaN4bzHLrB24OV4cVmEopnstSwnmNHRkgwnunHm3
         AlHcZtC8ULlXeXbZiLrr7k7iRQHHf/bOHdcLpInRCP/ICPwmCcZiwxe5aLCgF2A/Mk
         0RnIcsECUX2LSedqTAI4ftDHs0Lt60UYKbClOVimSe5X6njUiggEVD+I1sYg8uV5hW
         n5tA1k016jRrQ==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id 38A683093;
        Tue, 16 Oct 2018 09:03:28 -0700 (PDT)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by US01WXQAHTC1.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000;
 Tue, 16 Oct 2018 09:03:28 -0700
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     Alexey Brodkin <alexey.brodkin@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] clocksource/drivers/arc_timer: Utilize generic
 sched_clock
Thread-Topic: [PATCH] clocksource/drivers/arc_timer: Utilize generic
 sched_clock
Thread-Index: AQHUZSQrx0Qmu49VI06mKwaw7Xomww==
Date:   Tue, 16 Oct 2018 16:03:27 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075012B0AE356@US01WEMBX2.internal.synopsys.com>
References: <20181016074504.2042-1-abrodkin@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.199.106]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/2018 12:45 AM, Alexey Brodkin wrote:=0A=
> It turned out we used to use default implementation of sched_clock()=0A=
> from kernel/sched/clock.c which was as precise as 1/HZ, i.e.=0A=
> by default we had 10 msec granularity of time measurement.=0A=
>=0A=
> Now given ARC built-in timers are clocked with the same frequency as=0A=
> CPU cores we may get much higher precision of time tracking.=0A=
=0A=
Can you do LMBench runs with and w/o and see if there's any other changes. =
I'm=0A=
hoping lat_ctx will be more consistent.=0A=
=0A=
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig=0A=
> index dec0dd88ec15..3268dad4effe 100644=0A=
> --- a/drivers/clocksource/Kconfig=0A=
> +++ b/drivers/clocksource/Kconfig=0A=
> @@ -290,6 +290,7 @@ config CLKSRC_MPS2=0A=
>  =0A=
>  config ARC_TIMERS=0A=
>  	bool "Support for 32-bit TIMERn counters in ARC Cores" if COMPILE_TEST=
=0A=
> +	depends on GENERIC_SCHED_CLOCK=0A=
=0A=
It needs to select, not depends on=0A=
=0A=
> @@ -88,6 +89,11 @@ static u64 arc_read_gfrc(struct clocksource *cs)=0A=
>  	return (((u64)h) << 32) | l;=0A=
>  }=0A=
>  =0A=
> +static u64 arc_gfrc_clock_read(void)=0A=
=0A=
Needs to be notrace like other such routines.=0A=
=0A=
>=0A=
> +=0A=
>  static struct clocksource arc_counter_timer1 =3D {=0A=
>  	.name   =3D "ARC Timer1",=0A=
>  	.rating =3D 300,=0A=
> @@ -209,6 +229,8 @@ static int __init arc_cs_setup_timer1(struct device_n=
ode *node)=0A=
>  	write_aux_reg(ARC_REG_TIMER1_CNT, 0);=0A=
>  	write_aux_reg(ARC_REG_TIMER1_CTRL, TIMER_CTRL_NH);=0A=
>  =0A=
> +	sched_clock_register(arc_timer1_clock_read, 64, arc_timer_freq);=0A=
=0A=
TIMER1 is 32 bits wide.=0A=
=0A=
-Vineet=0A=
