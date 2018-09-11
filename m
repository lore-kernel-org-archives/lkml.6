Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55877C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D11720839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cXx8JZGR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D11720839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbeIKU5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 16:57:36 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35999 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbeIKU5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 16:57:35 -0400
Received: by mail-wm0-f67.google.com with SMTP id j192-v6so1575322wmj.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 08:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=K40vehxV02gSBpDOJpXrxBadtjIFfT2F8CcOsCvKCKI=;
        b=cXx8JZGRR2rVbB6n7iFtNYpvJ9JOfViBQ6lTO5w54eAWhNjIy0Xho6YSIKrMfqo/4S
         jts6bBCWMOjKOqtq9wQLyXSWq8k6YqJSBPVUodd6xcEZ7cL4dxkqGpTidu8FuBeAIZts
         QWoGVWOzMz7zkj9+8U2qzP0S/GqY5ncjjNuvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=K40vehxV02gSBpDOJpXrxBadtjIFfT2F8CcOsCvKCKI=;
        b=OLaBDnyNmiMP8kZ0eDPsLF7TYYpItZ5hG+3UwcwiWOoTu9hYAgAiuy4H0YW89z49F2
         bRlcvT/Hhlj3sNYs1rIN6jmCf0qkA6J9mUTCHx0vzouz7T8+N6U+9dW1roKbs8nJyu5E
         e57EvIIYSHNzAgB3HtPGlYr/LT1fcY7rd9wV7j6B0S3e31+/tZTNqdzD/a1OZNiVlxYc
         n/NFlIhfWKFmRxiPQENNZqQ+IrUIeM5ZSt/CCGpPYINXlK+6rfVZFtx9StrXSfvk6YhS
         xldB/9hKPgGgSU3Yirr8ssqbZnKfj3UbVODjI0Q+4UhhxdkOJqbEovqXfZb5voSIXUjZ
         H7DQ==
X-Gm-Message-State: APzg51CWlXCEDHMeYMFsZnzxKFyuYTytk9vIHP/w40aiblGZIPVVxWdg
        fT+tkK1hinCYpdD0wsTnsZZOpg==
X-Google-Smtp-Source: ANB0VdYqYBvmcbnJgmdUXVyLVqBYNe6EAaF93UjMJQhNPD7GrMKo9U+Om3+XGZY9hBlcxLcpIp/6Tg==
X-Received: by 2002:a1c:3d08:: with SMTP id k8-v6mr1818845wma.161.1536681458408;
        Tue, 11 Sep 2018 08:57:38 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id l130-v6sm1003812wmd.16.2018.09.11.08.57.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 08:57:37 -0700 (PDT)
Date:   Tue, 11 Sep 2018 16:57:35 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org,
        nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
Subject: Re: [PATCH] mfd: ti-lmu: constify mfd_cell tables
Message-ID: <20180911155355.GD4185@dell>
References: <20180829093108.GB22065@amd>
 <20180907093954.GA26364@amd>
 <e10bdc74-8138-055e-c829-7befbc7161b4@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e10bdc74-8138-055e-c829-7befbc7161b4@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Sep 2018, Dan Murphy wrote:

> Pavel
> 
> On 09/07/2018 04:39 AM, Pavel Machek wrote:
> > On Wed 2018-08-29 11:31:08, Pavel Machek wrote:
> >> From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> >>
> >> mfd: ti-lmu: constify mfd_cell tables
> >>     
> >> Add const attribute to all mfd_cell structures.
> >>     
> >> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> >> Signed-off-by: Pavel Machek <pavel@ucw.cz>
> > 
> > Lee, I guess this is for you to apply. Any news there?
> > 
> > There are more patches ready,
> 
> As I stated in another email thread.  I don't see the need for this level of LMU framework.
> 
> Here is the reference thread
> 
> https://lore.kernel.org/patchwork/patch/982550/

This driver has been present for 1.5 years.

Is that a NACK for *this* patch or are you hijacking? :)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
