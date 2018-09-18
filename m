Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1EDC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 23:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3452720C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 23:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LaRhAeCq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3452720C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbeISEto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 00:49:44 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37147 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728266AbeISEto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 00:49:44 -0400
Received: by mail-pg1-f195.google.com with SMTP id 2-v6so1761759pgo.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 16:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=1Gp6sMzc9rjka+xKBsb2Fo/YxyBwNUaNCDXgZtP2yKk=;
        b=LaRhAeCqyFaTJXihh1rOdB6gWqGx9RwNif0FGOwcTWyr+tyPN5WzB0z8V1QZpO7y1s
         W0Tp67H7B6YsWodTwT0emxK0Xx1ppCtfm+lLytSn3sL9lzQ92rprQehKTSkA+nCOOndt
         ImXXAIvjSowXnhi8kH+U5+kjXP62Eb35U5nmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1Gp6sMzc9rjka+xKBsb2Fo/YxyBwNUaNCDXgZtP2yKk=;
        b=iAJrPLRX84jgmyXSsOL2ksH5AbOa6Y0hYl+VObgdn/tdMBhnbPIpbvt6ZYtgkbh4SV
         Pv/IqrPfObXJIO/7TF0spKKBLU5ol/Y9c+d2m/7KBkDoPP7uuokOOBT/hpXGdWj1LmAX
         ZZNHmmZClhwdr6VpaS+XDmZYygefQ/tb3IH25II0MUYr27cbhO3hHhaBjuWa3zou/v6H
         zSlSnxAan2+3kY/aFtf2R5sR6+EQZ3iyRD3zn0PIM5/w0cCrVHok4MCoLGzSuJTcudfM
         EMbAdzlOHqjgEyvco/8sKJUkbz5cba8ye0Df0ca8E+Zr4ifOYrb6CQ3dJMuwItD2Y4rx
         IH6g==
X-Gm-Message-State: APzg51CPq8X+IvFWGkxQIaZkwNOBi6dRZDbmS+ZJLiCilTbXm/5aLNle
        6RR1bg9MM5H2lS5zJ2whldgKkO6/YVZ4+Q==
X-Google-Smtp-Source: ANB0VdYjRt7mSPYbcA0c5TrEKIutoJ1TxgGXEWn7kPsAno3Np0+x//gnbhdNlrVOFJ2/kENs1H9yxA==
X-Received: by 2002:a62:4898:: with SMTP id q24-v6mr33348806pfi.22.1537312491376;
        Tue, 18 Sep 2018 16:14:51 -0700 (PDT)
Received: from holly.lan ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id n83-v6sm42805317pfk.19.2018.09.18.16.14.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 16:14:50 -0700 (PDT)
Date:   Tue, 18 Sep 2018 16:14:49 -0700
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Laura Abbott <labbott@redhat.com>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] misc: kgdbts: Fix restrict error
Message-ID: <20180918231449.akg2qjgaohedtx4h@holly.lan>
References: <20180911174403.32088-1-labbott@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180911174403.32088-1-labbott@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 10:44:03AM -0700, Laura Abbott wrote:
> kgdbts current fails when compiled with restrict:
> 
> drivers/misc/kgdbts.c: In function ‘configure_kgdbts’:
> drivers/misc/kgdbts.c:1070:2: error: ‘strcpy’ source argument is the same as destination [-Werror=restrict]
>   strcpy(config, opt);
>   ^~~~~~~~~~~~~~~~~~~
> 
> As the error says, config is being used in both the source and destination.
> Refactor the code to avoid the extra copy and put the parsing closer to
> the actual location.
> 
> Signed-off-by: Laura Abbott <labbott@redhat.com>

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>

> ---
> v2: Refactored to move the verbose setting into kgbts_run_tests per
> suggestion of Daniel Thompson
> ---
>  drivers/misc/kgdbts.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/misc/kgdbts.c b/drivers/misc/kgdbts.c
> index 6193270e7b3d..de20bdaa148d 100644
> --- a/drivers/misc/kgdbts.c
> +++ b/drivers/misc/kgdbts.c
> @@ -985,6 +985,12 @@ static void kgdbts_run_tests(void)
>  	int nmi_sleep = 0;
>  	int i;
>  
> +	verbose = 0;
> +	if (strstr(config, "V1"))
> +		verbose = 1;
> +	if (strstr(config, "V2"))
> +		verbose = 2;
> +
>  	ptr = strchr(config, 'F');
>  	if (ptr)
>  		fork_test = simple_strtol(ptr + 1, NULL, 10);
> @@ -1068,13 +1074,6 @@ static int kgdbts_option_setup(char *opt)
>  		return -ENOSPC;
>  	}
>  	strcpy(config, opt);
> -
> -	verbose = 0;
> -	if (strstr(config, "V1"))
> -		verbose = 1;
> -	if (strstr(config, "V2"))
> -		verbose = 2;
> -
>  	return 0;
>  }
>  
> @@ -1086,9 +1085,6 @@ static int configure_kgdbts(void)
>  
>  	if (!strlen(config) || isspace(config[0]))
>  		goto noconfig;
> -	err = kgdbts_option_setup(config);
> -	if (err)
> -		goto noconfig;
>  
>  	final_ack = 0;
>  	run_plant_and_detach_test(1);
> -- 
> 2.17.1
> 
