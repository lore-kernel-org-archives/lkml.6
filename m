Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF9EC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 15:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBC322133F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 15:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XMaNJapB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBC322133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730172AbeK1CiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 21:38:21 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:56868 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729824AbeK1CiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 21:38:21 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wARFdDGR056627;
        Tue, 27 Nov 2018 09:39:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543333153;
        bh=VBzrOxJomFJOpPCiRjGS76oGZUxFt+AtpuIy/e7tFog=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=XMaNJapBczp0mOTQMZjqr21AocipyUNTzJAeiYGFhYhicwkoSFIXjPT/p3dnIu7jd
         Z3gVlyh+qf4mfCq+mxwszmY6ZxN1KFFNNkDLUBmZz/Xvu0noT79TW46YUvbPQdYFq8
         H90vdOIhUILtLJSQdBRQTUncbLvCb39jxRgW3cTU=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wARFdDB1019520
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Nov 2018 09:39:13 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 27
 Nov 2018 09:39:12 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 27 Nov 2018 09:39:12 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wARFd8fN001345;
        Tue, 27 Nov 2018 09:39:09 -0600
Subject: Re: [PATCH 08/17] soc: ti: pruss: Add a PRUSS irqchip driver for
 PRUSS interrupts
To:     David Lechner <david@lechnology.com>, <tony@atomide.com>
References: <1542886753-17625-1-git-send-email-rogerq@ti.com>
 <1542886753-17625-9-git-send-email-rogerq@ti.com>
 <af2f8ce3-923b-aa27-59b2-2ebb848c28c9@lechnology.com>
CC:     <robh+dt@kernel.org>, <bcousson@baylibre.com>,
        <ssantosh@kernel.org>, <ohad@wizery.com>,
        <bjorn.andersson@linaro.org>, <s-anna@ti.com>, <nsekhar@ti.com>,
        <t-kristo@ti.com>, <nsaulnier@ti.com>, <jreeder@ti.com>,
        <m-karicheri2@ti.com>, <woods.technical@gmail.com>,
        <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <5BFD651C.7020903@ti.com>
Date:   Tue, 27 Nov 2018 17:39:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <af2f8ce3-923b-aa27-59b2-2ebb848c28c9@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 26/11/18 23:17, David Lechner wrote:
> On 11/22/18 5:39 AM, Roger Quadros wrote:
>> From: Suman Anna <s-anna@ti.com>
>>
>> The Programmable Real-Time Unit Subsystem (PRUSS) contains an
>> interrupt controller (INTC) that can handle various system input
>> events and post interrupts back to the device-level initiators.
>> The INTC can support upto 64 input events with individual control
>> configuration and hardware prioritization. These events are mapped
>> onto 10 interrupt signals through two levels of many-to-one mapping
>> support. Different interrupt signals are routed to the individual
>> PRU cores or to the host CPU.
>>
>> The PRUSS INTC platform driver manages this PRUSS interrupt
>> controller and implements an irqchip driver to provide a Linux
>> standard way for the PRU client users to enable/disable/ack/
>> re-trigger a PRUSS system event. The system events to interrupt
>> channels and host interrupts relies on the mapping configuration
>> provided through a firmware resource table for now. This will be
>> revisited and enhanced in the future for a better interface. The
>> mappings will currently be programmed during the boot/shutdown
>> of the PRU.
> 
> Does this mapping table take up space in the PRU IRAM or DRAM? If
> so, that can be a problem on the AM18xx because it has such limited
> resources - every byte counts.

Currently the entire resource table is being placed in DRAM.
But that is only because the current rpmsg vdev implementation depends on the
rpmsg channel information and vring buffers to be in DRAM.

I think the right way is to split up the 2 things.
i.e. separate out rpmgs channel DRAM allocation from resource table
and don't copy the resource table to DRAM.

This way if there is no rpmsg channel in the resource table we won't eat
any DRAM.

I'm not sure if there are any bottlenecks. I will only know when I work on it.

> 
> Perhaps one way to simplify the mapping is to take out one of the
> two levels of mapping. All of the TRMs say that it is highly
> recommended to have a 1:1 mapping from channels to host interrupts.
> This part of the mapping could just be hard-coded in this driver.
> Then the mapping tables would just effectively mapping PRU system
> events to host interrupts.

We don't have to go this route if INTC map is not loaded in DRAM.

> 
>>
>> The PRUSS INTC module is reference counted during the interrupt
>> setup phase through the irqchip's irq_request_resources() and
>> irq_release_resources() ops. This restricts the module from being
>> removed as long as there are active interrupt users.
>>
>> The driver currently supports the AM335x SoC.
>>
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> Signed-off-by: Andrew F. Davis <afd@ti.com>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>   drivers/soc/ti/Makefile     |   2 +-
>>   drivers/soc/ti/pruss.h      |  29 +++
>>   drivers/soc/ti/pruss_intc.c | 572 ++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 602 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/soc/ti/pruss_intc.c
>>
> 
> ...
> 
>> diff --git a/drivers/soc/ti/pruss_intc.c b/drivers/soc/ti/pruss_intc.c
>> new file mode 100644
>> index 0000000..dde054b
>> --- /dev/null
>> +++ b/drivers/soc/ti/pruss_intc.c
>> @@ -0,0 +1,572 @@
> 
> ...
> 
>> +int pruss_intc_configure(struct pruss *pruss,
>> +             struct pruss_intc_config *intc_config)
>> +{
>> +    struct device *dev = pruss->dev;
>> +    struct pruss_intc *intc = to_pruss_intc(pruss);
>> +    int i, idx, ret;
>> +    s8 ch, host;
>> +    u64 sysevt_mask = 0;
>> +    u32 ch_mask = 0;
>> +    u32 host_mask = 0;
>> +    u32 val;
>> +
>> +    if (!intc)
>> +        return -EINVAL;
>> +
>> +    mutex_lock(&intc->lock);
>> +
>> +    /*
>> +     * configure channel map registers - each register holds map info
>> +     * for 4 events, with each event occupying the lower nibble in
>> +     * a register byte address in little-endian fashion
>> +     */
>> +    for (i = 0; i < ARRAY_SIZE(intc_config->sysev_to_ch); i++) {
>> +        ch = intc_config->sysev_to_ch[i];
>> +        if (ch < 0)
>> +            continue;
>> +
>> +        /* check if sysevent already assigned */
>> +        if (intc->config_map.sysev_to_ch[i] != -1) {
> 
> Perhaps define a macro for -1 so we know what it means?

sure.

cheers,
-roger
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
