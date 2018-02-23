Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751948AbeBWPhZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 10:37:25 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41756 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751406AbeBWPhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 10:37:22 -0500
Date: Fri, 23 Feb 2018 09:37:20 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Robin Jarry <robin.jarry@6wind.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 2/2] objtool: use host flags to detect if libelf is
 missing
Message-ID: <20180223153720.glun6fa2a3jde7mi@treble>
References: <cover.1519393674.git.robin.jarry@6wind.com>
 <2afbfc7911a0eb0642c33e8c2582f137a4fda2f3.1519393674.git.robin.jarry@6wind.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2afbfc7911a0eb0642c33e8c2582f137a4fda2f3.1519393674.git.robin.jarry@6wind.com>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 03:22:15PM +0100, Robin Jarry wrote:
> When libelf headers and libs are not found and CONFIG_UNWINDER_ORC is
> selected, there is a make error introduced by
> commit 3dd40cb320fe ("objtool: Upgrade libelf-devel warning to error for
> CONFIG_ORC_UNWINDER").
> 
> Host headers and libs may be in a non-standard location and the check is
> performed without host flags. Make sure to use host flags for the check
> (they will be used later when building objtool anyway).
> 
> Fixes: 3b27a0c85d70 ("objtool: Detect and warn if libelf is missing and don't break the build")
> Signed-off-by: Robin Jarry <robin.jarry@6wind.com>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index e9609319d2b8..4e8c667b9f3f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -955,7 +955,7 @@ export mod_sign_cmd
>  
>  ifdef CONFIG_STACK_VALIDATION
>    has_libelf := $(call try-run,\
> -		echo "int main() {}" | $(HOSTCC) -xc -o /dev/null -lelf -,1,0)
> +		echo "int main() {}" | $(HOSTCC) $(host_clfags) $(HOSTLDFLAGS) -xc -o /dev/null -lelf -,1,0)
>    ifeq ($(has_libelf),1)
>      objtool_target := tools/objtool FORCE
>    else
> -- 
> 2.11.0
> 

Hi Robin,

Did you test this?  I see some issues:

a) I don't see where the host_cflags variable comes from (and btw, it's
   misspelled...)

b) I don't see where objtool uses HOSTLDFLAGS.

-- 
Josh
