Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C0AC5ACC6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 02:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20ECD214AB
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 02:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hmGSg842";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IpxVQDZ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20ECD214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbeJQJyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 05:54:04 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35100 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbeJQJyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 05:54:03 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2FD53606DD; Wed, 17 Oct 2018 02:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539741646;
        bh=A2LdiJ40ctInLu+JQ3kwB+14oe8N6hXzrsbXO0QQefY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hmGSg842BoLMYncfgSGnuKEOYSK1B7mhHmL4DEaZSL74yRf+JGuzCKX1vRqqt9Xtx
         cColHJrWIMY53jriLB3HdWCMJK+PaZFSNYG5EvBwdq9aeBwTFYyxgoIY6uhCItPyYH
         B100llsJ7AO7+FaFUPXCXXZHph1r9mfLuy6SAqM0=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 9731960386;
        Wed, 17 Oct 2018 02:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539741645;
        bh=A2LdiJ40ctInLu+JQ3kwB+14oe8N6hXzrsbXO0QQefY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IpxVQDZ2i1OhDbg18ZAooS28E2IfpgmFmsLvvJc2mepKgnWkG1/P2hYbIU5WCCkur
         TlR4BKsNtiTAe2qOpvbwkByTS9HYknwL/c6HP2AIEgxc7Vi//IpSZaNfZZytPP2/cd
         n/h3gHT7wJmPSj9kJr4uEbhcqYppw7R0hzNHvF7g=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 16 Oct 2018 19:00:45 -0700
From:   Sodagudi Prasad <psodagud@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     bjorn.andersson@linaro.org, linus.walleij@linaro.org,
        linux-gpio@vger.kernel.org, sboyd@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: protected pins and debugfs
In-Reply-To: <5848ff92c1388b7d6904e88b57bbfec8@codeaurora.org>
References: <9aec322678417753fe4022691f4bfdbe@codeaurora.org>
 <153897864285.119890.13024399324598460044@swboyd.mtv.corp.google.com>
 <5848ff92c1388b7d6904e88b57bbfec8@codeaurora.org>
Message-ID: <91594b8e6578d542dc7cbebf34458b0c@codeaurora.org>
X-Sender: psodagud@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-10 12:40, Sodagudi Prasad wrote:
> On 2018-10-07 23:04, Stephen Boyd wrote:
>> Quoting Sodagudi Prasad (2018-10-03 05:38:24)
>>> 
>>>          for (i = 0; i < chip->ngpio; i++, gpio++) {
>>> +               label = gpiochip_is_requested(chip, i);
>>> +               if (!label)
>>> +                       continue;
>>>                  msm_gpio_dbg_show_one(s, NULL, chip, i, gpio);
>>> -               seq_puts(s, "\n");
>>>          }
>>>   }
>>> 
>> 
>> Does something not work with the following code in
>> msm_gpio_dbg_show_one()?
>> 
>> 
>>         if (!gpiochip_line_is_valid(chip, offset))
>> 		return;
> 
> Hi Stephen,
> I didnt realize that these changes are merged on tip. I was testing on
> 4.14 kernel.
> 
> https://lore.kernel.org/patchwork/patch/878107/
> https://lore.kernel.org/patchwork/patch/878106/
> https://lore.kernel.org/patchwork/patch/878109/


Hi Stephen,

After checking this further, adding "gpio-reserved-ranges" in not good 
option. Because of the following reasons.
1) These gpio information changes from platform to platform. So need to 
maintain reserved-range properly for each platform.
2) Also some of the gpio can be changed to secure/protected gpio 
dynamically based on the use case.

It looks adding the "gpio-reserved-ranges" ranges is not good option for 
most of the platforms.

Can you please check the initial patch suggested in this thread? Please 
let me know if you have any other options for the above points.

-Thanks, Prasad

> 
> I will add "gpio-reserved-ranges" to internal platforms and this issue
> should not be observed.
> 
> -thanks, Prasad

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
Linux Foundation Collaborative Project
