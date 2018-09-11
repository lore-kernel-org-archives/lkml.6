Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40FAC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D93220866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QH9K91sP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D93220866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbeIKUf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 16:35:29 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40956 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbeIKUf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 16:35:29 -0400
Received: by mail-wm0-f65.google.com with SMTP id 207-v6so1462135wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 08:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=5Yk3cBv/ob0kToL3wqBpgmLr89es/ll+9P1Ybb3UgRw=;
        b=QH9K91sPKOSXQsRqeTYHCSMP85haWroy9UM5AhZgV2T8zd8MZe2WkDwHKwo3tYtXM0
         gSltAwV7woW15PDfGBOjHq9W8Oxy/4CwTeGtEzastQwAG9pYfwvMRo0BBI1K99lOFQAG
         DdMmHuhBb+J+q7CFpGTsvJlxlzEEx5WMQf+Ag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5Yk3cBv/ob0kToL3wqBpgmLr89es/ll+9P1Ybb3UgRw=;
        b=UhkoFrkgXrCyol61d2cE+7r6j9YxH9u43pDtyRovglScW08aFMy5ur6CNaZn5M4qCm
         6Zh0N6/fNsVizgqKMYaOm/HR5HDHTpGBaTNgHyH/Cgrpgsan3P0QcSwM25RxLpxcjc4j
         FMPKaRN2e6fZ4Gtyui/udJi2llFyC623ScDdLR4RpDA1ywnjD/HCQwcimWkApJpHUU+V
         p0D/ddl5Wc8kKBvINRahJve1tHv6+ZlGvxsiJU2BwJZlOYNDPSanW2KhApaqHc/iX5p1
         u/C/ofRZbDvB5aTnZSCYq6If8SfawB/ehYtb/8CNmm9y5tkupW3pt2U0zV4hifGjqdsb
         kVjQ==
X-Gm-Message-State: APzg51C920JJPZ2jPRoYmkD+X1eIi5Ssnrj/6lhlL4oadcrho+CYRLy6
        8JOlLMkjHIl7bxLrQuGg2sPUpw==
X-Google-Smtp-Source: ANB0VdZiU2Of2eBx8GppmcH8IpOySUk9JaF6JLiqw/V4cg7DvJZUQSPb8pg3i3qi+8ZHB/R2r6XO5A==
X-Received: by 2002:a1c:ca17:: with SMTP id a23-v6mr1768410wmg.122.1536680138070;
        Tue, 11 Sep 2018 08:35:38 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id g126-v6sm1886833wmg.5.2018.09.11.08.35.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 08:35:37 -0700 (PDT)
Date:   Tue, 11 Sep 2018 16:35:35 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     robh+dt@kernel.org, broonie@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, bgoswami@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH v3 03/13] mfd: wcd9335: add wcd irq support
Message-ID: <20180911153535.GZ4185@dell>
References: <20180904102500.30318-1-srinivas.kandagatla@linaro.org>
 <20180904102500.30318-4-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180904102500.30318-4-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Sep 2018, Srinivas Kandagatla wrote:

> WCD9335 supports two lines of irqs INTR1 and INTR2. Multiple interrupts
> are muxed via these lines. INTR1 consists of all possible interrupt
> sources like: Ear OCP, HPH OCP, MBHC, MAD, VBAT, and SVA. INTR2 is a
> subset of first interrupt sources like MAD, VBAT, and SVA
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-by: Vinod Koul <vkoul@kernel.org>
> ---
>  drivers/mfd/wcd9335-core.c          | 78 +++++++++++++++++++++++++++++
>  include/linux/mfd/wcd9335/wcd9335.h | 33 ++++++++++++
>  2 files changed, 111 insertions(+)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
