Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 702D3C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 221352178F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTa3+Txd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 221352178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933904AbeFZReJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:34:09 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:42576 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933876AbeFZReH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:34:07 -0400
Received: by mail-ua0-f195.google.com with SMTP id x18-v6so11449874uaj.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 10:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bHzKaTMcq3WJpgnQFu42binSsmFd5l5rYApGziJpKQw=;
        b=dTa3+TxdM0O8A8l1vIezAvYEDzWyv+vUSEKKufbB5GymUiu+DrhcstvU1wZ9Ywodoh
         1CZs68qV/qLRqjPrWKHbkkR9bkHa2oZrDC1xhbudW8Ms3WEQEGSlVz/5Uz7FDcz0zg3A
         t1kMAz1de1Od0bmy7GVJLuGRffZ9NwLKeMT5m0pMG3AdfrekQSFftF4vgvdqHglEZHLm
         PRMTzPAmUKweY7TJ5fzQzBSAE7q9t3tryJ3nQ3kH0J2nwupKhCVTIu02rOfJNlKR1BsG
         JPIAkVhhe7kpj1o3YjiwpDjbZevPKl4hyPD70fSFztd8GAVZvKqa5I11rseyhek7753w
         6ZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bHzKaTMcq3WJpgnQFu42binSsmFd5l5rYApGziJpKQw=;
        b=XR4eWN87GEIy/ArLm8R2ghXwVhLutxPpcDDU4R9s1ycrk5o77Pud7SAgCPB3cHC/0x
         tZAt4AgnIxCcI3pz2TCq+7ps+MGqOigGWkMB3F2MW7ZCrEWhUVjazOudLfaMEDeuegwR
         2ogfuEGbUbAYrC+ZtNMvFJmcbK+vulmDCmNf0jw6nJsBntgQcJaGvaxTzH/Pykim/Yb/
         /wapLJJdGYuvYwPZV9TVNIP8PK01HnK0BFFFmMUxj0ABS0fZdpFs6au30qu5FAyhcG4V
         9hcCnSlSbD1Gjon+4sPsZa6/cK68v/9Qg+sOaaka4AXHJ4nhPCQXaPMXVqe9GEbec+Da
         X1Ow==
X-Gm-Message-State: APt69E0cDwlOdadWQ+fjJ0x5r2AoX8zVJETTvg3/eU9OsXejs3UDRGM9
        NIP6oQRTl8imYkoywaQR2bi8wggQrxop2a0FxEQ=
X-Google-Smtp-Source: AAOMgpfqoADYqTE8vLyIIrl8mXTSz9o/5i1UVzZMAegdFLKqeGePTLIt/wq4UD6XJHnl1ywtFZmZmm3JeNd+kTl0tDU=
X-Received: by 2002:ab0:1a23:: with SMTP id a35-v6mr1574605uai.47.1530034447195;
 Tue, 26 Jun 2018 10:34:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 10:34:06
 -0700 (PDT)
In-Reply-To: <20180626081409.9518-4-straube.linux@gmail.com>
References: <20180626081409.9518-1-straube.linux@gmail.com> <20180626081409.9518-4-straube.linux@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 26 Jun 2018 20:34:06 +0300
Message-ID: <CAHp75Ve8JTY7KiQcRnD+DV-oEWnqFgA9uu2Ufz22zaOvf_xiGw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] staging: rtl8723bs: use mac_pton() in rtw_macaddr_cfg()
To:     Michael Straube <straube.linux@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 11:14 AM, Michael Straube
<straube.linux@gmail.com> wrote:
> Use the mac_pton() helper to convert the mac address string.
>
> The functions key_char2num() and key_2char2num() are not used
> anywhere else and can be removed.
>
> This also has the benefit of validating the input since mac_pton()
> returns false if the string is not valid.
>

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>  .../staging/rtl8723bs/core/rtw_ieee80211.c    | 30 +++----------------
>  .../staging/rtl8723bs/os_dep/ioctl_linux.c    |  3 --
>  2 files changed, 4 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
> index 8af4a89e632f..8e0025e1ff14 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
> @@ -1137,25 +1137,6 @@ ParseRes rtw_ieee802_11_parse_elems(u8 *start, uint len,
>
>  }
>
> -static u8 key_char2num(u8 ch);
> -static u8 key_char2num(u8 ch)
> -{
> -               if ((ch >= '0') && (ch <= '9'))
> -                       return ch - '0';
> -               else if ((ch >= 'a') && (ch <= 'f'))
> -                       return ch - 'a' + 10;
> -               else if ((ch >= 'A') && (ch <= 'F'))
> -                       return ch - 'A' + 10;
> -               else
> -                       return 0xff;
> -}
> -
> -u8 key_2char2num(u8 hch, u8 lch);
> -u8 key_2char2num(u8 hch, u8 lch)
> -{
> -               return ((key_char2num(hch) << 4) | key_char2num(lch));
> -}
> -
>  void rtw_macaddr_cfg(struct device *dev, u8 *mac_addr)
>  {
>         u8 mac[ETH_ALEN];
> @@ -1166,14 +1147,11 @@ void rtw_macaddr_cfg(struct device *dev, u8 *mac_addr)
>         if (!mac_addr)
>                 return;
>
> -       if (rtw_initmac) {      /*      Users specify the mac address */
> -               int jj, kk;
> -
> -               for (jj = 0, kk = 0; jj < ETH_ALEN; jj++, kk += 3) {
> -                       mac[jj] = key_2char2num(rtw_initmac[kk], rtw_initmac[kk + 1]);
> -               }
> +       if (rtw_initmac && mac_pton(rtw_initmac, mac)) {
> +               /* Users specify the mac address */
>                 ether_addr_copy(mac_addr, mac);
> -       } else{ /*      Use the mac address stored in the Efuse */
> +       } else {
> +               /* Use the mac address stored in the Efuse */
>                 ether_addr_copy(mac, mac_addr);
>         }
>
> diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> index 39502156f652..4eb51f45b387 100644
> --- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> +++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> @@ -32,9 +32,6 @@
>  #define WEXT_CSCAN_HOME_DWELL_SECTION  'H'
>  #define WEXT_CSCAN_TYPE_SECTION                'T'
>
> -
> -extern u8 key_2char2num(u8 hch, u8 lch);
> -
>  static u32 rtw_rates[] = {1000000, 2000000, 5500000, 11000000,
>         6000000, 9000000, 12000000, 18000000, 24000000, 36000000, 48000000, 54000000};
>
> --
> 2.18.0
>



-- 
With Best Regards,
Andy Shevchenko
