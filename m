Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7EE1C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 04:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7030120B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 04:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbeLaEWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 23:22:23 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:35826 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbeLaEWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 23:22:22 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 182C314AE83AD;
        Sun, 30 Dec 2018 20:22:22 -0800 (PST)
Date:   Sun, 30 Dec 2018 20:22:19 -0800 (PST)
Message-Id: <20181230.202219.1041865778497322666.davem@davemloft.net>
To:     peng.hao2@zte.com.cn
Cc:     qiang.zhao@nxp.com, leoyang.li@nxp.com,
        linux-kernel@vger.kernel.org, wen.yang99@zte.com.cn,
        julia.lawall@lip6.fr, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4] soc/fsl/qe: fix err handling of ucc_of_parse_tdm
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1546073252-98777-1-git-send-email-peng.hao2@zte.com.cn>
References: <1546073252-98777-1-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 30 Dec 2018 20:22:22 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Hao <peng.hao2@zte.com.cn>
Date: Sat, 29 Dec 2018 16:47:32 +0800

> +static struct resource *ucc_get_resource_by_nodename(char *name)
> +{
> +	struct device_node *np;
> +	struct platform_device *pdev;
> +
> +	np = of_find_compatible_node(NULL, NULL, name);
> +	if (!np)
> +		return ERR_PTR(-EINVAL);
> +
> +	pdev = of_find_device_by_node(np);
> +	if (!pdev) {
> +		pr_err("%pOFn: failed to lookup pdev\n", np);
> +		of_node_put(np);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	of_node_put(np);
> +	return platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +}

"of_find_device_by_node()" takes a reference to the underlying device
structure, and you never release that reference.

I am very concerned about your submission because there are many
serious problems in it.  It is absolutely impossible for your v3 to
have been tested, and now this new v4 adds object reference leaks.
