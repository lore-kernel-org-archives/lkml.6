Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753606AbeCFMnc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 07:43:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:42320 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750933AbeCFMna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 07:43:30 -0500
Date: Tue, 6 Mar 2018 13:43:26 +0100
From: Petr Mladek <pmladek@suse.com>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
        Dave Young <dyoung@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] dump_stack: convert generic dump_stack into a weak symbol
Message-ID: <20180306124326.ucom526x6giwp2br@pathway.suse.cz>
References: <20180305053742.9149-1-sergey.senozhatsky@gmail.com>
 <20180305144846.3jommv372c73dltt@pathway.suse.cz>
 <20180306042957.GE6713@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180306042957.GE6713@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2018-03-06 13:29:57, Sergey Senozhatsky wrote:
> On (03/05/18 15:48), Petr Mladek wrote:
> [..]
> > 
> > I hope that I did not miss anything. I could not try this at
> > runtime.
> 
> I think you can. The rules are universal, you can do on x86
> something like this
> 
> ---
> 
>  arch/x86/kernel/dumpstack.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
> index a2d8a3908670..5d45f406717e 100644
> --- a/arch/x86/kernel/dumpstack.c
> +++ b/arch/x86/kernel/dumpstack.c
> @@ -375,3 +375,16 @@ static int __init code_bytes_setup(char *s)
>  	return 1;
>  }
>  __setup("code_bytes=", code_bytes_setup);
> +
> +void dump_stack(void)
> +{
> +	dump_stack_print_info(KERN_DEFAULT);
> +
> +	pr_crit("\t\tLinux\n\n");
> +
> +	pr_crit("An error has occurred. To continue:\n"
> +		"Press Enter to return to Linux, or\n"
> +		"Press CTRL+ALT+DEL to restart your computer.\n");
> +
> +	pr_crit("\n\n\tPress any key to continue _");
> +}
> 
> ---
> 
> Should be enough for testing.

Yup, this worked.

I have pushed the patch into printk.git for-4.17 branch,
see https://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk.git/commit/?h=for-4.17&id=33251b634b4aa1317e2f911e3b723179949a0605


Greentime Hu,

the for-4.17 branch in printk.git is based on Linus' tree. Therefore
I had to remove the hunk against arch/nds32/kernel/traps.c because
this file is only in linux-next.

I think that it might be easier if you remove the EXPORT_SYMBOL()
in your branch. Is it OK for you, please?

Best Regards,
Petr
