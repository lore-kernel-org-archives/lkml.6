Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E24CC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39DF3261A7
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:23:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39DF3261A7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754530AbeFYWXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 18:23:12 -0400
Received: from smtprelay0224.hostedemail.com ([216.40.44.224]:36699 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752363AbeFYWXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 18:23:10 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id C409A837F24C;
        Mon, 25 Jun 2018 22:23:09 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: force06_384f1d4000049
X-Filterd-Recvd-Size: 1443
Received: from XPS-9350.home (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Mon, 25 Jun 2018 22:23:06 +0000 (UTC)
Message-ID: <c892c7e7b271c9a269c78887777e691dce12f5c8.camel@perches.com>
Subject: Re: [PATCH v3 net-next] mdio-mux-gpio: Remove VLA usage
From:   Joe Perches <joe@perches.com>
To:     Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        netdev@vger.kernel.org
Date:   Mon, 25 Jun 2018 15:23:05 -0700
In-Reply-To: <20180625220917.GA25022@beast>
References: <20180625220917.GA25022@beast>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-06-25 at 15:09 -0700, Kees Cook wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this
> allocates the values buffer during the callback instead of putting it
> on the stack.

[]

> diff --git a/drivers/net/phy/mdio-mux-gpio.c b/drivers/net/phy/mdio-mux-gpio.c
[]
> @@ -44,15 +44,21 @@ static int mdio_mux_gpio_switch_fn(int current_child, int desired_child,
>  static int mdio_mux_gpio_probe(struct platform_device *pdev)
>  {
[]
> +	s = devm_kzalloc(&pdev->dev, sizeof(*s->values) * gpios->ndescs +
> +				     sizeof(*s), GFP_KERNEL);

Isn't this supposed to use your new struct_size()

