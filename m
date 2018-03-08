Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755665AbeCHK0T (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 05:26:19 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:50164 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754735AbeCHK0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 05:26:17 -0500
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="37612044"
Subject: Re: [PATCH 2/5] kbuild: define KBUILD_MODNAME even if multiple
 modules share objects
To: Masahiro Yamada <yamada.masahiro@socionext.com>
CC: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Govind Singh <govinds@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1520471103-10089-1-git-send-email-yamada.masahiro@socionext.com>
 <1520471103-10089-3-git-send-email-yamada.masahiro@socionext.com>
 <4022257e-9ab0-b038-df0e-b15b98cb999f@cn.fujitsu.com>
 <CAK7LNARhhs4o-cKKzW9exRjbCYpTntdBvUgsx6o-egsTc2pQ0g@mail.gmail.com>
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <2bb55c11-bffb-4099-f1fc-d31fb058d422@cn.fujitsu.com>
Date: Thu, 8 Mar 2018 18:25:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNARhhs4o-cKKzW9exRjbCYpTntdBvUgsx6o-egsTc2pQ0g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.60]
X-yoursite-MailScanner-ID: 8E39248AE761.A8F31
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro-san

On 03/08/2018 06:21 PM, Masahiro Yamada wrote:
> 2018-03-08 19:11 GMT+09:00 Cao jin <caoj.fnst@cn.fujitsu.com>:
>>
>>
>> On 03/08/2018 09:05 AM, Masahiro Yamada wrote:
>>> Currently, KBUILD_MODNAME is defined only when $(modname) contains
>>> just one word.  If an object is shared among multiple modules,
>>> undefined KBUILD_MODNAME could cause a build error.  For example,
>>> if CONFIG_DYNAMIC_DEBUG is enabled, any call of printk() populates
>>> .modname, then fails to build due to undefined KBUILD_MODNAME.
>>>
>>> Take the following code as an example:
>>>
>>>   obj-m += foo.o
>>>   obj-m += bar.o
>>>   foo-objs := foo-bar-common.o foo-main.o
>>>   bar-objs := foo-bar-common.o bar-main.o
>>>
>>> In this case, there is room for argument what to define for
>>> KBUILD_MODNAME when foo-bar-common.o is being compiled.
>>> "foo", "bar", or what else?
>>>
>>> One idea is to define colon-separated modules that share the object,
>>> in this case, "bar:foo" (modules are sorted alphabetically by
>>> $(sort ...).
>>>
>>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>>> ---
>>>
>>>  scripts/Makefile.lib | 9 +++++----
>>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
>>> index a7e315f..a1fbd6a 100644
>>> --- a/scripts/Makefile.lib
>>> +++ b/scripts/Makefile.lib
>>> @@ -92,8 +92,7 @@ subdir-ym   := $(addprefix $(obj)/,$(subdir-ym))
>>>  #       differ in different configs.
>>>  name-fix = $(squote)$(quote)$(subst $(comma),_,$(subst -,_,$1))$(quote)$(squote)
>>>  basename_flags = -DKBUILD_BASENAME=$(call name-fix,$(basetarget))
>>> -modname_flags  = $(if $(filter 1,$(words $(modname))),\
>>> -                 -DKBUILD_MODNAME=$(call name-fix,$(modname)))
>>> +modname_flags  = -DKBUILD_MODNAME=$(call name-fix,$(modname))
>>>
>>
>> I guess there is comment also need to be modified above this code hunk:
>>
>> Note: Files that end up in two or more modules are compiled without the
>>       KBUILD_MODNAME definition. The reason is that any made-up name
>>       would differ in different configs.
> 
> 
> Why do I have to add lying comments here?
> 
> The commit subject/log claims KBUILD_MODNAME should be _always_ defined.
> 

I feel you misunderstand my intention, the comment I mentioned is
already there, so they should be modified according to your patch.

-- 
Sincerely,
Cao jin
