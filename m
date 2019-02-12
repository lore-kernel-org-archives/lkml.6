Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BBBC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D683321B18
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549967199;
	bh=b0tVa3ej1EOyVDum8RD55CnX7XKjp4rEZYyet+hiOuw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=TQIsKrV/SO66oQn+uoGwPxidn0MeZ4qa34q2NeXmGlXMVqerfQt0kLngXnYv9ZF5M
	 30Ql45PnY5VzfzyFxb28A+NfAKiyY7CQahy2YcYlFNwwuMpbKzAKLuGs+fCUlXkHeo
	 7VetrH9uv96+hGQFhbCHT+YhorKP6wcAXetvXnR8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbfBLK0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 05:26:38 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36839 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbfBLK0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 05:26:38 -0500
Received: by mail-ot1-f65.google.com with SMTP id k98so3567623otk.3;
        Tue, 12 Feb 2019 02:26:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cBe9slv4lWWe8TyQe1NJiIvJQhQytL+FI1HCzOEUrUw=;
        b=qHGMa4SQo9RGNjimrdXcXEkS6Cu4dq07IsSKp3BKgxc19d0wacVXlgt1q4CpK0xULh
         GE67bCELh7YXRUDiDp2DsJK81ZmdgN0gQeT46h2DRCOgWET7C9CSBbZ9hJqkDzGzT1Q2
         d417Q0hDMcnzbTe68PvSyUao5dWoRxwNAUjsuJ+h9QqXBDhXusBxx6OiqtLuzweHGDBU
         S2unl7qSyWiudTgMRHvt8mdr6F9mgLXZaZeKKzmdVDwKRJ3izxINIblmHX27cr06Ra0r
         0IwOX1qSqFcq3r1/JniboLRuVaykwtVRpQA+ZswfZIpZF0KndtjXOBNl/i1aT6aHaENA
         ZofA==
X-Gm-Message-State: AHQUAubOluz1nNRS20mPu/cA3yVJB0FV3Odk11L+oM/r5+VZZgPNmacz
        Dt35s/HLvYCaDpl9xU53pxPObkCMFWbZ0fYz2VkpDA==
X-Google-Smtp-Source: AHgI3Ia+GFHZND+TIVz7TD1CXhcF6ms580F6Kvu9mvrSsRi0CnovaKz4bQrPnhRYCIaYRpEheSueac7ygw+YxWfD1WM=
X-Received: by 2002:a9d:4c0f:: with SMTP id l15mr3067685otf.139.1549967196904;
 Tue, 12 Feb 2019 02:26:36 -0800 (PST)
MIME-Version: 1.0
References: <cover.1549955027.git.viresh.kumar@linaro.org> <8030961ef762018fc286e4d3d3a010638e900e53.1549955027.git.viresh.kumar@linaro.org>
 <CAJZ5v0hLOD-5XDp7jAwt4EqWYGAU9VZzumNchW9_+bt7F1MdQw@mail.gmail.com> <20190212094909.5eivfzfnc62lay7x@vireshk-i7>
In-Reply-To: <20190212094909.5eivfzfnc62lay7x@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 12 Feb 2019 11:26:25 +0100
Message-ID: <CAJZ5v0hABvt2w7v9bfxyzf84+a4LU4C4tczVvwFnaDaY=pKG6A@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] cpufreq: dt: Implement online/offline() callbacks
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
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

On Tue, Feb 12, 2019 at 10:49 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 12-02-19, 10:43, Rafael J. Wysocki wrote:
> > On Tue, Feb 12, 2019 at 8:07 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > Implement the light-weight tear down and bring up helpers to reduce the
> > > amount of work to do on CPU offline/online operation.
> > >
> > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > ---
> > >  drivers/cpufreq/cpufreq-dt.c | 17 +++++++++++++++++
> > >  1 file changed, 17 insertions(+)
> > >
> > > diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> > > index 7ba392911cd0..1aefaa1b0ca2 100644
> > > --- a/drivers/cpufreq/cpufreq-dt.c
> > > +++ b/drivers/cpufreq/cpufreq-dt.c
> > > @@ -295,6 +295,21 @@ static int cpufreq_init(struct cpufreq_policy *policy)
> > >         return ret;
> > >  }
> > >
> > > +static int cpufreq_online(struct cpufreq_policy *policy)
> > > +{
> > > +       /* We did light-weight tear down earlier, nothing to do here */
> > > +       return 0;
> > > +}
> >
> > I think you could avoid having to add this empty stub if the core
> > checked for both online and offline, that is
> >
> > if (driver->offline || driver->online) {
>
> This doesn't look great as all we should care about here is ->online()
> and checking for offline as well looks a bit hacky.

That's a matter of the driver I/F definition.

You can require online to be there if offline is set and the other way
around (but then you should check if that's the case while registering
the driver) or you can allow just one of them to be provided for the
lightweight online/offline to be done.  In the latter case the
presence of the other callback plays the role of a flag.

Both are basically fine by me, but if you go for the former, please
add the checks to cpufreq_register_driver().
