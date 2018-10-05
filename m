Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA92EC65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 13:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B15932087D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 13:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="naU8+CeT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B15932087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbeJEUu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 16:50:59 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17386 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728278AbeJEUu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 16:50:58 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bb76c650000>; Fri, 05 Oct 2018 06:51:33 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 05 Oct 2018 06:52:08 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 05 Oct 2018 06:52:08 -0700
Received: from [10.21.132.143] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 5 Oct
 2018 13:52:07 +0000
Subject: Re: [PATCH 08/12] i2c: tegra: use core to detect 'no zero length'
 quirk
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        <linux-i2c@vger.kernel.org>
CC:     <linux-renesas-soc@vger.kernel.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20180723202617.15230-1-wsa+renesas@sang-engineering.com>
 <20180723202617.15230-9-wsa+renesas@sang-engineering.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <8eb3d00b-0275-30ec-ef44-5e859dd9242f@nvidia.com>
Date:   Fri, 5 Oct 2018 14:52:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180723202617.15230-9-wsa+renesas@sang-engineering.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1538747493; bh=bu8LfgMVvMNA0y7tle1tLAAJmn7e/emTgNx0zeoJQvk=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=naU8+CeTso0vLHIqEFp7L9T2Wh/d93pGHlUXVvgHBvsw1LoQCxSf9N/6r1znUkghz
         qE/OcghJJucLGo4u2l/cH/y2u1Ezy7cMZu0bnbUvGCJ7VFIxGWErPzgOYahor4aWgV
         LQUQMcrSavcno2UM7+vfFxXKcU1TlUW8cWi01YqD/WouWvfABm2or1JIrajaGVfvvN
         Y79CGzDQ3NQ2ZKimU2UO3AMPUZPqikRDFNE1J8QUBRNdPBnD2mLyrv8CSivNQKB9WB
         sBXHy6tMkHN0CYazKzGmvjxOeY1bUlHCsG5QMx1SKIa9dvfExK66vSB8ZTaTxeGadQ
         Nqjc19fzzbXDg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23/07/18 21:26, Wolfram Sang wrote:
> And don't reimplement in the driver.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Only build tested.
> 
>  drivers/i2c/busses/i2c-tegra.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
> index 60c8561fbe65..437294ea2f0a 100644
> --- a/drivers/i2c/busses/i2c-tegra.c
> +++ b/drivers/i2c/busses/i2c-tegra.c
> @@ -684,9 +684,6 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
>  
>  	tegra_i2c_flush_fifos(i2c_dev);
>  
> -	if (msg->len == 0)
> -		return -EINVAL;
> -
>  	i2c_dev->msg_buf = msg->buf;
>  	i2c_dev->msg_buf_remaining = msg->len;
>  	i2c_dev->msg_err = I2C_ERR_NONE;
> @@ -831,6 +828,7 @@ static const struct i2c_algorithm tegra_i2c_algo = {
>  
>  /* payload size is only 12 bit */
>  static const struct i2c_adapter_quirks tegra_i2c_quirks = {
> +	.flags = I2C_AQ_NO_ZERO_LEN,
>  	.max_read_len = 4096,
>  	.max_write_len = 4096,
>  };

Sorry for missing this, but looks fine to me, so ...

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
