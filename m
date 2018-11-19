Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD9EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 04:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE7D2087A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 04:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kRq4gKhA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFE7D2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbeKSO0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 09:26:47 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45531 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727374AbeKSO0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 09:26:47 -0500
Received: by mail-pf1-f194.google.com with SMTP id g62so10904434pfd.12
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 20:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W6VB1c2dyfcWsF/AQxV4nxQYdWWfLaBDDIg/sraD0iQ=;
        b=kRq4gKhAYjBd3PG5oXb4Lvtfa4+kO5XhwHoa5tCnlzmHs7SO1bPpz1cUOdoMPZYcVD
         3K1EGYfFPhY3dhvabuoz2g9QVQlgK5LEsX2beWtONGDVdiJ2+ltXe0lqCleF/T1QWMd9
         S743dFXjM1222czClXNd+berTVapGKhNxPdV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W6VB1c2dyfcWsF/AQxV4nxQYdWWfLaBDDIg/sraD0iQ=;
        b=Tbg+C19IlxM6r305sPFPwhQT5MOBBLRCo2Xa6+aQaIyQcs8ZrIVedKccYw/8j568VN
         DcORSwxsMyIPmwID0Yw43sg4V8Gtp88QNbCyiI/+Hr5jz9JLbaXYFU/s0YjSFJ8UGZ8I
         QO/rY96IhWYeW50kFb7h7gCU+81TqMdlouEvJE7h+BfGtWJ51YoZb8hz2YajScajAZt8
         Iz1X/zyIDFa+s+9fKTkq7Ahkk5UIXfPAUlfRlDBRg9osj0nX0Q490rftNS5nceKFHtOo
         6U+YtHk4as4Tw0/H6XAZ8fa3JmOuIeR9J+zLc8hP3h1WvdW6KopTAFkh2dv77o23TwyD
         Wd+A==
X-Gm-Message-State: AGRZ1gLO0gFLNRyzW3iLXEIgKWXAt6nzDlQRK9o7njNluX28vy/91qFZ
        vDqXbVlxtliM3d6HvQHnmq2RLw==
X-Google-Smtp-Source: AJdET5dKkzAKLP8w5l6U/HD09LowaMHm49xfninmrk9lHCfNzYFLPxk+Ze6xWyyLE+vBXUfXg00ekw==
X-Received: by 2002:a63:a064:: with SMTP id u36mr18825475pgn.145.1542600267940;
        Sun, 18 Nov 2018 20:04:27 -0800 (PST)
Received: from localhost ([122.172.88.116])
        by smtp.gmail.com with ESMTPSA id o13sm6510701pfk.57.2018.11.18.20.04.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Nov 2018 20:04:26 -0800 (PST)
Date:   Mon, 19 Nov 2018 09:34:23 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/7] drivers/cpufreq: change CONFIG_6xx to
 CONFIG_PPC_BOOK3S_32
Message-ID: <20181119040423.pbfuszycad66e2qr@vireshk-i7>
References: <aeeaafbdf0357f8bdb8ffd86822a0ddfd5521fd6.1542395798.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeeaafbdf0357f8bdb8ffd86822a0ddfd5521fd6.1542395798.git.christophe.leroy@c-s.fr>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-11-18, 10:24, Christophe Leroy wrote:
> Today, powerpc has three CONFIG labels which means exactly the same:
> - CONFIG_6xx
> - CONFIG_PPC_BOOK3S_32
> - CONFIG_PPC_STD_MMU_32
> 
> By consistency with PPC64, CONFIG_PPC_BOOK3S_32 is the preferred one.
> Using a label with includes _PPC_ also makes it clearer that it is
> linked to powerpc.
> 
> In preparation of the removal of CONFIG_6xx, this patch replaces it
> by CONFIG_PPC_BOOK3S_32
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  drivers/cpufreq/pmac32-cpufreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/pmac32-cpufreq.c b/drivers/cpufreq/pmac32-cpufreq.c
> index 61ae06ca008e..52f0d91d30c1 100644
> --- a/drivers/cpufreq/pmac32-cpufreq.c
> +++ b/drivers/cpufreq/pmac32-cpufreq.c
> @@ -128,7 +128,7 @@ static int cpu_750fx_cpu_speed(int low_speed)
>  			mtspr(SPRN_HID2, hid2);
>  		}
>  	}
> -#ifdef CONFIG_6xx
> +#ifdef CONFIG_PPC_BOOK3S_32
>  	low_choose_750fx_pll(low_speed);
>  #endif
>  	if (low_speed == 1) {
> @@ -166,7 +166,7 @@ static int dfs_set_cpu_speed(int low_speed)
>  	}
>  
>  	/* set frequency */
> -#ifdef CONFIG_6xx
> +#ifdef CONFIG_PPC_BOOK3S_32
>  	low_choose_7447a_dfs(low_speed);
>  #endif
>  	udelay(100);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
