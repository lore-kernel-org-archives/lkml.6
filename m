Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF51EECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 864B020874
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+hKkYKZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 864B020874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389006AbeGWSPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 14:15:51 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36456 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388662AbeGWSPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 14:15:50 -0400
Received: by mail-pl0-f65.google.com with SMTP id e11-v6so498218plb.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 10:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZMrvurHIeIzWKVx1oQOGkIsDhRwrZFpiyM8HEcOe32Q=;
        b=g+hKkYKZw7T8/WB0pYoGBqowIevOyWzcsPib75QUDKCV/NMZ0exSD/zttNJGfSsjS2
         jtnr1pJV3VfYkM9S1iCDHM3/aHsVJIAu6FZ8p0YJYcCeeC2f/84/qiV80iGl9L23EqVy
         TrVn7OKIlrGy2ei/V+tm2oPL17O2aLRwIsUZ0TpXKg50dhyYenvNbREew+pGQB558u8b
         rBZDFFgRU/vaFJsPZkLkld4GN8CED358EddiyjpIaecWNPH/6EXYml1V2NSyqJu9XWOd
         0WAYSRs532VIY52ubo/uxg+mkXdL/+2UnTcUSQUnGXeu4M6Dyxkd0NL+eT/2hnO1bfDS
         1sLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZMrvurHIeIzWKVx1oQOGkIsDhRwrZFpiyM8HEcOe32Q=;
        b=bPCz5t83ppFJj1qknfu3TUi8o2cEaXP4bRqU15adWdT4AEZUaYSWZzgm5TvKfGx9Qg
         0MJNmkTDr8/skZ/TTo3Ekegx7+y242s+7WCVSDPO16ZZqoSjiOmMhn6hjio5W8Cd4A5k
         tjB7eFsefdLK/M4YuJFPY6jdo93QQP+jUjFRCjVUHaqegUtooz/SjWk2cWivGeSu639d
         VwtU1BDg5rOy6hEpjSKdgJg5H26evWDuP+VudOG0/ettbQh1z285IirE7yS5Om4Hx64r
         a7U9wuwt4h8y2x516twIt2TmmuOcYX2dGXBeHcz/bGsk2rs6O2SHSUP1lK52ZNcLZbE5
         B2ww==
X-Gm-Message-State: AOUpUlF4SRneeKFcpiJ/pUDr92fnklnjIbKHttEjgn6Ixy9LOeK1XW/i
        sfVh7lfdP7n1GEOUyiAK/7wAK/nW
X-Google-Smtp-Source: AAOMgpfGhH2RKSFUo1Mn3NLXOSpGe7djWAjLm0YHjaLkKUPMHOJ4nLtrBz/YK/0xDbQpDamSOLDxEw==
X-Received: by 2002:a17:902:b08a:: with SMTP id p10-v6mr13491941plr.217.1532366018664;
        Mon, 23 Jul 2018 10:13:38 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id u11-v6sm18003730pfd.117.2018.07.23.10.13.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 10:13:37 -0700 (PDT)
Date:   Mon, 23 Jul 2018 10:13:36 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Anton Vasilyev <vasilyev@ispras.ru>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Pan Bian <bianpan2016@163.com>, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: Re: [PATCH] firmware: vpd: Fix section enabled flag on
 vpd_section_destroy
Message-ID: <20180723171336.GA15900@roeck-us.net>
References: <20180723164857.24460-1-vasilyev@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180723164857.24460-1-vasilyev@ispras.ru>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 07:48:57PM +0300, Anton Vasilyev wrote:
> static struct ro_vpd and rw_vpd are initialized by vpd_sections_init()
> in vpd_probe() based on header's ro and rw sizes.
> In vpd_remove() vpd_section_destroy() performs deinitialization based
> on enabled flag, which is set to true by vpd_sections_init().
> This leads to call of vpd_section_destroy() on already destroyed section
> for probe-release-probe-release sequence if first probe performs
> ro_vpd initialization and second probe does not initialize it.
> 

I am not sure if the situation described can be seen in the first place.
The second probe would only not perform ro_vpd initialization if it fails
prior to that, ie if it fails to allocate memory or if there is a
consistency problem. In that case the remove function would not be called.

However, there is a problem in the code: A partially failed probe will
leave the system in inconsistent state. Example: ro section initializes,
rw section fails to initialize. The probe will fail, but the ro section
will not be destroyed, its sysfs attributes still exist, and its memory
is still mapped. It would make more sense to fix _that_ problem.
Essentially, vpd_sections_init() should clean up after itself after it
fails to initialize a section.

Note that I am not convinced that the "enabled" flag is needed in the first
place. It is only relevant if vpd_section_destroy() is called, which only
happens from the remove function. The remove function is only called if the
probe function succeeded. In that case it is always set for both sections.

Thanks,
Guenter

> The patch adds changing enabled flag on vpd_section_destroy.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
> ---
>  drivers/firmware/google/vpd.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/firmware/google/vpd.c b/drivers/firmware/google/vpd.c
> index e9db895916c3..5347c17c7108 100644
> --- a/drivers/firmware/google/vpd.c
> +++ b/drivers/firmware/google/vpd.c
> @@ -246,6 +246,7 @@ static int vpd_section_destroy(struct vpd_section *sec)
>  		sysfs_remove_bin_file(vpd_kobj, &sec->bin_attr);
>  		kfree(sec->raw_name);
>  		memunmap(sec->baseaddr);
> +		sec->enabled = false;
>  	}
>  
>  	return 0;
> -- 
> 2.18.0
> 
