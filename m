Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2145AC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED6D2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:15:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DED6D2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbeJBAyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 20:54:35 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58240 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbeJBAye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 20:54:34 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g72jB-0001yA-Fd; Mon, 01 Oct 2018 20:15:29 +0200
Date:   Mon, 1 Oct 2018 20:15:28 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Mark Salyzyn <salyzyn@android.com>
cc:     linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dmitry Safonov <dsafonov@virtuozzo.com>,
        John Stultz <john.stultz@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Pinski <apinski@cavium.com>,
        linux-arm-kernel@lists.infradead.org,
        Jeremy Linton <Jeremy.Linton@arm.com>,
        android-kernel@android.com, Jinbum Park <jinb.park7@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: RESEND [PATCH v6 11/12] lib: vdso: Add support for
 CLOCK_BOOTTIME
In-Reply-To: <20181001175845.168430-12-salyzyn@android.com>
Message-ID: <alpine.DEB.2.21.1810012009010.32062@nanos.tec.linutronix.de>
References: <20181001175845.168430-1-salyzyn@android.com> <20181001175845.168430-12-salyzyn@android.com>
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

On Mon, 1 Oct 2018, Mark Salyzyn wrote:
>  
> +static notrace int do_boottime(const struct vdso_data *vd, struct timespec *ts)
> +{
> +	u32 seq, mult, shift;
> +	u64 nsec, cycle_last;
> +	vdso_wtm_clock_nsec_t wtm_nsec;
> +
> +	/* open coding timespec_add_ns to save a ts->tv_nsec = 0 */
> +	ts->tv_sec = sec + __iter_div_u64_rem(nsec, NSEC_PER_SEC, &nsec);
> +	ts->tv_nsec = nsec;
> +
> +	return 0;
> +}
> +

Instead of adding yet another copy of the same code you might want to look
at the rework I did for the x86 vdso in order to support CLOCK_TAI w/o
running into the issue of the clock switch case being compiled into a jump
table and then the compile asking for retpoline.

  http://lkml.kernel.org/r/20180917124533.329334911@linutronix.de

Thanks,

	tglx
