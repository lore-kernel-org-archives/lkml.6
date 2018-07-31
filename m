Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E21C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C413208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="m17HQBVt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C413208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732493AbeGaQaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 12:30:04 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:47160 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732304AbeGaQaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 12:30:04 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6VEnKKa061015;
        Tue, 31 Jul 2018 09:49:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1533048560;
        bh=aPEGFHdu55XJhPhFY1YN5NkfoVaTe3SBQ4Z7fcqMBKc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=m17HQBVtF6kWklB9aMzjJrDOz0GGpNDigxSZw1fQMcjP+6iWKQLQe2vPwnD13nlwV
         ZiqHyMsaXUqG3LLN5tIOG51GWEa8cxqxPSe0pJnrGjnb9qJEYSEi3FBW3GUr4P2m3Q
         k8Vs3Z3z0iC4jmSemkQFJHmShpaPTHq5gjaN8VAs=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6VEnJEH022540;
        Tue, 31 Jul 2018 09:49:20 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 31
 Jul 2018 09:49:19 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 31 Jul 2018 09:49:19 -0500
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6VEnJmH026042;
        Tue, 31 Jul 2018 09:49:19 -0500
Subject: Re: [PATCH] remoteproc: Reset table_ptr in rproc_start() failure
 paths
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Ohad Ben-Cohen <ohad@wizery.com>,
        Loic Pallardy <loic.pallardy@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20180727011535.21729-1-s-anna@ti.com>
 <20180731041559.GC5090@builder>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <aba8605f-86e0-c50b-680c-2d5602c25a03@ti.com>
Date:   Tue, 31 Jul 2018 09:49:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180731041559.GC5090@builder>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/30/2018 11:15 PM, Bjorn Andersson wrote:
> On Thu 26 Jul 18:15 PDT 2018, Suman Anna wrote:
> 
>> Unwind the modified table_ptr and restore it to the local copy
>> upon any subsequent failures in the rproc_start() function. This
>> keeps the function to remain balanced on failures without the need
>> to balance any modified variables elsewhere.
>>
> 
> Good catch.
> 
>> While at this, do some minor cleanup of the extra lines between
>> the failure labels as well.
>>
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> ---
>>  drivers/remoteproc/remoteproc_core.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
>> index eadff6ce2f7f..afef2d491c5b 100644
>> --- a/drivers/remoteproc/remoteproc_core.c
>> +++ b/drivers/remoteproc/remoteproc_core.c
>> @@ -953,7 +953,7 @@ static int rproc_start(struct rproc *rproc, const struct firmware *fw)
>>  	if (ret) {
>>  		dev_err(dev, "failed to prepare subdevices for %s: %d\n",
>>  			rproc->name, ret);
>> -		return ret;
>> +		goto reset_table_ptr;
>>  	}
>>  
>>  	/* power up the remote processor */
>> @@ -979,10 +979,11 @@ static int rproc_start(struct rproc *rproc, const struct firmware *fw)
>>  
>>  stop_rproc:
>>  	rproc->ops->stop(rproc);
>> -
>>  unprepare_subdevices:
>>  	rproc_unprepare_subdevices(rproc);
>> -
>> +reset_table_ptr:
>> +	if (loaded_table)
> 
> Regardless of us having a loaded_table it should have the same value as
> cached_table when we return - which might be NULL if we don't have a
> resource table.
> 
> So I applied this without the conditional, please object if I missed
> something.

Yeah, that's fine. I added the conditional only to keep it symmetric,
it gets modified only if loaded_table was non-NULL in the first place,
and is pointing to the cached_table otherwise.

regards
Suman

> 
> Regards,
> Bjorn
> 
>> +		rproc->table_ptr = rproc->cached_table;
>>  	return ret;
>>  }
>>  
>> -- 
>> 2.18.0
>>

