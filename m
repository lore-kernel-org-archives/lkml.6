Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C01F83CA1
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 06:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44C57205C9
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 06:40:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44C57205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbeG2ICS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 04:02:18 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.167]:30526 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbeG2ICR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 04:02:17 -0400
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBs7wpz98S0pHy2eYvMPA=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 43.13 DYNA|AUTH)
        with ESMTPSA id 6047f4u6T6Wgq6Z
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sun, 29 Jul 2018 08:32:42 +0200 (CEST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] pwm: pwm-omap-dmtimer: fix probing problems by returning EPROBE_DEFER
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20180728203501.GA16194@lenoch>
Date:   Sun, 29 Jul 2018 08:32:41 +0200
Cc:     linux-pwm@vger.kernel.org, linux-omap <linux-omap@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>, Keerthy <j-keerthy@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <BE83C4E8-55B0-4EA7-8FF6-756460464264@goldelico.com>
References: <20180728165914.15871-1-andreas@kemnade.info> <20180728203501.GA16194@lenoch>
To:     Ladislav Michl <ladis@linux-mips.org>,
        Andreas Kemnade <andreas@kemnade.info>,
        David Rivshin <drivshin@allworx.com>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Am 28.07.2018 um 22:35 schrieb Ladislav Michl <ladis@linux-mips.org>:
> 
> Hi Andreas,
> 
> On Sat, Jul 28, 2018 at 06:59:14PM +0200, Andreas Kemnade wrote:
>> I got this in the kernel log:
>> [    0.756042] omap-dmtimer-pwm dmtimer-pwm: dmtimer pdata structure NULL
>> [    0.756134] omap-dmtimer-pwm: probe of dmtimer-pwm failed with error -22
>> 
>> the probe function has to wait until omap_dm_timer_probe() in
>> clocksource/timer-ti-dm.c has initialized pdata, so defer probing
> 
> There already is a patch by David Rivshin addressing the same issue...

Here it is:

https://patchwork.ozlabs.org/patch/943148/

but hasn't arrived in linux-next.

But it is questionable if a driver should dev_info() about doing deferred probing.
IMHO, it should just do it which is how Andreas' patch works.

> 
>> Fixes: b7290cf6ff78 (pwm: pwm-omap-dmtimer: Adapt driver to utilize dmtimer pdata ops)
>> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
>> ---
>> drivers/pwm/pwm-omap-dmtimer.c | 3 +--
>> 1 file changed, 1 insertion(+), 2 deletions(-)
>> 
>> diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
>> index 665da3c8fbce..808835179c2e 100644
>> --- a/drivers/pwm/pwm-omap-dmtimer.c
>> +++ b/drivers/pwm/pwm-omap-dmtimer.c
>> @@ -264,8 +264,7 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
>> 
>> 	timer_pdata = dev_get_platdata(&timer_pdev->dev);
>> 	if (!timer_pdata) {
>> -		dev_err(&pdev->dev, "dmtimer pdata structure NULL\n");
>> -		ret = -EINVAL;
>> +		ret = -EPROBE_DEFER;
>> 		goto put;
>> 	}
>> 
>> -- 
>> 2.11.0
>> 

BR,
Nikolaus


