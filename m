Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AAB9ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 13:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E14DD2087A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 13:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0SE2N0m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E14DD2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbeJSVO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 17:14:56 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35776 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbeJSVOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 17:14:55 -0400
Received: by mail-pg1-f194.google.com with SMTP id 32-v6so4576929pgu.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 06:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KHRIKNLG6lHCHIonKfrJGppRkGzac/7mJE+cWwlOEgA=;
        b=Y0SE2N0mNWK3+nYxmMyH15kRnSt/2m3SNd9ukMS/1KQHf+ong51AQ6m72l6KHDIeyZ
         vQklNSQjUSUP9KuGtHigADqqoxgxKjLcb4lZnrm+vnssTinXL6ouNf/xE3R5xvId2LPG
         /aqimo+hu+0cRfvmzwZJQrfoW0eO5IKpJC47wg+CGtSf/lDKtIGztoXiAgIECBpqJvov
         IyCAl2u40uRyGVn+cyknjLPEDwAmFYvMVMA31XwsuQIC7YD3x2nFiVFSIcNsc0FS9kT/
         Sda/eGA+OdM9RVj3USR7e5R7sPlHbTjutd3UBLpoRg9xY7b9ayCfmYgCAsH0gptBJCqH
         JAAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KHRIKNLG6lHCHIonKfrJGppRkGzac/7mJE+cWwlOEgA=;
        b=S05sSTVGJx9C803HmvEWH0k5f5Enmj/FkGWSPPT3JiwTh57G1PgZivRcL/paAMu04I
         Beul69fkv/Fuyovhz7zCbYMp9wZHyR5GKVnSZVeDFKCbSaEQ6/dkm7DWrf5lG+5KKymh
         JTf5+oazscbdRunkJ4GycX8Xi39nAHPI15GkV+BMrXgG+cmuii8s22SEA7XfUsIN2Ae7
         ld4A30MR9o/oLoOcaErAsmnAVwtGDYv8zByP3UsvSoUyEwFvjNbu1901+jnx7SibKpRg
         wPkWjeZx4XPPwpXbWBKLV48FgnTsBBou6IyRTXM5ok73VR6uUtduDrLWcUHSVmjWmYx9
         xH0w==
X-Gm-Message-State: ABuFfogY+Jdywcyt7K2/VMcQ/eygjgLmY8BunXk5gMzRa0siOqVIJQpS
        YT8Wmy1wtZl17N/1N6e/dMI=
X-Google-Smtp-Source: ACcGV60Lhe/IBQw+BDLgBxrkLlyA0hpUTuD7wxYWSfVIkWbN7QLdqNBkIh4oL7+PW486KWlxQ/N4xw==
X-Received: by 2002:a63:df03:: with SMTP id u3-v6mr13442769pgg.362.1539954531272;
        Fri, 19 Oct 2018 06:08:51 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id n87-v6sm33426428pfb.62.2018.10.19.06.08.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 06:08:50 -0700 (PDT)
Subject: Re: [PATCH] amdgpu/gmc : fix compile warning
To:     "Koenig, Christian" <Christian.Koenig@amd.com>,
        Peng Hao <peng.hao2@zte.com.cn>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Martin Peres <martin.peres@linux.intel.com>
References: <022e41c0-8465-dc7a-a45c-64187ecd9684@amd.com>
 <4772f72c-6018-3556-6324-5f49faa00073@roeck-us.net>
 <4da23fcb-4a94-2695-ad80-929025e84bd2@gmail.com>
 <c72a23ea-efea-4c0e-d397-623d6ac16ebb@roeck-us.net>
 <c43669b7-1074-714c-fb22-81685826b3ad@amd.com>
 <74078dc6-ef08-586b-fd58-51eb2c0b5060@roeck-us.net>
 <BN6PR12MB1809E1A07CD1B5B0F41273EBF7E60@BN6PR12MB1809.namprd12.prod.outlook.com>
 <c6880c5b-e259-4923-8d5a-80c620563398@amd.com>
 <20181008174628.GB11442@roeck-us.net>
 <4a1faa3b-8c42-b742-9b55-9d2711f7ecc1@amd.com>
 <20181019085308.GY31561@phenom.ffwll.local>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <8081f60d-ef19-14a5-a589-874afc050d94@roeck-us.net>
Date:   Fri, 19 Oct 2018 06:08:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181019085308.GY31561@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/2018 01:53 AM, Daniel Vetter wrote:
> On Mon, Oct 08, 2018 at 06:13:56PM +0000, Koenig, Christian wrote:
>> Am 08.10.2018 um 19:46 schrieb Guenter Roeck:
>>> On Mon, Oct 08, 2018 at 05:22:24PM +0000, Koenig, Christian wrote:
>>>> Am 08.10.2018 um 17:57 schrieb Deucher, Alexander:
>>>>>>>> One thing I found missing in the discussion was the reference to the
>>>>>>>> C standard.
>>>>>>>> The C99 standard states in section 6.7.8 (Initialization) clause 19:
>>>>>>>> "... all
>>>>>>>> subobjects that are not initialized explicitly shall be initialized
>>>>>>>> implicitly the same as objects that have static storage duration".
>>>>>>>> Clause 21 makes further reference to partial initialization,
>>>>>>>> suggesting the same. Various online resources, including the gcc
>>>>>>>> documentation, all state the same. I don't find any reference to a
>>>>>>>> partial initialization which would leave members of a structure
>>>>>>>> undefined. It would be interesting for me to understand how and why
>>>>>>>> this does not apply here.
>>>>>>>>
>>>>>>>> In this context, it is interesting that the other 48 instances of the
>>>>>>>> { { 0 } } initialization in the same driver don't raise similar
>>>>>>>> concerns, nor seemed to have caused any operational problems.
>>>>>>> Feel free to provide patches to replace those with memset().
>>>>>>>
>>>>>> Not me. As I see it, the problem, if it exists, would be a violation of the C
>>>>>> standard. I don't believe hacking around bad C compilers. I would rather
>>>>>> blacklist such compilers.
>>>> Well then you would need to blacklist basically all gcc variants of the
>>>> last decade or so.
>>>>
>>>> Initializing only known members of structures is a perfectly valid
>>>> optimization and well known issue when you then compare the structure
>>>> with memcpy() or use the bytes for hashing or something similar.
>>>>
>>> Isn't that about padding ? That is a completely different issue.
>>
>> Correct, yes. But that is the reason why I recommend using memset() for
>> zero initialization.
>>
>> See we don't know the inner layout of the structure, could be another
>> structure or an union.
>>
>> If it's a structure everything is fine because if you initialize one
>> structure member all other get their default type (whatever that means),
>> but if it's an union.....
>>
>> Not sure if compilers still react allergic to that, but its the status
>> I've learned the hard way when the C99 standard came out and it still
>> seems like people are working around that so I recommend everybody to
>> stick with memset().
> 
> Went boom:
> 
> https://bugs.freedesktop.org/show_bug.cgi?id=108490
> 

What went boom ? This patch wasn't accepted, and I don't immediately see
the correlation of the suggested revert with the rejected patch.

Guenter

> Can we revert?
> 
> Also, can we properly igt this so that intel-gfx-ci could test this before
> it's all fireworks?
> 
> Thanks, Daniel
> 

