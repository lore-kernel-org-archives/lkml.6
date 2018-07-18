Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5A1ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 988982075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/RJSbBM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 988982075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731151AbeGRV3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 17:29:20 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35813 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbeGRV3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 17:29:19 -0400
Received: by mail-oi0-f65.google.com with SMTP id i12-v6so11409078oik.2;
        Wed, 18 Jul 2018 13:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Ny84xO/06cSbFK7l6R+eoIzgDdn8Cb9Wrouf+SlR/lo=;
        b=E/RJSbBM1e4Jmm2ipG684IErFmdhDg3Q66tyAMfc47ymi+/pje0JJ5CN5kCD0ihbfQ
         E0l9ewvBUbY0AV3FilP/OiDfO+CnpjJGlqz/e9B+QvRoKDiAt+hIG2Yvxp3anDPSPPsS
         EAvwj3r57KpVKWN9PDswo9iBNlqOR9jdM5jYZ8yQ/OeOUM9So8zPAfBMTufhVemlfpp5
         /8UA7opU99+/T7+axze0R3ZK/m3PRnx1kenCslPXWTXF6/MwxA88KfaxVx7gxFnjz0w/
         UQpMIkEPrXgeOTu+alTuWuPHVtOE+oABlfog47tQ0zn4qCIlGQ6ElBnrDYlWNPTt5CGp
         OnIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Ny84xO/06cSbFK7l6R+eoIzgDdn8Cb9Wrouf+SlR/lo=;
        b=ErVutYK5aWMc06bxnwGlNRU32T2sVKsV0kZZ73+BSxM/KXMkXIduFFuQFkoE/ebYqh
         LulrqIwdjQl9S0Kmh5T2NkxPLbz3ZB73msRdyZfONY+sPXfoMPPJy1UARmWKnrtRqQMC
         dXByL0dSpbldRsXhubjySk7Uvnovq4203RXunNxHxhE3BHHPPNtF0mpF6jUfV7YeZdXN
         frxJQkn0zvwxpPX5861WucInJhQZ/MhEBGU3csB8HlTl5vAnS6fdvQea9ralwuuClWbe
         ONZv/YgbkvZnB2j51atszq+7bphGAtaVCEZFIrHbQ3DfmMRZ55GnBX6dDvmpeN7+MxiI
         lJsw==
X-Gm-Message-State: AOUpUlHvjU8A7doqWU2TajbjC3HI+N+Gkz3ru57cSEv+emlvUTwcw02B
        /eZmQY38IYygH1XVE6p5XM9u6bICDnUfpgDA1sU=
X-Google-Smtp-Source: AAOMgpdNktyylvaedkY9FGwOCkFYm5c/kr249qRhlE1UbOX633KdYJ3wIUQvLUcYH+5YLlepQCvXKjHSuUuwiyLyJLQ=
X-Received: by 2002:aca:400b:: with SMTP id n11-v6mr7614224oia.150.1531946980841;
 Wed, 18 Jul 2018 13:49:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:42c1:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 13:49:40
 -0700 (PDT)
In-Reply-To: <20180718191851.31984-1-chenbo@pdx.edu>
References: <20180718191851.31984-1-chenbo@pdx.edu>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Wed, 18 Jul 2018 13:49:40 -0700
Message-ID: <CAKgT0UceBCgtae2NMpu236fYvJOU+0uzQDk5c6rgRXqB+7CcMQ@mail.gmail.com>
Subject: Re: [PATCH] e1000: ethtool: check on netif_running() before calling e1000_up()
To:     Bo Chen <chenbo@pdx.edu>
Cc:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        David Miller <davem@davemloft.net>,
        Netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, phenix1108@gmail.com,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 12:18 PM, Bo Chen <chenbo@pdx.edu> wrote:
> When the device is not up, the call to 'e1000_up()' from the error handling path
> of 'e1000_set_ringparam()' causes a kernel oops with a null-pointer
> dereference. The null-pointer dereference is triggered in function
> 'e1000_alloc_rx_buffers()' at line 'buffer_info = &rx_ring->buffer_info[i]'.
>
> This bug was reported by COD, a tool for testing kernel module binaries I am
> building. This bug was also detected by KFI from Dr. Kai Cong.
>
> This patch fixes the bug by checking on 'netif_running()' before calling
> 'e1000_up()' in 'e1000_set_ringparam()'.
>
> Signed-off-by: Bo Chen <chenbo@pdx.edu>

The change below looks good to me.

Acked-by: Alexander Duyck <alexander.h.duyck@intel.com>

> ---
>  drivers/net/ethernet/intel/e1000/e1000_ethtool.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
> index bdb3f8e65ed4..c1e4e94f100f 100644
> --- a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
> +++ b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
> @@ -644,7 +644,8 @@ static int e1000_set_ringparam(struct net_device *netdev,
>  err_alloc_rx:
>         kfree(txdr);
>  err_alloc_tx:
> -       e1000_up(adapter);
> +       if (netif_running(adapter->netdev))
> +               e1000_up(adapter);
>  err_setup:
>         clear_bit(__E1000_RESETTING, &adapter->flags);
>         return err;
> --
> 2.17.0
>
