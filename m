Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2389FC43444
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E95BB217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bFnd1jcy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbeLSRpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 12:45:15 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33738 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727594AbeLSRpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 12:45:15 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBJHjDdn086872;
        Wed, 19 Dec 2018 11:45:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1545241513;
        bh=oMTBmI41UCtrM2O4Cfk5EhcU2gOAv2ntVbTkXbM0c5k=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=bFnd1jcyf4GWgAlNJrY00G1xNJEYixTc/G/lAnhyHQux3fdMTSkq/CVUPIXlRFmAE
         iMyDyLmIBCpJadk7l4D1iAFIbCWFcA4K+LYmYHwsqtCLHkuh+tw/B4KlxQ2CosfCrG
         5m0vhYfV0xdbe2EQGryRoZFWhDqQ+jliA8CHxaYk=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBJHjDoQ106840
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Dec 2018 11:45:13 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 19
 Dec 2018 11:45:13 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 19 Dec 2018 11:45:13 -0600
Received: from [172.22.106.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBJHjDaJ011586;
        Wed, 19 Dec 2018 11:45:13 -0600
Subject: Re: [PATCH v2 3/4] iio: ti-ads8688: Update buffer allocation for
 timestamps
To:     Jonathan Cameron <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>
References: <20181211191207.21900-1-dmurphy@ti.com>
 <20181211191207.21900-3-dmurphy@ti.com> <20181216110639.3eb2e7b9@archlinux>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <15ee14f7-773d-5cd2-a6f5-6731dc284df6@ti.com>
Date:   Wed, 19 Dec 2018 11:45:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181216110639.3eb2e7b9@archlinux>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/2018 05:06 AM, Jonathan Cameron wrote:
> On Tue, 11 Dec 2018 13:12:06 -0600
> Dan Murphy <dmurphy@ti.com> wrote:
> 
>> Per Jonathan Cameron, the buffer needs to allocate room for a
>> 64 bit timestamp as well as the channels.  Change the buffer
>> to allocate this additional space.
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> Same question around data types as in the previous patch.
> 
> If you can track down the original patch that introduced the bug and add
> add a fixes tag, that would be great as well.  This one should go into
> stable.

I will git blame it and call it out.

> 
> Thanks,
> 
> Jonathan
>> ---
>>
>> v2 - New patch suggested change by maintainer - https://lore.kernel.org/patchwork/patch/1021048/
>>
>>  drivers/iio/adc/ti-ads8688.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/adc/ti-ads8688.c b/drivers/iio/adc/ti-ads8688.c
>> index 184d686ebd99..3597bc0697ee 100644
>> --- a/drivers/iio/adc/ti-ads8688.c
>> +++ b/drivers/iio/adc/ti-ads8688.c
>> @@ -385,7 +385,7 @@ static irqreturn_t ads8688_trigger_handler(int irq, void *p)
>>  {
>>  	struct iio_poll_func *pf = p;
>>  	struct iio_dev *indio_dev = pf->indio_dev;
>> -	u16 buffer[8];
>> +	unsigned short buffer[8 + sizeof(s64)/sizeof(short)];
> Why change from a well defined size of data to one that is only
> defined by the c spec to be no more than the size of an int?

I took the define from the ina2xx-adc I will change it back to the u16.

Dan

> 
>>  	int i, j = 0;
>>  
>>  	for (i = 0; i < indio_dev->masklength; i++) {
> 


-- 
------------------
Dan Murphy
