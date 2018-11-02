Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52F5C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 16:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C79C2081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 16:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XwmXaJDu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C79C2081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbeKCBmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 21:42:53 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35779 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbeKCBmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 21:42:53 -0400
Received: by mail-ed1-f65.google.com with SMTP id d6-v6so2329362edi.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 09:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZWPYcbOdNZuRP97q2FW3KBWcbG4yz3Ty50qTBDV9y7I=;
        b=XwmXaJDuDO6TKZGAoXWAJwSOGEoeAuWt2WOVJcsEB/mXqu6shP+O1faxRdJ8c1VRFX
         7sssVQLmsWff4El4jW2uOBIpa4Y6YzRVC3O/FafftNrpGgfthBeEx5JmhrSZk+m4OChW
         uqzYFfGpSdiz74I7z1CQRddWLEUa37T6oZflw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZWPYcbOdNZuRP97q2FW3KBWcbG4yz3Ty50qTBDV9y7I=;
        b=Rqu8sGhBGfuGmY5iylay/vlHx0ih3k1ZqWa/Gx2Wp20N43dEEod0mywKQkO4ujgXZm
         UCT9S35axUCpgEp7bgWIZJz+lXiQ+GHfxdE9bo/QA+248qdHWHopsbpcB74REy8g2gFL
         T+Z37+iwJ0Lmny1OX/II5qf3ZA142K6Gh52lYFqq+x78Bb5wq1+3ecKcNr9WHYdEN1Gc
         Z/7fUe+OEbleWdUL73iSDKJn9KkHpvRvwQtlzMJMK2opLPgLp6S950ZaOqZNy1w46Wot
         7iEi+XF1F/XEFLrJGYKDK9L1Ws9+nlQq/D/GIL3KX9mHmQk737siM7SGon7EVEj0ARC+
         GbjA==
X-Gm-Message-State: AGRZ1gJzaFMiVJkGF/0kc9ot+VvPytxIhVx96HIMgfpy6M8ieRsg4qff
        g/hGw6KMFEjD1L+1xEZrQfFnkyjHupk=
X-Google-Smtp-Source: AJdET5fMJ5tq/WbC5e+xeB8fvKDNonrASctlEtGvVuXIfCjM//fSa8fZpd0DKGlYWCdvVbZengFmgQ==
X-Received: by 2002:a50:e00e:: with SMTP id e14-v6mr9560318edl.152.1541176509412;
        Fri, 02 Nov 2018 09:35:09 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id d23-v6sm1221937ejk.21.2018.11.02.09.35.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 09:35:07 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id y20-v6so2294093eds.10
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 09:35:05 -0700 (PDT)
X-Received: by 2002:a50:ad0d:: with SMTP id y13-v6mr9469698edc.121.1541176505371;
 Fri, 02 Nov 2018 09:35:05 -0700 (PDT)
MIME-Version: 1.0
References: <20181102161833.2956376-1-arnd@arndb.de>
In-Reply-To: <20181102161833.2956376-1-arnd@arndb.de>
From:   Brian Norris <briannorris@chromium.org>
Date:   Fri, 2 Nov 2018 09:34:53 -0700
X-Gmail-Original-Message-ID: <CA+ASDXPVJMge_B-AUXj1sKc4dB+3FcXew8T5FYEXVsncKYotiw@mail.gmail.com>
Message-ID: <CA+ASDXPVJMge_B-AUXj1sKc4dB+3FcXew8T5FYEXVsncKYotiw@mail.gmail.com>
Subject: Re: [PATCH] ath10k: avoid -Wmaybe-uninitialized warning
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kalle Valo <kvalo@codeaurora.org>, davem@davemloft.net,
        pillair@codeaurora.org, akolli@codeaurora.org,
        bpothuno@codeaurora.org, yintang@qti.qualcomm.com,
        srirrama@codeaurora.org, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 2, 2018 at 9:19 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> In some configurations the inlining in gcc is suboptimal, causing
> a false-positive warning:
>
> drivers/net/wireless/ath/ath10k/mac.c: In function 'ath10k_mac_init_rd':
> drivers/net/wireless/ath/ath10k/mac.c:8374:39: error: 'rd' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>   ar->ath_common.regulatory.current_rd = rd;
>
> If we initialize the output of ath10k_mac_get_wrdd_regulatory()
> before returning, this problem goes away.
>
> Fixes: 209b2a68de76 ("ath10k: add platform regulatory domain support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/net/wireless/ath/ath10k/mac.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
> index a1c2801ded10..0d5fde28ee44 100644
> --- a/drivers/net/wireless/ath/ath10k/mac.c
> +++ b/drivers/net/wireless/ath/ath10k/mac.c
> @@ -8321,6 +8321,8 @@ static int ath10k_mac_get_wrdd_regulatory(struct ath10k *ar, u16 *rd)
>         u32 alpha2_code;
>         char alpha2[3];
>
> +       *rd = ar->hw_eeprom_rd;
> +

Maybe it's just me, but it seems kinda weird for this function to
assign a (valid) value to its "output" and still potentially return an
error.

If you really need to work around this compiler bug, maybe just put
the eeprom assignment back in ath10k_mac_init_rd()? I'll leave it up
to Kalle as to whether he wants to work around the compiler at all :)

Oh wait, one more thing: this is actually an invalid refactoring. See
how this function assigns '*rd' later in error cases. Today, we still
treat those as errors and clobber those with the eeprom value, but
now, you're making the fallback case continue to use the erroneous
value (0xffff). You need to make that use a local variable and avoid
clobbering *rd, if you want this to be correct.

>         root_handle = ACPI_HANDLE(&pdev->dev);

Side note: your patch made me notice -- this code is *not* only used
on PCI devices, yet it utilizes the 'pci_dev' structure. Fortunately,
it only does this to needless convert it right back to a bare
'device', and then the ACPI code safely handles non-ACPI devices
(should result in -EOPNOTSUPP below), but this is awfully strange
code.

Anyway, I'm just thinking out loud. I'll probably patch the pci_dev out myself.

Brian

>         if (!root_handle)
>                 return -EOPNOTSUPP;
> @@ -8365,11 +8367,9 @@ static int ath10k_mac_init_rd(struct ath10k *ar)
>         u16 rd;
>
>         ret = ath10k_mac_get_wrdd_regulatory(ar, &rd);
> -       if (ret) {
> +       if (ret)
>                 ath10k_dbg(ar, ATH10K_DBG_BOOT,
>                            "fallback to eeprom programmed regulatory settings\n");
> -               rd = ar->hw_eeprom_rd;
> -       }
>
>         ar->ath_common.regulatory.current_rd = rd;
>         return 0;
> --
> 2.18.0
>
