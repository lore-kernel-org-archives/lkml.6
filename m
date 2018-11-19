Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95BBC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 14:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1C512089F
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 14:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kburjvj8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1C512089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbeKTAxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 19:53:50 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46785 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728776AbeKTAxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 19:53:50 -0500
Received: by mail-pg1-f194.google.com with SMTP id w7so13905679pgp.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 06:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QwwJ9jpZ6WmrT0omEblarnufa53ZpvjuAUT5K9gZE+s=;
        b=Kburjvj8Qo9l0D7kIfsinZGo8301ZeI08m1hltPJmvsLzZ4DRVaEHe+1FMD2htvKqV
         xxaufzLsQNRFJcBZ4AG6ZMYAwB9OcuS7/B7ec39iWpy1H98woByFpusolAUpex6uHY23
         AhbkhykmybTSf9JzcX0LBDBe+oAGfDiedeKdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QwwJ9jpZ6WmrT0omEblarnufa53ZpvjuAUT5K9gZE+s=;
        b=N+zR6tLqgwigVtIKN9iUmvsZmXyUuQFfCa3LhpogjNqeWzzmliDofku61d7IwpU3cP
         7HrhpaBWZJVQnyBLlzPJ/H1MvOQJfRJiqMuZ2yYwyvJlml3k2z7riHO3mVjpp+rRKqm4
         YI93NploRqOwFm+5OeOIdysmFG0fE90KU/Jq96TCroWggoIGHkt7ZyqfncX0lRgTwtqG
         whliz1Qg3VUy63B8t3QFX3W4A9DVveY9BfTOyb/hhA1KoestztAn54k9XpVhZs0gpqGG
         W2bVGW07frHjDil73olaQbRh68m7Xhj8I66HNauP7MbAugmi5sZ0Lz7JtwS3Wti5SPLx
         E0SA==
X-Gm-Message-State: AGRZ1gKYQeONnqxWsktNOZW5ZTH/w4FuQBbS5fsaQgoZuJyt9kr9H0XL
        ybEs2eMjwXgNWDiv/IKFXYOV
X-Google-Smtp-Source: AJdET5fS+deuIRIGUwUJftk6b+oliA8KPwXL8nfiqDA/sgEEEdr8sY8oR+fUlmMQ6bI4J2ELjIrRhA==
X-Received: by 2002:a63:200e:: with SMTP id g14mr20380514pgg.235.1542637802824;
        Mon, 19 Nov 2018 06:30:02 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:631b:44eb:3905:6402:e2fb:2d7])
        by smtp.gmail.com with ESMTPSA id d202sm41775009pfd.58.2018.11.19.06.29.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 06:30:02 -0800 (PST)
Date:   Mon, 19 Nov 2018 19:59:50 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>, pn@denx.de
Cc:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, mp-cs@actions-semi.com,
        "Thomas C. Liau" <thomas.liau@actions-semi.com>,
        linux@cubietech.com, saravanan sekar <sravanhome@gmail.com>
Subject: Re: [PATCH v7 5/5] arm64: dts: actions: Add pinctrl node for Actions
 Semi S700
Message-ID: <20181119142950.GA3364@Mani-XPS-13-9360>
References: <20181115124748.268286-1-pn@denx.de>
 <20181115124748.268286-6-pn@denx.de>
 <CACRpkdZqvnmzzAn4SRWuchniMn7K6GrxUXynW=Hf5zrgDH11JQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdZqvnmzzAn4SRWuchniMn7K6GrxUXynW=Hf5zrgDH11JQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 02:13:25PM +0100, Linus Walleij wrote:
> On Thu, Nov 15, 2018 at 1:48 PM Parthiban Nallathambi <pn@denx.de> wrote:
> 
> > From: Saravanan Sekar <sravanhome@gmail.com>
> >
> > Add pinctrl nodes for Actions Semi S700 SoC
> >
> > Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> > Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> > Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Please merge this through the ARM SoC tree.
>

Applied to dt-next branch of my tree with Linus's Reviewed-by tag.

Thanks,
Mani

> Yours,
> Linus Walleij
