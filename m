Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF8BC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28ED220870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dZ8DPxTZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28ED220870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbeIJUSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 16:18:45 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37062 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727714AbeIJUSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 16:18:45 -0400
Received: by mail-wm0-f67.google.com with SMTP id n11-v6so21834658wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 08:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=1T3xH74dTf2Yz0XyXYvehUgJoPV4FvQl0x7/oTjgh3U=;
        b=dZ8DPxTZupDL6gKpT9n+ZqSXqMYKKp3eIvQlmTFRxPlc86Ce4EM/jEBnlPjhZ9Ahuc
         RkttqqGOIp4eEa0KGqxQeWnHPguQuNrmPq6Rylq9H16evFTdAqQ4G8aZOnd8eYveJ0uP
         W4fNdRIpqHaH3DXh4Ygq8osMGFSAo0c6dmBVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1T3xH74dTf2Yz0XyXYvehUgJoPV4FvQl0x7/oTjgh3U=;
        b=rVPiDzzA2NHBr57c/9+QsCk9tt0nP/vjSSs163Y5r9lDX2uvqk1V1ODIYlW/oujeul
         Z1F/Amw5rcWVv9bnGON4odH7YZ1QwYRZBkJMVnGS5II/4tzIbBzlM8i7eMpm0UQaXZT5
         MXZnLVL7KovDjcaRRWmg1luhRESidzRHGeyZAQvf1O57wAg+TLrkfingu8jTwFT3Bg0u
         FCDaEYz8bDJP3OuZkmJz04ud/YOYRqSBp8zMWsV+MSrA2fNHwkBB1tlQgc5s6Hg2nZM0
         80zQMEgqYQzS9xgpJcNNfaHjXUXjXILkNlnBh6m7PWq0tzaR1mZbfQVYIZY7Wdan1pKU
         uD7w==
X-Gm-Message-State: APzg51DmcUA0OEKEW2lBvHo6S07a0rLzn7Vs8FDudv9eshM686DkXhc3
        1noBGgVb0s+gtyIxXQAfuhChFg==
X-Google-Smtp-Source: ANB0VdajwteVushtb9zV6A9xUMiNsP/z8IyqJ+PkNZhdyMUSQwyiXlrWwA6EtMkv1AqIfBtWV1pdGw==
X-Received: by 2002:a1c:e581:: with SMTP id c123-v6mr1039365wmh.85.1536593048145;
        Mon, 10 Sep 2018 08:24:08 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id f6-v6sm18160368wrr.68.2018.09.10.08.24.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 08:24:07 -0700 (PDT)
Date:   Mon, 10 Sep 2018 16:24:05 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: max77620: Convert to using %pOFn instead of
 device_node.name
Message-ID: <20180910152405.GZ28860@dell>
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-30-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180828015252.28511-30-robh@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Aug 2018, Rob Herring wrote:

> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/mfd/max77620.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
