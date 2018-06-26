Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F59C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB9C525D56
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aScb+SEC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB9C525D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753288AbeFZRTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:19:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44712 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752223AbeFZRT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:19:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=a+YJ5U1OsfqH1vIiHa1D5xaMIf4GrfvMlXJ8wJZYya0=; b=aScb+SEC6O7oHMAsZksMzwsxG
        ap+XsxpNQjifwNAlQp0K8y68/tiEFXnQFQgpgQ5fmvZ5aPH4tFdRClP1zzOgUpwgcwgCJ8/bI7DiO
        YNaCr6DrZfCfmVinT9nFwfSqpUZ3rT4G6HZOoLkJcJhQBI6DycKC2n5YnBHL8ISNiFmxThxCywzrh
        9lHIOQJvpsOMyKzed7HOzK40mXPieboYzzOM/jQ/zdc+o89uQqg5zNp3tpiqsCh8WbBAUemsVzAma
        EVjZ8SooUnlz/8ypDrVeNh3rg4NTXF/ovJ/Z9nLrni1MLyakje8va8Gg3rvVg1VwFCBhdf/u1/XPn
        lGSEcErBw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fXrcm-00039c-2J; Tue, 26 Jun 2018 17:19:28 +0000
Subject: Re: [PATCH] Documentation: document ktime_get_*() APIs
To:     Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>
Cc:     y2038@lists.linaro.org, Dave Chinner <david@fromorbit.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Michal Hocko <mhocko@suse.com>, Ingo Molnar <mingo@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180626160442.572358-1-arnd@arndb.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d437aba7-f25f-0a96-e42b-997a3b6cda23@infradead.org>
Date:   Tue, 26 Jun 2018 10:19:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180626160442.572358-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/26/2018 09:03 AM, Arnd Bergmann wrote:
> As Dave Chinner points out, we don't have a proper documentation for the
> ktime_get() family of interfaces, making it rather unclear which of the
> over 30 (!) interfaces one should actually use in a driver or elsewhere
> in the kernel.
> 
> I wrote up an explanation from how I personally see the interfaces,
> documenting what each of the functions do and hopefully making it a bit
> clearer which should be used where.
> 
> This is the first time I tried writing .rst format documentation, so
> in addition to any mistakes in the content, I probably also introduce
> nonstandard formatting ;-)
> 
> I first tried to add an extra section to
> Documentation/timers/timekeeping.txt, but this is currently not included
> in the generated API, and it seems useful to have the API docs as part
> of what gets generated in
> https://www.kernel.org/doc/html/latest/core-api/index.html#core-utilities
> instead, so I started a new file there.
> 
> I also considered adding the documentation inline in the
> include/linux/timekeeping.h header, but couldn't figure out how to do
> that in a way that would result both in helpful inline comments as
> well as readable html output, so I settled for the latter, with
> a small note pointing to it from the header.
> 
> Cc: Dave Chinner <david@fromorbit.com>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  Documentation/core-api/index.rst       |   1 +
>  Documentation/core-api/timekeeping.rst | 185 +++++++++++++++++++++++++++++++++
>  include/linux/timekeeping.h            |  15 +++
>  3 files changed, 201 insertions(+)
>  create mode 100644 Documentation/core-api/timekeeping.rst
> 
> diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
> index f5a66b72f984..989c97cc232a 100644
> --- a/Documentation/core-api/index.rst
> +++ b/Documentation/core-api/index.rst
> @@ -28,6 +28,7 @@ Core utilities
>     printk-formats
>     circular-buffers
>     gfp_mask-from-fs-io
> +   timekeeping
>  
>  Interfaces for kernel debugging
>  ===============================
> diff --git a/Documentation/core-api/timekeeping.rst b/Documentation/core-api/timekeeping.rst
> new file mode 100644
> index 000000000000..97dafa69dddf
> --- /dev/null
> +++ b/Documentation/core-api/timekeeping.rst
> @@ -0,0 +1,185 @@
> +ktime access
> +============

I would prefer "ktime accessors" or "ktime interfaces", but no big deal.

> +
> +Device drivers can read the current time using ktime_get() and the many
> +related functions declared in linux/timekeeping.h. As a rule of thumb,
> +using an accessor with a shorter name is preferred over one with a longer
> +name if both are equally fit for a particular use case.
> +
> +Basic ktime_t based interfaces
> +------------------------------
> +
> +The recommended simplest form returns an opaque ktime_t, with variants
> +that return time for different clock references:
> +
> +
> +.. c:function:: ktime_t ktime_get( void )
> +
> +	CLOCK_MONOTONIC
> +
> +	Useful for reliable timestamps and measuring short time intervals
> +	accurately. Starts at system boot time but stops during suspend.
> +
> +.. c:function:: ktime_t ktime_get_boottime( void )
> +
> +	CLOCK_BOOTTIME
> +
> +	Like ktime_get(), but does not stop when suspended. This can be
> +	used e.g. for key expiration times that need to be synchronized
> +	with other machines across a suspend operation.
> +
> +.. c:function:: ktime_t ktime_get_real( void )
> +
> +	CLOCK_REALTIME
> +
> +	Returns the time in relative to the UNIX epoch starting in 1970
> +	using the Coordinated Universal Time (UTC), same as gettimeofday()
> +	user space. This is used for all timestamps that need to
> +	persist across a reboot, like inode times, but should be avoided
> +	for internal uses, since it can jump backwards due to a leap
> +	second update, NTP adjustment settimeofday() operation from user
> +	space.
> +
> +.. c:function:: ktime_t ktime_get_clocktai( void )
> +
> +	 CLOCK_TAI
> +
> +	Like ktime_get_real(), but uses the International Atomic Time (TAI)
> +	reference instead of UTC to avoid jumping on leap second updates.
> +	This is rarely useful in the kernel.
> +
> +.. c:function:: ktime_t ktime_get_raw( void )
> +
> +	CLOCK_MONOTONIC_RAW
> +
> +	Like ktime_get(), but runs at the same rate as the hardware
> +	clocksource without (NTP) adjustments for clock drift. This is
> +	also rarely needed in the kernel.
> +
> +nanosecond, timespec64, and second output
> +-------------------------------------

Documentation/core-api/timekeeping.rst:60: WARNING: Title underline too short.

nanosecond, timespec64, and second output
-------------------------------------

and that's the only sphinx error or warning that I see.  Nice.



Tested-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

thanks,
-- 
~Randy
