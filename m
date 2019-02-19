Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86558C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FF86206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729301AbfBSRFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 12:05:20 -0500
Received: from muru.com ([72.249.23.125]:39654 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbfBSRFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 12:05:20 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 8FD1680B6;
        Tue, 19 Feb 2019 17:05:29 +0000 (UTC)
Date:   Tue, 19 Feb 2019 09:05:16 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Peng Hao <peng.hao2@zte.com.cn>
Cc:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Julia Lawall <Julia.Lawall@lip6.fr>
Subject: Re: [PATCH]  arm/mach-omap2/display: fix possible object reference
 leak
Message-ID: <20190219170516.GL15711@atomide.com>
References: <1550071969-86286-1-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550071969-86286-1-git-send-email-peng.hao2@zte.com.cn>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Adding devicetree list, Julia, Rob and Tomi to Cc.

* Peng Hao <peng.hao2@zte.com.cn> [190212 23:11]:
> of_find_device_by_node() takes a reference to the struct device
> when it finds a match via get_device.When returning error we should
> call put_device.
> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  arch/arm/mach-omap2/display.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
> index f86b72d..c6aa9ed 100644
> --- a/arch/arm/mach-omap2/display.c
> +++ b/arch/arm/mach-omap2/display.c
> @@ -258,6 +258,7 @@ static int __init omapdss_init_of(void)
>  	r = of_platform_populate(node, NULL, NULL, &pdev->dev);
>  	if (r) {
>  		pr_err("Unable to populate DSS submodule devices\n");
> +		put_device(&pdev->dev);
>  		return r;
>  	}

In general, if the device tree node is never used afterwards,
should this be just:

	r = of_platform_populate(node, NULL, NULL, &pdev->dev);
	of_node_put(dev_node);
	if (r) {
		...
	}

If so, Julia might have a Coccinelle recpipe for it?

Regards,

Tony
