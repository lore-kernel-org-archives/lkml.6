Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8494AC43610
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49C8920825
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Hvc9TnhK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49C8920825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387915AbeKOTx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 14:53:57 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37143 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728634AbeKOTx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 14:53:56 -0500
Received: by mail-wm1-f66.google.com with SMTP id p2-v6so17237054wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 01:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Sa3kl/RsjKWO+z6SiPlqidK82hY1mr0ur092VFUOkug=;
        b=Hvc9TnhKlehbUHjKPaiBDz5attI7I+wYSLh51MLpJ+eNQOGP+XvngiocaMnKDtu+1f
         Bf3zLY+D025HUG61N+Kch7XAk57Reh1GvqeC/M9mD/ylAkgHC2v74GdevWIpoIjnZB4/
         LE2D5zyl6XVltLRNrcybf7WA+jnzzEHUZqoE4Ls1qYvst68jGjgCqFMQGXd99Lvz5EYK
         E9FYlqtkEk7C4P0xgVLfGiwKS9HrIJlMHrOUwzOZeoZZDr1gBvmIn+w0fvv43T0BI3zW
         tNRNy5i8Goc8R23dqT2yhXCJaUukUhJsl8J52WYTXcGgBwYUQ+e8JXxE3Edpe58KeN+g
         sx7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Sa3kl/RsjKWO+z6SiPlqidK82hY1mr0ur092VFUOkug=;
        b=bFZnrpIIlUFxW0Yq5Es5XcmEOoKc4xPOQ1xEWiEizvpfDHYC24DvwhvhABqpGNZx7D
         457SrRtKrWRRiwC2hZVsyN/pO0PDsvCM9UZSlrVkVi1dDlAuPWYqm2uk5irmr1lHkAsD
         NfCc/WXYQvo8rNE/UZDmjpTtlIts41hsdF3TS8NUwM+qZEiuKMmuk5fJxRdMYqd719se
         NmySTGbhLseiZlw1T5LOOh8BXbwQuFnjC6gSSyVgnp0nF/sB36ttPNqJaVN7DjN3ZdDx
         Kfq6Kb5ktDBwsn+gCXrXFJwEaShzioLproxYu4r124N4Ht3yFirsRhk3v9WL71NAN3P6
         sutQ==
X-Gm-Message-State: AGRZ1gI8n5pB3hA+eviawaJf/NXb87xyT+XLvxl3AK6/CgNKC5ctYyUk
        uhsZf9gQJCPt0ZHnonEwWD4w4w==
X-Google-Smtp-Source: AJdET5ec4VYABAIx97zKtMEl91kHSFI522CxXZHs5m5Fzho1KOKbdonjkjwCFKFBhqoDTg90XkhVyQ==
X-Received: by 2002:a1c:c545:: with SMTP id v66mr4879066wmf.132.1542275209188;
        Thu, 15 Nov 2018 01:46:49 -0800 (PST)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.gmail.com with ESMTPSA id m7sm5251705wml.32.2018.11.15.01.46.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 01:46:48 -0800 (PST)
Message-ID: <533bd2bd4dced1610a803e7b2d51995e5577ba1d.camel@baylibre.com>
Subject: Re: [RFC v1 5/7] clk: meson: meson8b: mark the CPU clock as
 CLK_IS_CRITICAL
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        narmstrong@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org
Date:   Thu, 15 Nov 2018 10:46:46 +0100
In-Reply-To: <20181114225725.2821-6-martin.blumenstingl@googlemail.com>
References: <20181114225725.2821-1-martin.blumenstingl@googlemail.com>
         <20181114225725.2821-6-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-11-14 at 23:57 +0100, Martin Blumenstingl wrote:
> We don't want the common clock framework to disable the "cpu_clk" if
> it's not used by any device. The cpufreq-dt driver does not enable the
> CPU clocks. However, even if it would we would still want the CPU clock
> to be enabled at all times because the CPU clock is also required even
> if we disable CPU frequency scaling on a specific board.
> 
> The reason why we want the CPU clock to be enabled is a clock further up
> in the tree:
> Since commit 6f888e7bc7bd58 ("clk: meson: clk-pll: add enable bit") the
> sys_pll can be disabled. However, since the CPU clock is derived from
> sys_pll we don't want sys_pll to get disabled. The common clock
> framework takes care of that for us by enabling all parent clocks of our
> CPU clock when we mark the CPU clock with CLK_IS_CRITICAL.
> 
> Until now this is not a problem yet because all clocks in the CPU
> clock's tree (including sys_pll) are read-only. However, once we allow
> modifications to the clocks in that tree we will need this.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/clk/meson/meson8b.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
> index 8a3c346e110d..d566dd5bc567 100644
> --- a/drivers/clk/meson/meson8b.c
> +++ b/drivers/clk/meson/meson8b.c
> @@ -646,7 +646,8 @@ static struct clk_regmap meson8b_cpu_clk = {
>  						  "cpu_scale_out_sel" },
>  		.num_parents = 2,
>  		.flags = (CLK_SET_RATE_PARENT |
> -			  CLK_SET_RATE_NO_REPARENT),
> +			  CLK_SET_RATE_NO_REPARENT |
> +			  CLK_IS_CRITICAL),
>  	},
>  };
>  

Acked-by: Jerome Brunet <jbrunet@baylibre.com>

