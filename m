Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2E2C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7532D20850
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="HJvzuqKX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7532D20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbeH2Rhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 13:37:31 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43509 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727595AbeH2Rhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 13:37:31 -0400
Received: by mail-pf1-f196.google.com with SMTP id j26-v6so2281303pfi.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 06:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5QtQ7zGBkb1eA20RGuOvBiXwVtTHQothmntswN3hGKk=;
        b=HJvzuqKXUyxC8rG9BCFPqlit3zC7Qm6rt0GsLbgz6oL7hWeXKdkzBmQOA+YW2EJFe/
         67gJ7Sf9PelSpjBs9N972RNrdwiqaTTtWsyFJvn8NZYuXsqqBj/cp29eZkU0aRYczrUL
         ykgvyzWoRE7Pjj73dklVr+rMnWzIWctuO1uoTa/kLQuXWXPI/sawgVBsfQRTV2RkmcFP
         bm7UtSfdvtrwvNe6zusDKqkDhXikmCfp5gDWu15yaRqvDn1CsvsjUbdL/5WknEwEmtUz
         HlJfpJEENd+lhENxvG3k9tYjzj9S1bEuF4rvWPd1u0BpyrtoOWH5D86f+zQDjZwqQrG+
         ypOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5QtQ7zGBkb1eA20RGuOvBiXwVtTHQothmntswN3hGKk=;
        b=Bvf9ZHnXLhqhCD7wycq8Q317QrNMO/9r/GosvDc/NX77O11D86ztzBZNFjiB+QQj4k
         /1WYJKi8Nt8PwSDOZB5rgzjwPtVPMI0kyFmgvlwDu8fZ5hrFFVZW9lkMSzKhz7a+QS4r
         xgJT3pzSFs2mXiZaP2ipDpqFcZwD5kkiovQTez9ouYQXGpP83sO1B2YHdCDT73S51ZtF
         rGxSscZprXuAKReCT7wADTnmJFqZ6P5IgpoI506FuRTfZ4atvKFOPgOzRopLI8hrl9D0
         XiqghwFQ+uHRsCgEhaBo9SewGaFej5+LEiohrmyrA8hhpd7jsq4jfS9yp80Mh9UwD6Fy
         fQVA==
X-Gm-Message-State: APzg51B2iBlVY6U1uOGESgObnojEhBA4686m5delsK4ITcojoxus2A5E
        w+ImvayfkU4J+WBMBjze34vhVtk31NvSWw==
X-Google-Smtp-Source: ANB0VdZZ8RJ7xuBV7xKaAEmj9piwwAmFCXFYv3uTIzWalMLWC3xhxcKntQkW6Qsd+PXBIFoiqH7Lsg==
X-Received: by 2002:a62:a6cc:: with SMTP id r73-v6mr6048449pfl.60.1535550030498;
        Wed, 29 Aug 2018 06:40:30 -0700 (PDT)
Received: from [10.86.62.45] (rap-us.hgst.com. [199.255.44.250])
        by smtp.googlemail.com with ESMTPSA id s9-v6sm6816518pgc.16.2018.08.29.06.40.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 06:40:29 -0700 (PDT)
Subject: Re: [PATCH 3/3] lightnvm: pblk: take write semaphore on metadata
To:     javier@cnexlabs.com
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1535532980-27672-1-git-send-email-javier@cnexlabs.com>
 <1535532980-27672-4-git-send-email-javier@cnexlabs.com>
 <f4f8c276-0269-5aa5-39fc-42aecc7bb309@lightnvm.io>
 <0FD404FB-C660-412B-9658-454A9DCD7558@cnexlabs.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <1911b06f-ddb5-40fd-f822-702ae725bade@lightnvm.io>
Date:   Wed, 29 Aug 2018 15:40:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <0FD404FB-C660-412B-9658-454A9DCD7558@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/29/2018 03:21 PM, Javier Gonzalez wrote:
>> On 29 Aug 2018, at 15.08, Matias Bjørling <mb@lightnvm.io> wrote:
>>
>> On 08/29/2018 10:56 AM, Javier González wrote:
>>> pblk guarantees write ordering at a chunk level through a per open chunk
>>> semaphore. At this point, since we only have an open I/O stream for both
>>> user and GC data, the semaphore is per parallel unit.
>>> For the metadata I/O that is synchronous, the semaphore is not needed as
>>> ordering is guaranteed. However, if the metadata scheme changes or
>>> multiple streams are open, this guarantee might not be preserved.
>>> This patch makes sure that all writes go through the semaphore, even for
>>> synchronous I/O. This is consistent with pblk's write I/O model. It also
>>> simplifies maintenance since changes in the metadata scheme could cause
>>> ordering issues.
>>> Signed-off-by: Javier González <javier@cnexlabs.com>
>>> ---
>>>   drivers/lightnvm/pblk-core.c | 16 +++++++++++++++-
>>>   drivers/lightnvm/pblk.h      |  1 +
>>>   2 files changed, 16 insertions(+), 1 deletion(-)
>>> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
>>> index 767178185f19..1e4dc0c1ed88 100644
>>> --- a/drivers/lightnvm/pblk-core.c
>>> +++ b/drivers/lightnvm/pblk-core.c
>>> @@ -558,6 +558,20 @@ int pblk_submit_io_sync(struct pblk *pblk, struct nvm_rq *rqd)
>>>   	return ret;
>>>   }
>>>   +int pblk_submit_io_sync_sem(struct pblk *pblk, struct nvm_rq *rqd)
>>> +{
>>> +	struct ppa_addr *ppa_list;
>>> +	int ret;
>>> +
>>> +	ppa_list = (rqd->nr_ppas > 1) ? rqd->ppa_list : &rqd->ppa_addr;
>>> +
>>> +	pblk_down_page(pblk, ppa_list, rqd->nr_ppas);
>>
>> If the debug stuff is killed inside __pblk_down_page, then ppa_list
>> and rqd->nr_ppas does not need to be passed, and this function can be
>> inlined in its caller. Can we kill it? I'll make the patch if you
>> like.
> 
> Sounds good. Sure, please send - should I wait to resend this series?
> 

Will do. Yes, wait a bit. I'll post asap.
