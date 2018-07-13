Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279DFECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6964208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AAQZopgO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6964208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730230AbeGMHsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 03:48:52 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36247 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729899AbeGMHsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 03:48:52 -0400
Received: by mail-wr1-f68.google.com with SMTP id h9-v6so24088040wro.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 00:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=tA9vVKloLH7hvA4JC07rwHTQ9WhbHllsIg0D7kwQTGw=;
        b=AAQZopgOApjks9LpF+CdVshCANeISZTiI36KngCObz/ecfyGm0y66vgFzSKA8ujpal
         t9xjz0NjzqmI/yGZu+VhgTpGWUnYQJClQbg3CVYjpOwC02PAYfzuIxScVgdWyrmA8ELh
         dkTfNppjdc1lYq5AcAzqntHh64VD9WcSjT3gU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=tA9vVKloLH7hvA4JC07rwHTQ9WhbHllsIg0D7kwQTGw=;
        b=HyNS7vI8y524UrdqhRZEMFRrvFYMTbtUahxJYKnSzl8NMYjzTDzD4hYaXH2AQoEibM
         e3+Ld0bgRlaWV6iwT7A1mQCLutXY2giZkFZnL0WhzQABawSzwexRWeuJXQ/Ghwc6im+k
         GVBAs1to5j23RmAcEUyrgT4WfyCfjIHiIdgeOmAUGY2NZ/WcjVC3r76+ricvED/wjOMx
         E+SPfii/uTrNIYfcqEEN+wD/WwlQDOyadurCJTqC0sm5+iZmFG0+1ewlB/JRxEPSnbSE
         cdDTRNS9mc0pPvUtBiP4TJfiWDZ1Q0d75fPyxKZqViMBEXZnAV3XWf1LuVX8qPSDtNEk
         JYgw==
X-Gm-Message-State: AOUpUlHpqqaFgYpCzfn07yX7gNPDBVqNPqLKuKkWZJKuIvG96iqOwiHn
        OgKcYnvicPkRWqlGuygZ7NXK+oxybgY=
X-Google-Smtp-Source: AAOMgpeW2d3xBx0P4RGqroyucOika3CnEdk3qoZxuWizjl/5Kh2z0pFWs+taY9PKgYXEDpjDbyMhpg==
X-Received: by 2002:adf:ec04:: with SMTP id x4-v6mr3716265wrn.245.1531467328366;
        Fri, 13 Jul 2018 00:35:28 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id c5-v6sm15459379wrh.36.2018.07.13.00.35.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Jul 2018 00:35:27 -0700 (PDT)
Date:   Fri, 13 Jul 2018 08:35:25 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Michael Hennerich <michael.hennerich@analog.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: adp8860: Mark expected switch fall-through
Message-ID: <20180713073525.GS4641@dell>
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

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
