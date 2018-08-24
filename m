Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D73C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 03:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75FB32156E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 03:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aUIWagNr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75FB32156E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbeHXGgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 02:36:01 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:33288 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbeHXGgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 02:36:01 -0400
Received: by mail-yw1-f67.google.com with SMTP id x67-v6so2611594ywg.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 20:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=j4KNIe9M4E5woRjNSx61c15zkstqheu33XjZ8tuJ0pc=;
        b=aUIWagNrfZHiX9hfWjZj0SQcuydCoDyXLdGxDyqG8496k/5/daJ5OqASML45UbvjNH
         UgGruiyJllkUX4eQQ/szX2/ojllUGevEixJzGUisMpr1dzkjV1EtdaFLsy1le2c136Ax
         W1mQnrGSIO1n4NUua2TVXM0JSheu4J/GytOn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=j4KNIe9M4E5woRjNSx61c15zkstqheu33XjZ8tuJ0pc=;
        b=rkPgpni2t+4V6k4xB0rwKzgytcXtq3mxjv+H7ikcTQT23ZtxzqbkyhMkFxB9Vvq/t5
         ZZDNDijQ2LsYm379ucFgi5cXGD/d1shaJQrD4hMYMy72IaJ5iT/ysXS42fsOWuyF2XM5
         gq+nNBEcSCYVX6wQ51o0XAT6KlBEo2ATY50anZMQlu3v8SFtBTtLmOdbHNJpT7SIJRb4
         jCtXJNo6/iPpvd3iNhJ+qooAnRAbQKpsXwINXWW8ExiklQRcxZ4gqo5QSXRYINPRVNiz
         frdExSWfkVIDfePsk7msE+nTOStl0GW4GZV+86NiLKPyXMSKa4hBL7x8vVpx1YXhuk/O
         iyPw==
X-Gm-Message-State: APzg51BQuoSkjcG9NXhhVx2r3RHYJzn0yriVqbqgQ8t1EpSReLB6EcQa
        KilMY6Jtrmq7gTfhq+xMmBIijvPTZvg=
X-Google-Smtp-Source: ANB0VdaT5rwjljA7KCIoJnDAhaYJEHddkt9gia/LNaJNgDiqLTja3nU3BSfODP4rRP5bK2EMIG5tAg==
X-Received: by 2002:a81:2244:: with SMTP id i65-v6mr2388601ywi.253.1535079805009;
        Thu, 23 Aug 2018 20:03:25 -0700 (PDT)
Received: from mail-yw1-f51.google.com (mail-yw1-f51.google.com. [209.85.161.51])
        by smtp.gmail.com with ESMTPSA id m82-v6sm2510756ywc.29.2018.08.23.20.03.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 20:03:23 -0700 (PDT)
Received: by mail-yw1-f51.google.com with SMTP id l189-v6so2595439ywb.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 20:03:23 -0700 (PDT)
X-Received: by 2002:a81:9b85:: with SMTP id s127-v6mr4431334ywg.47.1535079803053;
 Thu, 23 Aug 2018 20:03:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:2c11:0:0:0:0:0 with HTTP; Thu, 23 Aug 2018 20:03:22
 -0700 (PDT)
In-Reply-To: <20180824011540.GA25716@embeddedor.com>
References: <20180824011540.GA25716@embeddedor.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 23 Aug 2018 20:03:22 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJxbFzKsV1=xHiKtcx+61QBsK0LYMrwo1vGNWgALzqakw@mail.gmail.com>
Message-ID: <CAGXu5jJxbFzKsV1=xHiKtcx+61QBsK0LYMrwo1vGNWgALzqakw@mail.gmail.com>
Subject: Re: [PATCH] iwlwifi: d3: use struct_size() in kzalloc()
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 6:15 PM, Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
>
> struct foo {
>         int stuff;
>         void *entry[];
> };
>
> instance = kzalloc(sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);
>
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
>
> instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);
>
> This issue was detected with the help of Coccinelle.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
> index 79bdae9..6960318 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
> @@ -1769,8 +1769,7 @@ static void iwl_mvm_query_netdetect_reasons(struct iwl_mvm *mvm,
>                 n_matches = 0;
>         }
>
> -       net_detect = kzalloc(sizeof(*net_detect) +
> -                            (n_matches * sizeof(net_detect->matches[0])),
> +       net_detect = kzalloc(struct_size(net_detect, matches, n_matches),
>                              GFP_KERNEL);
>         if (!net_detect || !n_matches)
>                 goto out_report_nd;
> @@ -1785,8 +1784,7 @@ static void iwl_mvm_query_netdetect_reasons(struct iwl_mvm *mvm,
>                 for (j = 0; j < SCAN_OFFLOAD_MATCHING_CHANNELS_LEN; j++)
>                         n_channels += hweight8(fw_match->matching_channels[j]);
>
> -               match = kzalloc(sizeof(*match) +
> -                               (n_channels * sizeof(*match->channels)),
> +               match = kzalloc(struct_size(match, channels, n_channels),
>                                 GFP_KERNEL);
>                 if (!match)
>                         goto out_report_nd;
> --
> 2.7.4
>



-- 
Kees Cook
Pixel Security
