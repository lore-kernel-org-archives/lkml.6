Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E657AC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 06:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9537C2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 06:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="i/m7ohZH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9537C2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932897AbeFLGZr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 02:25:47 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:52393 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932539AbeFLGZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 02:25:45 -0400
Received: by mail-it0-f67.google.com with SMTP id m194-v6so13293743itg.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 23:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=djRo0AvE9gopwwP5+w01p5YWhU8W7ljhEsugL4Ar+9g=;
        b=i/m7ohZH6vWQXoZVuRsn5U1IxTJyNc0c2uDa5u/T144er4/XITKZgVryRUse1/2Wt1
         R4UlTTqrhetfc4C3OsCzuQGnYp6palRHWOVtlkiMHzmF6tMGT33vtxy1ziaypwsoR03A
         N+uCA2Kmh/iuSTmBUDjaXO4xCtocAs1jFOyg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=djRo0AvE9gopwwP5+w01p5YWhU8W7ljhEsugL4Ar+9g=;
        b=PDlaO8/GLOey5h+Yx5MIWzzRmuGituW1jyddeWTSnTnZ/HQxu4Obrdca/ojUVrsb94
         op5CZVaHPRFjajBhsguAE68FLUiXUD6wn3X+QMzey2JPoqjxiF7/OfGuqtvd2J+7awj/
         faf61pa70slwVufLiC5HHirh9kBUMNREg/nO7sF72r562ehJHg8/ur2uNEJaHL0J8ZFi
         nOCzExqGezsWuwHCd6NW//1geR9dXse44AuzpOvRNNTmaQ7JETXwsU6zTpRhEtTVDDcQ
         iuZm21UQnCbXum5wGIrzKKe2GAWxfbfJ894sYvnZjjFWwCWok0sR94X3UE3s6hgslY7H
         peJg==
X-Gm-Message-State: APt69E2+Vgv0y2QqF/S3J6H0C3RRdMk3NrPqL58xTEVgcPu3DtC/wQqB
        ByoGvi8vIp5QYuUSmoQWmZ09p2aS8RKyYH9BLjYQmA==
X-Google-Smtp-Source: ADUXVKI/Lz9c7GgT/3YVXbmQjeuvtW/1ilca74SY7sh0Aj2rTJ4HGcBkzKnZplrrsKygrOmzvYUW1KkYYN+RYIds1O8=
X-Received: by 2002:a24:308:: with SMTP id e8-v6mr2064788ite.102.1528784744621;
 Mon, 11 Jun 2018 23:25:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:c054:0:0:0:0:0 with HTTP; Mon, 11 Jun 2018 23:25:44
 -0700 (PDT)
In-Reply-To: <20180608095154.22413-1-feng.tang@intel.com>
References: <20180608095154.22413-1-feng.tang@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 12 Jun 2018 08:25:44 +0200
Message-ID: <CAPDyKFrs3ngkVVQaq34V9qzV3KoFdy=B+UbLnzR=fHKsOco=tg@mail.gmail.com>
Subject: Re: [PATCH] mmc: Move the mmc driver init earlier
To:     Feng Tang <feng.tang@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 June 2018 at 11:51, Feng Tang <feng.tang@intel.com> wrote:
> When doing some boot time optimization for an eMMC rootfs NUCs,
> we found the rootfs may spend around 100 microseconds waiting
> for eMMC card to be initialized, then the rootfs could be
> mounted.
>         [    1.216561] Waiting for root device /dev/mmcblk1p1...
>         [    1.289262] mmc1: new HS400 MMC card at address 0001
>         [    1.289667] mmcblk1: mmc1:0001 R1J56L 14.7 GiB
>         [    1.289772] mmcblk1boot0: mmc1:0001 R1J56L partition 1 8.00 MiB
>         [    1.289869] mmcblk1boot1: mmc1:0001 R1J56L partition 2 8.00 MiB
>         [    1.289967] mmcblk1rpmb: mmc1:0001 R1J56L partition 3 4.00 MiB
>         [    1.292798]  mmcblk1: p1 p2 p3
>         [    1.300576] EXT4-fs (mmcblk1p1): couldn't mount as ext3 due to feature incompatibilities
>         [    1.300912] EXT4-fs (mmcblk1p1): couldn't mount as ext2 due to feature incompatibilities
>
> And this is a common problem for smartphones, tablets, embedded
> devices and automotive products. This patch will make the eMMC/SD
> card  start initializing earlier, by changing its order in drivers/Makefile.
>
> On our platform, the waiting for eMMC card is almost eliminated with the patch,
> which is critical to boot time.

I am wondering what kernel version you are running here. There have
been some changes to the mmc initialization path, which perhaps can
help.

>
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
>  drivers/Makefile | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/Makefile b/drivers/Makefile
> index 24cd47014657..c473afd3c688 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -50,6 +50,9 @@ obj-$(CONFIG_REGULATOR)               += regulator/
>  # reset controllers early, since gpu drivers might rely on them to initialize
>  obj-$(CONFIG_RESET_CONTROLLER) += reset/
>
> +# put mmc early as many morden devices use emm/sd card as rootfs storage
> +obj-y                          += mmc/
> +

Your suggested approach isn't really a solution, as it may work for
your particular case but not for everybody else.

>  # tty/ comes before char/ so that the VT console is the boot-time
>  # default.
>  obj-y                          += tty/
> @@ -128,7 +131,6 @@ obj-$(CONFIG_EISA)          += eisa/
>  obj-$(CONFIG_PM_OPP)           += opp/
>  obj-$(CONFIG_CPU_FREQ)         += cpufreq/
>  obj-$(CONFIG_CPU_IDLE)         += cpuidle/
> -obj-y                          += mmc/
>  obj-$(CONFIG_MEMSTICK)         += memstick/
>  obj-$(CONFIG_NEW_LEDS)         += leds/
>  obj-$(CONFIG_INFINIBAND)       += infiniband/
> --
> 2.14.1
>

Kind regards
Uffe
