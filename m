Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E32C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 510F220870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="avmxF8Dp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 510F220870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbeIKOSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 10:18:10 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39801 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbeIKOSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 10:18:10 -0400
Received: by mail-wr1-f66.google.com with SMTP id s14-v6so15963654wrw.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 02:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Xu4uwE5DpLsfzsByG8NPhpM1yc6NbOJRpycgkbvJuJ8=;
        b=avmxF8DpCmKgdWXxLfJ/AWJUwTf1i7MhJcJOHW1gdZRoWmyXsFvYfvhcQOMNfmUIh7
         D/YeYiialsqh02baRNPKE28lBhpcu8MhLOMfTDO+kTF6YjIopUrk/LQ1W6Vl6J5qIoWe
         3Y8ccmByOXrq+WhM04Bsc+e97oVPadQi+4/hQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Xu4uwE5DpLsfzsByG8NPhpM1yc6NbOJRpycgkbvJuJ8=;
        b=EnM4cRrPh0usMIpC99G8tIB03VbLRAkCH4b1iw0VGG/Qe0wHl4KXP5SnIxBSVuOK+s
         SAaMK3NUK39It/u9c4z9anfkGarLupwJPfydLsCTHolOUrqp0LNGClh3PMeLvat8s1Kv
         8ssQKlW3K709PMaDoHSnQVpcpVyb7UImeRllK6x1PBJdP5C75tnQhGHxL5yumn/CHK2D
         3Trm3cZrkPHA5RZkWDfe0MCCBdZVuxPWWKsefaqniar/tUxjJ65+Iuap6idptdxsZgh8
         oj+Z6293enU2BmN39lAr8a8EwiVvfbGOOqsz5+bMyMJNe4o5HJ6GNxBpgWffUZbZlumx
         LPIQ==
X-Gm-Message-State: APzg51A2fdPsXQt5pxV9wdXpzwWMtU9HAxVLBAg9RSwRjJuxDdsa5fDk
        bTj/ozZlpQVo1NWqFyJK0TdlJQ==
X-Google-Smtp-Source: ANB0VdagJEs+Z3mN6S0SDxEXVTd0Kr/PYuHq9Zjhpq2smBeDxBT/ToySbjEPFP5JvBv4gn0BbXjGbg==
X-Received: by 2002:a5d:490b:: with SMTP id x11-v6mr16989463wrq.114.1536657583638;
        Tue, 11 Sep 2018 02:19:43 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id d1-v6sm36022148wrc.52.2018.09.11.02.19.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 02:19:42 -0700 (PDT)
Date:   Tue, 11 Sep 2018 10:19:40 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Laura Abbott <labbott@redhat.com>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: kgdbts: Fix restrict error
Message-ID: <20180911091940.roriqov64ayk7mfs@holly.lan>
References: <20180910230456.9220-1-labbott@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180910230456.9220-1-labbott@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 04:04:56PM -0700, Laura Abbott wrote:
> kgdbts current fails when compiled with restrict:
> 
> drivers/misc/kgdbts.c: In function ‘configure_kgdbts’:
> drivers/misc/kgdbts.c:1070:2: error: ‘strcpy’ source argument is the same as destination [-Werror=restrict]
>   strcpy(config, opt);
>   ^~~~~~~~~~~~~~~~~~~
> 
> As the error says, config is being used in both the source and destination.
> Refactor the code to only do the copy when needed.
> 
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
>  drivers/misc/kgdbts.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/misc/kgdbts.c b/drivers/misc/kgdbts.c
> index 6193270e7b3d..4447ad68ea39 100644
> --- a/drivers/misc/kgdbts.c
> +++ b/drivers/misc/kgdbts.c
> @@ -1061,20 +1061,23 @@ static void kgdbts_run_tests(void)
>  	configured = 0;
>  }
>  
> -static int kgdbts_option_setup(char *opt)
> +static void kgdbts_set_verbose(void)
>  {
> -	if (strlen(opt) >= MAX_CONFIG_LEN) {
> -		printk(KERN_ERR "kgdbts: config string too long\n");
> -		return -ENOSPC;
> -	}
> -	strcpy(config, opt);
> -
>  	verbose = 0;
>  	if (strstr(config, "V1"))
>  		verbose = 1;
>  	if (strstr(config, "V2"))
>  		verbose = 2;
> +}
>  
> +static int kgdbts_option_setup(char *opt)
> +{
> +	if (strlen(opt) >= MAX_CONFIG_LEN) {
> +		printk(KERN_ERR "kgdbts: config string too long\n");
> +		return -ENOSPC;
> +	}
> +	strcpy(config, opt);
> +	kgdbts_set_verbose();

I know this is honouring the existing code paths but I think
kgdbts_set_verbose() is redundant here. Directly setting up verbose from
kgdbts_run_tests() where the rest of the config string is parsed should
be sufficient.

Having said that I don't want to bounce perfectly correct fixes just
because they could have done more. Do you want to send a v2 or prefer me
to put further clean up on my TODO list?


Daniel.

>  	return 0;
>  }
>  
> @@ -1086,9 +1089,7 @@ static int configure_kgdbts(void)
>  
>  	if (!strlen(config) || isspace(config[0]))
>  		goto noconfig;
> -	err = kgdbts_option_setup(config);
> -	if (err)
> -		goto noconfig;
> +	kgdbts_set_verbose();
>  
>  	final_ack = 0;
>  	run_plant_and_detach_test(1);
> -- 
> 2.17.1
> 
