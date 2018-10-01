Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB25C64EB0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44D0F2084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bnXVTrr9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44D0F2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbeJAPkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 11:40:07 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53940 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728808AbeJAPkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 11:40:07 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9193LCx045046;
        Mon, 1 Oct 2018 04:03:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1538384601;
        bh=srxNRncv3K7ExcezVfds4+hUWcqT+AimforFf6UWJOw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=bnXVTrr9RCpx0cnsUUE6WNMEZhXn9fLLPlOmqicfxGiYG7rphekIIo1Wt0rp4wG19
         z/LfDUc0FpIYDr8pZvv8pYgoKZayiUJRDGGBsTBIzhTqkwEMHo87pYNHAFm+zL+MtO
         hENIx0y1z+KAPjj4AR5bK3SxHCpCYvae140jY+oM=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9193LWx001611;
        Mon, 1 Oct 2018 04:03:21 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 1 Oct
 2018 04:03:21 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 1 Oct 2018 04:03:21 -0500
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9193IHf025267;
        Mon, 1 Oct 2018 04:03:18 -0500
Subject: Re: [PATCH] clk: ti: fix OF child-node lookup
To:     Stephen Boyd <sboyd@kernel.org>, Johan Hovold <johan@kernel.org>
CC:     Michael Turquette <mturquette@baylibre.com>,
        <linux-omap@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20180822090319.29167-1-johan@kernel.org>
 <153566556601.129321.16962771053169973395@swboyd.mtv.corp.google.com>
 <9a80b925-a36e-3895-f91b-4716d5524249@ti.com>
 <153815024975.119890.6463829001501352147@swboyd.mtv.corp.google.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <6a81ed51-765d-e0b5-0baa-67774d536e1d@ti.com>
Date:   Mon, 1 Oct 2018 12:03:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <153815024975.119890.6463829001501352147@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/18 18:57, Stephen Boyd wrote:
> Quoting Tero Kristo (2018-09-20 00:11:08)
>> On 31/08/18 00:46, Stephen Boyd wrote:
>>> Quoting Johan Hovold (2018-08-22 02:03:19)
>>>> Fix child-node lookup which by using the wrong OF helper was searching
>>>> the whole tree depth-first, something which could end up matching an
>>>> unrelated node.
>>>>
>>>> Also fix the related node-reference leaks.
>>>>
>>>> Fixes: 5b385a45e001 ("clk: ti: add support for clkctrl aliases")
>>>> Signed-off-by: Johan Hovold <johan@kernel.org>
>>>> ---
>>>
>>> Applied to clk-next
>>>
>>
>> Stephen, this patch causes a merge conflict with some of the code I am
>> planning to send a pull-req against (the clkctrl work series:
>> https://patchwork.kernel.org/project/linux-clk/list/?series=13841)
>>
>> Would it be possible to drop this from clk-next, and for me to
>> pick-it-up via my own branch? I can get this setup either today or tomorrow.
>>
>> Alternatively I need an immutable branch against which I can work.
>>
> 
> clk-ti-of-node is immutable. You can base on top of that and send a PR.
> Does that work for you?

That should work just fine for me.

I'll work on top of this and send a pull-req, thanks.

-Tero


--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
