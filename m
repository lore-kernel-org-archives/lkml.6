Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396B0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BF492086C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550663482;
	bh=wGf3UgCeduoLJda1smGho54ly2KrsXANNfR4eS56iRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=v8XOg1HGPy/voTbqf7xj8065MfL6Q7jVc5nAUgkWMhY/+2gw6Dle1tbhLiolT1E91
	 INIKftArVCYTeJLFWPBGP5wY+lxJ8aO15n8d8CVTVt77qIryPKo97CPSrcbrXMRhqy
	 S3OtuGnvGYnkg9yDHC0h9FnDldBOsLGliN/J0IBM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbfBTLvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:51:19 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33785 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfBTLvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:51:19 -0500
Received: by mail-lf1-f65.google.com with SMTP id q12so17381785lfm.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 03:51:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ObCtWlCCUaEKXe6dR/Vv0KvJrO7uru38/f6Zl9kTejk=;
        b=piyTTvkf2FyTRun31MomvFr6GPwFyqAbyOy+UuDerdY7gElOyDEqOx05eQoUBQ21B9
         q1meJKXUgVMN2zkQc+cCGZaBtEn8DF3VHZUC0S0efIBeM04RmuQ/kK7++YKATSZ253bl
         Jj4fjvP1srY5m8QhSGdnvb23O2xyCGpORQxpkcojpj887eAx3g2ZBiE+IqNm7eTkwdp9
         TZdOjSs0CJDYNTa5SL/O3FWV/lSQgnYcjmQY8+/8Xb6MIj2PDMxZhRC537G78ekyRR55
         sxdr+yn8wlmiBwLPO1ct8p4AKHc03ZzWzl8qHfpzQEkudoCNo/H1ZIgNZASZdABk2e88
         /RAA==
X-Gm-Message-State: AHQUAubTHHVB4gcj/52uEN1GVxsalukRAM8Zl/SWIqck0x3teP3vwdaV
        gnrKnuouEajRCZ4/sY5aRfk=
X-Google-Smtp-Source: AHgI3IaNjO0Jg0gMUHeybkZaibFdcE4e6DbVYq/0FAeGMzr2fLfH75vb9uEYXO/uSwGp1fU3qGldmw==
X-Received: by 2002:a19:911c:: with SMTP id t28mr20662267lfd.78.1550663476727;
        Wed, 20 Feb 2019 03:51:16 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id e72sm1657225ljf.85.2019.02.20.03.51.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 03:51:15 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gwQPF-0002OE-GQ; Wed, 20 Feb 2019 12:51:17 +0100
Date:   Wed, 20 Feb 2019 12:51:17 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Mans Rullgard <mans@mansr.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform: set of_node in platform_device_register_full()
Message-ID: <20190220115117.GK4072@localhost>
References: <20190216164512.9525-1-mans@mansr.com>
 <20190220113506.11009-1-mans@mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220113506.11009-1-mans@mansr.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 11:35:06AM +0000, Mans Rullgard wrote:
> If the provided fwnode is an OF node, set dev.of_node as well.
> 
> Some drivers are just shims that create extra "glue" devices with the
> DT device as parent and have the real driver bind to these.  In these
> cases, the glue device needs to get a reference to the original DT node
> in order for the main driver to access properties and child nodes.
> 
> For example, the sunxi-musb driver creates such a glue device using
> platform_device_register_full().  Consequently, devices attached to
> this USB interface don't get associated with DT nodes, if present,
> the way they do with EHCI.
> 
> This change will allow sunxi-musb and similar driver to easily
> propagate the DT node to child devices as required.

Just a drive-by comment, didn't look to closely at this patch, but this
all sounds familiar.

Note that if both platform devices are bound to drivers you may end up
with some resources like pinctrl which are handled automatically by
driver core at probe time to be requested twice (and failing the second
time).

Take a look at 4e75e1d7dac9 ("driver core: add helper to reuse a
device-tree node"), which provides a means to avoid this, and
49484abd93ab ("USB: musb: dsps: propagate device-tree node").

> Signed-off-by: Mans Rullgard <mans@mansr.com>
> ---
>  drivers/base/platform.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index dff82a3c2caa..853a1d0e5845 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -512,6 +512,7 @@ struct platform_device *platform_device_register_full(
>  
>  	pdev->dev.parent = pdevinfo->parent;
>  	pdev->dev.fwnode = pdevinfo->fwnode;
> +	pdev->dev.of_node = of_node_get(to_of_node(pdev->dev.fwnode));
>  
>  	if (pdevinfo->dma_mask) {
>  		/*

Johan
