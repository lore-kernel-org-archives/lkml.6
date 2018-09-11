Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857AFC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2943A2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:55:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2943A2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbeIKWz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 18:55:58 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33548 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbeIKWz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 18:55:58 -0400
Received: by mail-qk1-f196.google.com with SMTP id z78-v6so17338509qka.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 10:55:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eX40pw1gYlsecW+rcTLM1uBV+HJDFWvSB2IJl6ogqDA=;
        b=oKPtb1LtuHmEpyefmfEWRwVC/qYE5ATZffKHdsc29nVTmIr7r5QzaAeHyOIihox68V
         sIzPvdp2jbA2CKGD7ksV8QiCBu35U4eEZMPbT+PYj2pYaPAoWkrhyptr0hbHYazCfKVM
         T2fp/2ShqFQsCvPHsI7srYbnf97jghS43myBRUplG46cbLN6v6s1C/CZ8MjGi/8BJk64
         6FkvrI9VwTUFtO2HxkeqftzIA22zvYUCYWgoyZ+qafQD/zlkomQ+XymwRXDqPv27SwoC
         Ehmzj/jhQ74NOsFN+ZgFzM4TXlDezR7o8zN8hl6yK/u7BEPF2Ad9HNodO9SO/mJQz7Xg
         HNIw==
X-Gm-Message-State: APzg51CabiVSyDctN+dlXWyc1M2s8Ae5C3+MtrKbo64MyqWrrDQ+3pTs
        U2SmwDFREOjuNGXSOLrvZVidsA==
X-Google-Smtp-Source: ANB0VdblKEU5LqVYJmsvOWiA9W/eMN7xhITcZBIIrRvPIg2ZdmZ79asxrgbb30QA6l/GHJs5g8Hdew==
X-Received: by 2002:a37:5e03:: with SMTP id s3-v6mr20083773qkb.339.1536688532909;
        Tue, 11 Sep 2018 10:55:32 -0700 (PDT)
Received: from ?IPv6:2601:602:9802:a8dc::42c3? ([2601:602:9802:a8dc::42c3])
        by smtp.gmail.com with ESMTPSA id 63-v6sm10873965qkm.0.2018.09.11.10.55.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 10:55:31 -0700 (PDT)
Subject: Re: [PATCH] scsi: ibmvscsis: Fix a stringop-overflow warning
To:     "Bryant G. Ly" <bryantly@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>
Cc:     "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
        Michael Cyr <mikecyr@linux.vnet.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org,
        target-devel <target-devel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Prarit Bhargava <prarit@redhat.com>
References: <20180910223723.25357-1-labbott@redhat.com>
 <CAGXu5j+-RNeEr+FUc6maamvzYpY7W0VJ-yYGDHnFTuNPeOUMFw@mail.gmail.com>
 <36c9adee-fbe8-f58d-e407-bbd57fdb1959@linux.ibm.com>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <c62a8355-fa40-26dc-5353-68e6e65d8e3a@redhat.com>
Date:   Tue, 11 Sep 2018 10:55:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <36c9adee-fbe8-f58d-e407-bbd57fdb1959@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2018 07:34 AM, Bryant G. Ly wrote:
> On 9/10/18 6:30 PM, Kees Cook wrote:
> 
>> On Mon, Sep 10, 2018 at 3:37 PM, Laura Abbott <labbott@redhat.com> wrote:
>>> There's currently a warning about string overflow with strncat:
>>>
>>> drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c: In function 'ibmvscsis_probe':
>>> drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:3479:2: error: 'strncat' specified
>>> bound 64 equals destination size [-Werror=stringop-overflow=]
>>>    strncat(vscsi->eye, vdev->name, MAX_EYE);
>>>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>
>>> Switch to using strlcat which correctly accounts for lengths that
>>> are equal to the destination buffer.
>>>
>>> Signed-off-by: Laura Abbott <labbott@redhat.com>
>>> ---
>>>   drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
>>> index fac377320158..53d344d8dc43 100644
>>> --- a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
>>> +++ b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
>>> @@ -3475,7 +3475,7 @@ static int ibmvscsis_probe(struct vio_dev *vdev,
>>>                  vscsi->dds.window[REMOTE].liobn);
>>>
>>>          strcpy(vscsi->eye, "VSCSI ");
>>> -       strncat(vscsi->eye, vdev->name, MAX_EYE);
>>> +       strlcat(vscsi->eye, vdev->name, MAX_EYE);
>> Can this just get switched to snprintf() instead?
>>
>> snprintf(vscsi->eye, sizeof(vscsi->eye), "VSCSI%s", vdev->name);
> 
> Either works for me.
> 

I'll switch to the snprintf since that's cleaner.

>>
>>>          vscsi->dds.unit_id = vdev->unit_address;
>>>          strncpy(vscsi->dds.partition_name, partition_name,
>> And does this strncpy need a NUL-termination and/or trailing padding?
>>
> Yes, good catch, it does need NUL-termination.
> 

I can send that cleanup in a second patch.

> -Bryant
> 
> 

