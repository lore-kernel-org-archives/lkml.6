Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08597C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4BE720833
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="efihKtGP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4BE720833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbeIKRtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 13:49:10 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38385 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbeIKRtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 13:49:10 -0400
Received: by mail-wm0-f65.google.com with SMTP id t25-v6so848566wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 05:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=D7X6ouYZgtmxr5vcfmMsrcOASzHcoKi0YMOsNUidqCU=;
        b=efihKtGP79huGr8AeAIW59GrY031+vA3lHiYnvtJriXrj6wYega71PNcFuMPqlKGtG
         xDGaLNnx2wUkcLYzBR5/L59kSwKf7UcQ/2Zj+EX+AlXcT1YHvxXvuARk6ek9Elyntc2a
         DB2ASUY1RlFR4RWcOJ5leDsmb6HBpT24q26KA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=D7X6ouYZgtmxr5vcfmMsrcOASzHcoKi0YMOsNUidqCU=;
        b=CAzZkdAbryddkh+8h9DaDPjooEg9cLpCumDtbprwAfXDwOFTCxpeItpinKqkAwQ8pq
         SA3APv82adpgy5o0J8LHVP4jOfQK5kyf5QARy/EiH1ylRSH/dOnMrkyXpjQ+gmHNb9fo
         0t5lmTkXuIi2dwHiU3s+OJ+pxR0190IOldGyWhxs7r4bppBmwvPSG2GcuvO2nYW/VQhu
         x3f7QIFtUyWykgJnkYlwhlnRknA0XnB4MvlTuH56UpeYGBQZUCsM3ROm3aAVqvofooAC
         f0acYwtG1ssDAtzrbuUygeTp1Q16FJCgvohQgInq0NprH0j9A1aVVle3ivCpI/u4kx09
         3JzQ==
X-Gm-Message-State: APzg51BSk07nPQ/8BzQ15pkdfOYUMJl/DVrcaPlhKR4motqlkMSt/a28
        oYoBZ3tAKudr2E+5wr+ik3wJpQ==
X-Google-Smtp-Source: ANB0VdaTRNbQTgdudn9UFnLNvTgnGqFRuxqHhd+fpKV73xl19wZUSZSEBUpOeQunUqvup9Qo9Kk99g==
X-Received: by 2002:a1c:8587:: with SMTP id h129-v6mr1244321wmd.105.1536670197236;
        Tue, 11 Sep 2018 05:49:57 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id 142-v6sm1296388wme.35.2018.09.11.05.49.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 05:49:56 -0700 (PDT)
Date:   Tue, 11 Sep 2018 13:49:54 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Laura Abbott <labbott@redhat.com>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kgdboc: Fix restrict error
Message-ID: <20180911124954.zwhzxshx6zzddj4v@holly.lan>
References: <20180910232014.2642-1-labbott@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180910232014.2642-1-labbott@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 04:20:14PM -0700, Laura Abbott wrote:
> There's an error when compiled with restrict:
> 
> drivers/tty/serial/kgdboc.c: In function ‘configure_kgdboc’:
> drivers/tty/serial/kgdboc.c:137:2: error: ‘strcpy’ source argument is the same
> as destination [-Werror=restrict]
>   strcpy(config, opt);
>   ^~~~~~~~~~~~~~~~~~~
> 
> As the error implies, this is from trying to use config as both source and
> destination. Drop the call to the function where config is the argument
> since nothing else happens in the function.
> 
> Signed-off-by: Laura Abbott <labbott@redhat.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

> ---
>  drivers/tty/serial/kgdboc.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
> index b4ba2b1dab76..dd503743bbff 100644
> --- a/drivers/tty/serial/kgdboc.c
> +++ b/drivers/tty/serial/kgdboc.c
> @@ -154,15 +154,13 @@ static int configure_kgdboc(void)
>  {
>  	struct tty_driver *p;
>  	int tty_line = 0;
> -	int err;
> +	int err = -ENODEV;
>  	char *cptr = config;
>  	struct console *cons;
>  
> -	err = kgdboc_option_setup(config);
> -	if (err || !strlen(config) || isspace(config[0]))
> +	if (!strlen(config) || isspace(config[0]))
>  		goto noconfig;
>  
> -	err = -ENODEV;
>  	kgdboc_io_ops.is_console = 0;
>  	kgdb_tty_driver = NULL;
>  
> -- 
> 2.17.1
> 
