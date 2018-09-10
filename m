Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA0DC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D62420833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bXa9lSFj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D62420833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbeIJUql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 16:46:41 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35442 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728686AbeIJUql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 16:46:41 -0400
Received: by mail-wr1-f67.google.com with SMTP id j26-v6so22525066wre.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 08:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=nRpOwDiT/WO6FC7Kwvmkv5UhBb5ZeODHLzG7+gkm4B4=;
        b=bXa9lSFjbtf+XFOASHW8qT0kmMrTxSi+/VQuJWQ4IAvNw1emwjoDdnzganESBdQIfK
         MS8Q9a0p6VrfobOhNZzH+1mfoc02O/HyHQMe0GKMX9E/MnHgFArMGLPuiRX2i0YpeJYb
         lWYvXGgrlCPVkmIjgJqyLedLnAGJaN8SoH3cE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=nRpOwDiT/WO6FC7Kwvmkv5UhBb5ZeODHLzG7+gkm4B4=;
        b=EHrwb8Voht39UoqM3RWZIG8VZqKObMjjGLikMgqF3DBIsauQD/qeatn4T9ZBcolk/I
         14NMVtRaYAqj8BA++1djn/g0BejrN+6KvPQzxmiW5Wr8BHJ048siY2Y6bc0ypVzYmD3A
         +F6N2EV+aMlR2ciE7407a/jSMC4dFkNhZvz1L0y26sKfzpfuU7bUfh8zwEG6rfL86QDS
         s1c4wA72dfrfaAbY+Q6uGl4chLUCCvPlzAzQdCcNL1wJy9lXohGoxoWFrsbfXfdIRgFV
         u4+FlVPN5SP4lBjLK6P7NIi7bORkJfV4vo+HdHO4ov1Ru7POZxvo3A4CPjheDGVTamp5
         6L3g==
X-Gm-Message-State: APzg51AAeTlV+AuMVB4gVPgKm+e5geyvBXnV95umDLtNvNQbh6sWpoPT
        sJxrqc1kGI2qVWp+V+L8ruKFbA==
X-Google-Smtp-Source: ANB0VdZfFXL+PWD9SYpP1JrhJfLAAvD6SpEGEnbwWa+/DAA7xt9xfHUJO5tGCcYi6aAdq2DJsPQxcQ==
X-Received: by 2002:a5d:608b:: with SMTP id w11-v6mr16362509wrt.193.1536594717750;
        Mon, 10 Sep 2018 08:51:57 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id f6-v6sm18247094wrr.68.2018.09.10.08.51.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 08:51:56 -0700 (PDT)
Date:   Mon, 10 Sep 2018 16:51:55 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1 6/7] mfd: Convert Intel PMIC drivers to use SPDX
 identifier
Message-ID: <20180910155155.GL28860@dell>
References: <20180830165255.43114-1-andriy.shevchenko@linux.intel.com>
 <20180830165255.43114-6-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180830165255.43114-6-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2018, Andy Shevchenko wrote:

> Reduce size of duplicated comments by switching to use SPDX identifier.
> 
> No functional change.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel_msic.c                 |  5 +----
>  drivers/mfd/intel_soc_pmic_bxtwc.c       | 10 +---------
>  drivers/mfd/intel_soc_pmic_chtdc_ti.c    |  5 +----
>  drivers/mfd/intel_soc_pmic_chtwc.c       |  5 +----
>  drivers/mfd/intel_soc_pmic_core.c        | 12 ++----------
>  drivers/mfd/intel_soc_pmic_core.h        | 12 ++----------
>  drivers/mfd/intel_soc_pmic_crc.c         | 12 ++----------
>  include/linux/mfd/intel_msic.h           |  7 ++-----
>  include/linux/mfd/intel_soc_pmic.h       | 12 ++----------
>  include/linux/mfd/intel_soc_pmic_bxtwc.h | 10 +---------
>  10 files changed, 15 insertions(+), 75 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
