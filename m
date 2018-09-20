Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0A5ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55EC7214C2
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JdoHfRGo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55EC7214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733205AbeITWTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:19:38 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40162 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728021AbeITWTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 18:19:37 -0400
Received: by mail-pl1-f196.google.com with SMTP id s17-v6so4597229plp.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 09:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/VYscu7rBqxLm1rNawvE/pGHrTD5EpVioCwE+Tsw/NM=;
        b=JdoHfRGoNEWhUT7UuaZceI9DYmNvD7c3iouwBQeACxcklZjJhgnb4hN2Kkmp5eoQ/W
         t3QzTVeg3aKgtE7q1sgkvywQhmj29WyUUmGjahTi4OeioPftHT9KiY9NHtVpcm1RVPrD
         U4mSXimyql4PflLnw8dYDKdnlzUlBroNdkLIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/VYscu7rBqxLm1rNawvE/pGHrTD5EpVioCwE+Tsw/NM=;
        b=TQZHj0eWDt4NdWXpqzYL8jaQ782kYR+h6GbkbSZwhlkLE30ZG+yDPeeBZotv9jghTB
         rlsuhRAkoKjdCtyn1SO8fnHm1WWiaK7T2H+xCjWosFe8PH2udGOMyr5JKtBiAf3l3gIR
         J7bFhkuk65aBeAo4ZhbsDYY3+3hFNTVMFLzqjSRcWRjRlnC3i26FfdPwR66NxwXNM8CF
         cfVtdH0RXhCyn2iOmWza0O1ZRWFWCcBW4SBiiXFt3ND2x0c7fOUmCNi5ouss6AxbyYfr
         JGSMw25zd4SNFGScJS/EUiuNMBF/n0H80V0MgzUW+S3GV+ndx4JVcM1cYiIafX57nkSa
         S6aw==
X-Gm-Message-State: APzg51B11sqfeKfvxwYYLFe2oOfM9dIybfBtn/lCet+KG40BFPkTuTlW
        XcAVyqXXp4Qtlef6z2HMHfvMDg==
X-Google-Smtp-Source: ANB0VdZgVdT0fIOHHqQr1gmrNAnlmlCHLNXWcVFh3Z1wTJj+/cY/+TxEG4pX9lS1cRR4cwA+LkbrxQ==
X-Received: by 2002:a17:902:59c7:: with SMTP id d7-v6mr4208972plj.142.1537461318597;
        Thu, 20 Sep 2018 09:35:18 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v72-v6sm41574418pfj.22.2018.09.20.09.35.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 09:35:17 -0700 (PDT)
Date:   Thu, 20 Sep 2018 09:39:28 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joe Perches <joe@perches.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>, Roman Gushchin <guro@fb.com>,
        Huang Ying <ying.huang@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 4/4] clk: pmc-atom: use devm_kstrdup_const()
Message-ID: <20180920163928.GI1367@tuxbook-pro>
References: <20180828093332.20674-1-brgl@bgdev.pl>
 <20180828093332.20674-5-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828093332.20674-5-brgl@bgdev.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 28 Aug 02:33 PDT 2018, Bartosz Golaszewski wrote:

> Use devm_kstrdup_const() in the pmc-atom driver. This mostly serves as
> an example of how to use this new routine to shrink driver code.
> 
> While we're at it: replace a call to kcalloc() with devm_kcalloc().
> 
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/clk/x86/clk-pmc-atom.c | 19 ++++---------------
>  1 file changed, 4 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/clk/x86/clk-pmc-atom.c b/drivers/clk/x86/clk-pmc-atom.c
> index 08ef69945ffb..daa2192e6568 100644
> --- a/drivers/clk/x86/clk-pmc-atom.c
> +++ b/drivers/clk/x86/clk-pmc-atom.c
> @@ -253,14 +253,6 @@ static void plt_clk_unregister_fixed_rate_loop(struct clk_plt_data *data,
>  		plt_clk_unregister_fixed_rate(data->parents[i]);
>  }
>  
> -static void plt_clk_free_parent_names_loop(const char **parent_names,
> -					   unsigned int i)
> -{
> -	while (i--)
> -		kfree_const(parent_names[i]);
> -	kfree(parent_names);
> -}
> -
>  static void plt_clk_unregister_loop(struct clk_plt_data *data,
>  				    unsigned int i)
>  {
> @@ -286,8 +278,8 @@ static const char **plt_clk_register_parents(struct platform_device *pdev,
>  	if (!data->parents)
>  		return ERR_PTR(-ENOMEM);
>  
> -	parent_names = kcalloc(nparents, sizeof(*parent_names),
> -			       GFP_KERNEL);
> +	parent_names = devm_kcalloc(&pdev->dev, nparents,
> +				    sizeof(*parent_names), GFP_KERNEL);
>  	if (!parent_names)
>  		return ERR_PTR(-ENOMEM);
>  
> @@ -300,7 +292,8 @@ static const char **plt_clk_register_parents(struct platform_device *pdev,
>  			err = PTR_ERR(data->parents[i]);
>  			goto err_unreg;
>  		}
> -		parent_names[i] = kstrdup_const(clks[i].name, GFP_KERNEL);
> +		parent_names[i] = devm_kstrdup_const(&pdev->dev,
> +						     clks[i].name, GFP_KERNEL);
>  	}
>  
>  	data->nparents = nparents;
> @@ -308,7 +301,6 @@ static const char **plt_clk_register_parents(struct platform_device *pdev,
>  
>  err_unreg:
>  	plt_clk_unregister_fixed_rate_loop(data, i);
> -	plt_clk_free_parent_names_loop(parent_names, i);
>  	return ERR_PTR(err);
>  }
>  
> @@ -351,15 +343,12 @@ static int plt_clk_probe(struct platform_device *pdev)
>  		goto err_unreg_clk_plt;
>  	}
>  
> -	plt_clk_free_parent_names_loop(parent_names, data->nparents);
> -
>  	platform_set_drvdata(pdev, data);
>  	return 0;
>  
>  err_unreg_clk_plt:
>  	plt_clk_unregister_loop(data, i);
>  	plt_clk_unregister_parents(data);
> -	plt_clk_free_parent_names_loop(parent_names, data->nparents);
>  	return err;
>  }
>  
> -- 
> 2.18.0
> 
