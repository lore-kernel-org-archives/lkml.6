Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5031DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19B25223CB
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="QeJKHaxk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19B25223CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387890AbeKOTtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 14:49:50 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45545 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728757AbeKOTtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 14:49:50 -0500
Received: by mail-wr1-f65.google.com with SMTP id k15-v6so20391179wre.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 01:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=POhP/2g1i9rdpO17mce+yjFjane/wH9yZG5D1QvoQzs=;
        b=QeJKHaxkDM2j9UvyVuxtcoN3+zMzUmmCtzjhgPB8m1bpCo2gUWYaf5z+9vHiPftvZH
         43Ga+6CcGS+vUSFpBpkwxU8IMh25sSZ6hsYN4UPtjAm52S5bWzQ4t/NBhuptlk96/Lyl
         XaCFYOfZADzYhE/VSBMoVEMaj6A7SBSVzMfh/iqxcqKUsRlJUsmFQTAXNbS/zXsdiS+B
         NfvSvbs+qFebSbkIvq/hnSo7gT4Yg1k7tKum/3qcTGYtzKk/mMJjvWuJb5PcPlj/60N8
         x9uMwYfTRwztGpBEtrb/qlrV+qXaka+8MjJQgBph+HdQyyVWvP2OT4ggoMSJCoektRGg
         Aljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=POhP/2g1i9rdpO17mce+yjFjane/wH9yZG5D1QvoQzs=;
        b=e3N7/m3JSJxMXqgYdTg6M/hqOGzZLFz2vVtYcbuKHF4f5r9wh+R2rURuv1CEeLNpHu
         FsRFGaE3BmA/huqgvzT7CRzkIhlmi1Tdt8DVLKLoLeYXEcuH94HE+DuxMzpwXZxL5AuM
         /FeBL+1zLBMP2M/AMl2+lJH1qVWTWiPIrizGTPX2cgBTnttHzBnmocTGU0qOtYOks808
         B+zkSqyBP893pbBn45LlMmYp+f32ZimP/NrefJ+56q9TMnrepdKBdng8S1sXVeb/o12j
         /LUHDV5u+Trqwtxvz0izAaZTWkNXvYoRKLJJh/k2Aj6fq0AzSJ1IqQRKyRPJeq9Aow5G
         tOlw==
X-Gm-Message-State: AGRZ1gL+WWOGqA25oXoDCwAfUhYkiDjv3MQkazTluEJNjV88aNaDtaMS
        g5k22zmk14b9a7pkdRP3/yaZng==
X-Google-Smtp-Source: AJdET5c7EgXrYZ39Vt/lhl8cQCmRxXueE29oZE+zDr9GEFbbmAXBvgHEgY1Su8q9qnW+bVa6+V/M/w==
X-Received: by 2002:a05:6000:11cb:: with SMTP id i11mr5040888wrx.234.1542274964761;
        Thu, 15 Nov 2018 01:42:44 -0800 (PST)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.gmail.com with ESMTPSA id m13-v6sm28745104wrw.14.2018.11.15.01.42.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 01:42:44 -0800 (PST)
Message-ID: <3f1c522adc74bbc9debd9830a694038c437f54bd.camel@baylibre.com>
Subject: Re: [RFC v1 2/7] clk: meson: meson8b: do not use cpu_div3 for
 cpu_scale_out_sel
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        narmstrong@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org
Date:   Thu, 15 Nov 2018 10:42:42 +0100
In-Reply-To: <20181114225725.2821-3-martin.blumenstingl@googlemail.com>
References: <20181114225725.2821-1-martin.blumenstingl@googlemail.com>
         <20181114225725.2821-3-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-11-14 at 23:57 +0100, Martin Blumenstingl wrote:
> The cpu_div3 clock (cpu_in divided by 3) generates a signal with a duty
> cycle of 33%. The CPU clock however requires a clock signal with a duty
> cycle of 50% to run stable.
> cpu_div3 was observed to be problematic when cycling through all
> available CPU frequencies (with additional patches on top of this one)
> while running "stress --cpu 4" in the background. This caused sporadic
> hangs where the whole system would fully lock up.
> 
> Amlogic's 3.10 kernel code also does not use the cpu_div3 clock either
> when changing the CPU clock.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/clk/meson/meson8b.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
> index 40e77fe4ba7c..8a3c346e110d 100644
> --- a/drivers/clk/meson/meson8b.c
> +++ b/drivers/clk/meson/meson8b.c
> @@ -608,20 +608,27 @@ static struct clk_regmap meson8b_cpu_scale_div = {
>  	},
>  };
>  
> +static u32 mux_table_cpu_scale_out_sel[] = { 0, 1, 3 };
>  static struct clk_regmap meson8b_cpu_scale_out_sel = {
>  	.data = &(struct clk_regmap_mux_data){
>  		.offset = HHI_SYS_CPU_CLK_CNTL0,
>  		.mask = 0x3,
>  		.shift = 2,
> +		.table = mux_table_cpu_scale_out_sel,
>  	},
>  	.hw.init = &(struct clk_init_data){
>  		.name = "cpu_scale_out_sel",
>  		.ops = &clk_regmap_mux_ro_ops,
> +		/*
> +		 * NOTE: We are skipping the parent with value 0x2 (which is
> +		 * "cpu_div3") because it results in a duty cycle of 33% which
> +		 * makes the system unstable and can result in a lockup of the
> +		 * whole system.
> +		 */
>  		.parent_names = (const char *[]) { "cpu_in_sel",
>  						   "cpu_div2",
> -						   "cpu_div3",
>  						   "cpu_scale_div" },
> -		.num_parents = 4,
> +		.num_parents = 3,
>  		.flags = CLK_SET_RATE_PARENT,
>  	},
>  };

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>

