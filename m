Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9004AECE566
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 347AC2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="baRuoF1Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 347AC2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731442AbeITEJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 00:09:38 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36385 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbeITEJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 00:09:38 -0400
Received: by mail-wm1-f68.google.com with SMTP id j192-v6so8723262wmj.1;
        Wed, 19 Sep 2018 15:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ADPqFlF88heAT1v38Gok5chXrGTveT8whJPlgwnvLug=;
        b=baRuoF1ZktRXkkAAwAPqDano/lVptlA8XYLlEgbJ6P24dO13cJt33H4XALzZEPFJnI
         2G/YBy3jLb9uplzNqb2y1bgreiMI2kx6ajAIY2yxYhujTrfikfNgjRNIMZ5dcu9QBldd
         n6nViK8lofonfPnN4NgTT5KJoZrUcrbenJsJckNp4ZmiKdprNS192ijNbJEOh576KRbm
         Pqe8HXlA+aBQ7nnCaSSi2YRLkGsTd8kgLm+2HukEi2pbOYqMLhj7SfwSCCoijuIh86ol
         1pE3PojnZsdd5yysbBs7oRmrQhqfIO/WQlX2OMzQSMpDW4J9QAAt8OxCbqzo5nELaKmb
         9HbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ADPqFlF88heAT1v38Gok5chXrGTveT8whJPlgwnvLug=;
        b=o5fie9snhI7IrCvWTJ8lGajOeHD9MIPFwZA59n9e/1f3LGQ4xlyUt1TLyVasBBp5bt
         B3PGKdrBekAWAYKqgiXRT5ud9hooH1iYUu9MC9WZZ5oZN5KB5fKbQhRZ2BvJmGpHooTS
         nQ7haXQ//jr0//UTIRgaE8XchmKuneUw8ywjwdfy+p72ZnYbTgX8gPWBLyw13eTOxqLe
         T8HcaVJUy1wW+jiXF/rfeYdv+bKfzZLed998KbFLUxYiK5MCu+ClxaHYB2xrKZ28bzyD
         XV/6cff8JQ2LiLg02Xhj6Nw6DPoJLcub5Of6f+roOPgMIQ1rPDyEDNcr6ToGjaxlzYRy
         68cw==
X-Gm-Message-State: APzg51Bg8CF5sMVRL+SEHuD5g9zsPbFw5BOTCl27BU0MlYJrVkeqkcKM
        nQJu8YvovztCtHnV0HahsSY=
X-Google-Smtp-Source: ANB0VdYmBL99taGuNQLoonwWrQC8eDJk73kqte8ivmfRaTcRnAV8Y2vl0ixW4INNNy38YETCP5n/OA==
X-Received: by 2002:a1c:d141:: with SMTP id i62-v6mr10154wmg.113.1537396173101;
        Wed, 19 Sep 2018 15:29:33 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id f18-v6sm21361649wrw.32.2018.09.19.15.29.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 15:29:32 -0700 (PDT)
Date:   Wed, 19 Sep 2018 15:29:30 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     ilia.lin@gmail.com, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cpufreq: qcom-kryo: Fix section mismatch warning
Message-ID: <20180919222930.GA28725@flashbox>
References: <20180919182247.1101-1-natechancellor@gmail.com>
 <CAKwvOdnW8p4Tj2n+Y4XyMMVdD7W90W4NTLkJHKhZ6604ah4fnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnW8p4Tj2n+Y4XyMMVdD7W90W4NTLkJHKhZ6604ah4fnw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 02:45:15PM -0700, Nick Desaulniers wrote:
> On Wed, Sep 19, 2018 at 11:22 AM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > WARNING: vmlinux.o(.text+0x8aa424): Section mismatch in reference from
> > the function qcom_cpufreq_kryo_probe() to the function
> > .init.text:qcom_cpufreq_kryo_get_msm_id()
> > The function qcom_cpufreq_kryo_probe() references
> > the function __init qcom_cpufreq_kryo_get_msm_id().
> > This is often because qcom_cpufreq_kryo_probe lacks a __init
> > annotation or the annotation of qcom_cpufreq_kryo_get_msm_id is wrong.
> >
> > Add the '__init' annotation to qcom_cpufreq_kryo_probe so that there is
> > no more mismatch warning.
> 
> I wonder why this driver has an exit function marked __init rather
> than __exit? Does that mean it gets cleaned up after kernel init, and
> so on unloading of the driver, the kernel jumps to unmapped memory?
> 
> Does this patch now produce a warning for `qcom_cpufreq_kryo_driver`
> referencing `qcom_cpufreq_kryo_probe`?
> 

Hmmm I could have sworn I built this before sending it, although my
config might have been messed up but yes, I do see that warning.

WARNING: vmlinux.o(.data+0x117618): Section mismatch in reference from
the variable qcom_cpufreq_kryo_driver to the function
.init.text:qcom_cpufreq_kryo_probe()                                             
The variable qcom_cpufreq_kryo_driver references
the function __init qcom_cpufreq_kryo_probe() 

I suppose v1 might be the better option then as with the other patch,
marking qcom_cpufreq_kryo_driver doesn't seem correct.

I'm open to suggestions though.

Nathan

> >
> > Fixes: 46e2856b8e18 ("cpufreq: Add Kryo CPU scaling driver")
> > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >
> > v1 -> v2:
> >
> > Add '__init' to qcom_cpufreq_kryo_probe instead of removing it from
> > qcom_cpufreq_kryo_get_msm_id.
> >
> >  drivers/cpufreq/qcom-cpufreq-kryo.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-kryo.c
> > index a1830fa25fc5..e001ef8ea7de 100644
> > --- a/drivers/cpufreq/qcom-cpufreq-kryo.c
> > +++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
> > @@ -73,7 +73,7 @@ static enum _msm8996_version __init qcom_cpufreq_kryo_get_msm_id(void)
> >         return version;
> >  }
> >
> > -static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
> > +static int __init qcom_cpufreq_kryo_probe(struct platform_device *pdev)
> >  {
> >         struct opp_table *opp_tables[NR_CPUS] = {0};
> >         enum _msm8996_version msm8996_version;
> > --
> > 2.19.0
> >
> 
> 
> --
> Thanks,
> ~Nick Desaulniers
