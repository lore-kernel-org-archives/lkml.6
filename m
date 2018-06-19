Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDEFC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 929FA20874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:34:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 929FA20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ladisch.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756186AbeFSGen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 02:34:43 -0400
Received: from webclient5.webclient5.de ([136.243.32.184]:44195 "EHLO
        webclient5.webclient5.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751166AbeFSGem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 02:34:42 -0400
X-Greylist: delayed 485 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Jun 2018 02:34:42 EDT
Received: from [10.1.2.4] (unknown [94.101.37.79])
        by webclient5.webclient5.de (Postfix) with ESMTPSA id F22755582405;
        Tue, 19 Jun 2018 08:26:34 +0200 (CEST)
Subject: Re: [PATCH] firewire: ohci: stop using get_seconds() for BUS_TIME
To:     Arnd Bergmann <arnd@arndb.de>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        linux1394-devel@lists.sourceforge.net, y2038@lists.linaro.org,
        Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>
References: <20180618141933.3404739-1-arnd@arndb.de>
From:   Clemens Ladisch <clemens@ladisch.de>
Message-ID: <355fd76d-0196-55b8-20f5-9b3136507690@ladisch.de>
Date:   Tue, 19 Jun 2018 08:26:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180618141933.3404739-1-arnd@arndb.de>
Content-Type: text/plain; charset=us-ascii
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.99.4 at webclient5
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:
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
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-By: Clemens Ladisch <clemens@ladisch.de>

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
