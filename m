Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA52C282C5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 06:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C09720861
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 06:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CNmKYxod"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfAVG02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 01:26:28 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:55692 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfAVG01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 01:26:27 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0M6Q3XN029465;
        Tue, 22 Jan 2019 00:26:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1548138363;
        bh=e8jXkpB/T+CjRVM7qysk0BQ16HfDyopHE4oMPrDIJAs=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=CNmKYxodv/4fuI7weHVuc4vzMKpJfBqfPF3rdyZ0p2vxI2DvHKeNwEe9XXq5riL3Q
         54xfsVRJBU8NxNuI0pe8Y+My3QAWHVnWDSMSfoRB/41kn1M4f9Vi4N9/g4Vdcw/08k
         84z4RmC98JuVN1ctTDktmVx+kp0kR8NEDLd394aw=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0M6Q2lO099069
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Jan 2019 00:26:02 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 22
 Jan 2019 00:26:02 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 22 Jan 2019 00:26:02 -0600
Received: from [172.24.191.45] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0M6Pwut027309;
        Tue, 22 Jan 2019 00:25:59 -0600
Subject: Re: [Letux-kernel] [PATCH v3 3/3] arm: omap_hwmod disable ick
 autoidling when a hwmod requires that
From:   Keerthy <j-keerthy@ti.com>
To:     Andreas Kemnade <andreas@kemnade.info>
CC:     Tony Lindgren <tony@atomide.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, <paul@pwsan.com>,
        <sboyd@kernel.org>, <mturquette@baylibre.com>,
        <linux-kernel@vger.kernel.org>, <t-kristo@ti.com>,
        <bcousson@baylibre.com>, <linux-omap@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
References: <20190116220429.9136-1-andreas@kemnade.info>
 <20190116220429.9136-4-andreas@kemnade.info>
 <20190118154807.GV5544@atomide.com> <20190118181827.7163bee4@aktux>
 <20190118183630.GX5544@atomide.com> <20190118203832.3be7975e@aktux>
 <20190118204204.44db353f@aktux> <20190118194802.GZ5544@atomide.com>
 <c2c283c5-d1f7-8b65-a19b-0c4af80b722a@ti.com> <20190119081211.73844b6a@aktux>
 <dd7f4d9f-4036-5fc2-995e-c3dae6e69aff@ti.com>
Message-ID: <f7a46583-b6ac-a125-c8ab-e36fa80fe693@ti.com>
Date:   Tue, 22 Jan 2019 11:56:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <dd7f4d9f-4036-5fc2-995e-c3dae6e69aff@ti.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/01/19 1:28 PM, J, KEERTHY wrote:
> 
> 
> On 1/19/2019 12:42 PM, Andreas Kemnade wrote:
>> On Sat, 19 Jan 2019 12:09:48 +0530
>> "J, KEERTHY" <j-keerthy@ti.com> wrote:
>>
>>> On 1/19/2019 1:18 AM, Tony Lindgren wrote:
>>>> * Andreas Kemnade <andreas@kemnade.info> [190118 19:42]:
>>>>> On Fri, 18 Jan 2019 20:38:47 +0100
>>>>> Andreas Kemnade <andreas@kemnade.info> wrote:
>>>>>  
>>>>>> Hi,
>>>>>>
>>>>>> On Fri, 18 Jan 2019 10:36:30 -0800
>>>>>> Tony Lindgren <tony@atomide.com> wrote:
>>>>>>
>>>>>> [...]
>>>>>>> til the next workaround.
>>>>>>>      
>>>>>>>> That flags also causes the iclk being enabled/disabled
>>>>>>>> manually.
>>>>>>>
>>>>>>> Yes but SWSUP_IDLE for the interface clock to me currently
>>>>>>> just means:
>>>>>>>
>>>>>>> "manually enable and disable ocp interface clock"
>>>>>>>       
>>>>>> well, if we want to manually disable it and not automatically,
>>>>>> we have to disable autoidle or it will be automatically disabled.
>>>>>>
>>>>>> Disabling it manually when it is already auto-disabled (by
>>>>>> autoidle) is
>>>>>> just practically a no-op towards the clock.
>>>>>>  
>>>>>>> and with your changes it becomes:
>>>>>>>
>>>>>>> "manually enable and disable ocp interface clock and block
>>>>>>>    autoidle while in use".
>>>>>>>
>>>>>>> So aren't we now changing the way things behave in general
>>>>>>> for SWSUP_IDLE?
>>>>>>>       
>>>>>> Yes, we are, so proper testing is needed. But If I read those
>>>>>> comments
>>>>>> it was always intended this way but not fully implemented because it
>>>>>> appeared to be more work like needing a usecounter (which my patchset
>>>>>> also adds) for that autoidle flag.
>>>>>>   
>>>>> and there are quite few hwmods marked by this flag.
>>>>> And then there are those clocks marked by this flags (on am33xx) which
>>>>> do not have that autoidle feature at all, so the risk is not too high.
>>>>
>>>> Keerthy, can you please test this series on top of the
>>>> related clock patches with your am335x PM test cases?
>>>
>>> Can you point me to the clock series that needs to be tested
>>> along with this?
>>>
>>
>> https://patchwork.kernel.org/project/linux-clk/list/?series=66691
> 
> Thanks Andreas. I will test both series and get back.

Tested for DS0 (deeps sleep 0 on am33/am43 boards) No issues seen with
the current patch series on top of clock series.

Tested-by: Keerthy <j-keerthy@ti.com>

> 
>>
>> Regards,
>> Andreas
>>

