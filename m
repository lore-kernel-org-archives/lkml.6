Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11EAC31D64
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A2F20989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yuahOS1q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbfAUHN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:13:26 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33416 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728143AbfAUHNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:13:18 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0L7CvFu073936;
        Mon, 21 Jan 2019 01:12:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1548054777;
        bh=1MY2+aLxo+iQWNtqOUc8eCVRHprDMIc0zOaEbr27wQg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=yuahOS1qZlsJPXmhSwPvDweUePYI6MDLpbx3C+g72YnoykZ6h7vdBd0JyEqPf0HRp
         Hh2nJ0tWfuZq/fV9MjaGu9hCZtuXQ17IEgN7D//9XyZSIjeXo+v2NFVEbAy3OVFtr7
         jZZI7qwqrM4y0Vzgj9NJLtzGBtIQcuMYHZBOCSLQ=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0L7CvHY106296
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Jan 2019 01:12:57 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 21
 Jan 2019 01:12:54 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 21 Jan 2019 01:12:54 -0600
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0L7Cokg020788;
        Mon, 21 Jan 2019 01:12:51 -0600
Subject: Re: [PATCH v3 3/3] arm: omap_hwmod disable ick autoidling when a
 hwmod requires that
To:     Tony Lindgren <tony@atomide.com>,
        Andreas Kemnade <andreas@kemnade.info>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bcousson@baylibre.com>,
        <paul@pwsan.com>, <letux-kernel@openphoenux.org>
References: <20190116220429.9136-1-andreas@kemnade.info>
 <20190116220429.9136-4-andreas@kemnade.info>
 <20190118154807.GV5544@atomide.com> <20190118181827.7163bee4@aktux>
 <20190118183630.GX5544@atomide.com> <20190118203832.3be7975e@aktux>
 <20190118194536.GY5544@atomide.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <ed0928fc-add1-1f37-c907-89bf5133fc00@ti.com>
Date:   Mon, 21 Jan 2019 09:12:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190118194536.GY5544@atomide.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2019 21:45, Tony Lindgren wrote:
> * Andreas Kemnade <andreas@kemnade.info> [190118 19:39]:
>> Hi,
>>
>> On Fri, 18 Jan 2019 10:36:30 -0800
>> Tony Lindgren <tony@atomide.com> wrote:
>>
>> [...]
>>> til the next workaround.
>>>
>>>> That flags also causes the iclk being enabled/disabled
>>>> manually.
>>>
>>> Yes but SWSUP_IDLE for the interface clock to me currently
>>> just means:
>>>
>>> "manually enable and disable ocp interface clock"
>>>
>> well, if we want to manually disable it and not automatically,
>> we have to disable autoidle or it will be automatically disabled.
>>
>> Disabling it manually when it is already auto-disabled (by autoidle) is
>> just practically a no-op towards the clock.
> 
> OK I buy that :) It should be probably added to the patch
> description to make it clear what it changes.
> 
> Tero, any comments on this change?

Well, seeing the flag is pretty much only used for a handful of hwmods 
nowadays, it should be fine. OMAP3 PM should be tested with this change 
though, as there are couple of hwmods impacted on that platform. I 
wonder what happens to cpuidle when display is active...

-Tero

> 
>>> and with your changes it becomes:
>>>
>>> "manually enable and disable ocp interface clock and block
>>>   autoidle while in use".
>>>
>>> So aren't we now changing the way things behave in general
>>> for SWSUP_IDLE?
>>>
>> Yes, we are, so proper testing is needed. But If I read those comments
>> it was always intended this way but not fully implemented because it
>> appeared to be more work like needing a usecounter (which my patchset
>> also adds) for that autoidle flag.
> 
> OK yeah the use count seems necessary. I'll test here
> with my PM use cases.
> 
> Regards,
> 
> Tony
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
