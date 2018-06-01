Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751364AbeFAHL6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 03:11:58 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34304 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750760AbeFAHL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 03:11:57 -0400
Date: Fri, 1 Jun 2018 09:12:15 +0200
From: Borislav Petkov <bp@alien8.de>
To: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        Srinivas REDDY Eeda <srinivas.eeda@oracle.com>, hpa@zytor.com
Subject: Re: [PATCH] x86/microcode/intel: Fix memleak in save_microcode_patch
Message-ID: <20180601071215.GD17783@nazgul.tnic>
References: <888102f0-fd22-459d-b090-a1bd8a00cb2b@default>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <888102f0-fd22-459d-b090-a1bd8a00cb2b@default>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 09:51:05PM -0700, Zhenzhong Duan wrote:
> Free useless ucode_patch entry when it's replaced.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
> ---
>  arch/x86/kernel/cpu/microcode/intel.c |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
> index 1c2cfa0..461e315 100644
> --- a/arch/x86/kernel/cpu/microcode/intel.c
> +++ b/arch/x86/kernel/cpu/microcode/intel.c
> @@ -150,6 +150,12 @@ static bool microcode_matches(struct microcode_header_intel *mc_header,
>  	return false;
>  }
>  
> +static void memfree_patch(struct ucode_patch *p)
> +{
> +	kfree(p->data);
> +	kfree(p);
> +}
> +
>  static struct ucode_patch *memdup_patch(void *data, unsigned int size)
>  {
>  	struct ucode_patch *p;
> @@ -190,8 +196,10 @@ static void save_microcode_patch(void *data, unsigned int size)
>  			p = memdup_patch(data, size);
>  			if (!p)
>  				pr_err("Error allocating buffer %p\n", data);
> -			else
> +			else {
>  				list_replace(&iter->plist, &p->plist);
> +				memfree_patch(iter);

Looks correct. I've dropped the memfree_patch() two-liner though and
made it do kfree() directly.

Thx.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
