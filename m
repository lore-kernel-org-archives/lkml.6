Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D436C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 16:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB4F32243E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 16:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSlYjIcb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB4F32243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733309AbeKOCFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 21:05:48 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:32993 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731585AbeKOCFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 21:05:47 -0500
Received: by mail-qk1-f194.google.com with SMTP id o89so26635830qko.0;
        Wed, 14 Nov 2018 08:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cB6zloiCCh4J6hRjYExG6HTiZsY309QCKGedPhFlyzE=;
        b=VSlYjIcb2UgC3fGtBkUwPORMH009x7vxm0XzsFVPGxCNz3zft0KTpWgF8YjclDkQog
         KLZeVn1AgyM9oG+1d+pU7p/HgioU1zQCsGygH0gTRfts347OCpb0/+TURjvb0DCm7G2q
         rRQ4WMRaPTosjlwbzjwePdDzw87ATzRp1/5p/88U05Hcu/S4pF8DXAKF9aPea3Zv4Y4Z
         ZJ+atWhXf43WCQrOQ3jrbOgAWctFz/1Wycwhfy54Pq6uO4Mg2GcOYW6seToSEOC9r41L
         Viu3gKP3Dg98ews49I1WH2SRYPXNlrWk++oqZJP2eo4WpetaH1k15LGoBoQUFEDP+LQo
         D38A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cB6zloiCCh4J6hRjYExG6HTiZsY309QCKGedPhFlyzE=;
        b=r+T+22Mia5+TQQRKbEf6eTlr5BFjQVlMRcofsx9jFq8c9FxEmMkeBfQFARsNsLaATs
         t4CNlysiOUt96ChWFnj3V5wmbRLcQd9PGIbGfBbXko2Zh5zVr4pVYf0TM2IeMPjiKV/N
         kiOrimSsZghM/U7hMLLzHw9CNoO6dUdI11wGtn6NPGY+G9h60ISz6cY1eGa7PbG56Kiy
         jPq7CJHKx4STN2SUdWNahCT8k0zfccae11YW3drwv54zPH5AG9mXoEHB9vvoracOTDiv
         6XLq6eSJfunNHWdVGXa0xntf6sNpnR/CQS2b2oX34561VSWU8EZfiTZV7rPs9zzkr+1K
         wnTQ==
X-Gm-Message-State: AGRZ1gKvWxcwu3j9xdSfoS9yuF3hnjsner570wu7OoApRRWL15Hvkr2o
        kGoPWW2058AioeBDnuUF1oozY8uiskEesNkmqzM=
X-Google-Smtp-Source: AJdET5cs9u3UZNjt5KzJlTHlXrSRK5DjUbo/1zzjnVibmklaRY1VoWswzr9oxXmvw6syYAijDg93bgiA4kjNvz+g4P8=
X-Received: by 2002:aed:2d42:: with SMTP id h60mr2334713qtd.373.1542211318331;
 Wed, 14 Nov 2018 08:01:58 -0800 (PST)
MIME-Version: 1.0
References: <20181114151212.20942-1-loic.wyn@gmail.com>
In-Reply-To: <20181114151212.20942-1-loic.wyn@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 14 Nov 2018 18:01:47 +0200
Message-ID: <CAHp75VfX+4SUcKUPfQCeVM2M6dKwD+PZpTDHP2yi4yv35prhVQ@mail.gmail.com>
Subject: Re: [PATCH] ideapad-laptop: Add Lenovo Yoga 2 13 to the no_hw_rfkill
 DMI list
To:     Loic Wei-Yu-Neng <loic.wyn@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Ike Panhc <ike.pan@canonical.com>,
        Andy Shevchenko <andy@infradead.org>,
        Jiri Kosina <trivial@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 5:13 PM Loic WEI YU NENG <loic.wyn@gmail.com> wrote:
>
> Some Lenovo ideapad models lack a physical rfkill switch.
> On Lenovo models Yoga 2 13, ideapad-laptop would wrongly report all
> radios as blocked by hardware which caused wireless network connections
> to fail.
> Add these models without an rfkill switch to the no_hw_rfkill list.
>

Pushed to my review and testing queue, thanks

> Signed-off-by: Loic WEI YU NENG <loic.wyn@gmail.com>
> ---
>  drivers/platform/x86/ideapad-laptop.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
> index b6489cba2985..1589dffab9fa 100644
> --- a/drivers/platform/x86/ideapad-laptop.c
> +++ b/drivers/platform/x86/ideapad-laptop.c
> @@ -1188,6 +1188,13 @@ static const struct dmi_system_id no_hw_rfkill_list[] = {
>                         DMI_MATCH(DMI_BOARD_NAME, "Yoga2"),
>                 },
>         },
> +       {
> +               .ident = "Lenovo Yoga 2 13",
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +                       DMI_MATCH(DMI_PRODUCT_VERSION, "Yoga 2 13"),
> +               },
> +       },
>         {
>                 .ident = "Lenovo Yoga 3 1170 / 1470",
>                 .matches = {
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
