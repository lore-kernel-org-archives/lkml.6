Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B4AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94DA52085B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="maAxWPJt";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="maAxWPJt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94DA52085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbeJKDEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 23:04:20 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57624 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbeJKDET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 23:04:19 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C23BA60C4D; Wed, 10 Oct 2018 19:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539200441;
        bh=jpSnUR9RhwSuaR+uzq2CGKc+ge//VavyzSUlvEFYnjw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=maAxWPJtLcGBQSUFjSeZlpFSa4J9iNTONRoTxPF2zYGAtvjpHSrGzFnOJaZWUeM5X
         Nad8aDffvkQjv1u6S6snSdGcOd71fVbrkqHwCL97OHApI0jweP0Ubbh+RAriTr0wqG
         inU7zLGcj0gmdYxciRVG4IbrhndlOLhWTNtwcSPY=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 7846360866;
        Wed, 10 Oct 2018 19:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539200441;
        bh=jpSnUR9RhwSuaR+uzq2CGKc+ge//VavyzSUlvEFYnjw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=maAxWPJtLcGBQSUFjSeZlpFSa4J9iNTONRoTxPF2zYGAtvjpHSrGzFnOJaZWUeM5X
         Nad8aDffvkQjv1u6S6snSdGcOd71fVbrkqHwCL97OHApI0jweP0Ubbh+RAriTr0wqG
         inU7zLGcj0gmdYxciRVG4IbrhndlOLhWTNtwcSPY=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 10 Oct 2018 12:40:41 -0700
From:   Sodagudi Prasad <psodagud@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     bjorn.andersson@linaro.org, linus.walleij@linaro.org,
        linux-gpio@vger.kernel.org, sboyd@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: protected pins and debugfs
In-Reply-To: <153897864285.119890.13024399324598460044@swboyd.mtv.corp.google.com>
References: <9aec322678417753fe4022691f4bfdbe@codeaurora.org>
 <153897864285.119890.13024399324598460044@swboyd.mtv.corp.google.com>
Message-ID: <5848ff92c1388b7d6904e88b57bbfec8@codeaurora.org>
X-Sender: psodagud@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-07 23:04, Stephen Boyd wrote:
> Quoting Sodagudi Prasad (2018-10-03 05:38:24)
>> 
>>          for (i = 0; i < chip->ngpio; i++, gpio++) {
>> +               label = gpiochip_is_requested(chip, i);
>> +               if (!label)
>> +                       continue;
>>                  msm_gpio_dbg_show_one(s, NULL, chip, i, gpio);
>> -               seq_puts(s, "\n");
>>          }
>>   }
>> 
> 
> Does something not work with the following code in
> msm_gpio_dbg_show_one()?
> 
> 
>         if (!gpiochip_line_is_valid(chip, offset))
> 		return;

Hi Stephen,
I didnt realize that these changes are merged on tip. I was testing on 
4.14 kernel.

https://lore.kernel.org/patchwork/patch/878107/
https://lore.kernel.org/patchwork/patch/878106/
https://lore.kernel.org/patchwork/patch/878109/

I will add "gpio-reserved-ranges" to internal platforms and this issue 
should not be observed.

-thanks, Prasad

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
Linux Foundation Collaborative Project
