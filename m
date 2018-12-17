Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A34C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3786B2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RPrX/uK5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732938AbeLQOek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 09:34:40 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52617 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732843AbeLQOej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 09:34:39 -0500
Received: by mail-wm1-f68.google.com with SMTP id m1so12590331wml.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 06:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=SKuXzIBi+yiiIFMkUfS0RrbPDR1u+s//VaBjVaNDxsc=;
        b=RPrX/uK5MZCtJXLIxsj6/UuxBPMnpf1pZrm4G1vjJYwYt2Su0/W37BJ5dLBpHq6p/P
         R+e+ydEpG/ugB+C/Mv8NyD03bvXrZZ6hRTUnEk/BVB/Tejmsrh82mwiDqv5cHSaZDGkN
         7ZW0RFy28+giVkt/cH+6rjW9fSrjlXUZ4QefI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=SKuXzIBi+yiiIFMkUfS0RrbPDR1u+s//VaBjVaNDxsc=;
        b=HT6CO5xC3I28fjiemvGnhoaTHqMQwCFJmb16XDyCACY2zQrZFNEfJRnC51l7VGh2+T
         qf21sKwYRUwB81PoH3SFYRJXP5mHQkNoB30Y+inXy6xMDIJlOYwLuI9Da8Z3pRTJHCaN
         8wKr/SP5yJPuIYWXwbRpnGLOjTKEdqjA93QVf52C7rnFhsxIGagBiMs+j5cEL9GzbCoO
         jFiwDtglAOFaewyv8QqRudo9aL1bSqhQ8xCh0SIDrbbzE724341ENQ1TY3S4qvJTTjxD
         AhQjkxdRi1uC9YM0NFsKcATs9R0+BxkhD+iIsbzj2UXjmQ0pakvbNOeh1TzSJKe/XLOA
         mREg==
X-Gm-Message-State: AA+aEWZXYXVu3EQAaERo0AlzTBmdmeEjYDJYVDs/UJoO/EhNFgKHiUl5
        h0zhTL4F0SFNY6xS9nIWBRTBFw==
X-Google-Smtp-Source: AFSGD/UAFRNrsgj1Yjqe1ceBm54QhcNxo9K2Fim2R0syx3cE7SB+3aJrvHY46eyULMwM6Ba4jRvOSg==
X-Received: by 2002:a1c:9692:: with SMTP id y140mr12321167wmd.67.1545057277874;
        Mon, 17 Dec 2018 06:34:37 -0800 (PST)
Received: from dell ([95.149.164.119])
        by smtp.gmail.com with ESMTPSA id j8sm431231wrt.40.2018.12.17.06.34.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 06:34:37 -0800 (PST)
Date:   Mon, 17 Dec 2018 14:34:35 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     "J, KEERTHY" <j-keerthy@ti.com>
Cc:     Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH] tps65218.c: fix IRQ resource leak in tps65218_probe()
Message-ID: <20181217143435.GC4497@dell>
References: <1544090279-26762-1-git-send-email-Christian.Hohnstaedt@wago.com>
 <20181214122559.GV4497@dell>
 <20181214122619.GW4497@dell>
 <f584aab6-374c-5a53-51c5-61098f8bb792@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f584aab6-374c-5a53-51c5-61098f8bb792@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2018, J, KEERTHY wrote:

> 
> 
> On 12/14/2018 5:56 PM, Lee Jones wrote:
> > On Fri, 14 Dec 2018, Lee Jones wrote:
> > 
> > > On Thu, 06 Dec 2018, Christian Hohnstaedt wrote:
> > > 
> > > > Free allocated IRQ if reading the device ID fails.
> > > 
> > > The patch is fine.  However, in future please submit patches using the
> > > format set (by precedent) by the subsystem.  I will fix the subject
> > > for you this time.
> > > 
> > > To check the format, you can do:
> > > 
> > >    `git log --oneline -- <subsystem>`
> > 
> > Patch applied, by the way.
> 
> This would no longer be needed as the bigger clean up is here:
> 
> https://lkml.org/lkml/2018/12/9/86
> 
> As both are applied it results in a compilation issue.
> 
> Lee Jones,
> 
> Do you want me to submit a fix patch? Or you can revert this patch?
> Anything fine by me.

I have removed this patch from the MFD tree now.  Thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
