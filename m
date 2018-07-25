Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED58C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAAC820843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:06:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAAC820843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731386AbeGYXTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 19:19:43 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:46520 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729182AbeGYXTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 19:19:43 -0400
Received: by mail-qk0-f193.google.com with SMTP id o2-v6so5942234qkc.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 15:06:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TqUQGvjpy6YGyMH+20ABayDGzBCid31vSSfRp2cZRxI=;
        b=dxvdz6b0DYj+gaticvw8roHJRiRFZO1r7Dy5cVtZYzzXpmAlgYVa14xShm2270P/wY
         txJaU+A5mZYpAFZI9aT9CvEKTHRWn9ukMeDn9dDG+hbGPoWobhmOhYhrBBGGclzs+Pjl
         ZxqTFmiHIYkU38q3K4lWlHwcc2j/KlOnMJ844Gm79YMR9SGkDg0pvXQKJS8Jx8eHoA8O
         dc4H5DwQeCb1l17jX6UadjwZv9aiurnG2jWD9SOwmhG5rxJjuNzCR4Tq9ByybzgaOiXg
         P1Im95HimvkKhIzPklUM7HlXPTi7L2EhQ/fCwQA5B1J+FitqOnJmgKLLzNowl9CUqXaO
         K8aw==
X-Gm-Message-State: AOUpUlElHtXnkpM8kcMv2KDGRqcT88ynach3Vwyhh7xBT7LUX6LQNdIr
        RDvWkMbN8CbFvGSSRPMl1jlDCg==
X-Google-Smtp-Source: AAOMgpfB2WmofvGONL/4TKT9e1v6JjuXgr9CEYQU6lqYQ3KMuUc9Dam4btjwoPPcl07A1pQ3RmM3qg==
X-Received: by 2002:a37:7883:: with SMTP id t125-v6mr22151086qkc.334.1532556362345;
        Wed, 25 Jul 2018 15:06:02 -0700 (PDT)
Received: from ?IPv6:2601:602:9802:a8dc:4eb2:6dae:ab32:e5b0? ([2601:602:9802:a8dc:4eb2:6dae:ab32:e5b0])
        by smtp.gmail.com with ESMTPSA id 134-v6sm10392072qke.94.2018.07.25.15.05.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 15:06:00 -0700 (PDT)
Subject: Re: [PATCHv3 0/2] Stackleak for arm64
To:     Will Deacon <will.deacon@arm.com>
Cc:     Alexander Popov <alex.popov@linux.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>, james.morse@arm.com
References: <1531341400-12077-1-git-send-email-alex.popov@linux.com>
 <20180720214154.2940-1-labbott@redhat.com> <20180724163807.GE25888@arm.com>
 <20180725114954.GD30289@arm.com>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <fbf890f6-7424-362e-95dd-223262e5f19e@redhat.com>
Date:   Wed, 25 Jul 2018 15:05:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180725114954.GD30289@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/25/2018 04:49 AM, Will Deacon wrote:
> Hi Laura,
> 
> On Tue, Jul 24, 2018 at 05:38:07PM +0100, Will Deacon wrote:
>> On Fri, Jul 20, 2018 at 02:41:52PM -0700, Laura Abbott wrote:
>>> This is the version of stackleak for arm64, hopefully ready for queueing
>>
>> Thanks. I'll push these into linux-next tomorrow, once I've had a chance
>> to test my conflict resolution in entry.S.
> 
> I've run into a couple of issues with this series:
> 
> 1. I had to install libmpc-dev to get GCC_PLUGINS to appear, otherwise the
>     hostcc check would silently fail. I guess that's a general observation,
>     but it might be nice to print a message about the missing dependencies.
> 
> 2. It breaks arm64 allmodconfig build. Log below.
> 
> Please can you take a look at the build failure? Otherwise, the patches
> look good to me.
> 
> Cheers,
> 
> Will
> 
> --->8
> 
> arch/arm64/kernel/sdei.c: In function ‘on_sdei_normal_stack’:
> arch/arm64/kernel/sdei.c:101:7: error: dereferencing pointer to incomplete type ‘struct stack_info’
>     info->low = low;
>         ^~
> arch/arm64/kernel/sdei.c:103:16: error: ‘STACK_TYPE_SDEI_NORMAL’ undeclared (first use in this function); did you mean ‘SCHED_NORMAL’?
>     info->type = STACK_TYPE_SDEI_NORMAL;
>                  ^~~~~~~~~~~~~~~~~~~~~~
>                  SCHED_NORMAL
> arch/arm64/kernel/sdei.c:103:16: note: each undeclared identifier is reported only once for each function it appears in
> arch/arm64/kernel/sdei.c: In function ‘on_sdei_critical_stack’:
> arch/arm64/kernel/sdei.c:121:16: error: ‘STACK_TYPE_SDEI_CRITICAL’ undeclared (first use in this function)
>     info->type = STACK_TYPE_SDEI_CRITICAL;
>                  ^~~~~~~~~~~~~~~~~~~~~~~~
> arch/arm64/kernel/sdei.c: At top level:
> arch/arm64/kernel/sdei.c:127:6: error: conflicting types for ‘_on_sdei_stack’
>   bool _on_sdei_stack(unsigned long sp,
>        ^~~~~~~~~~~~~~
> In file included from ./include/linux/arm_sdei.h:14:0,
>                   from arch/arm64/kernel/sdei.c:5:
> ./arch/arm64/include/asm/sdei.h:45:6: note: previous declaration of ‘_on_sdei_stack’ was here
>   bool _on_sdei_stack(unsigned long sp, struct stack_info *info);
>        ^~~~~~~~~~~~~~
> arch/arm64/kernel/sdei.c: In function ‘_on_sdei_stack’:
> arch/arm64/kernel/sdei.c:136:33: error: ‘info’ undeclared (first use in this function); did you mean ‘int’?
>    if (on_sdei_critical_stack(sp, info))
>                                   ^~~~
>                                   int
> arch/arm64/kernel/sdei.c:131:21: warning: unused variable ‘high’ [-Wunused-variable]
>    unsigned long low, high;
>                       ^~~~
> arch/arm64/kernel/sdei.c:131:16: warning: unused variable ‘low’ [-Wunused-variable]
>    unsigned long low, high;
>                  ^~~
> make[1]: *** [arch/arm64/kernel/sdei.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [arch/arm64/kernel] Error 2
> 

Ugh this was a failure that I missed folding in, sorry about that

--- 8< ----

diff --git a/arch/arm64/kernel/sdei.c b/arch/arm64/kernel/sdei.c
index 7154fee1cb2b..a94a868f0532 100644
--- a/arch/arm64/kernel/sdei.c
+++ b/arch/arm64/kernel/sdei.c
@@ -13,6 +13,7 @@
  #include <asm/mmu.h>
  #include <asm/ptrace.h>
  #include <asm/sections.h>
+#include <asm/stacktrace.h>
  #include <asm/sysreg.h>
  #include <asm/vmap_stack.h>
  
@@ -125,11 +126,8 @@ bool on_sdei_critical_stack(unsigned long sp,
  }
  
  bool _on_sdei_stack(unsigned long sp,
-		unsigned long *stack_low,
-		unsigned long *stack_high)
+		struct stack_info *info)
  {
-	unsigned long low, high;
-
  	if (!IS_ENABLED(CONFIG_VMAP_STACK))
  		return false;
  
