Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61356C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 275C82084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uRJX5DBs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732891AbfAKNv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 08:51:29 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:40302 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732876AbfAKNv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 08:51:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=kMAKAE1n6w0jiweeK7Ui6ZhFN+TRzH4vfpyEDeal7QY=;
        b=uRJX5DBsVuGkpmCWHZAnwbGPL8eAyGl0/nwPLAMk/ZzpTj7P31VUGmHjI3cQgvg25uIjNbC/0yLLHKD6zTGVuFAru0pW4dpnsBeBk9XmUXLKR9V/5O5tGDNv9/xiFE42ACpN7n+T6E5aSqp0J258cRCKOHNOwOoIiEkSySjb6xI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1ghxDZ-0000w2-C2; Fri, 11 Jan 2019 14:51:25 +0100
Date:   Fri, 11 Jan 2019 14:51:25 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-pwm@vger.kernel.org,
        Praveen Kumar B <praveen.b@broadcom.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] drivers: pwm: pwm-bcm-kona: Add pwm-kona-v2 support
Message-ID: <20190111135125.GC1895@lunn.ch>
References: <1547184076-20521-1-git-send-email-sheetal.tigadoli@broadcom.com>
 <1547184076-20521-3-git-send-email-sheetal.tigadoli@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547184076-20521-3-git-send-email-sheetal.tigadoli@broadcom.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 10:51:15AM +0530, Sheetal Tigadoli wrote:
> From: Praveen Kumar B <praveen.b@broadcom.com>
> 
> Add support for new version of pwm-kona.
> Add support to make PWM changes configured and stable.
> 
> Signed-off-by: Praveen Kumar B <praveen.b@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> Signed-off-by: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
> ---
>  drivers/pwm/pwm-bcm-kona.c | 128 ++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 98 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
> index 09a95ae..2b44ad8 100644
> --- a/drivers/pwm/pwm-bcm-kona.c
> +++ b/drivers/pwm/pwm-bcm-kona.c
> @@ -45,30 +45,39 @@
>   *    high or low depending on its state at that exact instant.
>   */
>  
> -#define PWM_CONTROL_OFFSET			(0x00000000)
> +#define PWM_CONTROL_OFFSET			0x00000000
>  #define PWM_CONTROL_SMOOTH_SHIFT(chan)		(24 + (chan))
>  #define PWM_CONTROL_TYPE_SHIFT(chan)		(16 + (chan))
>  #define PWM_CONTROL_POLARITY_SHIFT(chan)	(8 + (chan))
>  #define PWM_CONTROL_TRIGGER_SHIFT(chan)		(chan)
>  
> -#define PRESCALE_OFFSET				(0x00000004)
> +#define PRESCALE_OFFSET				0x00000004
>  #define PRESCALE_SHIFT(chan)			((chan) << 2)
>  #define PRESCALE_MASK(chan)			(0x7 << PRESCALE_SHIFT(chan))
> -#define PRESCALE_MIN				(0x00000000)
> -#define PRESCALE_MAX				(0x00000007)
> +#define PRESCALE_MIN				0x00000000
> +#define PRESCALE_MAX				0x00000007

Hi Praveen

These changes are unrelated to adding support for a new PWM. So
ideally they should be in a separate patch.

> +static int kona_pwmc_wait_stable(struct pwm_chip *chip, unsigned int chan,
> +				 unsigned int kona_ver)
> +{
> +	struct kona_pwmc *kp = to_kona_pwmc(chip);
> +	unsigned int value;
> +	unsigned int count = PWM_MONITOR_TIMEOUT_US * 1000;
> +
> +	switch (kona_ver) {
> +	case KONA_PWM_V1:
> +		/*
> +		 * There must be a min 400ns delay between clearing trigger and
> +		 * settingit. Failing to do this may result in no PWM signal.
> +		 */
> +		ndelay(400);
> +		return 0;
> +	case KONA_PWM_V2:
> +		do {
> +			value = readl(kp->base + PWM_MONITOR_OFFSET);
> +			if (!(value & (BIT(chan))))
> +				return 0;
> +			ndelay(1);
> +		} while (count--);

You can probably use readl_poll_timeout() here.

    Andrew
