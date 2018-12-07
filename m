Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB85C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 07:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD88B20838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 07:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gyoPyYdy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD88B20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbeLGHXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 02:23:12 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32822 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeLGHXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 02:23:11 -0500
Received: by mail-wr1-f65.google.com with SMTP id c14so2836529wrr.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 23:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=dnkbnjloWAk87bUhR0TGnS9e3Xtyho1TLIdVzuZ2EDY=;
        b=gyoPyYdy94Rv9yXJHvPXbkMCse4NXP3eD/U+BAzXOPvk27JEwKgDIHK523k8CszZJE
         HBH2bzJgfJ3XflT4WVVwyn2MTumpxeO4sRGL39UU86Dlw31+i4OpboAzdhP9SPi4DodA
         WZ7jLfVWZBIl8krpq3fUKJZVMWIu4mcT4r0Hg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=dnkbnjloWAk87bUhR0TGnS9e3Xtyho1TLIdVzuZ2EDY=;
        b=ktV0i2NSNRYSwr8cKikT30rDYAMFISRz1ym840Nj3LRSeeolDwDOEUsfs8UyBXypk/
         7zujw1sjHOQ2XwIQi7jgcz3hbZrlKAXLgX142qevmWoqvb90ydWR5P2q+It6IFcg56xk
         EY0mW7uf32YbQPH0daDN5gL+j1/LmgV0PvHG4HLIA6kQAHV+9aaQ2liUh4u9yiwD/hEo
         4IV78k1/3eqS81iYyOcVunBeq4QU5ExHtfLjNjxftmbfhsM+ml0Ia8E3fmmZE630gEx/
         BNdCP1+KjRHxRklBMvW0zhFZBnrs3UJ86tzBxjmQGiP9rDdBvPC9OD6g5hqdZiR03m1v
         Kuyg==
X-Gm-Message-State: AA+aEWaHSlG5Ebrb09+pQCzohygMHAGSDRY14S521ko8WAxCvBaEbBjx
        M8IEO0v+gBDUJeSUbLlcTify3cbVegM=
X-Google-Smtp-Source: AFSGD/V/4mw6L0/b5LqxMA1/o4/WYUeYDifYbUGJC3vD5cqeqevwfTkwI/Ar0H/DpzdU+R0sKEajcQ==
X-Received: by 2002:adf:e8c1:: with SMTP id k1mr795005wrn.104.1544167389998;
        Thu, 06 Dec 2018 23:23:09 -0800 (PST)
Received: from dell ([2.31.167.218])
        by smtp.gmail.com with ESMTPSA id x76sm6563551wmd.27.2018.12.06.23.23.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 23:23:09 -0800 (PST)
Date:   Fri, 7 Dec 2018 07:23:07 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Cheng-yi Chiang <cychiang@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org, Dylan Reid <dgreid@chromium.org>,
        tzungbi@chromium.org, rohitkr@codeaurora.org
Subject: Re: [PATCH 1/3] mfd: cros_ec: Add commands to control codec
Message-ID: <20181207072307.GF26661@dell>
References: <20181127120041.90759-1-cychiang@chromium.org>
 <20181128093411.GC4272@dell>
 <20181203111919.GL26661@dell>
 <CAFv8NwLEQ7EUSTRfAf42w2BY0aEPi_pjcMkPzzCNb=17pfzQXw@mail.gmail.com>
 <CAFv8NwLZc7YmCbFi-4nCOG5GUwrRbc+JdXLBKv2JA8d6eC3SDg@mail.gmail.com>
 <20181205113045.GD26661@dell>
 <20181205113406.GE26661@dell>
 <CAFv8NwKgspykPHWfdjapzY-wCAp8MmduKq_yhrvWct2r7yFCzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFv8NwKgspykPHWfdjapzY-wCAp8MmduKq_yhrvWct2r7yFCzA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Dec 2018, Cheng-yi Chiang wrote:

> On Wed, Dec 5, 2018 at 7:34 PM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Wed, 05 Dec 2018, Lee Jones wrote:
> >
> > > On Wed, 05 Dec 2018, Cheng-yi Chiang wrote:
> > >
> > > > Hi Lee,
> > > >
> > > > I tried to apply this patch based on
> > > > for-mfd-next branch of mfd tree (
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git )
> > > > Then, I tried to compile all modules by
> > > >
> > > >  ARCH=x86_64 make allyesconfig
> > > >  ARCH=x86_64 make -j64
> > > >
> > > > There was no error.
> > > > Could you please let me know what was the error when you failed to
> > > > apply this patch ?
> > >
> > > Doesn't work for me.
> > >
> > > lee@host:~/projects/kernel [for-mfd-next]$ formfdnext
> > > Applying: mfd: cros_ec: Add commands to control codec
> > > error: sha1 information is lacking or useless (include/linux/mfd/cros_ec_commands.h).
> > > error: could not build fake ancestor
> > > Patch failed at 0001 mfd: cros_ec: Add commands to control codec
> > > Use 'git am --show-current-patch' to see the failed patch
> > > When you have resolved this problem, run "git am --continue".
> > > If you prefer to skip this patch, run "git am --skip" instead.
> > > To restore the original branch and stop patching, run "git am --abort".
> >
> > Not that the following lines (as seen in your patch) are not present
> > in the Mainline kernel.
> >
> > > @@ -4077,6 +4077,100 @@ struct __ec_align1 ec_response_i2c_passthru_protect {
> > >       uint8_t status;         /* Status flags (0: unlocked, 1: locked) */
> > >  };
> >
> > Do you have other patches applied to your tree?
> 
> Hi Lee,
> Sorry, I see the problem.
> I was using git am -3 which solves the conflict by itself.

That's what I use, but it still had issues.

Git is probably using a previous resolution in your case.

> I will resend a patch based on your for-mfd-next branch so we can keep
> the patch clean.
> Thanks for your time.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
