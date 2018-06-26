Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E3FC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 11:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55FAE269F7
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 11:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="ZOvYE23/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55FAE269F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934834AbeFZLoh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 07:44:37 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:36194 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933794AbeFZLof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 07:44:35 -0400
Received: by mail-io0-f196.google.com with SMTP id k3-v6so15683431iog.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 04:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+bnJt8OSZ5Bzhi5QtgO5Cr8muhePOpbSyqauzyBQR1s=;
        b=ZOvYE23/tmzMjDvqSaXl4rp3tU6CmgIn1r+LbZd+glIkzySU0LPeJ0gDcbM0f3IeEG
         Bnd2mJkxJgs28FJp+UigfIwnMIkHXFvsT3EcAL7RQ3MnLp5SX8gxQUjsyJaKv4UT+WFW
         3EJUEdNZEb76SGRaFhP5t/rmieNik9ioYgabVsVtbIP2Iuy0vbWiT3RxTeusWCW5W4bb
         55EnR2BfxxSbyNr5h3q+VXih2kDdBjKbLnycEA5y6wTyIWkxqUN/pYW6BNt8uIY8tqVo
         1vnyLCzwx6MZALXpWlclZHlk+9ohJZwJqwExJVnzLj0dhQQqMx9+SopCIipjbgHkDQAf
         X7eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+bnJt8OSZ5Bzhi5QtgO5Cr8muhePOpbSyqauzyBQR1s=;
        b=iLhXBkFCfflk2Nc1QXnpdp6RIaWx38wrnH9Ly8qwLXVuPQqi1ctEG+lnMqfzuRZhMW
         zo4cddcr9/Rq5K77nrVgZpJNPyOhhS/1FrEcfI5LL11MYM8jiK2vdViA0xL3fV3icwl3
         GJO7PIV8AbPDGkYF/ZMac8S9j47cuZg6k2nvTCH6SpEHFPK3eCeN7nyTdBAsZxhIuiHc
         Qw+SgjO2wz15BCOm2swlkBZUQc/aNpbloqcYMtFRsp5YX6Ey++K1jyKMCsBdEDH4qd7x
         jwNU9YJmsa5uI0A+PEe3u92sUFWiKxYg+hDGVzZj8wOAdiCO8tmDswhEwxiUH5j8hlsz
         tExA==
X-Gm-Message-State: APt69E2SAqL6gfz/Hgnkoh9aBJ3MRlW5/6Xwp9Ekv95+yfGQhk2SIwMi
        hPs79TzllTI5NsXZpplU7zo84w==
X-Google-Smtp-Source: AAOMgpdTwtz8Gt0TdjgQooV5CmWl/ZWU0I0s3COAQol+hIE0b+42wmVLVCIzvPINoZihWZh7zUhUxA==
X-Received: by 2002:a5e:860f:: with SMTP id z15-v6mr939729ioj.73.1530013474247;
        Tue, 26 Jun 2018 04:44:34 -0700 (PDT)
Received: from [10.86.48.245] (rap-us.hgst.com. [199.255.44.250])
        by smtp.googlemail.com with ESMTPSA id e124-v6sm621387ite.1.2018.06.26.04.44.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 04:44:33 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: pblk: assume that chunks are closed on 1.2
 devices
To:     hans.ml.holmberg@owltronix.com
Cc:     javier@cnexlabs.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, hans.holmberg@cnexlabs.com
References: <1529399189-3239-1-git-send-email-hans.ml.holmberg@owltronix.com>
 <a2bb1959-5244-f8af-b747-6d87e8d456a4@lightnvm.io>
 <1612C143-24C3-4B6F-B745-945EAF684DFC@cnexlabs.com>
 <ed909bcb-8e91-7e6d-521e-b5f36db61efa@lightnvm.io>
 <CANr-nt3Qzp-brMa16NAVa=E6eRCfpNyV44cmRoaxYUV0J7zStA@mail.gmail.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <4bcd22df-3899-fc87-d558-27754befae5e@lightnvm.io>
Date:   Tue, 26 Jun 2018 13:44:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <CANr-nt3Qzp-brMa16NAVa=E6eRCfpNyV44cmRoaxYUV0J7zStA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/26/2018 01:31 PM, Hans Holmberg wrote:
> On Tue, Jun 26, 2018 at 1:38 PM, Matias Bjørling <mb@lightnvm.io> wrote:
>> On 06/26/2018 11:37 AM, Javier Gonzalez wrote:
>>>
>>>
>>>
>>>> On 26 Jun 2018, at 10.41, Matias Bjørling <mb@lightnvm.io> wrote:
>>>>
>>>> On 06/19/2018 11:06 AM, Hans Holmberg wrote:
>>>>>
>>>>> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
>>>>> We can't know if a block is closed or not on 1.2 devices, so assume
>>>>> closed state to make sure that blocks are erased before writing.
>>>>> Fixes: 32ef9412c114 ("lightnvm: pblk: implement get log report chunk")
>>>>> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
>>>>> ---
>>>>> This patch applies on:
>>>>> ssh://github.com/OpenChannelSSD/linux branch for-4.19/core
>>>>>    drivers/lightnvm/pblk-init.c | 5 +++--
>>>>>    1 file changed, 3 insertions(+), 2 deletions(-)
>>>>> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
>>>>> index aa24264..3b8aa4a 100644
>>>>> --- a/drivers/lightnvm/pblk-init.c
>>>>> +++ b/drivers/lightnvm/pblk-init.c
>>>>> @@ -717,10 +717,11 @@ static int pblk_setup_line_meta_12(struct pblk
>>>>> *pblk, struct pblk_line *line,
>>>>>                  /*
>>>>>                   * In 1.2 spec. chunk state is not persisted by the
>>>>> device. Thus
>>>>> -                * some of the values are reset each time pblk is
>>>>> instantiated.
>>>>> +                * some of the values are reset each time pblk is
>>>>> instantiated,
>>>>> +                * so we have to assume that the block is closed.
>>>>>                   */
>>>>>                  if (lun_bb_meta[line->id] == NVM_BLK_T_FREE)
>>>>> -                       chunk->state =  NVM_CHK_ST_FREE;
>>>>> +                       chunk->state =  NVM_CHK_ST_CLOSED;
>>>>>                  else
>>>>>                          chunk->state = NVM_CHK_ST_OFFLINE;
>>>>>
>>>>
>>>> pblk should scan (or the lightnvm subsystem) the blocks for their
>>>> state, such that it doesn't have to reinitialize a full drive if it is
>>>> already in a closed state. If marking closed, it does a full erase
>>>> cycle on initialization, which should be avoided since it is a limited
>>>> resource.
>>>
>>>
>>> In 1.2 there is no such state unfortunately. However, pblk will never
>>> attempt to reinitialize the whole drive - metadata for closed blocks
>>> will be recovered and only those going to GC will be erased before
>>> usage. In fact, a full close drive is the state pblk expects.
>>>
>>> This patch only affects "unknown blocks", thus the only case in which
>>> pblk would attempt to double erase is when blocks have been pre-erased
>>> (e.g., factory or through liblightnvm). After an erase round though,
>>> pblk will only erase pre-usage. One thing we could do is attempting to
>>> read the first page of these unknown blocks and mark them as free if
>>> "empty page" is returned. Is this what you mean?
>>
>>
>> Yes, that is what I mean.
>>
>> Note that this can be
>>>
>>> costly on large drives; this is the reason we returned to the pre-2.0
>>> behaviour with this patch. We are implementing a log that, among other
>>> things, keeps the state so that pblk can have an accurate state for the
>>> cases this can be a problem.
>>
>>
>> Yep, it will take some time. Good to hear with the log.
> 
> Until we have a log in place, this patch unbreaks 1.2 support and has
> no negative impact on performance (as compared to pre 2.0 support), so
> please consider it for the next window.
> The current state is that if a pblk instance is created on a 1.2 disk
> with written blocks, writes will fail.
> 
>   / Hans
> 

The negative impact is that all blocks are erased, even if they are in 
free state. This is a showstopper. We cannot throw out 1/X of the 
lifetime of the drive on each initialization. The 1.2 spec is made such 
that a scan can recover the block state accurately.
