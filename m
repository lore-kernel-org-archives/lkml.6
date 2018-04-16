Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755226AbeDPN2L (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 09:28:11 -0400
Received: from mail.skyhub.de ([5.9.137.197]:57738 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754834AbeDPN2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 09:28:10 -0400
Date: Mon, 16 Apr 2018 15:27:31 +0200
From: Borislav Petkov <bp@alien8.de>
To: David Wang <davidwang@zhaoxin.com>
Cc: tony.luck@intel.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, brucechang@via-alliance.com,
        cooperyan@zhaoxin.com, qiyuanwang@zhaoxin.com, benjaminpan@viatech.com,
        lukelin@viacpu.com, timguo@zhaoxin.com
Subject: Re: [PATCH v2 1/2] x86/mce: new Centaur CPUs support MCE broadcasting
Message-ID: <20180416132731.GB29072@pd.tnic>
References: <1522640032-3357-1-git-send-email-davidwang@zhaoxin.com>
 <1522640032-3357-2-git-send-email-davidwang@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1522640032-3357-2-git-send-email-davidwang@zhaoxin.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 02, 2018 at 11:33:51AM +0800, David Wang wrote:
> This patch is used to tell the kernel that newer Centaur CPU support

Avoid writing "This patch" in the commit message of a patch. It is
tautologically useless.

> MCE broadcasting.
> 
> Signed-off-by: David Wang <davidwang@zhaoxin.com>
> ---
>  arch/x86/kernel/cpu/mcheck/mce.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
> index 7065846..c3db7ce 100644
> --- a/arch/x86/kernel/cpu/mcheck/mce.c
> +++ b/arch/x86/kernel/cpu/mcheck/mce.c
> @@ -1688,6 +1688,17 @@ static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)

This code doesn't belong in the "apply_quirks" function but in
__mcheck_cpu_init_vendor(). Just add a X86_VENDOR_CENTAUR case there.

I know, I know, there's a similar Intel piece which does the same thing
but all that quirks code should go to the vendor-specific init functions
and the quirks function be deleted. One day when I get bored...

>  		if (c->x86 == 6 && c->x86_model == 45)
>  			quirk_no_way_out = quirk_sandybridge_ifu;
>  	}
> +
> +	if (c->x86_vendor == X86_VENDOR_CENTAUR) {
> +		/*
> +		 * All newer Centaur CPUs support MCE broadcasting. Enable
> +		 * synchronization with a one second timeout.
> +		 */
> +		if ((c->x86 > 6 || (c->x86 == 6 && c->x86_model == 0xf && c->x86_mask >=0xe)) &&

arch/x86/kernel/cpu/mcheck/mce.c: In function ‘__mcheck_cpu_apply_quirks’:
arch/x86/kernel/cpu/mcheck/mce.c:1688:64: error: ‘struct cpuinfo_x86’ has no member named ‘x86_mask’; did you mean ‘x86_model’?
   if ((c->x86 > 6 || (c->x86 == 6 && c->x86_model == 0xf && c->x86_mask >=0xe)) &&
                                                                ^~~~~~~~
                                                                x86_model

and no, it needs to be x86_stepping.

Also,

ERROR: spaces required around that '>=' (ctx:WxV)
#40: FILE: arch/x86/kernel/cpu/mcheck/mce.c:1697:
+               if ((c->x86 > 6 || (c->x86 == 6 && c->x86_model == 0xf && c->x86_mask >=0xe)) &&
                                                                                      ^

Please integrate scripts/checkpatch.pl into your patch creation
workflow. Some of the warnings/errors *actually* make sense.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
