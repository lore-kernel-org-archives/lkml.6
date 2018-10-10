Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC8AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 20:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27B342087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 20:30:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27B342087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbeJKDyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 23:54:20 -0400
Received: from mga03.intel.com ([134.134.136.65]:62250 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbeJKDyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 23:54:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Oct 2018 13:30:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,365,1534834800"; 
   d="scan'208";a="90930975"
Received: from irvmail001.ir.intel.com ([163.33.26.43])
  by orsmga003.jf.intel.com with ESMTP; 10 Oct 2018 13:30:21 -0700
Received: from mwajdecz-mobl1.ger.corp.intel.com (mwajdecz-mobl1.ger.corp.intel.com [172.28.174.54])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id w9AKUKq0019733;
        Wed, 10 Oct 2018 21:30:20 +0100
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     "Nick Desaulniers" <ndesaulniers@google.com>,
        "Nathan Chancellor" <natechancellor@gmail.com>,
        "Jani Nikula" <jani.nikula@linux.intel.com>
Cc:     intel-gfx@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, rodrigo.vivi@intel.com,
        lukas.bulwahn@gmail.com
Subject: Re: [Intel-gfx] [PATCH] drm/i915: Convert _print_param to a macro
References: <20181009171401.14980-1-natechancellor@gmail.com>
 <CAKwvOdm-oiVvuX_QDjQ1QcO3+=XowHEnHgj3PyQ4hY=thrJGNA@mail.gmail.com>
 <87woqqm2mz.fsf@intel.com>
Date:   Wed, 10 Oct 2018 22:30:20 +0200
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Michal Wajdeczko" <michal.wajdeczko@intel.com>
Message-ID: <op.zqoq8ui3xaggs7@mwajdecz-mobl1.ger.corp.intel.com>
In-Reply-To: <87woqqm2mz.fsf@intel.com>
User-Agent: Opera Mail/1.0 (Win32)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Oct 2018 14:01:40 +0200, Jani Nikula  
<jani.nikula@linux.intel.com> wrote:

> On Tue, 09 Oct 2018, Nick Desaulniers <ndesaulniers@google.com> wrote:
>> On Tue, Oct 9, 2018 at 10:14 AM Nathan Chancellor
>> <natechancellor@gmail.com> wrote:
>>>
>>> When building the kernel with Clang with defconfig and CONFIG_64BIT
>>> disabled, vmlinux fails to link because of the BUILD_BUG in
>>> _print_param.
>>>
>>> ld: drivers/gpu/drm/i915/i915_params.o: in function `i915_params_dump':
>>> i915_params.c:(.text+0x56): undefined reference to
>>> `__compiletime_assert_191'
>>>
>>> This function is semantically invalid unless the code is first inlined
>>> then constant folded, which doesn't work for Clang because semantic
>>> analysis happens before optimization/inlining. Converting this function
>>> to a macro avoids this problem and allows Clang to properly remove the
>>> BUILD_BUG during optimization.
>>
>> Thanks Nathan for the patch.  To provide more context, Clang does
>> semantic analysis before optimization, where as GCC does these
>> together (IIUC).  So the above link error is from the naked
>> BUILD_BUG().  Clang can't evaluate the __builtin_strcmp's statically
>> until inlining has occurred, but that optimization happens after
>> semantic analysis.  To do the inlining before semantic analysis, we
>> MUST leverage the preprocessor, which runs before the compiler starts
>> doing semantic analysis.  I suspect this code is not valid for GCC
>> unless optimizations are enabled (the kernel only does compile with
>> optimizations turned on).  This change allows us to build this
>> translation unit with Clang.
>>
>> Acked-by: Nick Desaulniers <ndesaulniers@google.com>
>> (Note: this is the change I suggested, so not sure whether Acked-by or
>> Reviewed-by is more appropriate).
>
> *Sad trombone*
>
> I'd rather see us converting more macros to static inlines than the
> other way round.
>
> I'll let others chime in if they have any better ideas, otherwise I'll
> apply this one.

Option 1: Just drop BUILD_BUG() from _print_param() function.

Option 2: Use aliases instead of real types in param() macros.

Aliases can be same as in linux/moduleparam.h (charp|int|uint|bool)
We can convert aliases back to real types but it will also allow
to construct proper names for dedicated functions - see [1]

Michal

[1] https://patchwork.freedesktop.org/patch/255928/


>
> BR,
> Jani.
>
>>
>>>
>>> The output of 'objdump -D' is identically before and after this change
>>> for GCC regardless of if CONFIG_64BIT is set and allows Clang to link
>>> the kernel successfully with or without CONFIG_64BIT set.
>>>
>>> Link: https://github.com/ClangBuiltLinux/linux/issues/191
>>> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
>>> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
>>> ---
>>>  drivers/gpu/drm/i915/i915_params.c | 29 +++++++++++++----------------
>>>  1 file changed, 13 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/i915/i915_params.c  
>>> b/drivers/gpu/drm/i915/i915_params.c
>>> index 295e981e4a39..a0f20b9b6f2d 100644
>>> --- a/drivers/gpu/drm/i915/i915_params.c
>>> +++ b/drivers/gpu/drm/i915/i915_params.c
>>> @@ -174,22 +174,19 @@ i915_param_named(enable_dpcd_backlight, bool,  
>>> 0600,
>>>  i915_param_named(enable_gvt, bool, 0400,
>>>         "Enable support for Intel GVT-g graphics virtualization host  
>>> support(default:false)");
>>>
>>> -static __always_inline void _print_param(struct drm_printer *p,
>>> -                                        const char *name,
>>> -                                        const char *type,
>>> -                                        const void *x)
>>> -{
>>> -       if (!__builtin_strcmp(type, "bool"))
>>> -               drm_printf(p, "i915.%s=%s\n", name, yesno(*(const bool  
>>> *)x));
>>> -       else if (!__builtin_strcmp(type, "int"))
>>> -               drm_printf(p, "i915.%s=%d\n", name, *(const int *)x);
>>> -       else if (!__builtin_strcmp(type, "unsigned int"))
>>> -               drm_printf(p, "i915.%s=%u\n", name, *(const unsigned  
>>> int *)x);
>>> -       else if (!__builtin_strcmp(type, "char *"))
>>> -               drm_printf(p, "i915.%s=%s\n", name, *(const char **)x);
>>> -       else
>>> -               BUILD_BUG();
>>> -}
>>> +#define _print_param(p, name, type,  
>>> x)                                        \
>>> +do  
>>> {                                                                           
>>> \
>>> +       if (!__builtin_strcmp(type,  
>>> "bool"))                                   \
>>> +               drm_printf(p, "i915.%s=%s\n", name, yesno(*(const bool  
>>> *)x));  \
>>> +       else if (!__builtin_strcmp(type,  
>>> "int"))                               \
>>> +               drm_printf(p, "i915.%s=%d\n", name, *(const int  
>>> *)x);          \
>>> +       else if (!__builtin_strcmp(type, "unsigned  
>>> int"))                      \
>>> +               drm_printf(p, "i915.%s=%u\n", name, *(const unsigned  
>>> int *)x); \
>>> +       else if (!__builtin_strcmp(type, "char  
>>> *"))                            \
>>> +               drm_printf(p, "i915.%s=%s\n", name, *(const char  
>>> **)x);        \
>>> +        
>>> else                                                                    
>>> \
>>> +                
>>> BUILD_BUG();                                                   \
>>> +} while (0)
>>>
>>>  /**
>>>   * i915_params_dump - dump i915 modparams
>>> --
>>> 2.19.0
>>>
