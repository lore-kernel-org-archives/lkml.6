Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B234C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0763A217FA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730078AbfBESZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 13:25:06 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:45974 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729989AbfBESZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 13:25:03 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 65622133FB6F1;
        Tue,  5 Feb 2019 10:25:02 -0800 (PST)
Date:   Mon, 04 Feb 2019 19:20:40 -0800 (PST)
Message-Id: <20190204.192040.1074738183781998611.davem@davemloft.net>
To:     thierry.reding@gmail.com
Cc:     hkallweit1@gmail.com, andrew@lunn.ch, nic_swsd@realtek.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] r8169: Avoid pointer aliasing
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190204164213.30727-2-thierry.reding@gmail.com>
References: <20190204164213.30727-1-thierry.reding@gmail.com>
        <20190204164213.30727-2-thierry.reding@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 05 Feb 2019 10:25:02 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <thierry.reding@gmail.com>
Date: Mon,  4 Feb 2019 17:42:13 +0100

> @@ -7316,7 +7325,7 @@ static int rtl_get_ether_clk(struct rtl8169_private *tp)
>  static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  {
>  	const struct rtl_cfg_info *cfg = rtl_cfg_infos + ent->driver_data;
> -	u8 mac_addr[ETH_ALEN] __aligned(4) = {};
> +	u8 mac_addr[ETH_ALEN] = {};
>  	struct rtl8169_private *tp;

I agree with Heiner, you have to provide at least 2 byte alignment for this
buffer due to the reasons he stated.
