Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49751ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 23:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E92942075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 23:11:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E92942075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730524AbeGRXvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 19:51:08 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:45486 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbeGRXvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 19:51:08 -0400
Received: from localhost (unknown [172.58.43.198])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A83C11007FA43;
        Wed, 18 Jul 2018 16:10:57 -0700 (PDT)
Date:   Thu, 19 Jul 2018 08:10:54 +0900 (KST)
Message-Id: <20180719.081054.2060054138371290633.davem@davemloft.net>
To:     brgl@bgdev.pl
Cc:     nsekhar@ti.com, khilman@kernel.org, linux@armlinux.org.uk,
        grygorii.strashko@ti.com, srinivas.kandagatla@linaro.org,
        lukas@wunner.de, robh@kernel.org, f.fainelli@gmail.com,
        dan.carpenter@oracle.com, ivan.khoronzhuk@linaro.org,
        david@lechnology.com, gregkh@linuxfoundation.org, andrew@lunn.ch,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        bgolaszewski@baylibre.com
Subject: Re: [PATCH 1/5] net: visually shrink eth_platform_get_mac_address()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180718161035.7005-2-brgl@bgdev.pl>
References: <20180718161035.7005-1-brgl@bgdev.pl>
        <20180718161035.7005-2-brgl@bgdev.pl>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 18 Jul 2018 16:10:59 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 18 Jul 2018 18:10:31 +0200

> @@ -527,15 +527,10 @@ unsigned char * __weak arch_get_platform_mac_address(void)
>  
>  int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
>  {
> -	const unsigned char *addr;
> -	struct device_node *dp;
> +	struct device_node *dp = dev_is_pci(dev) ?
> +			pci_device_to_OF_node(to_pci_dev(dev)) : dev->of_node;
> +	const unsigned char *addr = NULL;
>  
> -	if (dev_is_pci(dev))
> -		dp = pci_device_to_OF_node(to_pci_dev(dev));
> -	else
> -		dp = dev->of_node;
> -

Reverse christmas tree is why the assignments are in the body of
the function instead of the declaration area.

Please don't do this, thanks.
