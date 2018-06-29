Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB912C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 03:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 842B127A60
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 03:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEd6hRwz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 842B127A60
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967706AbeF2DAW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 23:00:22 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33329 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967683AbeF2DAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 23:00:19 -0400
Received: by mail-pl0-f66.google.com with SMTP id 6-v6so3732955plb.0;
        Thu, 28 Jun 2018 20:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FH/mPJaCf7DA+dZ6YzcaN+VECXdGgiVRWwt/b03kPHY=;
        b=JEd6hRwzsntY4lsPa/t5JKDubwuOAGIQ8M3WMC0FyKx5Rn1Jomhgdfizdv3L+Rvo6B
         jrf6oKjrO/Cx7TDhtei2mAlCkgevX0QVNAHYJI6pdxfuTea43YJRjVxPi07LwpHRmfEJ
         f5ErilU58o/fkgXQQj6dCFDWJtZBHU0FLKsXf0m0jkhUTJiHSQEmhFHnXVijyepku+H4
         6jbEynoPjevUepGTj/wudU6SoxCTPW/9o3i0I10++f97c2+kq4g2IKeM4HxhiUEqJqHj
         10MsmFmU11aowZ4zQMC9DxR3xxcVURtLp4lOFI0GFGcWV/zjRwWmBJc7D5YeoP0/t7/v
         paCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FH/mPJaCf7DA+dZ6YzcaN+VECXdGgiVRWwt/b03kPHY=;
        b=ao/lMSUbk3I7bEYxup8qHJF/CiTOrmU4Zcv3I73zOOCr/u+EghZiZj5lQbRqbrvkrL
         yDIsLfs1HJ3cXhGsMFZE9wrFsO9QWsJ4fk7/ARUawAFgqlO33FBU5Sk5R43LyTanNnWe
         po8ATuEd0E4KRCJYiPu2RQWY0Chab/1etlzIhnc5lF1V/ZGbPT2OhxouqQ92FrifcHGo
         XMrIG9peM4tQNKFyzDLOQAo+GtxbUdICuqWlUfbtxhYTLP7iaIdCFQ+htQmex/yn0QvL
         Nv1qN8DmwrHA130wYycVvKHtj6ljzaxbPYNsyTB0JJYYJUMWPobRvilAPD7/ewek2Rkl
         Av+w==
X-Gm-Message-State: APt69E2dH++WFOQuMQc7BkgJnvPK/iudekCz/2zDkd8TaDtjscQmzwq+
        eZ4Kak6Kw8JwSEi1H2qfVZk=
X-Google-Smtp-Source: ADUXVKLMem6q+ZQfV1CDG6T7SBGcwPri761DZyouCZINuPH8mq3VgkBPUZLCM2aIykzFVTS0Ko+E7g==
X-Received: by 2002:a17:902:7446:: with SMTP id e6-v6mr13139814plt.161.1530241219122;
        Thu, 28 Jun 2018 20:00:19 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id k10-v6sm21251622pfj.29.2018.06.28.20.00.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 20:00:17 -0700 (PDT)
Subject: Re: [PATCH v4 1/6] Documentation: DT: Consolidate SP805 binding docs
To:     Ray Jui <ray.jui@broadcom.com>
Cc:     Rob Herring <robh@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
References: <1527530497-10392-2-git-send-email-ray.jui@broadcom.com>
 <20180605194124.GA26885@rob-hp-laptop>
 <e91c75f3-f7a4-6f51-9911-7e22d5d05084@roeck-us.net>
 <CABGGisxEvWDy16SKE2RG-vhUHBZHSCCHyfwJsPY16B1fQS-=cA@mail.gmail.com>
 <09c870cd-0a44-6634-58d8-f57f9fcd0cb5@broadcom.com>
 <46ca340f-4347-94ca-6463-d38bece820e2@broadcom.com>
 <20180627183327.GD16753@roeck-us.net>
 <a18733e2-be06-4ea9-dbfb-1d4f756a97e7@broadcom.com>
 <20180627184234.GA19538@roeck-us.net>
 <8483f675-0c7d-4b0f-25fd-a5eff4bc7937@broadcom.com>
 <20180627185529.GB19743@roeck-us.net>
 <42b856bf-2dc1-f69b-44e1-f5a04715f673@broadcom.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <08e99a9e-1d87-f8c3-f566-73ef8cbf1111@roeck-us.net>
Date:   Thu, 28 Jun 2018 20:00:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <42b856bf-2dc1-f69b-44e1-f5a04715f673@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/28/2018 04:50 PM, Ray Jui wrote:
> Hi Guenter/Florian,
> 
> On 6/27/2018 11:55 AM, Guenter Roeck wrote:
>> On Wed, Jun 27, 2018 at 11:47:21AM -0700, Ray Jui wrote:
>>>
>>>
>>> On 6/27/2018 11:42 AM, Guenter Roeck wrote:
>>>> On Wed, Jun 27, 2018 at 11:38:48AM -0700, Ray Jui wrote:
>>>>>
>>>>>
>>>>> On 6/27/2018 11:33 AM, Guenter Roeck wrote:
>>>>>> On Wed, Jun 20, 2018 at 10:39:16AM -0700, Ray Jui wrote:
>>>>>>> Hi Guenter/Rob,
>>>>>>>
>>>>>>> Kindly let me know how you want to proceed with this?
>>>>>>>
>>>>>>
>>>>>> If I recall correctly, the patch series does not add a new problem
>>>>>> but merely exposes one. Is my recollection correct ? If so, maybe
>>>>>> we should just add a note somewhere indicating what might be wrong
>>>>>> and otherwise apply the series.
>>>>>>
>>>>>> Does this make sense ?
>>>>>
>>>>> Yes this makes a lot of sense to me. This patch series exposes potential
>>>>> problems in some SoCs that they might not be feeding the correct clock into
>>>>> WDT, at least based on clock names from their DT entries.
>>>>>
>>>>> This patch series does not change/affect how SP805 works on those systems.
>>>>>
>>>>> Where should the note be added?
>>>>>
>>>>
>>>> I would suggest to add a note into the driver where the clock is used,
>>>> with the details discussed here.
>>>
>>> I assume you meant adding the notes to the SP805 driver where the clock is
>>> used.
>>>
>>> If so, I think that makes sense. That notes deserves its own patch because
>>> it really has nothing to do with any of the change in this patch series.
>>>
>>> Do you want me to 1) embed that patch into this patch series and send out
>>> v5; or 2) leave the patch series as it is and send out a separate patch to
>>> add the notes to the driver?
>>>
>> 2) is fine. I don't have the series here right now; if I recall correctly
>> all patches in the series are all marked as Reviewed-by: and/or Acked-by:.
>> If so, I'll apply them to my tree tonight, or at least the ones that will
>> go in through the watchdog tree.
>>
>> Guenter
>>
> 
> Guenter, please let us know once you take the first 4 patches.
> 

Patches are in my tree. Wim, it would be great if you can pick up the tree
so it shows up in -next.

Thanks,
Guenter

> Florian, could you please help with the last 2, once Guenter confirmed the first 4 are merged.
> 
> Thanks!
> 
> Ray
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

