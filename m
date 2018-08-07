Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1CEC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 07:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EC9C219E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 07:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EC9C219E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388899AbeHGJqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 05:46:53 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:38656 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732805AbeHGJqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 05:46:53 -0400
Received: by mail-ua0-f196.google.com with SMTP id o11-v6so15068345uak.5;
        Tue, 07 Aug 2018 00:33:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GE/fYjIuio1/pTL8bdFFc+pv3Uk68paDEfNifPHmXWs=;
        b=kRCazbIZcFhm67uwFIStF7WwZE9ZpQ8Lq0X4I0+6myDc1uvY2et+q3Lg0cRz3CwYWl
         7IVW0UWs+zLE1Ls7Jb0uNIVAFmqkUdPE3dl+8dsSMkmmo/jFNgBwnYNYP4cxiooMVyQg
         SaFXSZcp05ZWNqfFyRapJA7I3GK9zlNHPzHVBAPwPJOlZg/FJPh3c6340VcVtkUfeDVD
         NNyyb0PdC5SU/rG1TT65BEP4BEw1JUJ3xsCxKa0Gn6sgdtTbS5plVJzi79TV790ul5E9
         CxJgxAc3sjkyJUDsKrFgiNRs1WEzWLfH6ISvCdswl72YRWWw4qe6ZCqpvuQGYx88RmE0
         05Fg==
X-Gm-Message-State: AOUpUlF5w+KZYUs+QbpIsorLMRr/Jfod339Kym+YAnVsL7zF3ybIxDrH
        D0Z15JbQ/eMbudz2EqH/W+qnRbsbu5VOk4DBFRc=
X-Google-Smtp-Source: AAOMgpdqehgpS+3jTcG7bm7ld/PVCL4WRpJ333yQgVnmJoBlkr38nSKWpnzWEGar3HZagmHTOncuQ4QjHujYxrctMO4=
X-Received: by 2002:a1f:8948:: with SMTP id l69-v6mr11835313vkd.132.1533627230008;
 Tue, 07 Aug 2018 00:33:50 -0700 (PDT)
MIME-Version: 1.0
References: <20180803030237.3366-1-songjun.wu@linux.intel.com> <20180803030237.3366-9-songjun.wu@linux.intel.com>
In-Reply-To: <20180803030237.3366-9-songjun.wu@linux.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 7 Aug 2018 09:33:38 +0200
Message-ID: <CAMuHMdXkGchPN337dXbBVOFsb1o-Tkh8S_z=uCm3Z0sDjPVMKA@mail.gmail.com>
Subject: Re: [PATCH v2 08/18] serial: intel: Get serial id from dts
To:     songjun.wu@linux.intel.com
Cc:     hua.ma@linux.intel.com, yixin.zhu@linux.intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiri Slaby <jslaby@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Songjun,

On Fri, Aug 3, 2018 at 5:04 AM Songjun Wu <songjun.wu@linux.intel.com> wrote:
> Get serial id from dts.
>
> "#ifdef CONFIG_LANTIQ" preprocessor is used because LTQ_EARLY_ASC
> macro is defined in lantiq_soc.h.
> lantiq_soc.h is in arch path for legacy product support.
>
> arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
>
> If "#ifdef preprocessor" is changed to
> "if (IS_ENABLED(CONFIG_LANTIQ))", when CONFIG_LANTIQ is not enabled,
> code using LTQ_EARLY_ASC is compiled.
> Compilation will fail for no LTQ_EARLY_ASC defined.
>
> Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>

Thanks for your patch!

> @@ -699,9 +700,19 @@ lqasc_probe(struct platform_device *pdev)
>                 return -ENODEV;
>         }
>
> -       /* check if this is the console port */
> -       if (mmres->start != CPHYSADDR(LTQ_EARLY_ASC))
> -               line = 1;
> +       /* get serial id */
> +       line = of_alias_get_id(node, "serial");
> +       if (line < 0) {
> +#ifdef CONFIG_LANTIQ
> +               if (mmres->start == CPHYSADDR(LTQ_EARLY_ASC))
> +                       line = 0;
> +               else
> +                       line = 1;
> +#else
> +               dev_err(&pdev->dev, "failed to get alias id, errno %d\n", line);
> +               return line;

Please note that not providing a fallback here makes life harder when using
DT overlays.
See the description of commit 7678f4c20fa7670f ("serial: sh-sci: Add support
for dynamic instances") for background info.

> +#endif
> +       }
>
>         if (lqasc_port[line]) {
>                 dev_err(&pdev->dev, "port %d already allocated\n", line);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
