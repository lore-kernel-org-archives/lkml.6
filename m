Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751851AbeB0Rtf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 12:49:35 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49360 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751117AbeB0Rtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 12:49:33 -0500
Date: Tue, 27 Feb 2018 11:49:32 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Robin Jarry <robin.jarry@6wind.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2 3/3] objtool: use global host flags for compilation
Message-ID: <20180227174932.e4pbucnwhducv7xr@treble>
References: <cover.1519393674.git.robin.jarry@6wind.com>
 <cover.1519668832.git.robin.jarry@6wind.com>
 <2fa138b613417581eca23afd8741aaf75fbf966a.1519668832.git.robin.jarry@6wind.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2fa138b613417581eca23afd8741aaf75fbf966a.1519668832.git.robin.jarry@6wind.com>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 07:41:48PM +0100, Robin Jarry wrote:
> When libelf headers and libs are not found and CONFIG_UNWINDER_ORC is
> selected, there is a make error introduced by
> commit 3dd40cb320fe ("objtool: Upgrade libelf-devel warning to error for
> CONFIG_ORC_UNWINDER").
> 
> Host headers and libs may be in a non-standard location and the check is
> performed without host flags. Make sure to use host flags for the check
> and for building objtool. Remove duplicate flags.
> 
> Fixes: 3b27a0c85d70 ("objtool: Detect and warn if libelf is missing and don't break the build")
> Signed-off-by: Robin Jarry <robin.jarry@6wind.com>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> ---
>  Makefile               | 2 +-
>  tools/objtool/Makefile | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index f7c543cebfc6..c9dc35fe0e48 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -955,7 +955,7 @@ export mod_sign_cmd
>  
>  ifdef CONFIG_STACK_VALIDATION
>    has_libelf := $(call try-run,\
> -		echo "int main() {}" | $(HOSTCC) -xc -o /dev/null -lelf -,1,0)
> +	echo "int main() {}" | $(HOSTCC) $(HOSTLDFLAGS) -xc -o /dev/null -lelf -,1,0)

This should probably also have HOSTCFLAGS, since the objtool makefile
uses it as well.

-- 
Josh
