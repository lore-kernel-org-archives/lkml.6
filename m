Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D100C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E3D325594
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:05:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E3D325594
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753021AbeFYIFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 04:05:54 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:54436 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752507AbeFYIFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 04:05:51 -0400
Received: from localhost (unknown [211.231.11.194])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id AEB61133F9EE1;
        Mon, 25 Jun 2018 01:05:49 -0700 (PDT)
Date:   Mon, 25 Jun 2018 17:05:47 +0900 (KST)
Message-Id: <20180625.170547.658198698048994134.davem@davemloft.net>
To:     marcel@ziswiler.com
Cc:     netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        jeffrey.t.kirsher@intel.com, marcel.ziswiler@toradex.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] igb: allow optionally getting mac address from device
 tree
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180625080042.32286-1-marcel@ziswiler.com>
References: <20180625080042.32286-1-marcel@ziswiler.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 25 Jun 2018 01:05:51 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel@ziswiler.com>
Date: Mon, 25 Jun 2018 10:00:42 +0200

> @@ -3122,7 +3124,11 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  		break;
>  	}
>  
> -	if (eth_platform_get_mac_address(&pdev->dev, hw->mac.addr)) {
> +	/* try to get the MAC address from device tree data */
> +	iap = of_get_mac_address(pdev->dev.of_node);
> +	if (iap)
> +		memcpy(hw->mac.addr, iap, ETH_ALEN);

This is exactly what eth_platform_get_mac_address() shoule be doing.
