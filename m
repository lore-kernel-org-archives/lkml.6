Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9F0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E78217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbfBSVhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 16:37:48 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38397 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbfBSVhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 16:37:48 -0500
Received: by mail-qt1-f194.google.com with SMTP id 2so25000193qtb.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 13:37:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=negk3eC+GoymokVpzay6lU5dVWvVumB0yt3iSqDQKz4=;
        b=heVpDPm7gVnNFhEXI/8Rkpr/kBurZgnGVnl/0fSQQwTReqFUQOWpsa5EcpZH2xxq4h
         xVp64y7QH1crlFLePs+hlyx+zB0h7JML3Lyz2/40aQsQt3Auc1TwmSXQwJBq2pSQyK07
         sy06lcJSMGNGqmfsz4eOy6p15GencREHoUe9Y6X0GfyB/qwMAtOtJtIsA5P5rdZTOnSC
         TgvS/1bhJJygu+npzJ4UHFtNn4jTHxhBcABE6yuTYumIfjTvsP+W54oOf/TvzZFiiQ0E
         o5jZFeQJFHbOreCodp4qxQZhoM7DPmxLO1MoyDOKYZwQykUY1T0rMetURypuUhc9mLlf
         lpCg==
X-Gm-Message-State: AHQUAuaNQtACcvmULXfO5GMK3+b9HRyRrcnLDeYzycoLJyJWy/NwLnMb
        pRu9pQ25ZZRf7Qz2jtKUgoSf4A==
X-Google-Smtp-Source: AHgI3IbpmKfkXdViySCLxHF6q/t9Qg9NtFvv2uWFvZyT+wtfvK/WOJxQyhPq1pWcGMo9NH5DmqU82Q==
X-Received: by 2002:ac8:2b17:: with SMTP id 23mr9492711qtu.157.1550612267403;
        Tue, 19 Feb 2019 13:37:47 -0800 (PST)
Received: from ?IPv6:2601:602:9800:dae6::112f? ([2601:602:9800:dae6::112f])
        by smtp.gmail.com with ESMTPSA id u32sm21096992qtc.54.2019.02.19.13.37.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 13:37:46 -0800 (PST)
Subject: Re: [PATCH 13/14] staging: android: ion: Do not sync CPU cache on
 map/unmap
To:     Brian Starkey <Brian.Starkey@arm.com>,
        "Andrew F. Davis" <afd@ti.com>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Arve_Hj=c3=b8nnev=c3=a5g?= <arve@android.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>, nd <nd@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>
References: <alpine.DEB.2.10.1901161450470.10666@lmark-linux.qualcomm.com>
 <3bf4bfce-aee6-9c52-c2f7-783dc63bfc3a@ti.com>
 <alpine.DEB.2.10.1901171704270.12287@lmark-linux.qualcomm.com>
 <b8b16d71-e09b-6bf9-259e-79c1de7fd15b@ti.com>
 <20190121112235.g36qqptpv6wjuj7w@DESKTOP-E1NTVVP.localdomain>
 <b89df12e-00bc-5484-6458-f7c85a362b42@ti.com>
 <CAO_48GEYPW0u6uWkkFgqjmmabLcBm69OD34QihSNGewqz_AqSQ@mail.gmail.com>
 <d24949d2-3736-0e6f-99ae-b8550d53a828@ti.com>
 <20190123171153.ql25gyg6sma4fpqb@DESKTOP-E1NTVVP.localdomain>
 <af5c22b2-0d9e-4bd1-6fdd-1a3880890916@ti.com>
 <20190124164447.3dwwampprzofwbyr@DESKTOP-E1NTVVP.localdomain>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <08057adf-d1da-7cb7-79ac-8e6e3934e7d7@redhat.com>
Date:   Tue, 19 Feb 2019 13:37:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190124164447.3dwwampprzofwbyr@DESKTOP-E1NTVVP.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/19 8:44 AM, Brian Starkey wrote:
> On Thu, Jan 24, 2019 at 10:04:46AM -0600, Andrew F. Davis wrote:
>> On 1/23/19 11:11 AM, Brian Starkey wrote:
> 
> [snip]
> 
>>
>> I'm very new to all this, so any pointers to history in this area are
>> appreciated.
>>
> 
> [snip]
> 
>>
>>> In case you didn't come across it already, the effort which seems to
>>> have gained the most "air-time" recently is
>>> https://github.com/cubanismo/allocator, which is still a userspace
>>> module (perhaps some concepts from there could go into the kernel?),
>>> but makes some attempts at generic constraint solving. It's also not
>>> really moving anywhere at the moment.
>>>
>>
>> Very interesting, I'm going to have to stare at this for a bit.
> 
> In which case, some reading material that might be of interest :-)
> 
> https://www.x.org/wiki/Events/XDC2016/Program/Unix_Device_Memory_Allocation.pdf
> https://www.x.org/wiki/Events/XDC2017/jones_allocator.pdf
> https://lists.freedesktop.org/archives/mesa-dev/2017-November/177632.html
> 
> -Brian
> 

In some respects this is more a question of "what is the purpose
of Ion". Once upon a time, Ion was going to do constraint solving
but that never really happened and I figured Ion would get deprecated.
People keep coming out of the woodwork with new uses for Ion so
its stuck around. This is why I've primarily focused on Ion as a
framework for exposing available memory types to userspace and leave
the constraint solving to someone else, since that's what most
users seem to want out of Ion ("I know I want memory type X please
give it to me"). That's not to say that this was a perfect or
even the correct approach, just what made the most sense based
on users.

Thanks,
Laura
