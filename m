Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751070AbeCIDN1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 22:13:27 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:54896 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750848AbeCIDN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 22:13:26 -0500
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="37653267"
Subject: Re: [PATCH 4/5] kbuild: simplify modname calculation
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
        <linux-kbuild@vger.kernel.org>
CC: Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Govind Singh <govinds@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>, <linux-kernel@vger.kernel.org>
References: <1520471103-10089-1-git-send-email-yamada.masahiro@socionext.com>
 <1520471103-10089-5-git-send-email-yamada.masahiro@socionext.com>
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <4c97d2e7-4029-e19e-4fc2-44d0cea927a5@cn.fujitsu.com>
Date: Fri, 9 Mar 2018 11:12:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <1520471103-10089-5-git-send-email-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.60]
X-yoursite-MailScanner-ID: 7EAA748AE761.A8A1C
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/08/2018 09:05 AM, Masahiro Yamada wrote:
> modname can be calculated much more simply.  If modname-multi is
> empty, it is a single-used object.  So, modname = $(basetarget).> Otherwise, modname = $(modname-multi).
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  scripts/Makefile.build | 12 +-----------
>  scripts/Makefile.lib   |  7 -------
>  2 files changed, 1 insertion(+), 18 deletions(-)
> 
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 4f2b25d..b8aecb7 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -131,17 +131,7 @@ $(real-objs-m:.o=.lst): quiet_modtag := [M]
>  
>  $(obj-m)              : quiet_modtag := [M]
>  
> -# Default for not multi-part modules
> -modname = $(basetarget)
> -
> -$(multi-objs-m)         : modname = $(modname-multi)
> -$(multi-objs-m:.o=.i)   : modname = $(modname-multi)
> -$(multi-objs-m:.o=.s)   : modname = $(modname-multi)
> -$(multi-objs-m:.o=.lst) : modname = $(modname-multi)
> -$(multi-objs-y)         : modname = $(modname-multi)
> -$(multi-objs-y:.o=.i)   : modname = $(modname-multi)
> -$(multi-objs-y:.o=.s)   : modname = $(modname-multi)
> -$(multi-objs-y:.o=.lst) : modname = $(modname-multi)
> +modname = $(if $(modname-multi),$(modname-multi),$(basetarget))
>  
>  quiet_cmd_cc_s_c = CC $(quiet_modtag)  $@
>  cmd_cc_s_c       = $(CC) $(c_flags) $(DISABLE_LTO) -fverbose-asm -S -o $@ $<
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 9217d40..e4e8e1b 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -47,11 +47,6 @@ multi-used-m := $(sort $(foreach m,$(obj-m), $(if $(strip $($(m:.o=-objs)) $($(m
>  multi-used   := $(multi-used-y) $(multi-used-m)
>  single-used-m := $(sort $(filter-out $(multi-used-m),$(obj-m)))
>  
> -# Build list of the parts of our composite objects, our composite
> -# objects depend on those (obviously)
> -multi-objs-y := $(foreach m, $(multi-used-y), $($(m:.o=-objs)) $($(m:.o=-y)))
> -multi-objs-m := $(foreach m, $(multi-used-m), $($(m:.o=-objs)) $($(m:.o=-y)) $($(m:.o=-m)))
> -
>  # $(subdir-obj-y) is the list of objects in $(obj-y) which uses dir/ to
>  # tell kbuild to descend
>  subdir-obj-y := $(filter %/built-in.o, $(obj-y))
> @@ -80,8 +75,6 @@ real-objs-m	:= $(addprefix $(obj)/,$(real-objs-m))
>  single-used-m	:= $(addprefix $(obj)/,$(single-used-m))
>  multi-used-y	:= $(addprefix $(obj)/,$(multi-used-y))
>  multi-used-m	:= $(addprefix $(obj)/,$(multi-used-m))
> -multi-objs-y	:= $(addprefix $(obj)/,$(multi-objs-y))
> -multi-objs-m	:= $(addprefix $(obj)/,$(multi-objs-m))
>  subdir-ym	:= $(addprefix $(obj)/,$(subdir-ym))
>  
>  # These flags are needed for modversions and compiling, so we define them here
> 

multi-objs-y/m seems only exist for rules above with target-specific
variable assignment. A great simplification, So

Reviewed-by: Cao jin <caoj.fnst@cn.fujitsu.com>
-- 
Sincerely,
Cao jin
