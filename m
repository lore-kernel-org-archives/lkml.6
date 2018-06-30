Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FBEC3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 13:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6D6724446
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 13:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XeBPQDre"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6D6724446
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753026AbeF3NO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 09:14:56 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:37589 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752423AbeF3NOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 09:14:53 -0400
Received: by mail-pl0-f66.google.com with SMTP id 31-v6so5785985plc.4
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jun 2018 06:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WEIedL4ETXu48HZKo7jD2vtE+rGtdBk5hzDrVj/8Q/I=;
        b=XeBPQDreoYJBxp0AQ1t37QufkZAHF4cH8+YUPw12PD5IXWBIivqxW7G7XBc6OkwkYM
         kQQAq+p1UrOPWRwoHdwTAprNw0asGIuuiE4h1PR502rHwlvu5/kzTxrtbGjFzztOg3e6
         fre6XIisSb1o/gWXcchIBg5M2tq8Zyn22ruxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WEIedL4ETXu48HZKo7jD2vtE+rGtdBk5hzDrVj/8Q/I=;
        b=kvGsWOKj4Wl0i/1uAI3G/uSbvGb6ShdjYAFIOCp53Pz89pU4RediVXXNqThubenJ7I
         Wr5c+YffnCdJhwYZHticUD42RZzrU6r2CMPJGABAMGy6StTh/qjCEKe5pofHYJHbebS6
         ngfliWy37Whk/C9Jiqin7JbYEepiNaQWD8HEsD/am6BB98W8Utw5EvWeXHg4poEvCBHL
         78rVP+WYWM3px+1SOZydD3Ws10hAKJd7a4VzYPdz+6mAMiGNH47FsOsjFB64LFOu5ybH
         6y/0SDBxV/ojosZjXJB3Wg1MxWSB5jZIE8cDWQsBSGhpKeLetNtV21a8QOXpRKQBHeH0
         S8Rg==
X-Gm-Message-State: APt69E15RCKijK0lfI8/moTCepy5YccDIT2SOJm84BlbIblBcwWWEKKM
        CqP0NyToyoqoGXjWzf2XzkvF
X-Google-Smtp-Source: ADUXVKI1jxmbuMB03bRiRrkjQu+v9tUnu3XgdCN/sLL1IS5GTb4qL0fa1joMdJXycapYOR0u1CXtqw==
X-Received: by 2002:a17:902:42c3:: with SMTP id h61-v6mr18794773pld.319.1530364492523;
        Sat, 30 Jun 2018 06:14:52 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2405:204:73ca:b257:2c06:3367:1893:796])
        by smtp.gmail.com with ESMTPSA id 86-v6sm31892319pfp.17.2018.06.30.06.14.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Jun 2018 06:14:51 -0700 (PDT)
Date:   Sat, 30 Jun 2018 18:44:39 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        =?utf-8?B?5YiY54Kc?= <liuwei@actions-semi.com>,
        mp-cs@actions-semi.com, 96boards@ucrobotics.com,
        devicetree <devicetree@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        amit.kucheria@linaro.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        Mani Sadhasivam <manivannanece23@gmail.com>,
        Thomas Liau <thomas.liau@actions-semi.com>,
        jeff.chen@actions-semi.com
Subject: Re: [PATCH v2 5/6] i2c: Add Actions Semi OWL family S900 I2C driver
Message-ID: <20180630131439.GC16775@Mani-XPS-13-9360>
References: <20180628181042.2239-1-manivannan.sadhasivam@linaro.org>
 <20180628181042.2239-6-manivannan.sadhasivam@linaro.org>
 <CAHp75Vd__qOXVxZTdxREwD6p1sEw49R2Kqb+esAmr_EhtT=gFg@mail.gmail.com>
 <20180630124400.GB16775@Mani-XPS-13-9360>
 <CAHp75Ve5Thjsux6oaZis7axF3jZwqhr2CfrXFcpZuziszB_E9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Ve5Thjsux6oaZis7axF3jZwqhr2CfrXFcpZuziszB_E9A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Sat, Jun 30, 2018 at 04:04:20PM +0300, Andy Shevchenko wrote:
> On Sat, Jun 30, 2018 at 3:44 PM, Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> > On Sat, Jun 30, 2018 at 03:14:37PM +0300, Andy Shevchenko wrote:
> >> On Thu, Jun 28, 2018 at 9:10 PM, Manivannan Sadhasivam
> >> <manivannan.sadhasivam@linaro.org> wrote:
> 
> >> > +static int owl_i2c_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
> >> > +                               int num)
> >> > +{
> >>
> >> > +       int ret = 0, idx;
> >>
> >> Redundant assignment.
> >>
> >
> > No. Actually the return path will be fixed in next iteration. Please
> > see my reply to Peter's review for explanation.
> 
> How come? I didn't find anything related to this comment in reply you
> are referring to.
> I left deliberately the below part to show you the pointlessness of an
> assignment to 0.
>

Sorry, my bad. I overlooked this part. This assignment will be dropped.

> >> > +       ret = owl_i2c_hw_init(i2c_dev);
> >> > +       if (ret)
> >> > +               return ret;
> 
> Do you mean you are dropping this in next revision?
> 

Nope :)

Thanks,
Mani

> -- 
> With Best Regards,
> Andy Shevchenko
