Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D8EC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B96E120838
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549882611;
	bh=dvdpeWXedN+u8Qtd4MK9Rt5RdeQbRY0v5EiU4W0rjAs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=x+X3YYmEoONq1eYpxHLn8um685/T3GXzWIeDzXmk3S5nslZNSC/DdDQPvjw2TyReh
	 6dyIvCAgKPX83BWWTXoyOmiKPC8deC/g3iGC+Kw4tse6ayn0wdu1oSWh1PrSDVSN9V
	 li6EBlx97mecQp4fO1rIITv/YT0JwJqLkJO5m/e0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfBKK4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:56:50 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40374 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfBKK4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:56:49 -0500
Received: by mail-ot1-f68.google.com with SMTP id s5so16673340oth.7;
        Mon, 11 Feb 2019 02:56:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hLhMU0Cq4xXNQYUiNoUh61NcLGkXG3B/pawhM1x1X9w=;
        b=VwR+FA83M9reujMAhq6mTUqxgHVTBTKUrBVM10WoT7CC3kFw2ylyK+aBDAcwGndNNK
         xsfemN9QYgCq7vfaJq9kGHze41aW8g7ic+skC8FFn05SSfLuxROXfCytxS1hWAuz9vcq
         stYFeScbHSgjrhwPjfKsfjmyGfPCAqB0LpmXPVYWcrBSrftag7GJEsAIhZzZJabQB8Ev
         XTUYBgnCJuVgXZPUSyNyw3v7kNuomLMSbhp0J3IQ/BJgDkg8OFA0z81dOCqK06OqqV3j
         ss9L0FC3ertDQGlGcZNJ7LecJoFe4XRRk8nTApb8XVuWSmSzXH7k2uMRRRbGG5yv+YpV
         +0Nw==
X-Gm-Message-State: AHQUAubZsIoWap4ZHvQW8MFIIgFPEavzqMJJDmU8+7I4YAuufjNNuQQm
        Ip5VL8bP/Gs4/Q+iEP/LO0AHbYotRjtVtW+7EMk=
X-Google-Smtp-Source: AHgI3IZt6qXGIDBGbFluk7qnsht6A/YzPy3zUraXhmJ9eLlqPL4VCMN1DpMhvTna4VCKPvtXNHCulmThKqXbIBD/o/8=
X-Received: by 2002:a9d:718d:: with SMTP id o13mr7516888otj.119.1549882608827;
 Mon, 11 Feb 2019 02:56:48 -0800 (PST)
MIME-Version: 1.0
References: <cover.1549874368.git.viresh.kumar@linaro.org> <03ac36a174f6c28be0b3af9d2db8631d56695f1d.1549874368.git.viresh.kumar@linaro.org>
 <CAJZ5v0hhxUQxf9VbhU_6B29MYspNo0Go+o4_OkxgnBe8+bGTdw@mail.gmail.com>
In-Reply-To: <CAJZ5v0hhxUQxf9VbhU_6B29MYspNo0Go+o4_OkxgnBe8+bGTdw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 11 Feb 2019 11:56:37 +0100
Message-ID: <CAJZ5v0jKFaF5JRuwzR=d5Zc9p86m0eBDSmC-+d3LSKgyWuUpYg@mail.gmail.com>
Subject: Re: [PATCH 1/2] cpufreq: Allow light-weight tear down on CPU offline operation
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

On Mon, Feb 11, 2019 at 11:51 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Feb 11, 2019 at 9:41 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > The cpufreq core doesn't remove the cpufreq policy anymore on CPU
> > offline operation, rather that happens when the CPU device gets
> > unregistered from the kernel. This allows faster recovery when the CPU
> > comes back online. This is also very useful during system wide
> > suspend/resume where we offline all non-boot CPUs during suspend and
> > then bring them back on resume.
> >
> > This commit takes the same idea a step ahead to allow drivers to do
> > light weight tear-down during CPU offline operation.
> >
> > A new callback is introduced, light_weight_exit(), which gets called
> > when all the CPUs of a policy are removed/offlined and the existing
> > exit() callback gets called when the policy gets freed.
> >
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---

[cut]

> > diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> > index 9db074ecbbd7..36ce31516041 100644
> > --- a/include/linux/cpufreq.h
> > +++ b/include/linux/cpufreq.h
> > @@ -325,6 +325,7 @@ struct cpufreq_driver {
> >         /* optional */
> >         int             (*bios_limit)(int cpu, unsigned int *limit);
> >
> > +       int             (*light_weight_exit)(struct cpufreq_policy *policy);
>
> Can you call it "offline"?
>
> >         int             (*exit)(struct cpufreq_policy *policy);
> >         void            (*stop_cpu)(struct cpufreq_policy *policy);
> >         int             (*suspend)(struct cpufreq_policy *policy);
> > --

Also, I would prefer a corresponding "online" callback to be there too
for symmetry and I'd prefer the core to decide to call "online"
instead of "init" for the light-weight case instead of ->init() itself
having to figure out the context.
