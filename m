Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70459C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1112920833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MDVBxuLB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1112920833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbeIJUpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 16:45:46 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36452 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728101AbeIJUpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 16:45:45 -0400
Received: by mail-wm0-f66.google.com with SMTP id j192-v6so22073732wmj.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 08:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=sToDIZEi4y73bDKcC5FhQXsb2MpVarT6eIelGgWWvpg=;
        b=MDVBxuLBcASzr83pYD/fpdUjo0GEeY0KBaYIQQNio6WL65TBemqjz3KsNl0qgFps9L
         NOBbTFdfzRXQKDJWQE0fbccUhZR8cTRAk59wnjXtoNEUzd0zwa583njLd5HeHuC58lXw
         XqsGJfH5dGxMXwmkHcivcBq04XCSo7X8IY4FY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=sToDIZEi4y73bDKcC5FhQXsb2MpVarT6eIelGgWWvpg=;
        b=heljJLmbmZfxPXoQJ1UhUjEBt9tTJ4Y7jfF1Nx0c78bl1z+qJCZ7Naea11m95OfLKI
         vGwcxcaXCQVxrCDQ4ltKRbYodiUxICN9SZ0OihpUmDstDgqdvUk2J5Fzvz71i/aa0o0b
         i3oalJpf/e4BhJs/DfdRVICcO/sNEx9/cQcUvR/2RRsgpKoldlgAhNdWlZ6wlTaLnvOo
         WCeWlR+bUDMH8ThwcPm9uUE+ipvKbXoM2g5tE38wlJYpeFrZab/+PHUeW/cHZ31lHMFH
         zhnXpjpjaI1uRBq8X9wdwvZLg3IqpNdKD+prHhRSRF+tKm0kS62gs118dhVTiDEnmQfM
         HNvg==
X-Gm-Message-State: APzg51Duq/OSRs/nH4aQDEDxiDqOrLyYKrQ3ZWixnfvC9bKjAq85Wn9R
        0ib1oS2zHjPHCqyPUdmsAAqLMayLUjpL2w==
X-Google-Smtp-Source: ANB0VdaGyBcozefqsJBnlW0XRsqtdKUuaE2EuTYdBSPWBUcMAR91CivFq9AH6xeU3OuWdEjj4Sd5PQ==
X-Received: by 2002:a1c:87c9:: with SMTP id j192-v6mr1134900wmd.71.1536594662063;
        Mon, 10 Sep 2018 08:51:02 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id v21-v6sm13827625wrd.4.2018.09.10.08.51.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 08:51:01 -0700 (PDT)
Date:   Mon, 10 Sep 2018 16:50:59 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1 1/7] mfd: intel_msic: Use DEFINE_RES_IRQ() macro
Message-ID: <20180910155059.GG28860@dell>
References: <20180830165255.43114-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180830165255.43114-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2018, Andy Shevchenko wrote:

> Instead of open coding each data structure with IRQ resources,
> use dedicated macro.
> 
> In one case use DEFINE_RES_IRQ_NAMED() and DEFINE_RES_MEM_NAMED().
> 
> No functional change intended.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel_msic.c | 44 +++++++++-------------------------------
>  1 file changed, 10 insertions(+), 34 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
