Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C68C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 22:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6588720818
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 22:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZlK5YlZE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6588720818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439009AbeKWJMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 04:12:30 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45833 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730540AbeKWJMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 04:12:30 -0500
Received: by mail-pg1-f194.google.com with SMTP id y4so2204910pgc.12;
        Thu, 22 Nov 2018 14:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YJfyDBolJ+U3xXev1xBbjbMoiaxZBi7gHynOnanFRDU=;
        b=ZlK5YlZEzBOKF6I6aHb+0k7cBNibikgtvNjyL1PHm3b4bgOEv3Yhy+I8EX3tk1TMB0
         byVxHkhuQcDgHYQ0idBVwc56DswrT37t/s6erkuWlXJ4rw3k7N3WXGbUyJWdFzbD+n10
         L1pirFcXSrudmjxNh2IdE7pc6EZhDzc1hM92SIClPG+oX+LLvIaBPF5iTsDI/mZlM7T1
         NN1M84dZaCy+rQ2OZ+3CuoRiKo0kbbbwe/sDvCDuq8h7HMNhAIQ6btcaYDoYONQCVnr3
         T+ysFhvcAoVUUMur1tv2ng7Pjg1owHwXNrW7LXeme8lah7Tx/wPO+C+KboFWwXdHs6fW
         3+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YJfyDBolJ+U3xXev1xBbjbMoiaxZBi7gHynOnanFRDU=;
        b=Jju56kjg14jGQC4dXomxEEOVa4EFnMo6h0HQxiq7zX17LkdRWWj5wYaq6lWQF0HMVa
         BFvQYbRaKd8lbDwIhkZGY18He+DWbogVfcbYGnHlgsc1t0jMKS5kXJL7EHVILdsmheB9
         8aXki9jmOi2BSp9qguIfR5ZoFrtB4X62Fw4XHCEqD73n+CyddVprqsYSZs5fd9qPnv4I
         h6NlUx83XQsXzH1i6LLdplYYI39MAzjtl+ywRLfJwDO7sWDjbVOLOzcc1UMHH0306aAk
         wrLNyWX3qL8vHxQWdlOWXqf37cgNPO5TOjhu2ZsbB5ixCrKQ00Hk+Th1PsOmfCAE2WW+
         uEcA==
X-Gm-Message-State: AGRZ1gJyNlqx1huxo5Hb8nROjURqOOVWVPLMedHmC92FeZS3ppoM57SK
        C+k/JGyZLI2qcOYmk9T1hLg=
X-Google-Smtp-Source: AJdET5enjKbH3nibcumQTPrKMtUVQBG+eYuEZPcB8j/+FPBBbBg4KYNKix3F4kNXEf4DDb9HCDIvSg==
X-Received: by 2002:a62:8145:: with SMTP id t66mr13372512pfd.55.1542925861785;
        Thu, 22 Nov 2018 14:31:01 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h74sm2189763pfd.35.2018.11.22.14.30.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 14:31:00 -0800 (PST)
Subject: Re: [PATCH 4.19 00/42] 4.19.4-stable review
To:     Thomas Voegtle <tv@lio96.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Chris Wilson <chris@chris-wilson.co.uk>
References: <20181121183147.869199006@linuxfoundation.org>
 <alpine.LSU.2.21.1811222148260.12239@er-systems.de>
 <alpine.LSU.2.21.1811222259160.22493@er-systems.de>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <259dad79-9bed-0b6b-3723-82bf4a0a9603@roeck-us.net>
Date:   Thu, 22 Nov 2018 14:30:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.21.1811222259160.22493@er-systems.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/18 2:01 PM, Thomas Voegtle wrote:
> On Thu, 22 Nov 2018, Thomas Voegtle wrote:
> 
>>
>> Doesn't compile for me on OpenSuSE 15.0 (gcc 7.3.1):
>>
>>   CALL    scripts/checksyscalls.sh
>>   DESCEND  objtool
>>   CHK     include/generated/compile.h
>>   CC [M]  drivers/gpu/drm/i915/i915_gem_gtt.o
>> drivers/gpu/drm/i915/i915_gem_gtt.c: In function ‘gen6_dump_ppgtt’:
>> drivers/gpu/drm/i915/i915_gem_gtt.c:1771:41: error: format ‘%llx’ expects
>> argument of type ‘long long unsigned int’, but argument 5 has type ‘long
>> unsigned int’ [-Werror=format=]
>>    seq_printf(m, "\t\t(%03d, %04d) %08llx: ",
>>                                    ~~~~~ ^
>>                                    %08lx
>> cc1: all warnings being treated as errors
>> make[4]: *** [scripts/Makefile.build:306:
>> drivers/gpu/drm/i915/i915_gem_gtt.o] Error 1
>> make[3]: *** [scripts/Makefile.build:546: drivers/gpu/drm/i915] Error 2
>> make[2]: *** [scripts/Makefile.build:546: drivers/gpu/drm] Error 2
>> make[1]: *** [scripts/Makefile.build:546: drivers/gpu] Error 2
>> make: *** [Makefile:1052: drivers] Error 2
>>
>>
>>
>> 4.19.3 is broken for me, too. 4.19.2 is works.
>> 4.20-rc tree works.
>>
>> Config attached.
> 
> 
> quick bisect shows problem is:
> 
> commit 1a25e1a1be71a49ee7f34fb14b5a26191e6cf501
> Author: Chris Wilson <chris@chris-wilson.co.uk>
> Date:   Thu Oct 25 10:18:22 2018 +0100
> 
>      drm/i915: Mark up GTT sizes as u64
> 
>      commit c58281056a8b26d5d9dc15c19859a7880835ef44 upstream.
> 
> 
> reverted on 4.19.4-rc1 it compiles for me. I guess something is missing here?
> 
AFAICS someone was not careful with the backport. Upstream doesn't have %llx
at that place.

Guenter
