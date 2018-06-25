Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467F0C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 016AC25D9F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="W4cSwwXV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 016AC25D9F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755274AbeFYQAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 12:00:17 -0400
Received: from vern.gendns.com ([206.190.152.46]:47745 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754632AbeFYQAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 12:00:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=M/cHQPIQ02w6hDGi0pucIBHjbqpDctQ6eAUyXfIh1xM=; b=W4cSwwXVoQmJs6sNuXq/x7VvhM
        PBnI3mQxT/bGvVFadxTflNToYuvf4WeX+KhuoJBb96SlT7Htmyl9MW0pZ5+zGo0ufeq7GtYVFgiEf
        FEBbSrZeMsWBIwzqmJUbI3AZZGNjI+4mQ6pKzHJzkZDQ5ykgyCGkZd1U9/JYAzm3O8fsDnbdpMEod
        KN2ftWxliegL0f14txg4pCQI9qfammkwfXaowX9SwZMlpCL6BdPOoObfh1UK6eJOypvZnkNlgiwdZ
        zqAkzw1f+xNKsjIs3AAmSM0fPrSdXdH1+GctoRMryEAM65jYtEoRNSPOfQxWeiP+iL6Ao1dtmlDb9
        u3XBiw2A==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:54048 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1fXTuX-001AJ9-9H; Mon, 25 Jun 2018 12:00:13 -0400
Subject: Re: [PATCH 3/9] ARM: davinci: da850-evm: use aemif platform driver in
 legacy mode
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180625152920.11549-1-brgl@bgdev.pl>
 <20180625152920.11549-4-brgl@bgdev.pl>
From:   David Lechner <david@lechnology.com>
Message-ID: <13418bf6-dbe7-5091-b5a7-07f779fb9f63@lechnology.com>
Date:   Mon, 25 Jun 2018 11:00:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180625152920.11549-4-brgl@bgdev.pl>
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
> We now support board files in the aemif driver. Register a platform
> device instead of using the handcrafted API in da850-evm.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---

> -	iounmap(aemif_addr);
> -}
> +static struct platform_device da850_evm_aemif_device = {
> +	.name		= "ti-aemif",
> +	.dev = {
> +		.platform_data	= &da850_evm_aemif_pdata,
> +	},
> +	.resource	= da850_evm_aemif_resource,
> +	.num_resources	= ARRAY_SIZE(da850_evm_aemif_resource),
> +	.id		= -1,
> +};
> 

Not essential, but it is nice to have the id right after name
since they are closely related (as you did in several other
instances in this same patch). For a second, I thought you
forgot id = -1 here before I saw it.
