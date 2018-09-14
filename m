Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293F8FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 07:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D505E20866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 07:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uBl4iv5S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D505E20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbeINMyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 08:54:35 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:46820 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbeINMye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 08:54:34 -0400
Received: by mail-qt0-f196.google.com with SMTP id l42-v6so7866703qtf.13;
        Fri, 14 Sep 2018 00:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3efAQs9RgsvufH+fx5koIKFbVTz2vAavkVGrNZFIPnU=;
        b=uBl4iv5SpTalF7QA9Fj99feQEzVAti+6AUcYn327vE/55o3Jyvu6pDWSF+aoSbQOR5
         6ssEc3tybJ3a32+W0RE7DAV5sN9DuTDLhQPzh8iyVbjM8xi7iulCVQWtOPekYITVDs44
         3Jh6iM7k6EytzSXtNG+LbKWDJuX1MW12DEzJ5BMORyMYtw0WgIj9NZz1fWPK+hF1ezdb
         7RakWMPJ/F/LUAqjpauv/PgE7dlaLHFZLURl+75kB/mneLSM+vmqnRBbRo5rS1g+TSUL
         fX19tqE6dilsZ4tdpxJ+JmQw2w07R/MGOaaPutlEV9/Zx4+8WPaVExiw8jFea8oLFOSl
         quRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3efAQs9RgsvufH+fx5koIKFbVTz2vAavkVGrNZFIPnU=;
        b=SJuAZZZxk6f5Y2lF5/1iklyKjrg6/bpjkDItfyJCJeC0ybebUxZNxCdjIpQGlOjMme
         /e/hququlkNqjI8jcCW4QOR5fJSDgampK3lXGZhKKYz8DFWy/JeyuTq15//cmT6JJKba
         uXb9OtH7lCcJ75fYaiuG5dZKm/Y8VwKhcrbpMPJ5ybUUFRMiTO8SWtGJWN0q6XATxKvS
         WHjGaKlkrAgty71gcRyZ1TP3zmKvsab+ts6pRfvXoeY3sX5Y08Ri5Wbo5yCvr+2n1Mn4
         V8bunfNyElKDl/hR5qZrwTOEyzjNJWlSQVjNjRnx8PIrw7N7YQXz7c7unNr0XormnAoC
         1ybw==
X-Gm-Message-State: APzg51AKxS4rpI4QV7Tg49ScvjHvdOSXehNdOYr82QDvA6uPty+GRNje
        +5o+4ndhJJRYZ/48tSEjppzZ8dj707rYAXxp28A=
X-Google-Smtp-Source: ANB0VdZVScsXqAYFPw+BMFY5+E/mu6qmDWuDCORYboUD4deVe55jJqWhFk5/sBKmlcyoCLIG2EHx47DH3QrdqEqQ+M4=
X-Received: by 2002:a0c:c13c:: with SMTP id f57-v6mr8161409qvh.7.1536910881253;
 Fri, 14 Sep 2018 00:41:21 -0700 (PDT)
MIME-Version: 1.0
References: <20180913223143.12664-1-rajatja@google.com>
In-Reply-To: <20180913223143.12664-1-rajatja@google.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 14 Sep 2018 10:33:18 +0300
Message-ID: <CAHp75VcVkp6i_4oNVJvzde13MwaRQge91mvZF2aXgneZC9nzWg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: icelake: Fix the resource number for community-4/5
To:     Rajat Jain <rajatja@google.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        rajatxjain@gmail.com, subrata.banik@intel.com,
        aamir.bohra@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 1:54 AM Rajat Jain <rajatja@google.com> wrote:
>
> The Icelake does not have a community-3, and the memory resources are
> laid out in the following order in the ACPI:
>
> resource-0: community-0 registers
> resource-1: community-1 registers
> resource-2: community-2 registers
> resource-3: community-4 registers
> resource-4: community-5 registers
>
> (EDS also describes the communities in the above order).
>
> Since the pinctrl driver exposes communities 0, 1, 4, 5, it needs to get
> the corresponding community registers by getting the resourse number right.
> Currently the resourse number is not correct for community 4 and 5, thus
> fix that.
>

Can you share link to the ACPI dump of the tables? (you may get one by
running `acpidump -o tables.dat`)

> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
>  drivers/pinctrl/intel/pinctrl-icelake.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pinctrl/intel/pinctrl-icelake.c b/drivers/pinctrl/intel/pinctrl-icelake.c
> index 630b966ce081..5b4eaf7c90df 100644
> --- a/drivers/pinctrl/intel/pinctrl-icelake.c
> +++ b/drivers/pinctrl/intel/pinctrl-icelake.c
> @@ -331,8 +331,8 @@ static const struct intel_padgroup icllp_community5_gpps[] = {
>  static const struct intel_community icllp_communities[] = {
>         ICL_COMMUNITY(0, 0, 58, icllp_community0_gpps),
>         ICL_COMMUNITY(1, 59, 152, icllp_community1_gpps),
> -       ICL_COMMUNITY(2, 153, 215, icllp_community4_gpps),
> -       ICL_COMMUNITY(3, 216, 240, icllp_community5_gpps),
> +       ICL_COMMUNITY(3, 153, 215, icllp_community4_gpps),
> +       ICL_COMMUNITY(4, 216, 240, icllp_community5_gpps),
>  };
>
>  static const unsigned int icllp_spi0_pins[] = { 22, 23, 24, 25, 26 };
> --
> 2.19.0.397.gdd90340f6a-goog
>


-- 
With Best Regards,
Andy Shevchenko
