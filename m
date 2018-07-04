Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDDEC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B514A245E7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Azcm+QV4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B514A245E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933440AbeGDHk3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 03:40:29 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43080 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932319AbeGDHk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 03:40:26 -0400
Received: by mail-wr0-f195.google.com with SMTP id f18-v6so4245142wre.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 00:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=fVrViC/j9QGa8LSMDZ4Ml14wm3LsDq1fdIK75NslJWA=;
        b=Azcm+QV471imZniOZfUcKI8XPlHxPgt/+ScJqzG+vTyJcv6vrcVqrFbM82FYoLSyx1
         mraWs8dwHu58ENoX4bCw+zzHLKLfmyUODXzCocnY7AJmL6xxi+/9gs6mDj2eG0kkaSPI
         FQEoQt3NxQsrWP+0wlfb7ccw+FjJUWVsj+mE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=fVrViC/j9QGa8LSMDZ4Ml14wm3LsDq1fdIK75NslJWA=;
        b=RQ7JB48hdQOLXCpX3UXgrkHStb9diLuCbyEZsymRTeN3+vmbd0lezrvau2vhYuTPxN
         kiKlzMPtQvIlocEiTMq1qXooOaN+czgrPCQlW5Ho8cOWIUfUZixdCvI0qZIQ1GrVQo7k
         lNffmlWlr/q9CBVTHYYQfsELoR+tS05tLyDk0gYba6ym4N9CoD6lSKbaS9At76ZBG29F
         bUKHIE6JP9u9ex5GbuJVmmAkqBoNdqDYtnFUJBwgiV3ZkBBJ+6H1ODT/mywA4z7cxf0a
         RFjsNVkm/ubZnCjNsmjvsv4Vh/peMWupCZDu9id2Lmd7KWeo/wZUw5WOibgVqiCuvGim
         YiLQ==
X-Gm-Message-State: APt69E0g/eoCt91SWjHieeB245aATx18WSc+oRJV0OAK5mKO5T26ZjYp
        +5FmCV2BFcAAWWSVNNRSFG6E9g==
X-Google-Smtp-Source: AAOMgpdb/ZltaaWzua3uM7oBEpjx6ZjxczG59Xk0NKrXFpywQ6dAE7hr5jc6/eD5BUN9jL5i0u3aOQ==
X-Received: by 2002:adf:9d1c:: with SMTP id k28-v6mr740976wre.29.1530690025603;
        Wed, 04 Jul 2018 00:40:25 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id o3-v6sm936566wrs.31.2018.07.04.00.40.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 00:40:24 -0700 (PDT)
Date:   Wed, 4 Jul 2018 08:40:23 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Johan Hovold <johan@kernel.org>, Octavian Purdila <tavi@cs.pub.ro>,
        lkml <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org,
        tglx@linutronix.de
Subject: Re: [PATCH v2] mfd: dln2: use irqsave() in USB's complete callback
Message-ID: <20180704074023.GN20176@dell>
References: <20180701154108.13233-1-bigeasy@linutronix.de>
 <CAMoF9u0ZxNqKLV6FEjpHkGGuh8_V7zFQ_VpK-Y-fmbkSwL31Rg@mail.gmail.com>
 <20180702062442.GD9802@localhost>
 <20180702073132.vrbvrdrht3ipwhq7@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180702073132.vrbvrdrht3ipwhq7@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Jul 2018, Sebastian Andrzej Siewior wrote:

> The USB completion callback does not disable interrupts while acquiring
> the lock. We want to remove the local_irq_disable() invocation from
> __usb_hcd_giveback_urb() and therefore it is required for the callback
> handler to disable the interrupts while acquiring the lock.
> The callback may be invoked either in IRQ or BH context depending on the
> USB host controller.
> Use the _irqsave() variant of the locking primitives.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Octavian Purdila <tavi@cs.pub.ro>
> Reviewed-by: Johan Hovold <johan@kernel.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> v1…v2: Remove also the comment that says that there is no need to
>        disable interrupts.
> 
>  drivers/mfd/dln2.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
