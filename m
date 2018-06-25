Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9920C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F7A7214F0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="dE6xRpaw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F7A7214F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755679AbeFYPxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:53:52 -0400
Received: from vern.gendns.com ([206.190.152.46]:47435 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754915AbeFYPxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:53:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=c7OzWhinLwcYbAMenKQaluwX+koTU6Tg2kUp5fA/5Ww=; b=dE6xRpawx6xZZ0ntLo/cDMILQb
        0e/VfKzlU8AP3W5YknAyEB2i0i1irEElhl3zLsNIsaaAPBm1LDGQxLRdsHzdxaP32ebpfJW8oXY9T
        DOsTPFpSbz6VqXfCKeMvx4q1ercyQD2zkLPaC7qdJz6alMjgqd6SZ4a2FdieUkrhzbYFlR5+YeQWt
        N+t2NM6HUABHNKa5OVlHN7k6T0+QjYG4BeYLJFs0u9by6J8rseskaUlczwLg0Fol2+p98drTMrNNf
        lkrrqVRPElqsBKHcrHvneTikEFsAz8SaQ6txsSi4VnZl13rjtgjou8/1E17c/pWhS/RiLQXHG3AJu
        HfaB60/A==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:53978 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1fXToI-0018vq-3m; Mon, 25 Jun 2018 11:53:46 -0400
Subject: Re: [PATCH 1/9] clk: davinci: psc-dm365: use two lookup entries for
 the aemif clock
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180625152920.11549-1-brgl@bgdev.pl>
 <20180625152920.11549-2-brgl@bgdev.pl>
From:   David Lechner <david@lechnology.com>
Message-ID: <241fed6e-b414-feac-8e6c-39713c5e665e@lechnology.com>
Date:   Mon, 25 Jun 2018 10:53:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180625152920.11549-2-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/25/2018 10:29 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> We want to be able to get the clock both from the board file by its
> con_id and from the aemif driver by dev_id.

What about the other SoCs? Don't they need this change as well?

> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   drivers/clk/davinci/psc-dm365.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/davinci/psc-dm365.c b/drivers/clk/davinci/psc-dm365.c
> index 8c73086cc676..c75424f4ea3b 100644
> --- a/drivers/clk/davinci/psc-dm365.c
> +++ b/drivers/clk/davinci/psc-dm365.c
> @@ -21,7 +21,8 @@ LPSC_CLKDEV1(mmcsd1_clkdev,		NULL,		"da830-mmc.1");
>   LPSC_CLKDEV1(asp0_clkdev,		NULL,		"davinci-mcbsp");
>   LPSC_CLKDEV1(usb_clkdev,		"usb",		NULL);
>   LPSC_CLKDEV1(spi2_clkdev,		NULL,		"spi_davinci.2");
> -LPSC_CLKDEV1(aemif_clkdev,		"aemif",	NULL);
> +LPSC_CLKDEV2(aemif_clkdev,		"aemif",	NULL,
> +					NULL,		"ti-aemif");
>   LPSC_CLKDEV1(mmcsd0_clkdev,		NULL,		"da830-mmc.0");
>   LPSC_CLKDEV1(i2c_clkdev,		NULL,		"i2c_davinci.1");
>   LPSC_CLKDEV1(uart0_clkdev,		NULL,		"serial8250.0");
> 

