Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAA4C6778A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 03:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 253BB20779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 03:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PJhaCcRV";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Mgw5m8l9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 253BB20779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387811AbeGWEGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 00:06:13 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51008 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbeGWEGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 00:06:13 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1FBE660BE1; Mon, 23 Jul 2018 03:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532315233;
        bh=fKRHmpveHnxqMdrFhKP9RdAadoPKpmpvBtNU4U6d2rI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PJhaCcRVs/ql3lASCcGYXqW4GdW39yurGfsXAReQDci2DEvGvuN1EfXGsc2hpPULj
         SecHVLVms+CPo9leqg12nHALP0+tWaz4OfsrcYdXJCMg+UN32v/K5MC/eiOs3bSGhd
         cAduHrkryNvZ/d88i6O1LOFhdR8j63DzxMKNCis0=
Received: from [10.206.24.39] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: asutoshd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 65EF660285;
        Mon, 23 Jul 2018 03:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532315230;
        bh=fKRHmpveHnxqMdrFhKP9RdAadoPKpmpvBtNU4U6d2rI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Mgw5m8l9FRn29N9uly5Os29hsyt1dD5Q7U95jd7ivyPio9NkboyDakgD3t+ZzOhtF
         HlwoilboxBVISrDJKJm6en5norOYvbj59Whm1sV07r7NJj6lqSGWJw1rz1nuW2K1sU
         Fj+MvT7KhTybwbu94YarYtvBnlZ4Zm4KLygRmV+M=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 65EF660285
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=asutoshd@codeaurora.org
Subject: Re: [PATCH v1 7/9] scsi: ufs: add UFS power collapse support during
 hibern8
To:     Subhash Jadavani <subhashj@codeaurora.org>
Cc:     cang@codeaurora.org, vivek.gautam@codeaurora.org,
        rnayak@codeaurora.org, vinholikatti@gmail.com,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        linux-kernel@vger.kernel.org
References: <cover.1530880006.git.asutoshd@codeaurora.org>
 <13f4fbc290b5e3cfea95f49d65ddb2bf99a15cdb.1530880007.git.asutoshd@codeaurora.org>
 <e14fff20f9464677967fac6d9c5b905c@codeaurora.org>
From:   "Asutosh Das (asd)" <asutoshd@codeaurora.org>
Message-ID: <8607cabf-e6ae-0a53-2139-d2279d458a9c@codeaurora.org>
Date:   Mon, 23 Jul 2018 08:37:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <e14fff20f9464677967fac6d9c5b905c@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/2018 5:28 AM, Subhash Jadavani wrote:
> On 2018-07-06 05:30, Asutosh Das wrote:
>> From: Subhash Jadavani <subhashj@codeaurora.org>
>>
>> UFS host controller hardware may allow the host controller
>> to be power collapsed when UFS link is hibern8 state, this
>> change allows the UFS host controller to be power collapsed
>> during hibern8.
>>
>> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
>> Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
>> Signed-off-by: Can Guo <cang@codeaurora.org>
>> Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
>> ---
>>  drivers/scsi/ufs/ufshcd.c |  8 ++++++--
>>  drivers/scsi/ufs/ufshcd.h | 13 ++++++++++++-
>>  2 files changed, 18 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
>> index 40d9c35..50588cf 100644
>> --- a/drivers/scsi/ufs/ufshcd.c
>> +++ b/drivers/scsi/ufs/ufshcd.c
>> @@ -7673,13 +7673,17 @@ static int ufshcd_vreg_set_hpm(struct ufs_hba 
>> *hba)
>>
>>  static void ufshcd_hba_vreg_set_lpm(struct ufs_hba *hba)
>>  {
>> -    if (ufshcd_is_link_off(hba))
>> +    if (ufshcd_is_link_off(hba) ||
>> +        (ufshcd_is_link_hibern8(hba)
>> +         && ufshcd_is_power_collapse_during_hibern8_allowed(hba)))
>>          ufshcd_setup_hba_vreg(hba, false);
> 
> I guess we have to handle the UFS host controller power collapse via 
> "power-domains" which would requires us to specify the "power-domains" 
> attribute under UFS controller's DT node and then linux core power 
> framework should automatically collapse the UFS controller post runtime 
> suspend. This also means we can't power collapse UFS controller 
> aggressively (as part of clock gating) but it should still be fine from 
> power point of view.
> 
>>  }
>>
>>  static void ufshcd_hba_vreg_set_hpm(struct ufs_hba *hba)
>>  {
>> -    if (ufshcd_is_link_off(hba))
>> +    if (ufshcd_is_link_off(hba) ||
>> +        (ufshcd_is_link_hibern8(hba)
>> +         && ufshcd_is_power_collapse_during_hibern8_allowed(hba)))
>>          ufshcd_setup_hba_vreg(hba, true);
>>  }
>>
>> diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
>> index f79a639..8c5f987 100644
>> --- a/drivers/scsi/ufs/ufshcd.h
>> +++ b/drivers/scsi/ufs/ufshcd.h
>> @@ -728,7 +728,12 @@ struct ufs_hba {
>>       * to do background operation when it's active but it might degrade
>>       * the performance of ongoing read/write operations.
>>       */
>> -#define UFSHCD_CAP_KEEP_AUTO_BKOPS_ENABLED_EXCEPT_SUSPEND (1 << 5)
>> +#define UFSHCD_CAP_KEEP_AUTO_BKOPS_ENABLED_EXCEPT_SUSPEND (1 << 6)
>> +    /*
>> +     * If host controller hardware can be power collapsed when UFS 
>> link is
>> +     * in hibern8 then enable this cap.
>> +     */
>> +#define UFSHCD_CAP_POWER_COLLAPSE_DURING_HIBERN8 (1 << 7)
>>
>>      struct devfreq *devfreq;
>>      struct ufs_clk_scaling clk_scaling;
>> @@ -764,6 +769,12 @@ static inline bool
>> ufshcd_is_hibern8_on_idle_allowed(struct ufs_hba *hba)
>>      return hba->caps & UFSHCD_CAP_HIBERN8_ENTER_ON_IDLE;
>>  }
>>
>> +static inline bool ufshcd_is_power_collapse_during_hibern8_allowed(
>> +                        struct ufs_hba *hba)
>> +{
>> +    return !!(hba->caps & UFSHCD_CAP_POWER_COLLAPSE_DURING_HIBERN8);
>> +}
>> +
>>  static inline bool ufshcd_is_intr_aggr_allowed(struct ufs_hba *hba)
>>  {
>>  /* DWC UFS Core has the Interrupt aggregation feature but is not 
>> detectable*/
> 

Thanks. I'll check the 'power-domains' part and get back with the changes.


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project
