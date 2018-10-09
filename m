Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626ACC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 173BC21479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BPi5RVa2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 173BC21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbeJIRq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 13:46:27 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45789 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbeJIRq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 13:46:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id q5-v6so1205642wrw.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 03:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=YIu3TxjrBNefNpOzGKA5UeZd9KuQzm7VKX0rY/gxv9s=;
        b=BPi5RVa2XNhrCjpl5GPSnfDlEfiHXaqz5PmiDXWJZUjs9K3F6iZ9LhAmPEVXEqsiHc
         /aS07er0Mqbci1JC9Rf9pJ9r+cP/m2NbCjJ8iyQ0wvYiw/GBd1CfT8lF44CwkUX6fqY7
         ht2P2jPU5Mi/CDCnsO6gVPTGhH5GVU+gmZZzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YIu3TxjrBNefNpOzGKA5UeZd9KuQzm7VKX0rY/gxv9s=;
        b=fi5p5HPPKGrh+bWj9KXPWe6zQF+fLvD0aE18Eoh38UlUnCJdP6z9d2bRTIgZw25k/6
         Gtr91tFDktrBqqfLdy1iXsT6FOZlg8VzxcFof6ZXpJKYauaGO71uzbTLE7HpDCnRAaAN
         5D6LNCTI3mJRR1nr1/28b5+389dgwZfb68FGFvtWcqbXanCQpd7BpDnO3WmcIftJlQEJ
         tT+5n7HHHSiX3EMCpB3aEYtMmXkb/u/TIZAXDnPbG/j8U9bw63Ifkv9pzcdq1hKck2rB
         c3kQkj1xRMdQGq2zQc7Gp2nDSglQgwgPFDR+FXZByB5W7s2U2surObd1+dENIOYyWlGx
         FvKw==
X-Gm-Message-State: ABuFfohoudoTTShbUBdUgHLCe4zDkqqjYANJS+/CnUtLXbdoBZhGtxNX
        Do0BtN1P9LbQ5WS6c5Rr0zxiCQ==
X-Google-Smtp-Source: ACcGV60OsYmYLL96xI/uQ+mjUD6SLo528HOPHtuwiqm+wMGrE356ku0LuMlDVLXU5uAykXDQqCLdoA==
X-Received: by 2002:a5d:5501:: with SMTP id b1-v6mr18730786wrv.228.1539081010253;
        Tue, 09 Oct 2018 03:30:10 -0700 (PDT)
Received: from dell ([2.27.167.111])
        by smtp.gmail.com with ESMTPSA id r131-v6sm10146502wmb.32.2018.10.09.03.30.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 03:30:09 -0700 (PDT)
Date:   Tue, 9 Oct 2018 11:30:07 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Vignesh R <vigneshr@ti.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH 3/5] mfd: ti_am335x_tscadc: Keep ADC interface on if
 child is wakeup capable
Message-ID: <20181009103007.GO4939@dell>
References: <20180630103318.25355-1-vigneshr@ti.com>
 <20180630103318.25355-4-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180630103318.25355-4-vigneshr@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Jun 2018, Vignesh R wrote:

> If a child device like touchscreen is wakeup capable, then keep ADC
> interface on, so that a touching resistive screen will generate wakeup
> event to the system.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  drivers/mfd/ti_am335x_tscadc.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
