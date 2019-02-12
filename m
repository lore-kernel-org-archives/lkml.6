Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BCFC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26BBD21773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549968885;
	bh=thLhzasbrRN/e5PKKH8ea4a8jctA9b37oXWyV0CkXL8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2MmyiEMtWO1RxRF//q4Yy3BicrRt5Ohf0q8oCgG0Rg3WtPD4yoxU8bwcfUHFpGOkL
	 qixaxcnidjmB+dOm2QQYysRN8qx1I/FvDw7+M3D8IO+yZGnTFsLJNQohNFIn04459C
	 6B4ikQZTcpA/3IVvfwqyu2S8aXiEl1aOQ3BNxxF8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbfBLKym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 05:54:42 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34667 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727343AbfBLKym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 05:54:42 -0500
Received: by mail-ot1-f65.google.com with SMTP id 98so3711176oty.1;
        Tue, 12 Feb 2019 02:54:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p9EYS1KK28bFPgtAuWV5Fqgkw/0xKBaRX+VvmQziMpI=;
        b=oJD6SCz0GWbPCy6xRMDksio1zsv1uOZsv0IFwNzev2he/hj+FzOJQ4VcfwVQpl1/oI
         6D5uklI+Dw638zjpi0dxwe9w3aZJjYN4nVYc6BegKEPRvFUGvm3f09oTU56UQUndaUX3
         8sTimLrJoi+Ie9+8U6JdCIy8gju5glHt0a+MaFvKBquZIwCjr+MaoRcOaiZ0rg28/+ap
         mcLZR8AAbuN/h/1h0dbhfNRQI56As0PnVBYFC4cPdNKo8pJSn5IeERWeteX3xYqmLVba
         sB4p6uGcfWoHaFPbEy0+5pKmoHVAqkBSs9WPiIBRKEHHDWVyLePsn+z0sDiZ0Pn+Ykbq
         zC4w==
X-Gm-Message-State: AHQUAua2cOiKtzzYTwZGQMBc4eJ0tWOXsB4KJkq3WZmfSTd1ziTnSYVn
        e4BhaKUXBUZJklgIeClWGV2YN2K0iLbGmfVucGA=
X-Google-Smtp-Source: AHgI3Ib2rWWXZU6b+9bmMmITJA9Wkxv73r3W+brFmHXZfk2vzB31aL85FNOqMsbX9AKYuvqfFGV5Dq5iYBzGLirvB2s=
X-Received: by 2002:a9d:5e8c:: with SMTP id f12mr3197406otl.343.1549968881389;
 Tue, 12 Feb 2019 02:54:41 -0800 (PST)
MIME-Version: 1.0
References: <f48f04ddfe3bd072f40154cdd971079199db0e4b.1549955027.git.viresh.kumar@linaro.org>
 <15c641e4139d0b9a7d7540eefced1c012b608e91.1549968315.git.viresh.kumar@linaro.org>
In-Reply-To: <15c641e4139d0b9a7d7540eefced1c012b608e91.1549968315.git.viresh.kumar@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 12 Feb 2019 11:54:29 +0100
Message-ID: <CAJZ5v0hez63un9g4h0U+YOZV1o7S+FT8NritiX6dxEcD1-fTSQ@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] cpufreq: Allow light-weight tear down and bring up
 of CPUs
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 11:47 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>

[cut]

> @@ -2488,7 +2505,8 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
>                     driver_data->target) ||
>              (driver_data->setpolicy && (driver_data->target_index ||
>                     driver_data->target)) ||
> -            (!!driver_data->get_intermediate != !!driver_data->target_intermediate))
> +            (!!driver_data->get_intermediate != !!driver_data->target_intermediate) ||
> +            (!driver_data->online ^ !driver_data->offline))

Why do you need the ^ here?  != should be sufficient:

!driver_data->online != !driver_data->offline

?

>                 return -EINVAL;
>
>         pr_debug("trying to register driver %s\n", driver_data->name);
