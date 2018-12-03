Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED31C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 04:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A3D421473
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 04:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bYYkhUjt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A3D421473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725866AbeLCEol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 23:44:41 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39134 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbeLCEol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 23:44:41 -0500
Received: by mail-pf1-f194.google.com with SMTP id c72so5708052pfc.6
        for <linux-kernel@vger.kernel.org>; Sun, 02 Dec 2018 20:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PuQS+8+6RbtBscC/MGZg4WmBz4k6gLdzwCAgtuPUgnE=;
        b=bYYkhUjtZvPqtCLIvXJeXW6rTMmubg7N6GQOqyDPsxcjwzhBmoT8fjjos6o0pZHMyD
         0ca4IURc1y5VfNtmSvb/c2bQ1dFXWR9tS4wFn20B1IdwABgdYqwF1hhlYR4yj5rzNPoT
         orAQrXEgZziXsRHZTJZ+HIQdcfyD+jM7oPfZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PuQS+8+6RbtBscC/MGZg4WmBz4k6gLdzwCAgtuPUgnE=;
        b=r6tuLVX7Y1bopXduBTsV5ncVy9W2Wmq6NgGVyllQU8jgfdsYYEp6ka58RVSTXbZ6aQ
         p9ykBojBhjpIgLAiKW3AxhllA0ZwYfrpBG7LSl5xo5N5bFQjHzBZxWRWc7T+HF3qt2sG
         R/tDYFB8MQxaR89VUytRt8jwYOWhBRfkXXZ8yz//zd0FBwK6sUlFqG4zCXTsZdZZgnqc
         raW5N42eHsoTfXkl5RV6o3cm91bJYSJCNVtiIlyaw2Br9Eg3NCRFxkcony7CoeI1URMY
         DahSnvGcmNcOZ8M4bJYMZutoc4tpJ+cnJ+FejtvVLg0wgRpk58POB3DKl8n0dAftFwde
         cgtQ==
X-Gm-Message-State: AA+aEWZizV61sh6TzIXJRtf/hUCuQHrLaDn25dtPJ5xxyz5c8yJ5WciA
        FMMLn7qBDcrPy9LhdYP7QG5yqw==
X-Google-Smtp-Source: AFSGD/UtBJqp3bLSxAYjT0o4GCKHZck6iuj4AE6U23XTXQA8waYakVzW+5h5Yn6W573eJvy8myQxnA==
X-Received: by 2002:a62:931a:: with SMTP id b26mr15138782pfe.65.1543812276790;
        Sun, 02 Dec 2018 20:44:36 -0800 (PST)
Received: from localhost ([122.172.23.29])
        by smtp.gmail.com with ESMTPSA id e9sm15427719pff.5.2018.12.02.20.44.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Dec 2018 20:44:36 -0800 (PST)
Date:   Mon, 3 Dec 2018 10:14:33 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: ia64: Remove unused header files
Message-ID: <20181203044433.pj22fmle2rxvxy3v@vireshk-i7>
References: <20181130141620.2488-1-tiny.windzz@gmail.com>
 <20181203044222.rt3v3fnrc5fpjlji@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203044222.rt3v3fnrc5fpjlji@vireshk-i7>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-12-18, 10:12, Viresh Kumar wrote:
> On 30-11-18, 09:16, Yangtao Li wrote:
> > seq_file.h does not need to be included,so remove it.Moreover deleted a
> > line of meaningless return and move the module declaration to the end.
> > In a function whose return type is void, returning on the last line is
> > not required.
> > 
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  drivers/cpufreq/ia64-acpi-cpufreq.c | 10 +++-------
> >  1 file changed, 3 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/ia64-acpi-cpufreq.c b/drivers/cpufreq/ia64-acpi-cpufreq.c
> > index dd5440d3372d..43ac191fb46a 100644
> > --- a/drivers/cpufreq/ia64-acpi-cpufreq.c
> > +++ b/drivers/cpufreq/ia64-acpi-cpufreq.c
> > @@ -16,7 +16,6 @@
> >  #include <linux/init.h>
> >  #include <linux/cpufreq.h>
> >  #include <linux/proc_fs.h>
> > -#include <linux/seq_file.h>
> >  #include <asm/io.h>
> >  #include <linux/uaccess.h>
> >  #include <asm/pal.h>
> > @@ -24,11 +23,6 @@
> >  #include <linux/acpi.h>
> >  #include <acpi/processor.h>
> >  
> > -MODULE_AUTHOR("Venkatesh Pallipadi");
> > -MODULE_DESCRIPTION("ACPI Processor P-States Driver");
> > -MODULE_LICENSE("GPL");
> > -
> > -
> >  struct cpufreq_acpi_io {
> >  	struct acpi_processor_performance	acpi_data;
> >  	unsigned int				resume;
> > @@ -348,9 +342,11 @@ acpi_cpufreq_exit (void)
> >  	pr_debug("acpi_cpufreq_exit\n");
> >  
> >  	cpufreq_unregister_driver(&acpi_cpufreq_driver);
> > -	return;
> >  }
> >  
> > +MODULE_AUTHOR("Venkatesh Pallipadi");
> > +MODULE_DESCRIPTION("ACPI Processor P-States Driver");
> > +MODULE_LICENSE("GPL");

Well, why not move this to the end of file completely ?

> >  
> >  late_initcall(acpi_cpufreq_init);
> >  module_exit(acpi_cpufreq_exit);
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
