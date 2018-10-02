Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F98C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C43AF206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iV1dFkDV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C43AF206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbeJBVtx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 17:49:53 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44692 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728755AbeJBVtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 17:49:53 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w92F5xWj127853;
        Tue, 2 Oct 2018 10:05:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1538492759;
        bh=/S4P3S2Wi5sTSHL0dEhr56FzgAgKDp3pZIDIEAKczEw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=iV1dFkDV6s9ZvkICazYwaNfenA+ElXn7OXPZQrZsjMxweBVR6CXPYcbBqd/IdJJBw
         puapaWj5PHJOZlMES2Mjd06NtOrChzyWtZ1RUFLj+kk3R27WtYqPeiXkl4c0Bg6fo5
         7ZfhaWspqrQjT7PHm0RnDX/t+yQgbJ8UT+f2zxPo=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w92F5xKT020640;
        Tue, 2 Oct 2018 10:05:59 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 2 Oct
 2018 10:05:59 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 2 Oct 2018 10:05:59 -0500
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w92F5wUa024715;
        Tue, 2 Oct 2018 10:05:58 -0500
Subject: Re: [PATCH 2/5] remoteproc: Check for NULL firmwares in sysfs
 interface
To:     Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Ohad Ben-Cohen <ohad@wizery.com>,
        Loic Pallardy <loic.pallardy@st.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20180915003725.17549-1-s-anna@ti.com>
 <20180915003725.17549-3-s-anna@ti.com>
 <a74114d9-e4d6-3f13-add8-2025d0d320f8@st.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <505f8177-9e27-d864-6355-2bc4171abf47@ti.com>
Date:   Tue, 2 Oct 2018 10:05:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <a74114d9-e4d6-3f13-add8-2025d0d320f8@st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaud,

On 10/02/2018 04:43 AM, Arnaud Pouliquen wrote:
> Hi Suman,
> 
> On 09/15/2018 02:37 AM, Suman Anna wrote:
>> The remoteproc framework provides a sysfs file 'firmware'
>> for modifying the firmware image name from userspace. Add
>> an additional check to ensure NULL firmwares are errored
>> out right away, rather than getting a delayed error while
>> requesting a firmware during the start of a remoteproc
>> later on.
>>
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> ---
>>  drivers/remoteproc/remoteproc_sysfs.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
>> index 2142b3ea726e..ce93f4d710f3 100644
>> --- a/drivers/remoteproc/remoteproc_sysfs.c
>> +++ b/drivers/remoteproc/remoteproc_sysfs.c
>> @@ -49,6 +49,11 @@ static ssize_t firmware_store(struct device *dev,
>>  	}
>>  
>>  	len = strcspn(buf, "\n");
>> +	if (!len) {
>> +		dev_err(dev, "can't provide a NULL firmware\n");
>> +		err = -EINVAL;
>> +		goto out;
>> +	}

> This patch fixes only the case of a null name but not a bad name. So I'm
> not one hundred percent sure that it is relevant, as it treats only a
> part of the problem. But it's fine with me if it is accepted.

Yeah, it is a minor fix catching only NULL names. There is no way for
the interface to know a bad name until the corresponding firmware is
requested.

regards
Suman

> 
> Tested-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> 
> Regards
> Arnaud
> 
>>  
>>  	p = kstrndup(buf, len, GFP_KERNEL);
>>  	if (!p) {
>>

