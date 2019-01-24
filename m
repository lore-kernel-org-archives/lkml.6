Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41B7C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF69621872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbfAXKkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 05:40:25 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:49385 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfAXKkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 05:40:24 -0500
Received: from 79.184.255.239.ipv4.supernova.orange.pl (79.184.255.239) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id dbbc36c8b17a10fc; Thu, 24 Jan 2019 11:40:22 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpuidle: use BIT() for idle state flags and remove CPUIDLE_DRIVER_FLAGS_MASK
Date:   Thu, 24 Jan 2019 11:39:22 +0100
Message-ID: <11142952.kgryYQbe4O@aspire.rjw.lan>
In-Reply-To: <20190115172210.19793-1-tiny.windzz@gmail.com>
References: <20190115172210.19793-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, January 15, 2019 6:22:10 PM CET Yangtao Li wrote:
> Use BIT() macro to do a small tidy-up. The CPUIDLE_DRIVER_FLAGS_MASK
>  is not being used, so remove it.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  include/linux/cpuidle.h | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index 4dff74f48d4b..3b39472324a3 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -69,11 +69,9 @@ struct cpuidle_state {
>  
>  /* Idle State Flags */
>  #define CPUIDLE_FLAG_NONE       (0x00)
> -#define CPUIDLE_FLAG_POLLING	(0x01) /* polling state */
> -#define CPUIDLE_FLAG_COUPLED	(0x02) /* state applies to multiple cpus */
> -#define CPUIDLE_FLAG_TIMER_STOP (0x04)  /* timer is stopped on this state */
> -
> -#define CPUIDLE_DRIVER_FLAGS_MASK (0xFFFF0000)
> +#define CPUIDLE_FLAG_POLLING	BIT(0) /* polling state */
> +#define CPUIDLE_FLAG_COUPLED	BIT(1) /* state applies to multiple cpus */
> +#define CPUIDLE_FLAG_TIMER_STOP BIT(2) /* timer is stopped on this state */
>  
>  struct cpuidle_device_kobj;
>  struct cpuidle_state_kobj;
> 

Applied, even though I'm not a big fan of conversions from open-coded
values (as long as they are correct) to BIT(), unless you are going to
add a new flag and want to use BIT() for that, because that doesn't really
matter and only makes the lives of 'git blame' users harder.

However, in this particular case, the removal of the unused symbol is
legitimate IMO.

