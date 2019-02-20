Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691A3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FE002086C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfBTLxw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:53:52 -0500
Received: from unicorn.mansr.com ([81.2.72.234]:44704 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbfBTLxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:53:52 -0500
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id BB16015632; Wed, 20 Feb 2019 11:53:50 +0000 (GMT)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform: set of_node in platform_device_register_full()
References: <20190216164512.9525-1-mans@mansr.com>
        <20190220113506.11009-1-mans@mansr.com>
Date:   Wed, 20 Feb 2019 11:53:50 +0000
In-Reply-To: <20190220113506.11009-1-mans@mansr.com> (Mans Rullgard's message
        of "Wed, 20 Feb 2019 11:35:06 +0000")
Message-ID: <yw1xmumqwu9d.fsf@mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mans Rullgard <mans@mansr.com> writes:

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
>
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
> -- 

Sorry, I forgot to add a v2 to this.  Anyway, the only change is the
commit message.

-- 
Måns Rullgård
