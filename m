Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90615C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 08:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51A03205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 08:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Ott2O7JU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51A03205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbeK2T4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 14:56:35 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:42322 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbeK2T4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 14:56:35 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAT8p7iV046970;
        Thu, 29 Nov 2018 02:51:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543481467;
        bh=sBLXjLUdLISmYEYTrO0R5UkJZ4wVDS+GJ1QX8LYc0XM=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=Ott2O7JUCZYW/lovljzCBWdhe2ONinbGbb6N+yN2yaKCo6BRmytNlwVp7ne36FjVd
         6SO8uvJvc1IpiSpQqikI2FHkKf4eNn9aGggD6NDll9Y5CrM3i/SnRj/oMc9Zp1ExwG
         LGehsnfAsh89hXEQ+JIZ9qActLBU2N5staakn3Ls=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAT8p740112393
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Nov 2018 02:51:07 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 29
 Nov 2018 02:51:06 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 29 Nov 2018 02:51:06 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAT8p2Ln020902;
        Thu, 29 Nov 2018 02:51:02 -0600
Subject: Re: [PATCH 02/16] remoteproc: Add a rproc_set_firmware() API
To:     David Lechner <david@lechnology.com>, <ohad@wizery.com>,
        <bjorn.andersson@linaro.org>
References: <1543218769-5507-1-git-send-email-rogerq@ti.com>
 <1543218769-5507-3-git-send-email-rogerq@ti.com>
 <ee68d58b-24ff-f7b2-aa62-f1e73e078516@lechnology.com>
CC:     <tony@atomide.com>, <robh+dt@kernel.org>, <bcousson@baylibre.com>,
        <ssantosh@kernel.org>, <s-anna@ti.com>, <nsekhar@ti.com>,
        <t-kristo@ti.com>, <nsaulnier@ti.com>, <jreeder@ti.com>,
        <m-karicheri2@ti.com>, <woods.technical@gmail.com>,
        <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <5BFFA875.6020002@ti.com>
Date:   Thu, 29 Nov 2018 10:51:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <ee68d58b-24ff-f7b2-aa62-f1e73e078516@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/11/18 23:41, David Lechner wrote:
> On 11/26/18 1:52 AM, Roger Quadros wrote:
>> From: Suman Anna <s-anna@ti.com>
>>
>> A new API, rproc_set_firmware() is added to allow the remoteproc platform
>> drivers and remoteproc client drivers to be able to configure a custom
>> firmware name that is different from the default name used during
>> remoteproc registration. This function is being introduced to provide
>> a kernel-level equivalent of the current sysfs interface to remoteproc
>> client drivers. This allows some remoteproc drivers to choose different
>> firmwares at runtime when the remote processor is not running based on
>> the functional feature it is providing using that remote processor.
>> The TI PRU Ethernet driver will be an example of such usage as it
>> requires to use different firmwares for different supported protocols.
>>
>> Also, update the firmware_store() function used by the sysfs interface
>> to reuse this function to avoid code duplication.
>>
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> ---
>>   drivers/remoteproc/remoteproc_core.c  | 61 +++++++++++++++++++++++++++++++++++
>>   drivers/remoteproc/remoteproc_sysfs.c | 33 ++-----------------
>>   include/linux/remoteproc.h            |  1 +
>>   3 files changed, 64 insertions(+), 31 deletions(-)
>>
>> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
>> index 39458a7..581e6e8 100644
>> --- a/drivers/remoteproc/remoteproc_core.c
>> +++ b/drivers/remoteproc/remoteproc_core.c
>> @@ -2151,6 +2151,67 @@ void rproc_report_crash(struct rproc *rproc, enum rproc_crash_type type)
> 
> ...
> 
>> +int rproc_set_firmware(struct rproc *rproc, const char *fw_name)
>> +{
>> +    struct device *dev = rproc->dev.parent;
>> +    int ret, len;
>> +    char *p;
>> +
>> +    if (!rproc || !fw_name)
>> +        return -EINVAL;
>> +
>> +    ret = mutex_lock_interruptible(&rproc->lock);
>> +    if (ret) {
>> +        dev_err(dev, "can't lock rproc %s: %d\n", rproc->name, ret);
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (rproc->state != RPROC_OFFLINE) {
>> +        dev_err(dev, "can't change firmware while running\n");
>> +        ret = -EBUSY;
>> +        goto out;
>> +    }
>> +
>> +    len = strcspn(fw_name, "\n");
>> +    if (!len) {
>> +        dev_err(dev, "can't provide a NULL firmware\n");
> 
> I realize this was just copied, but technically, this would be an
> empty string rather than NULL.
> 
Noted. Thanks.

cheers,
-roger
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
