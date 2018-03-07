Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754312AbeCGMLd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 07:11:33 -0500
Received: from mail.skyhub.de ([5.9.137.197]:57566 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751150AbeCGMLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 07:11:31 -0500
Date: Wed, 7 Mar 2018 13:11:20 +0100
From: Borislav Petkov <bp@alien8.de>
To: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chun-Yi Lee <jlee@suse.com>, Tony Luck <tony.luck@intel.com>,
        Will Deacon <will.deacon@arm.com>, Dave Hansen <dave.hansen@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Peter Zijlstra <peter.zijlstra@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH V2 2/3] efi: Introduce efi_rts_workqueue and some
 infrastructure to invoke all efi_runtime_services()
Message-ID: <20180307121047.GG23662@pd.tnic>
References: <1520292190-5027-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <1520292190-5027-3-git-send-email-sai.praneeth.prakhya@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1520292190-5027-3-git-send-email-sai.praneeth.prakhya@intel.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2018 at 03:23:09PM -0800, Sai Praneeth Prakhya wrote:
> +#define efi_queue_work(_rts, _arg1, _arg2, _arg3, _arg4, _arg5)		\
> +({									\
> +	struct efi_runtime_work efi_rts_work;				\
> +									\
> +	INIT_WORK_ONSTACK(&efi_rts_work.work, efi_call_rts);		\
> +	efi_rts_work.func = _rts;					\
> +	efi_rts_work.arg1 = _arg1;					\
> +	efi_rts_work.arg2 = _arg2;					\
> +	efi_rts_work.arg3 = _arg3;					\
> +	efi_rts_work.arg4 = _arg4;					\
> +	efi_rts_work.arg5 = _arg5;					\
> +	/*								\
> +	 * queue_work() returns 0 if work was already on queue,		\
> +	 * _ideally_ this should never happen.				\
> +	 */								\
> +	if (queue_work(efi_rts_wq, &efi_rts_work.work))			\
> +		flush_work(&efi_rts_work.work);				\
> +	else								\
> +		BUG();							\

So failure to queue that work is such a critical problem that we need
to BUG() and can't possibly continue and shoult not attempt recovery at
all?

IOW, we should always strive to fail gracefully and not shit in pants at
the first sign of trouble.

Even checkpatch warns here:

WARNING: Avoid crashing the kernel - try using WARN_ON & recovery code rather than BUG() or BUG_ON()
#184: FILE: drivers/firmware/efi/runtime-wrappers.c:92:
+               BUG();                                                  \


and by looking at the other output, you should run your patches through
checkpatch. Some of the things make sense like:

WARNING: quoted string split across lines
#97: FILE: drivers/firmware/efi/efi.c:341:
+               pr_err("Failed to create efi_rts_workqueue, EFI runtime services "
+                      "disabled.\n");

for example.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
