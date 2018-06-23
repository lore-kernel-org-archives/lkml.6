Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBD0C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 13:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50DCC24C13
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 13:52:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50DCC24C13
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751998AbeFWNw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 09:52:28 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43383 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751931AbeFWNw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 09:52:26 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos.glx-home)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fWixQ-00063W-8D; Sat, 23 Jun 2018 15:52:04 +0200
Date:   Sat, 23 Jun 2018 15:52:03 +0200 (CEST)
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
Subject: Re: [PATCH v12 08/11] ARM/time: remove read_boot_clock64()
In-Reply-To: <20180621212518.19914-9-pasha.tatashin@oracle.com>
Message-ID: <alpine.DEB.2.21.1806231549431.8650@nanos.tec.linutronix.de>
References: <20180621212518.19914-1-pasha.tatashin@oracle.com> <20180621212518.19914-9-pasha.tatashin@oracle.com>
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

> read_boot_clock64() is deleted, and replaced with
> read_persistent_wall_and_boot_offset().
> 
> The default implementation of read_persistent_wall_and_boot_offset()
> provides a better fallback than the current stubs for read_boot_clock64()
> that arm has, so remove the old code.

You forgot to say, that this function has no users, so the removal is not
changing anything,

> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> ---
>  arch/arm/kernel/time.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/arch/arm/kernel/time.c b/arch/arm/kernel/time.c
> index cf2701cb0de8..0a6a457b13c7 100644
> --- a/arch/arm/kernel/time.c
> +++ b/arch/arm/kernel/time.c
> @@ -83,29 +83,19 @@ static void dummy_clock_access(struct timespec64 *ts)
>  }
>  
>  static clock_access_fn __read_persistent_clock = dummy_clock_access;
> -static clock_access_fn __read_boot_clock = dummy_clock_access;
>  
>  void read_persistent_clock64(struct timespec64 *ts)
>  {
>  	__read_persistent_clock(ts);
>  }
>  
> -void read_boot_clock64(struct timespec64 *ts)
> -{
> -	__read_boot_clock(ts);
> -}
> -
>  int __init register_persistent_clock(clock_access_fn read_boot,
>  				     clock_access_fn read_persistent)
>  {
>  	/* Only allow the clockaccess functions to be registered once */
> -	if (__read_persistent_clock == dummy_clock_access &&
> -	    __read_boot_clock == dummy_clock_access) {
> -		if (read_boot)
> -			__read_boot_clock = read_boot;

That leaves the fn_read_boot argument unused. So this wants to be cleaned
up as well.

Thanks,

	tglx
