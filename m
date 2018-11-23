Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0092C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 753C420672
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAd8GtjP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 753C420672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504110AbeKWWuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 17:50:40 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46006 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388296AbeKWWuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 17:50:40 -0500
Received: by mail-pg1-f193.google.com with SMTP id y4so3006738pgc.12;
        Fri, 23 Nov 2018 04:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b8Lg/JH6rO0SxCB1KGTrHdzM1UnUpZoUnGxVv7waBY4=;
        b=OAd8GtjP/xBLetY3xf4G5YkxyUc1GPW5gpWi8t0ANYt4sX9ybetwStoc8aiM5b1qe9
         zpyglx52y/UYj8eKfRKFt4G2WVMykq5CmQN+/R1fifaAmOeGJVUvx5hxO3piPzqh0mTu
         trPP5SYxM+A5y+R6HfP5Io9Rc01vkzkmyOtE9BFE5/ivzgA7kIBq1tGlfqal9hp+1Wbs
         DqD6XaEU4COc87IpftTi0lF0z58xenZKLOAtvr+b0uaaG+5LxIjEi0T777e3okpy7QFC
         E9a09PO6gIZ40/Zw5iqNuJ5/RHDAcvzyX6FF+hN29uLcMXpQKEgFROwgLbLedbTvb0wn
         E9Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b8Lg/JH6rO0SxCB1KGTrHdzM1UnUpZoUnGxVv7waBY4=;
        b=WzxYJ75gpYu8QgIhTpXUG5VwpzCK8PZh/q9xH2ViBFA8+g+YiFL5VixeA2wN9NWqX0
         Lq1NWNQ81QYG8Pin4jtMyVqrddlvdLVwS/NABaAYxaZ9/9Xegd6Y1KGY8wqst+fyHs1M
         VD/Iy2/G1TjH3fBuqN5COWTwvd9qgfPwXe/bBFphL/XAJ902zzs/5kTunvB3bPCohPB2
         tf5ysoeVQVSNRncIzKINzgC6+YRmtyyj6+Z9zEgGdBBPZ5HVwt0K9KK1GOSXcb6n79hZ
         ToZLv1wLaVvTmizIBIiqXdiWEV4MlOowjnKs4vGd45hiWMQjv5jcfdNn59pcF2s/3KJN
         ca6A==
X-Gm-Message-State: AA+aEWb/wu9J+oBQLuiknOkO7hfwHch1+erUs9mz526wwNB84eD/s0w5
        swlx55n1Wbs28wzkPHWh4kA=
X-Google-Smtp-Source: AFSGD/VprE0FvzVCH0mSnoX13upYP84Y/dwHRtb1mZM+jEOMAmTwQFoIrj3ZGogBDXfFI6Ru7oMKNQ==
X-Received: by 2002:a63:e101:: with SMTP id z1mr13838129pgh.310.1542974801967;
        Fri, 23 Nov 2018 04:06:41 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h8sm36374649pgv.27.2018.11.23.04.06.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 04:06:41 -0800 (PST)
Subject: Re: [PATCH 4.19 00/42] 4.19.4-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Voegtle <tv@lio96.de>, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Chris Wilson <chris@chris-wilson.co.uk>
References: <20181121183147.869199006@linuxfoundation.org>
 <alpine.LSU.2.21.1811222148260.12239@er-systems.de>
 <alpine.LSU.2.21.1811222259160.22493@er-systems.de>
 <259dad79-9bed-0b6b-3723-82bf4a0a9603@roeck-us.net>
 <20181123074500.GA31919@kroah.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <6d6dd7c6-3610-6a0b-1197-32faa2db1ede@roeck-us.net>
Date:   Fri, 23 Nov 2018 04:06:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181123074500.GA31919@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/18 11:45 PM, Greg Kroah-Hartman wrote:
> On Thu, Nov 22, 2018 at 02:30:58PM -0800, Guenter Roeck wrote:
>> On 11/22/18 2:01 PM, Thomas Voegtle wrote:
>>> On Thu, 22 Nov 2018, Thomas Voegtle wrote:
>>>
>>>>
>>>> Doesn't compile for me on OpenSuSE 15.0 (gcc 7.3.1):
>>>>
>>>>    CALL    scripts/checksyscalls.sh
>>>>    DESCEND  objtool
>>>>    CHK     include/generated/compile.h
>>>>    CC [M]  drivers/gpu/drm/i915/i915_gem_gtt.o
>>>> drivers/gpu/drm/i915/i915_gem_gtt.c: In function ‘gen6_dump_ppgtt’:
>>>> drivers/gpu/drm/i915/i915_gem_gtt.c:1771:41: error: format ‘%llx’ expects
>>>> argument of type ‘long long unsigned int’, but argument 5 has type ‘long
>>>> unsigned int’ [-Werror=format=]
>>>>     seq_printf(m, "\t\t(%03d, %04d) %08llx: ",
>>>>                                     ~~~~~ ^
>>>>                                     %08lx
>>>> cc1: all warnings being treated as errors
>>>> make[4]: *** [scripts/Makefile.build:306:
>>>> drivers/gpu/drm/i915/i915_gem_gtt.o] Error 1
>>>> make[3]: *** [scripts/Makefile.build:546: drivers/gpu/drm/i915] Error 2
>>>> make[2]: *** [scripts/Makefile.build:546: drivers/gpu/drm] Error 2
>>>> make[1]: *** [scripts/Makefile.build:546: drivers/gpu] Error 2
>>>> make: *** [Makefile:1052: drivers] Error 2
>>>>
>>>>
>>>>
>>>> 4.19.3 is broken for me, too. 4.19.2 is works.
>>>> 4.20-rc tree works.
>>>>
>>>> Config attached.
>>>
>>>
>>> quick bisect shows problem is:
>>>
>>> commit 1a25e1a1be71a49ee7f34fb14b5a26191e6cf501
>>> Author: Chris Wilson <chris@chris-wilson.co.uk>
>>> Date:   Thu Oct 25 10:18:22 2018 +0100
>>>
>>>       drm/i915: Mark up GTT sizes as u64
>>>
>>>       commit c58281056a8b26d5d9dc15c19859a7880835ef44 upstream.
>>>
>>>
>>> reverted on 4.19.4-rc1 it compiles for me. I guess something is missing here?
>>>
>> AFAICS someone was not careful with the backport. Upstream doesn't have %llx
>> at that place.
> 
> Yes it does, unless I'm reading the code wrong?
> 

Ah, I was looking at v4.20-rc1, which didn't have it. Wrong branch, sorry.

> It seems that this does not trigger on upstream due to f6e35cda6614
> ("drm/i915: Replace some PAGE_SIZE with I915_GTT_PAGE_SIZE") being
> there, which changed the type of the variable being displayed here.
>  > I've now backported that as well, as it should help out over time, and
> the build warning seems to be gone.
> 
Makes sense.

Thanks,
Guenter
