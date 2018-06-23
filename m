Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFA7C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 13:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AE6B24BF1
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 13:51:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AE6B24BF1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751591AbeFWNvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 09:51:04 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43370 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751326AbeFWNvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 09:51:03 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos.glx-home)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fWiur-00060r-OR; Sat, 23 Jun 2018 15:49:25 +0200
Date:   Sat, 23 Jun 2018 15:49:24 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, hpa@zytor.com, douly.fnst@cn.fujitsu.com,
        peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com,
        pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v12 06/11] time: replace read_boot_clock64() with
 read_persistent_wall_and_boot_offset()
In-Reply-To: <20180621212518.19914-7-pasha.tatashin@oracle.com>
Message-ID: <alpine.DEB.2.21.1806231537430.8650@nanos.tec.linutronix.de>
References: <20180621212518.19914-1-pasha.tatashin@oracle.com> <20180621212518.19914-7-pasha.tatashin@oracle.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jun 2018, Pavel Tatashin wrote:

> If architecture does not support exact boot time, it is challenging to
> estimate boot time without having a reference to the current persistent
> clock value. Yet, we cannot read the persistent clock time again, because
> this may lead to math discrepancies with the caller of read_boot_clock64()
> who have read the persistent clock at a different time.
> 
> This is why it is better to provide two values simultaneously: the
> persistent clock value, and the boot time.
> 
> Thus, we replace read_boot_clock64() with:
> read_persistent_wall_and_boot_offset(wall_time, boot_offset)
> 
> Where wall_time is returned by read_persistent_clock()
> And boot_offset is wall_time - boot time
> 
> We calculate boot_offset using the current value of local_clock() so
> architectures, that do not have a dedicated boot_clock but have early
> sched_clock(), such as SPARCv9, x86, and possibly more will benefit from
> this change by getting a better and more consistent estimate of the boot
> time without need for an arch specific implementation.

Again. You are doing 5 things in one patch. 

>  /**
> - * read_boot_clock64 -  Return time of the system start.
> + * read_persistent_wall_and_boot_offset - Read persistent clock, and also offset
> + *                                        from the boot.
>   *
>   * Weak dummy function for arches that do not yet support it.
> - * Function to read the exact time the system has been started.
> - * Returns a timespec64 with tv_sec=0 and tv_nsec=0 if unsupported.
> - *
> - *  XXX - Do be sure to remove it once all arches implement it.
> + * wall_time	- current time as returned by persistent clock
> + * boot_offset	- offset that is defined as wall_time - boot_time
> + * The default function calculates offset based on the current value of
> + * local_clock(). This way architectures that support sched_clock() but don't
> + * support dedicated boot time clock will provide the best estimate of the
> + * boot time.
>   */
> -void __weak read_boot_clock64(struct timespec64 *ts)
> +void __weak __init
> +read_persistent_wall_and_boot_offset(struct timespec64 *wall_time,
> +				     struct timespec64 *boot_offset)
>  {
> -	ts->tv_sec = 0;
> -	ts->tv_nsec = 0;
> +	read_persistent_clock64(wall_time);
> +	*boot_offset = ns_to_timespec64(local_clock());

Introduce the default function with

	  *boot_offset = 0;

And then in a follow up patch, add the local_clock() magic to it. This 'oh
lets do all in one just because we can' is just wrong. It's harder to
review and its bad for bisection because you cannot differentiate whether
the wreckage comes from the timekeeping_init() conversion or the magic new
functionality in read_persistent_wall_and_boot_offset().

That said, I like the local_clock() idea itself, but it might wreckage some
architecture(s), so we need to watchout for that.

>  /* Flag for if timekeeping_resume() has injected sleeptime */
> @@ -1521,28 +1527,28 @@ static bool persistent_clock_exists;
>   */
>  void __init timekeeping_init(void)
>  {
> +	struct timespec64 wall_time, boot_offset, wall_to_mono;
>  	struct timekeeper *tk = &tk_core.timekeeper;
>  	struct clocksource *clock;
>  	unsigned long flags;
> -	struct timespec64 now, boot, tmp;
> -
> -	read_persistent_clock64(&now);
> -	if (!timespec64_valid_strict(&now)) {
> -		pr_warn("WARNING: Persistent clock returned invalid value!\n"
> -			"         Check your CMOS/BIOS settings.\n");
> -		now.tv_sec = 0;
> -		now.tv_nsec = 0;
> -	} else if (now.tv_sec || now.tv_nsec)
> -		persistent_clock_exists = true;
>  
> -	read_boot_clock64(&boot);
> -	if (!timespec64_valid_strict(&boot)) {
> -		pr_warn("WARNING: Boot clock returned invalid value!\n"
> -			"         Check your CMOS/BIOS settings.\n");
> -		boot.tv_sec = 0;
> -		boot.tv_nsec = 0;
> +	read_persistent_wall_and_boot_offset(&wall_time, &boot_offset);
> +	if (timespec64_valid_strict(&wall_time) &&
> +	    timespec64_to_ns(&wall_time)) {

Can you please have an explicit ts_to_ns(wall) > 0 there? I know it's
implied in timespec64_valid_strict(), but it makes this code more obvious.

> +		persistent_clock_exists = true;
> +	} else {
> +		pr_warn("Persistent clock returned invalid value");
> +		wall_time = (struct timespec64){0};
>  	}
>  
> +	if (timespec64_compare(&wall_time, &boot_offset) < 0)
> +		boot_offset = (struct timespec64){0};
> +
> +	/* We want set wall_to_mono, so the following is true:

See: https://lkml.kernel.org/r/CA+55aFyQYJerovMsSoSKS7PessZBr4vNp-3QUUwhqk4A4_jcbg@mail.gmail.com

> +	 * wall time + wall_to_mono = boot time
> +	 */
> +	wall_to_mono = timespec64_sub(boot_offset, wall_time);
> +
>  	raw_spin_lock_irqsave(&timekeeper_lock, flags);

Thanks,

	tglx
