Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2324CC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE13025DD7
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="FHLurCpv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE13025DD7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754462AbeFYQJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 12:09:02 -0400
Received: from vern.gendns.com ([206.190.152.46]:48152 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751878AbeFYQJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 12:09:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kUYvYmvJMbpYtQP5ClY+Ob7yiq2wVkk0lCji50b8038=; b=FHLurCpvKWNIt/V6otb0BINZV3
        GFUm2+O6XUVuInkd4dAeqvjmeS2V4dpojpyUuw/JgAvk0tOn3nXhIyy5rT7M/nNuraF8grIAaddmc
        oQvB+/GWhkTRmrmkYp2+VG0vRu30PIm1UXfe70GuwI9Ya3ASlxTjlIFaNT13ITPEY/q/PHn8OdQpA
        x/d9A6fElx6n7zuEXyVLFbxSsPW3NDZhSME97N8XazGlmjAWmZH5Aco73Je2A+qYQeV2NId7kABgl
        U5WwP2xnJeNdidr49Wq9ptNHGtd/L9sLZYkE63u2gZLCzPc9jwK+j9Du4oAh+pB2N0LroFCONK3fl
        pUN0oACA==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:54168 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1fXU30-001C8M-PY; Mon, 25 Jun 2018 12:08:59 -0400
Subject: Re: [PATCH 2/9] ARM: davinci: omapl138-hawk: add aemif & nand support
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180625152920.11549-1-brgl@bgdev.pl>
 <20180625152920.11549-3-brgl@bgdev.pl>
From:   David Lechner <david@lechnology.com>
Message-ID: <41248083-69db-4b88-8a11-e7fa2bd06718@lechnology.com>
Date:   Mon, 25 Jun 2018 11:08:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180625152920.11549-3-brgl@bgdev.pl>
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
> We now have support for aemif & nand from board files. As an example
> add support for nand to da850-hawk.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---

> +static struct platform_device omapl138_hawk_aemif_devices[] = {
> +	{
> +		.name		= "davinci_nand",
> +		.id		= 1,

same comment as on da850-evm...

this might need id = 0 now.

> +		.dev		= {
> +			.platform_data	= &omapl138_hawk_nandflash_data,
> +		},
> +		.resource	= omapl138_hawk_nandflash_resource,
> +		.num_resources	= ARRAY_SIZE(omapl138_hawk_nandflash_resource),
> +	}
> +};
