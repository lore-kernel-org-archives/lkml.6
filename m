Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE205C46470
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 08:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86EFB21748
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 08:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="GjYmp1oO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86EFB21748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbeHEKdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 06:33:12 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:36881 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbeHEKdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 06:33:12 -0400
Received: by mail-qt0-f194.google.com with SMTP id n6-v6so10654107qtl.4
        for <linux-kernel@vger.kernel.org>; Sun, 05 Aug 2018 01:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VJSDojTbzMjrBPtqDBh+7R3BGWy6nWura0YGmFUimfo=;
        b=GjYmp1oOPO5028EUT+E7YeOg9dnG+T3qdSL6Hd5amTeUVWrsBqpsaIJaF5KUs9GkKJ
         PiD+R5KD945ecbICy9d7Ye65kFueUlYpoi1ucVfLIf6HFGC+GHe3PZtz6Z3D3C53yeED
         vs1TA6zCqDovPfuwLZSg7acjEmyyc145KWkHnAnt5KHo+n0HZOdVy1R3+nd8XMv4M2RS
         fQg4jAjz/yakxBNi94QmHyhyodPqazWMFUaqO0Y8wgQMPZB1n9ZI56Pz0AHrQweOf1zt
         jyt9tt9U4LvMJvnSNGN0uGPUc6w6M9I+L0IrT8eib7RcRP01iAsswPaOu3PHqCIhIbvz
         bLDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VJSDojTbzMjrBPtqDBh+7R3BGWy6nWura0YGmFUimfo=;
        b=N4tTah09OxWrjYHKoPcU4YAL3rNYHIa2uQDqF5xiBH+usY7xWZvzpVPVG46sDyuWQ+
         5f9612fyFOyYfwDE3SeyZiUiEponoRg4YZDDH/QfRPVUtsFtRXhC/kSiIGwBvSET43D0
         QGYucPHIqwEsQZdblFdY6XE43YrQarL+BwekcMKsRiExO13SeXxmgHwPymDglRPwcrKp
         t1gVmsRXoRwBEzs7hF93KkDvlpkRk2PM8SL6p2Koe+LSzdehT/iVTIULNrSM7uT4irXx
         kfnX3VunkUg5SrZkQpS20YAboLflOu/alQd98iLVxA4k+Zo8d2kZTm3Ojx9j0NmPglMC
         SxCQ==
X-Gm-Message-State: AOUpUlFCFSjsf751FeaKwhQN9GTM8dZ/7YMSnxulZN0cWZur2TLRf0Pn
        r360o5f9iVH/voR8adk4C96VtmIjhEM=
X-Google-Smtp-Source: AAOMgpcXMy3uY02aN4/CIINpm/QLkfq8apScGkDki5dGp3jPzJXEtmFpuE2HF3aLNVD4i+elGt/wDA==
X-Received: by 2002:aed:35bd:: with SMTP id c58-v6mr10105497qte.155.1533457765331;
        Sun, 05 Aug 2018 01:29:25 -0700 (PDT)
Received: from C02VV2HXHV2Q.local ([217.63.102.42])
        by smtp.gmail.com with ESMTPSA id s53-v6sm8731584qts.5.2018.08.05.01.29.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Aug 2018 01:29:24 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: remove minor version check for 2.0
To:     axboe@kernel.dk
Cc:     Javier Gonzalez <javier@cnexlabs.com>,
        "Konopko, Igor J" <igor.j.konopko@intel.com>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        Heiner Litz <hlitz@ucsc.edu>,
        Young Tack Tack Jin <youngtack.jin@circuitblvd.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180803090237.2022-1-mb@lightnvm.io>
 <7B08AEC1-90F8-4AE0-AE46-BADF8CC8D270@cnexlabs.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <2f1d5972-3257-22e0-efd7-0038f979f438@lightnvm.io>
Date:   Sun, 5 Aug 2018 10:29:21 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <7B08AEC1-90F8-4AE0-AE46-BADF8CC8D270@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/18 2:07 PM, Javier Gonzalez wrote:
>> On 3 Aug 2018, at 11.02, Matias Bjørling <mb@lightnvm.io> wrote:
>>
>> A minor version number increase should not break backwards
>> compatibility.
>>
>> Fixes: 3cb98f84d368b ("lightnvm: add minor version to generic geometry")
>> Signed-off-by: Matias Bjørling <mb@lightnvm.io>
>> ---
>> drivers/nvme/host/lightnvm.c | 6 ------
>> 1 file changed, 6 deletions(-)
>>
>> diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
>> index d9e4cccd5b66..a156fe3ca7d3 100644
>> --- a/drivers/nvme/host/lightnvm.c
>> +++ b/drivers/nvme/host/lightnvm.c
>> @@ -414,12 +414,6 @@ static int nvme_nvm_setup_20(struct nvme_nvm_id20 *id,
>> 	/* Set compacted version for upper layers */
>> 	geo->version = NVM_OCSSD_SPEC_20;
>>
>> -	if (!(geo->major_ver_id == 2 && geo->minor_ver_id == 0)) {
>> -		pr_err("nvm: OCSSD version not supported (v%d.%d)\n",
>> -				geo->major_ver_id, geo->minor_ver_id);
>> -		return -EINVAL;
>> -	}
>> -
>> 	geo->num_ch = le16_to_cpu(id->num_grp);
>> 	geo->num_lun = le16_to_cpu(id->num_pu);
>> 	geo->all_luns = geo->num_ch * geo->num_lun;
>> --
>> 2.11.0
> 
> Looks good to me.
> 
> Reviewed-by: Javier González <javier@cnexlabs.com>
> 

Hi Jens,

Would it be possible to pick this one up for 4.19?

Thank you!
