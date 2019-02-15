Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C300DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 969E521B18
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rc+TAWv+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729462AbfBOTTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 14:19:36 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:47450 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfBOTTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 14:19:36 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1FJJHkw000815;
        Fri, 15 Feb 2019 13:19:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550258357;
        bh=TTB9+UpBcPw64jt3Ak3yB9DsSjg+ihJjBGgM7DmhxNo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=rc+TAWv+9wfjVByTYME+4eND8rDETSOiZFBBvQ3jQOczhLgL5UvIdx4qqiLqHKr71
         y+0PJCGGBfgmTgiahcedwdIsz2GRzylW02uuiQMsfSQEEQTFCEseQSxpEajpOHroD9
         2+zwFtCGa6jWSImISpeAxZbK7NKEHvSBm6nNovB0=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1FJJHlQ098938
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Feb 2019 13:19:17 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 15
 Feb 2019 13:19:16 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 15 Feb 2019 13:19:16 -0600
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1FJJCS5026922;
        Fri, 15 Feb 2019 13:19:14 -0600
Subject: Re: [PATCH v3 0/3] mach-omap2: handle autoidle denial
To:     Andreas Kemnade <andreas@kemnade.info>,
        Tony Lindgren <tony@atomide.com>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bcousson@baylibre.com>,
        <paul@pwsan.com>, <letux-kernel@openphoenux.org>
References: <20190116220429.9136-1-andreas@kemnade.info>
 <20190121195803.GH5544@atomide.com> <20190209195105.74bb9085@aktux>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <a3f9aa94-33c3-9f14-1656-5bee705b3537@ti.com>
Date:   Fri, 15 Feb 2019 21:19:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190209195105.74bb9085@aktux>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/2019 20:53, Andreas Kemnade wrote:
> On Mon, 21 Jan 2019 11:58:03 -0800
> Tony Lindgren <tony@atomide.com> wrote:
> 
>> * Andreas Kemnade <andreas@kemnade.info> [190116 14:04]:
>>> On the gta04 with a dm3730 omap_hdq does not work properly when the
>>> device enters lower power states. Idling uart1 and 2 is enough
>>> to show up that problem, if there are no other things enabled.
>>> Further research reveals that hdq iclk must not be turned off during
>>> transfers, also according to the TRM. That fact is also correctly described
>>> in the flags but the code to handle that is incomplete.
>>>
>>> To handle multiple users of a single ick, autoidle is disabled
>>> when a user of that ick requires that (has the OCPIF_SWSUP_IDLE))
>>>
>>> Changes v3:
>>> - replace CLK_IS_BASIC
>>>
>>> Changes v2:
>>> - uses spinlocks instead of mutexes
>>> - invert counter logic
>>> - check whether clock type is basic
>>
>> For this series it's best to merge it all via the
>> clock tree along with the related clock patches:
>>
>> Acked-by: Tony Lindgren <tony@atomide.com>
>>
> hmm, this is stalled. Have I missed any new objections?

Sorry, I've just been pretty busy as usual, queued up for 5.1 now, thanks.

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
