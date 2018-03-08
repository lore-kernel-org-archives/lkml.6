Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934944AbeCHKUt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 05:20:49 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:40148 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755373AbeCHKUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 05:20:47 -0500
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="37611897"
Subject: Re: [PATCH 1/5] kbuild: remove unnecessary $(subst $(obj)/,,...) in
 modname-multi
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
        <linux-kbuild@vger.kernel.org>
CC: Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Govind Singh <govinds@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>, <linux-kernel@vger.kernel.org>
References: <1520471103-10089-1-git-send-email-yamada.masahiro@socionext.com>
 <1520471103-10089-2-git-send-email-yamada.masahiro@socionext.com>
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <cc031caa-3bf6-f8f0-6d82-1f01985ddd8a@cn.fujitsu.com>
Date: Thu, 8 Mar 2018 18:19:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <1520471103-10089-2-git-send-email-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.226.60]
X-yoursite-MailScanner-ID: 1DE4B48AE762.A61CF
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/08/2018 09:04 AM, Masahiro Yamada wrote:
> In the context ...
> 
>     $(obj)/%.s: $(src)/%.c FORCE
>             $(call if_changed_dep,cc_s_c)
> 
>     $(obj)/%.i: $(src)/%.c FORCE
>             $(call if_changed_dep,cpp_i_c)
> 
>     $(obj)/%.o: $(src)/%.c $(recordmcount_source) $(objtool_dep) FORCE
>             $(call cmd,force_checksrc)
>             $(call if_changed_rule,cc_o_c)
> 
>     $(obj)/%.lst: $(src)/%.c FORCE
>             $(call if_changed_dep,cc_lst_c)
> 
> '$*' returns the stem of the target (the part of '%'), so $(obj)/ has
> already been ripped off.
> 
> $(subst $(obj)/,,$*.o) is the same as $(*.o)
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  scripts/Makefile.lib | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 5589bae..a7e315f 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -175,7 +175,7 @@ dtc_cpp_flags  = -Wp,-MD,$(depfile).pre.tmp -nostdinc                    \
>  
>  # Finds the multi-part object the current object will be linked into
>  modname-multi = $(sort $(foreach m,$(multi-used),\
> -		$(if $(filter $(subst $(obj)/,,$*.o), $($(m:.o=-objs)) $($(m:.o=-y))),$(m:.o=))))
> +		$(if $(filter $*.o, $($(m:.o=-objs)) $($(m:.o=-y))),$(m:.o=))))
>  
>  # Useful for describing the dependency of composite objects
>  # Usage:
> 

A subtle catch! And in my test, a debug line

    $(info $@ = $*)

in rule:

    $(obj)/%.o: $(src)/%.c xxx

does tell me it is correct. So,

Reviewed-by: Cao jin <caoj.fnst@cn.fujitsu.com>
-- 
Sincerely,
Cao jin
