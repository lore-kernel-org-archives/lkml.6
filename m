Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059E0C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 05:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB6FC2089B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 05:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z7v8OXrl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB6FC2089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751015AbeGJFYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 01:24:42 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38631 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750913AbeGJFYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 01:24:39 -0400
Received: by mail-wr1-f65.google.com with SMTP id m1-v6so405639wrg.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 22:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=1MeiGYxmIz+IkmutBMq62FwvrWPg0aSu9Ral76dvaJM=;
        b=Z7v8OXrl3Zkmz660bLlCcUUdoTeFbih5TorkqkykQHjaX9gqCst8Lu40499iun4Ai1
         bhi9gtykaduRTcqF+6kFx/pXsg5IaUkDZnALaOZfE8XVoBH8R7tY2J8BBocyJM5FPUD3
         EhSd3ibOVAxQbzpSLx9KrR9CxQtQ07msviSWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1MeiGYxmIz+IkmutBMq62FwvrWPg0aSu9Ral76dvaJM=;
        b=TjTVo5lVDUuFjXZWj+6AvdcgQLiCBpXjl8Hvg531gHxMkaFiaSFQKhw0d8QjLywQ/j
         ihM5CGw6URIhvi3AXme6tSFeQrIeJJMAukSOLdlggGAeUfw1vg2ombDCjVXkpNpll1XB
         MEAYgHvnKwjTszlXepSVUqgsteZM56qCPkA7lYCJo5qAterR6u+tfqjOUsuS/VEOOal4
         Wg+VxYNIcI6HHp8Ag3ei/MbDu9a1N1qcghJ0mpSkd6L053VW1WNRYYr8jEzUmhPJlN2o
         n2uS13fcynTsQKa3F9iuiMc2iCUX/eHMoSOBQhQEPX7CpFpeYrQl+iQuluOXJbnHHl04
         Xmeg==
X-Gm-Message-State: AOUpUlFsnUpbvX0qevTaXk3p3B7q4uEjlH4PFsanN+TFG8WxhxfFd/Gr
        U12M8DuuZdmW7JnBJ+JA7iSTOolo3To=
X-Google-Smtp-Source: AAOMgpfUJAHZ/MCS8j7ypQ1WkOfzt2KUuv2HXyINOqzv9AsPRvTTlaes5CUdruOuuuCwD71CAooDMg==
X-Received: by 2002:adf:98d2:: with SMTP id w76-v6mr5389310wrb.124.1531200278563;
        Mon, 09 Jul 2018 22:24:38 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id s13-v6sm17362381wra.22.2018.07.09.22.24.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 22:24:37 -0700 (PDT)
Date:   Tue, 10 Jul 2018 06:24:36 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Michael Hennerich <michael.hennerich@analog.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: adp8860: Mark expected switch fall-through
Message-ID: <20180710052436.GB4641@dell>
References: <20180709215156.GA8782@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180709215156.GA8782@embeddedor.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Jul 2018, Gustavo A. R. Silva wrote:

> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/video/backlight/adp8860_bl.c | 1 +
>  1 file changed, 1 insertion(+)

Looks good to me, but Dan should still review.

  https://gcc.gnu.org/onlinedocs/gcc-8.1.0/gcc.pdf#page=86

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
