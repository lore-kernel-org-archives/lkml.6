Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD37C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C19642243E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="otE5056V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C19642243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732403AbeKNEHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 23:07:09 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46554 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732124AbeKNEHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 23:07:09 -0500
Received: by mail-pg1-f193.google.com with SMTP id w7so6037325pgp.13;
        Tue, 13 Nov 2018 10:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kaIaaal67lYba6J7S/0V3r6PjYPGN5dPrQScII7rvSI=;
        b=otE5056VCANmE0Dt9352TRSY6nkBOPveimnA9aebCOtjWWX0dj7cUgIhh1BPFvkH1k
         QSIaS9KyaQM6Vyc9gZIYK2a9YAvZytPmWKmOchg/UaDaPDFudtHDECvj/Y/exsofm+dj
         UxkFgeQP1cWaeekU4cLkUeWUMfWxuGhUUSgGCCx0wDXocHlZHePjYnwWeje2pwErEuMm
         hejNss+g1TPafHBcYizkbEMbNEUy9Ganm5LtDIUgWIhn9yttBgev9CgxF0rj29QYp18P
         PrcKwg2PGfheoe3SfoWAnEUgNawWp34pZLT9okFF+jpAZoaFy9l1DaK5WOKKHF8YQJZg
         p7mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kaIaaal67lYba6J7S/0V3r6PjYPGN5dPrQScII7rvSI=;
        b=cKgdZY+gcXPmezARMl2ziFP4vpihHWqr0WIUTNipOp8e3sTW836plXC6lQEDLKUMMQ
         yu91PSTx966DBMwsYQf0edKQX9/Z/eirpc1pG8HHjv6xqOqu8JQjjzJownqC9HufX4t3
         cdmYTng4qkbHeue1hnPUTID9DYtnz3eHXupdaFeFicS3dPvIs7iXpl9aCm+SGv2qiN14
         iWOypXUAOv5lNF5mLuJCHj51Uw71590+3/tJeK6nFni+K5X9zHD0OFANHt5T0MUdGyMK
         2q+3w7X2DDQKPTxNtTKLUfzgW4qZhpkcVkbKoomO85XYShV//mJGosEhnoTTpsChbIUL
         1SjA==
X-Gm-Message-State: AGRZ1gI1oRyWfkdnOrv2iXDoTTZMJd8+7d9jitknMrXeDcZaTZ7cJ6BY
        9K5UQ2LhrQsLkmvNigt/NBc=
X-Google-Smtp-Source: AJdET5dg7nWM5XBVeeUsFvi+WNuyUaslnToSwdr0OJkLj7wDETRMykHWd1DZmpxBEJ3VvZnbsD8ukA==
X-Received: by 2002:a62:85:: with SMTP id 127-v6mr6100593pfa.24.1542132474817;
        Tue, 13 Nov 2018 10:07:54 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id f32sm18881836pgf.80.2018.11.13.10.07.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 10:07:53 -0800 (PST)
Date:   Tue, 13 Nov 2018 10:07:51 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Joe Perches <joe@perches.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 18/20] Input: hp_sdc_rtc - Switch to use %ptR
Message-ID: <20181113180751.GA197552@dtor-ws>
References: <20181113171729.19645-1-andriy.shevchenko@linux.intel.com>
 <20181113171729.19645-19-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113171729.19645-19-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 07:17:27PM +0200, Andy Shevchenko wrote:
> Use %ptR instead of open coded variant to print content of
> struct rtc_time in human readable format.
> 
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Please feel free to merge with the rest of the series.

> ---
>  drivers/input/misc/hp_sdc_rtc.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/input/misc/hp_sdc_rtc.c b/drivers/input/misc/hp_sdc_rtc.c
> index 47eb8ca729fe..abca895a6156 100644
> --- a/drivers/input/misc/hp_sdc_rtc.c
> +++ b/drivers/input/misc/hp_sdc_rtc.c
> @@ -441,12 +441,10 @@ static int hp_sdc_rtc_proc_show(struct seq_file *m, void *v)
>  		seq_puts(m, "BBRTC\t\t: READ FAILED!\n");
>  	} else {
>  		seq_printf(m,
> -			     "rtc_time\t: %02d:%02d:%02d\n"
> -			     "rtc_date\t: %04d-%02d-%02d\n"
> +			     "rtc_time\t: %ptRt\n"
> +			     "rtc_date\t: %ptRd\n"
>  			     "rtc_epoch\t: %04lu\n",
> -			     tm.tm_hour, tm.tm_min, tm.tm_sec,
> -			     tm.tm_year + 1900, tm.tm_mon + 1, 
> -			     tm.tm_mday, epoch);
> +			     &tm, &tm, epoch);
>  	}
>  
>  	if (hp_sdc_rtc_read_rt(&tv)) {
> -- 
> 2.19.1
> 

-- 
Dmitry
