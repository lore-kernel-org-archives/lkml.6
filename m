Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062DBC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2057204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jBzK/M/Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2057204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbeIJUqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 16:46:10 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38655 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728101AbeIJUqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 16:46:09 -0400
Received: by mail-wm0-f67.google.com with SMTP id t25-v6so21941898wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 08:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=box/eFIx3OHWULUQYhuMFmUTDQAw3Q+uP8OwMJizTfs=;
        b=jBzK/M/Ykkuboq52cBLrdZj8FO2pKt7xfeaplygt1fZa9M2jArhqvZ5JP0TX3TmqUP
         6f7XgDSJWpzLdLE7UVJxNC0bDUeyQnaQZsKNb90gZFpyUoQLSg0NwpBebJNRxpCXYlDv
         OLyJS5kEJMmPF1MF2cFoS15HVTIdWBvFF0TI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=box/eFIx3OHWULUQYhuMFmUTDQAw3Q+uP8OwMJizTfs=;
        b=N39c3U+vmcLzofqBWSM6tPk2tEAKQsZx0Zot1u9zxiIENnWUas1kepVljdAHHzGe3O
         Z5cIe6N+Re6L/TWa/HpZ8qIIbGGH3Gv1v9XYTpr6GzwS1dYCfrySSPZYLGpMZ6pEtxvw
         HNZpO4n7WhUp2pBFT2jT3H8Vh1NQLNwmx+qAOi1rXqWNSEO9OubLuklCmnRxeL/fcivG
         p/sAQLHQjjGwaKJH14/9PS1XUuQQNbFYj9YFxOn/D0EmZTVjxVspQl53GJYPgqIn/rW+
         KVkxjJZPt8C9WNARQf1hYzL1bMMZe2qkYvTWpOxp7DaD+bU3AfO92Hd4CRGNdU8zGFuj
         +5Ag==
X-Gm-Message-State: APzg51Anv+GGeF9dFdrylbxbo74056DDX0qPRNaV5E5QtFuDoOsVPK+T
        cTzxV7tiIG2uDYYqOgxAQuWAkw==
X-Google-Smtp-Source: ANB0VdZcQBM53miGCjuYeVEgscr3L1+S9WHT1KbTGquw15hQV2iRtd8oHn+ixSPzX3QeIp87lYnJyQ==
X-Received: by 2002:a1c:1a49:: with SMTP id a70-v6mr1117726wma.91.1536594686160;
        Mon, 10 Sep 2018 08:51:26 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id j2-v6sm27615073wmj.5.2018.09.10.08.51.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 08:51:25 -0700 (PDT)
Date:   Mon, 10 Sep 2018 16:51:23 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1 3/7] mfd: intel_soc_pmic_crc: Use REGMAP_IRQ_REG()
 macro
Message-ID: <20180910155123.GI28860@dell>
References: <20180830165255.43114-1-andriy.shevchenko@linux.intel.com>
 <20180830165255.43114-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180830165255.43114-3-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2018, Andy Shevchenko wrote:

> Instead of open coding each data structure with regmap IRQresources,
> use dedicated macro.
> 
> No functional change intended.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel_soc_pmic_crc.c | 28 +++++++---------------------
>  1 file changed, 7 insertions(+), 21 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
