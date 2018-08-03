Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC60C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7308A2175E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="hW1fKqkJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7308A2175E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729909AbeHCOgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 10:36:03 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40578 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728198AbeHCOgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 10:36:03 -0400
Received: by mail-lj1-f194.google.com with SMTP id j19-v6so4816517ljc.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 05:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yAiGYM8ZqFECE4IsLkNUTsZwYEzxiDv7Me9zw3iaBSA=;
        b=hW1fKqkJSvarWVWbpPbNp+FXcxEVw08cds9I0mR0glCr7HbD9LahkMh7+VeONQtMuT
         0tfJDO3zHaTavfox5H78GKe+6LETXxXRY090hh2SxDExTeoWCTtxI/xlZKqBt07QD+kS
         V0jVBZ/uJwJrmyQlxFrIOZJ8q69l1keqottbMxnAYdgkyj9f+Z+3DEM1fGMPV922H6i0
         GKSISpzpN187qQcqofJ2uJdGOBgZfMrfZnrqDYeTyWcNf+JCa7rh2g7n/7c5noDC6CQo
         9i0nRWsGoR3uZVL4WBlDm2JhL9RCtH8XVLQy+4l3ukOFI5edO+apb9ohazaqX7MtMigl
         W/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yAiGYM8ZqFECE4IsLkNUTsZwYEzxiDv7Me9zw3iaBSA=;
        b=Rng7TehEt92EMutMe4jchRrQ0upKICRd9wdWP2pbMD4cL5PxEvymOyNEaYEQ/mkQGf
         hB3fv0sqj4EVkY29WmkU9mhIJKBUvjwZSl0jaa4Kxsdoy0uYpP85PR0KrWAXThWqwDhl
         B9+IwTyce55BQuQI4RbVhVJ5AKn0K+2pr2Ept0lHhB30CBFpCtzhI+yZjNrj3NWYUwZ5
         csTvAtrgqUV2WZSb8tcoHJqerd3xVitsgd1TjCLJGrvV/tHWjtBrKNSumhy2Bc1QWLMr
         eyfn0if58qnBdFtuYa5m/DSQ50ZY+Bp74OnGCr37V0J0Ay0q9rTd/gDlYxGMj5+Ch2Te
         /XTQ==
X-Gm-Message-State: AOUpUlECp1o6BdIvUhIaEb8MdPeM/Ydv3X7fcLOXFjrVMzIbtlLZwyB7
        1264mv2efIGPCxFVKdhl1PPW3U46MVE8BQ==
X-Google-Smtp-Source: AAOMgpc1cvWXhZ5L1fCxGBi6i4As9gBh6bu0l3L/3ulVdZeJJazWQWw8K5/a95UFHGaaki1BJBo6xw==
X-Received: by 2002:a2e:1b83:: with SMTP id c3-v6mr5305509ljf.0.1533299991880;
        Fri, 03 Aug 2018 05:39:51 -0700 (PDT)
Received: from [192.168.0.10] (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.googlemail.com with ESMTPSA id d12-v6sm712532lfg.15.2018.08.03.05.39.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 05:39:51 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: pblk: remove unnecessary drive version check
To:     javier@cnexlabs.com
Cc:     igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        hans.holmberg@cnexlabs.com, hlitz@ucsc.edu,
        youngtack.jin@circuitblvd.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180802205841.22039-1-mb@lightnvm.io>
 <4382FFAE-0602-4A16-8120-E930141606ED@cnexlabs.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <130c689a-723f-a32a-96e3-a7a59ff6b7b8@lightnvm.io>
Date:   Fri, 3 Aug 2018 14:39:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <4382FFAE-0602-4A16-8120-E930141606ED@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2018 02:18 PM, Javier Gonzalez wrote:
>> On 2 Aug 2018, at 22.58, Matias Bjørling <mb@lightnvm.io> wrote:
>>
>> The nvme driver checks for 1.2 and 2.0 compatibility. If an unsupported
>> version is reported, the device will not be initialized.
>>
>> Signed-off-by: Matias Bjørling <mb@lightnvm.io>
>> ---
>> drivers/lightnvm/pblk-init.c | 8 --------
>> 1 file changed, 8 deletions(-)
>>
>> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
>> index 537e98f2b24a..e9e2fedff387 100644
>> --- a/drivers/lightnvm/pblk-init.c
>> +++ b/drivers/lightnvm/pblk-init.c
>> @@ -1202,14 +1202,6 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
>> 	pblk->state = PBLK_STATE_RUNNING;
>> 	pblk->gc.gc_enabled = 0;
>>
>> -	if (!(geo->version == NVM_OCSSD_SPEC_12 ||
>> -					geo->version == NVM_OCSSD_SPEC_20)) {
>> -		pblk_err(pblk, "OCSSD version not supported (%u)\n",
>> -							geo->version);
>> -		kfree(pblk);
>> -		return ERR_PTR(-EINVAL);
>> -	}
>> -
>> 	if (geo->version == NVM_OCSSD_SPEC_12 && geo->dom & NVM_RSP_L2P) {
>> 		pblk_err(pblk, "host-side L2P table not supported. (%x)\n",
>> 							geo->dom);
>> --
>> 2.11.0
> 
> The same comment goes for this patch. pblk does support 2.0 and 1.2
> today, but it is not guaranteed it will support a new revision straight
> away. So I think that a check wither here or through the .capabilities I
> proposed on the other patch is necessary.
> 

Works for me. I'll send another patch that enables pblk target to tell 
which version it supports.
