Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE6EC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BA8821A58
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QUFamuWv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BA8821A58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932917AbeGDHea (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 03:34:30 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52605 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932207AbeGDHe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 03:34:28 -0400
Received: by mail-wm0-f67.google.com with SMTP id w16-v6so4666404wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 00:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ViLV4Qpth14ZjD0E21qulEc02BAxBVuGRQNbPLHReOc=;
        b=QUFamuWvj37EzAIVaZvSOSrjNetJ0bAfTOwSqpvt1Tc/y5SJW+bVTb9mFkktXQpiXD
         6D2pm8+qmm90m54Oq6IPrI4ciSlJtrP/tAHf5WUvVLMfyX4BYpKxB/o2uEIwIiq6Mgy1
         uCDB7YJMtVW8pQVa50mjtLt5P7IaIWn4jRAGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ViLV4Qpth14ZjD0E21qulEc02BAxBVuGRQNbPLHReOc=;
        b=PmlqA1q5JLI5OM30N1E30JNtgGbtKGnhpFNZLPwmhrbFy1HrDeXESV1ed0gDpSYs+6
         dmcg9+ZihwvnUklRN0ad/qz1eawci/bVqdyABsQqJ72+P8sYXYrysxNqS8CZqhXhq0YJ
         qK+ncPAze3FsobP7xeHbpiFp+Yb1MI3ihbKq/JrBsKs/QETSSo7G73tK0yNwqVG19JyX
         y9FYUotZ0B9Lrq+07PksvmOrnVhi304QxBB5tu3GY34MK2u1wWjjCbZ82aAUFR9D6gFw
         YUmROmm+JpWGtMNP35YbwnlZWYs9PNIWjgcewZtMw6yh7Pmqn8TMDz1m8z7IxVomDVKm
         hehQ==
X-Gm-Message-State: APt69E3OA35CkCzUxUWbcwns4yMiBGKybyIElKLgd+h54UrYElT5MwCe
        wRPlWmGRUfQAUalZK+LUWMZCXAjoFNc=
X-Google-Smtp-Source: AAOMgpdhk4dXu7tZhHRXaDJwuiBTvcqmvjsTOrcoUrER4Q+xft+2hpz2cZYBGGwIP5DRSyE4z5T/dw==
X-Received: by 2002:a1c:497:: with SMTP id 145-v6mr820054wme.157.1530689667169;
        Wed, 04 Jul 2018 00:34:27 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id m145-v6sm5415284wma.19.2018.07.04.00.34.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 00:34:26 -0700 (PDT)
Date:   Wed, 4 Jul 2018 08:34:24 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1] mfd: intel-lpss: Add Ice Lake PCI IDs
Message-ID: <20180704073424.GJ20176@dell>
References: <20180627204808.38096-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180627204808.38096-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jun 2018, Andy Shevchenko wrote:

> From: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Intel Ice Lake has the same LPSS than Intel Cannon Lake. Add the new IDs
> to the list of supported devices.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel-lpss-pci.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
