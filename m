Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C75C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8827A2443A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CIO+dPMM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8827A2443A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932778AbeGCJRd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 05:17:33 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33057 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754602AbeGCJR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 05:17:29 -0400
Received: by mail-wr0-f193.google.com with SMTP id k7-v6so1179550wrq.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 02:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=sApgy0aNJbjOBy8ZSdCdHw4MsQN885nC7CRiyY0ZK4I=;
        b=CIO+dPMMlct8xGBzXmRi+w2/d2b/XQdg2yl6rAJyrwfq7sxdnrt8Hfy1qrWDZbm8/2
         9Olk0su8gArh+ee++d9ruaKhOJ5bIhRGHe5Wjn1Zx9EfX0i57B+KP19yFPnNgTWYhNsO
         d6CtcDjMRbzvhS9xQ5jkkAdpTGjL2SmTC1Jkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=sApgy0aNJbjOBy8ZSdCdHw4MsQN885nC7CRiyY0ZK4I=;
        b=WuffYM21sIGyktN5QjKQBT0GavwsACFaXMnZZS9J2tk3mUpItUYFIjQQ6Cor/GOvQ6
         emxOh5XIOc4RpBvZzrmw1Rs+acueJvLM58rSqjjQtcSQMJQJIwvG+1mMCElpbWtIfMfF
         9jR/QQOXyFDKspbJ2ggy/8cQ2KvYA9ymSplhs1skm5cQZB4nvYC5TOK7fpPKlwUtayuJ
         E/dI04eSmcMqv8zgKfzJI+LTgGYYUx4qDhY3MFRGBcU3OAA3vMf62K7hn0ldQTSTd3M4
         c16hEafTOp0fPqHWpZ+fr8ctX82E5vj5sbY3e57xNQviYNPmtaxzKL7LCZqQveeTNHu4
         8wPA==
X-Gm-Message-State: APt69E2Oc18l93oHp3CXdOwht9BvxwbfkvFaTW0ebPCSJhP+OcAoeSsB
        RE/44oghjNvcOuglc6PsMTws9w==
X-Google-Smtp-Source: AAOMgpcmOqImedp+Bazlx6dUY2mrehZgvhJiYzbzwmI8MWLMZCTxGMbWY+oD+EzRbWMRwOimaVih5Q==
X-Received: by 2002:adf:9527:: with SMTP id 36-v6mr1818926wrs.99.1530609448435;
        Tue, 03 Jul 2018 02:17:28 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id a184-v6sm1168295wmf.30.2018.07.03.02.17.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 02:17:27 -0700 (PDT)
Date:   Tue, 3 Jul 2018 10:17:26 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>, chen.zhong@mediatek.com,
        linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <mbrugger@suse.com>
Subject: Re: [PATCH] input: mtk-pmic-keys: Fix probe when no DT node present
Message-ID: <20180703091726.GM20176@dell>
References: <20180622114228.8619-1-matthias.bgg@gmail.com>
 <20180622183114.GA92912@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180622183114.GA92912@dtor-ws>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jun 2018, Dmitry Torokhov wrote:

> On Fri, Jun 22, 2018 at 01:42:28PM +0200, Matthias Brugger wrote:
> > The drivers gets probed from a mfd devices. So the driver runs
> > probe although no DT node exists. This leads to a NULL pointer
> > dereference in the probe function. Check if a node exists and
> > error out in case none is present.
> 
> Hmm, if a cell specifies of_compatible and no such node is present in DT
> maybe we should bail out in mfd_add_device() instead of pushing the
> check into individual drivers? Something like:
> 
> diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
> index 94e3f32ce935..36a5fd98000d 100644
> --- a/drivers/mfd/mfd-core.c
> +++ b/drivers/mfd/mfd-core.c
> @@ -137,6 +137,18 @@ static inline void mfd_acpi_add_device(const struct mfd_cell *cell,
>  }
>  #endif
>  
> +static struct device_node *mfd_get_node_for_cell(struct device *parent,
> +						 const struct mfd_cell *cell)
> +{
> +	struct device_node *np;
> +
> +	for_each_child_of_node(parent->of_node, np)
> +		if (of_device_is_compatible(np, cell->of_compatible))
> +			return np;
> +
> +	return NULL;
> +}
> +
>  static int mfd_add_device(struct device *parent, int id,
>  			  const struct mfd_cell *cell, atomic_t *usage_count,
>  			  struct resource *mem_base,
> @@ -144,7 +156,6 @@ static int mfd_add_device(struct device *parent, int id,
>  {
>  	struct resource *res;
>  	struct platform_device *pdev;
> -	struct device_node *np = NULL;
>  	int ret = -ENOMEM;
>  	int platform_id;
>  	int r;
> @@ -176,11 +187,11 @@ static int mfd_add_device(struct device *parent, int id,
>  		goto fail_res;
>  
>  	if (parent->of_node && cell->of_compatible) {
> -		for_each_child_of_node(parent->of_node, np) {
> -			if (of_device_is_compatible(np, cell->of_compatible)) {
> -				pdev->dev.of_node = np;
> -				break;
> -			}
> +		pdev->dev.of_node = mfd_get_node_for_cell(parent, cell);
> +		if (!pdev->dev.of_node) {
> +			dev_err(parent, "unable to locate node for %s (%s)\n",
> +				cell->name, cell->of_compatible);
> +			goto fail_res;
>  		}
>  	}
>  
> Lee?

This change results the wrong semantics.  MFD overrides Device Tree,
such that if a device is supplied and registered using
mfd_add_device(s) it should be probed.  The only reason we provide a
pointer to the of_node is for the child device to pull properties
from.

If a device should only be probed if an OF node exists, then it should
not be registered at the MFD level.

> > Fixes: 3e9f0b3e2b27 ("input: Add MediaTek PMIC keys support")
> > Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> > ---
> >  drivers/input/keyboard/mtk-pmic-keys.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
> > index 02c67a1749fc..388043e1939c 100644
> > --- a/drivers/input/keyboard/mtk-pmic-keys.c
> > +++ b/drivers/input/keyboard/mtk-pmic-keys.c
> > @@ -257,6 +257,9 @@ static int mtk_pmic_keys_probe(struct platform_device *pdev)
> >  	const struct of_device_id *of_id =
> >  		of_match_device(of_mtk_pmic_keys_match_tbl, &pdev->dev);
> >  
> > +	if (of_id == NULL)
> > +		return -ENODEV;
> > +
> >  	keys = devm_kzalloc(&pdev->dev, sizeof(*keys), GFP_KERNEL);
> >  	if (!keys)
> >  		return -ENOMEM;
> 
> Thanks.
> 

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
