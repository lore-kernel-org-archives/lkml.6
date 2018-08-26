Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4170C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 02:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A0F320A8B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 02:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LaDid5Ov"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A0F320A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbeHZGLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 02:11:53 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40397 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbeHZGLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 02:11:53 -0400
Received: by mail-pl1-f194.google.com with SMTP id s17-v6so2638402plp.7;
        Sat, 25 Aug 2018 19:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DrsiFBVl5rxJ1W9225DocJmNFgk0nfkx8kkanUwY60I=;
        b=LaDid5OvpC0UusglW9g8kftJv5YxSokqnFWcggVqcLFDYCoiVvTxM06R1nWHJCDu8v
         BHgKmWZAlR5zEvGejPalCExg5Z/xHQxyhZBrsURlj9A+Mz/PwS8VZiUTj0QtQw7gRCDa
         R9CDOnZQzwGW3wQlaIbDHH23WY73farQJcu56pW9WDIxTKCqpmfBMah4bkbXRcgyac2Z
         eV8HhbaxMH77Scz+pLqk2isb5+gCaPzKr6noReOCQh16zGaN6DoENMqokuNzArx4jezp
         ECKaYTrljxl55KB0jgTWL3Wl73hPGg+dz0PkPORjfJBm92ssL88Q0iFHOEGEZ3plyoPK
         5DzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DrsiFBVl5rxJ1W9225DocJmNFgk0nfkx8kkanUwY60I=;
        b=HghrD9mfJ4mvNddifFu5inEk+9OyTDdrd1ZxHQdQxQn+N4AHfdKC+DYlekoGWrMgrG
         MCaSVKjOLzQTwfqQHC92DBcMELjR+R6MMCBgeubyut0Z7DInnBHwHJ+2KinVKt+LoT1f
         +Pdd3iKXuIefXh1r7SulJxTd517y88Y5mZf4RK6Ak8O1jvh0Wn5E5oL9WtGUEO7ctlhC
         4FWjas8VN9OcZspqmnOCb/4BYs8p1aD5uX4SBYVIR2/G8GNv9fGTuyIkMalMHYEfc2pG
         PHQW4vS/hZIuawQwYefmJAr2P0kbdB1IoNqj0+SLXeYlfwjVUdBsKGCkBbAPrJ19Vfgo
         aXbQ==
X-Gm-Message-State: APzg51BBX4dkcpIY9MC08s7CPsYO3bGQox78agbpjRizkuiHfs6W5VrG
        YsAOWPNCy/EpRqIKodviByU=
X-Google-Smtp-Source: ANB0VdabZCgM648is1vUyr3rJJAL8wK+7ZtkSlTpLQBn89Cx4SeQl1pH9YdlL2uc0n4bAeNR8iudjA==
X-Received: by 2002:a17:902:8d91:: with SMTP id v17-v6mr7738228plo.9.1535250657286;
        Sat, 25 Aug 2018 19:30:57 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id z11-v6sm16224838pff.162.2018.08.25.19.30.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Aug 2018 19:30:56 -0700 (PDT)
Subject: Re: [PATCH 4.4 103/105] Revert "x86/mm/pat: Ensure cpa->pfn only
 contains page frame numbers"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Roland Dreier <roland@purestorage.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        matt@codeblueprint.co.uk, bp@suse.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>, luto@kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>, bp@alien8.de,
        brgerst@gmail.com, davej@codemonkey.org.uk, dvlasenk@redhat.com,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        sai.praneeth.prakhya@intel.com, sds@tycho.nsa.gov,
        Thomas Gleixner <tglx@linutronix.de>, toshi.kani@hp.com,
        linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Yazen.Ghannam@amd.com
References: <20171215092305.994559179@linuxfoundation.org>
 <20171215092311.347628971@linuxfoundation.org>
 <CAL1RGDVgShymmT+TJ3mAHEL7n+qoisk6mQ=Tji_T=0d_QA=VKw@mail.gmail.com>
 <1535129126.2902.36.camel@codethink.co.uk>
 <CAL1RGDW1Lo+F5D479Jsi-AFsmjVpdDre_qOFSCwWubG6U=bxeQ@mail.gmail.com>
 <20180824191749.GA15489@kroah.com>
 <CAL1RGDXUx-frpWuuYyc-VrAEoOU2+irGQPRWvoBzO2ZxEPGrww@mail.gmail.com>
 <35e0f79b-6fac-5027-6377-67dbe2a293b9@roeck-us.net>
 <20180825150723.GA10230@kroah.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <c2e61e43-6cd5-567a-8c3c-3cc3ff456c31@roeck-us.net>
Date:   Sat, 25 Aug 2018 19:30:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180825150723.GA10230@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/25/2018 08:07 AM, Greg Kroah-Hartman wrote:
> On Sat, Aug 25, 2018 at 06:52:32AM -0700, Guenter Roeck wrote:
>> Hi Roland,
>>
>> On 08/24/2018 01:04 PM, Roland Dreier wrote:
>>>> Ok, so what patch should be reverted?  I'm seeing other reports of
>>>> problems all around this same area, but I can't figure out exactly what
>>>> to do.
>>>
>>> Are any of those reports public?  If so can you point me at them, I'm
>>> curious if the symptoms match up.
>>>
>>> I don't think we want to revert anything.  I think you should pull in
>>> edc3b9129cec and at least the first three patches that Ben listed:
>>>
>>> 21cdb6b56843 x86/mm: Page align the '_end' symbol to avoid pfn conversion bugs
>>> b61a76f8850d x86/efi: Map RAM into the identity page table for mixed mode
>>> 753b11ef8e92 x86/efi: Setup separate EFI page tables in kexec paths
>>>
>>> the first patch takes a bit of massaging (mostly because some of it is
>>> already touched by 02ff2769edbc, which keeps the changes from
>>> edc3b9129cec, and so we can drop a good bit when applying).  The other
>>> three apply cleanly.
>>>
>>> I'm currently testing that and can send you the state of my tree in a bit.
>>>
>>
>> Have you made any progress ? On my side I am still out of luck since I can not
>> reproduce the problem.
> 
> Perhaps just the patch that Andi posted to the stable list helps out
> here?
> 

For reference:

https://www.spinics.net/lists/stable/msg253357.html

That would be the most straightforward and simple fix, so I would prefer
to go with it if it works.

Guenter
