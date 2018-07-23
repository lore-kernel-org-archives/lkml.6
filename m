Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91078ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55CAE20883
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:40:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55CAE20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=s5r6.in-berlin.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388585AbeGWNlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:41:09 -0400
Received: from einhorn-mail.in-berlin.de ([217.197.80.20]:53933 "EHLO
        einhorn-mail.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387909AbeGWNlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:41:08 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Received: from authenticated.user (localhost [127.0.0.1]) by einhorn.in-berlin.de  with ESMTP id w6NCcwuq013870
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Jul 2018 14:38:58 +0200
Date:   Mon, 23 Jul 2018 14:38:58 +0200
From:   Stefan Richter <stefanr@s5r6.in-berlin.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038@lists.linaro.org, Clemens Ladisch <clemens@ladisch.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Hector Martin <marcan@marcan.st>,
        linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RESEND] firewire: ohci: stop using get_seconds() for
 BUS_TIME
Message-ID: <20180723143858.27558e27@kant>
In-Reply-To: <20180711124923.1205200-1-arnd@arndb.de>
References: <20180711124923.1205200-1-arnd@arndb.de>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 11 Arnd Bergmann wrote:
> The ohci driver uses the get_seconds() function to implement the 32-bit
> CSR_BUS_TIME register. This was added in 2010 commit a48777e03ad5
> ("firewire: add CSR BUS_TIME support").
> 
> As get_seconds() returns a 32-bit value (on 32-bit architectures), it
> seems like a good fit for that register, but it is also deprecated because
> of the y2038/y2106 overflow problem, and should be replaced throughout
> the kernel with either ktime_get_real_seconds() or ktime_get_seconds().
> 
> I'm using the latter here, which uses monotonic time. This has the
> advantage of behaving better during concurrent settimeofday() updates
> or leap second adjustments and won't overflow a 32-bit integer, but
> the downside of using CLOCK_MONOTONIC instead of CLOCK_REALTIME is
> that the observed values are not related to external clocks.
> 
> If we instead need UTC but can live with clock jumps or overflows,
> then we should use ktime_get_real_seconds() instead, retaining the
> existing behavior.
> 
> Reviewed-by: Clemens Ladisch <clemens@ladisch.de>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I notice that Stefan Richter has not been active on the mailing lists
> since February 2018.

Thanks Arnd and Clemens.

I resurrected and updated one of my FireWire enabled PCs, and try to get
pack to reasonable response times to firewire driver patches.

The switch from CLOCK_REALTIME to CLOCK_MONOTONIC looks good to me, but
I'll have another look at the context.

> Andrew, could you pick it up in the meantime?
> ---
>  drivers/firewire/ohci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
> index 45c048751f3b..5125841ea338 100644
> --- a/drivers/firewire/ohci.c
> +++ b/drivers/firewire/ohci.c
> @@ -1765,7 +1765,7 @@ static u32 update_bus_time(struct fw_ohci *ohci)
>  
>  	if (unlikely(!ohci->bus_time_running)) {
>  		reg_write(ohci, OHCI1394_IntMaskSet, OHCI1394_cycle64Seconds);
> -		ohci->bus_time = (lower_32_bits(get_seconds()) & ~0x7f) |
> +		ohci->bus_time = (lower_32_bits(ktime_get_seconds()) & ~0x7f) |
>  		                 (cycle_time_seconds & 0x40);
>  		ohci->bus_time_running = true;
>  	}

-- 
Stefan Richter
-======---=- -=== =-===
http://arcgraph.de/sr/
