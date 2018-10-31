Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A396EC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 11:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53B6D20664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 11:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HgO0h06Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53B6D20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbeJaU46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 16:56:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45759 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727733AbeJaU46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 16:56:58 -0400
Received: by mail-wr1-f67.google.com with SMTP id n5-v6so16136696wrw.12
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 04:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VxrawWAfSIUX3aK1jCb4GSWmhJQGqQnjWxksxXZKWtY=;
        b=HgO0h06Qd/OnUd2JKPx8JmNr7D3hXPkPR0CCmttunH612fM58YIgKM2gMP3WJXnHTp
         KnhGjybJr2xR3JPMJKXJ3O9QrHFNwKBqZXbLB54PeHhSlSpSijdov6OdpkZPXdqGv+EP
         EoF76Fg3dA0yUZuT4f7HOx1AMnwRWgTd8CbV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VxrawWAfSIUX3aK1jCb4GSWmhJQGqQnjWxksxXZKWtY=;
        b=EYrEbJ9lyaDaX0DQmizhmkvUAM0n9K2OSuQDZrX+Ndg1jY+JJucxHh6CjymFYQk5ps
         7OKYuhPuiGFvAzuDuMD86+ksXWMzVF0467VFOJr86Qec3ZMMSjAGtDOZ2cJLIdUmS9us
         89Th2EAkVLM/MnymMiEUuzWM5//R21NR0ejRhxOYnfpQ7F8bJzUYG0EUdDkdJuOStduO
         6g0Rcl5p+Zaj7Gbl8pAjrekehq0yYxiMNxdH35gti97QX5Md51nArFBFQZclAb+VXWxM
         s5bV8OpZ2wRE2O8AwgKu8V7VJdbR/fE6SFD4cWzAiBqLFCbnFGMoxK8jdI4u5bdp+Aqo
         099w==
X-Gm-Message-State: AGRZ1gL9kC2ysPZQ+uj3TjF/BlViWFrsudlHEV84oBgHbhoZfqgLtDPt
        Vy7c9IxU5rIkvBxoDkFPXLY+tQ==
X-Google-Smtp-Source: AJdET5cuFSc8YX2el0mv0UzcNpSULujKRjGXyYPBp9Rq9bfPp4t5gzRp2ODEnfiVtgqhovSGUvJUNA==
X-Received: by 2002:a5d:6a8d:: with SMTP id s13-v6mr2379787wru.44.1540987153470;
        Wed, 31 Oct 2018 04:59:13 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id f4-v6sm6532037wrw.10.2018.10.31.04.59.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 04:59:12 -0700 (PDT)
Date:   Wed, 31 Oct 2018 11:59:10 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        "Tobin C . Harding" <me@tobin.cc>, joe@perches.com,
        stable@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kdb: Fix btc (backtrace on each cpu) crash
Message-ID: <20181031115910.5bqgtnzf2zujnp5b@holly.lan>
References: <20181030205334.148162-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030205334.148162-1-dianders@chromium.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 01:53:34PM -0700, Douglas Anderson wrote:
> Typing 'btc' on kdb doing all sorts of fail.  Sometimes it would
> crash, sometimes display nothing, and sometimes hang.
> 
> Bisect tracked this down to the commit ad67b74d2469 ("printk: hash
> addresses printed with %p"), suggesting an obvious fix.  The pointer
> used internally in kdb shouldn't be hashed, so switch it to %px.
> 
> Fixes: ad67b74d2469 ("printk: hash addresses printed with %p")
> Cc: stable@vger.kernel.org
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

I think we've already got a fix for this:
https://git.kernel.org/pub/scm/linux/kernel/git/jwessel/kgdb.git/commit/?h=kgdb-next&id=a0ca72c2d1ac83d0853a23ffde8f3624648b1ee8


Daniel.

> ---
> 
>  kernel/debug/kdb/kdb_bt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/debug/kdb/kdb_bt.c b/kernel/debug/kdb/kdb_bt.c
> index 6ad4a9fcbd6f..7921ae4fca8d 100644
> --- a/kernel/debug/kdb/kdb_bt.c
> +++ b/kernel/debug/kdb/kdb_bt.c
> @@ -179,14 +179,14 @@ kdb_bt(int argc, const char **argv)
>  				kdb_printf("no process for cpu %ld\n", cpu);
>  				return 0;
>  			}
> -			sprintf(buf, "btt 0x%p\n", KDB_TSK(cpu));
> +			sprintf(buf, "btt 0x%px\n", KDB_TSK(cpu));
>  			kdb_parse(buf);
>  			return 0;
>  		}
>  		kdb_printf("btc: cpu status: ");
>  		kdb_parse("cpu\n");
>  		for_each_online_cpu(cpu) {
> -			sprintf(buf, "btt 0x%p\n", KDB_TSK(cpu));
> +			sprintf(buf, "btt 0x%px\n", KDB_TSK(cpu));
>  			kdb_parse(buf);
>  			touch_nmi_watchdog();
>  		}
> -- 
> 2.19.1.568.g152ad8e336-goog
> 
