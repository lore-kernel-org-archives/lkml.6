Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933537AbeEWOq4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 10:46:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:36361 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933149AbeEWOqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 10:46:50 -0400
Date: Wed, 23 May 2018 16:46:21 +0200
From: Borislav Petkov <bp@suse.de>
To: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc: x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Radim Krcmar <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Use 'imply' with SEV Kconfig CRYPTO dependencies
Message-ID: <20180523144621.GB25143@pd.tnic>
References: <1526915573-22917-1-git-send-email-Janakarajan.Natarajan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1526915573-22917-1-git-send-email-Janakarajan.Natarajan@amd.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Tom and Brijesh.

On Mon, May 21, 2018 at 10:12:53AM -0500, Janakarajan Natarajan wrote:
> Use Kconfig imply 'option' when specifying SEV CRYPTO dependencies.
> 
> Example configuration:
> .
> .
> CONFIG_CRYPTO_DEV_CCP=y
> CONFIG_CRYPTO_DEV_CCP_DD=m
> CONFIG_CRYPTO_DEV_SP_CCP=y
> CONFIG_CRYPTO_DEV_CCP_CRYPTO=m
> CONFIG_CRYPTO_DEV_SP_PSP=y
> .
> .
> CONFIG_KVM_AMD=y
> CONFIG_KVM_AMD_SEV=y
> .
> .
> 
> When the CRYPTO_DEV_SP_DD is m, KVM_AMD set to y produces compile time
> errors.
> 
> Since KVM_AMD_SEV depends on KVM_AMD and CRYPTO_DEV_CCP_DD, the
> issue can be prevented by using 'imply' Kconfig option when specifying
> the CRYPTO dependencies.
> 
> Fixes: 505c9e94d832 ("KVM: x86: prefer "depends on" to "select" for SEV")
> 
> Signed-off-by: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
> ---
>  arch/x86/kvm/Kconfig | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> index 92fd433..d9b16b7 100644
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
> @@ -85,7 +85,9 @@ config KVM_AMD_SEV
>  	def_bool y
>  	bool "AMD Secure Encrypted Virtualization (SEV) support"
>  	depends on KVM_AMD && X86_64
> -	depends on CRYPTO_DEV_CCP && CRYPTO_DEV_CCP_DD && CRYPTO_DEV_SP_PSP
> +	imply CRYPTO_DEV_CCP
> +	imply CRYPTO_DEV_CCP_DD
> +	imply CRYPTO_DEV_SP_PSP
>  	---help---
>  	Provides support for launching Encrypted VMs on AMD processors.

Well, this solves the build issue but I just created a config:

$ grep -E "(KVM|PSP)" .config | grep -v '#'
CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_KVM=y
CONFIG_KVM_AMD=m

which builds but the PSP functionality is not there. And I don't think
this is serving the user: she should be able to select what she wants
and get the required functionality added and not have build errors with
any possible configuration.

Now, looking at the security processor Kconfig stuff, it is somewhat
confusing but maybe I didn't look at it long enough. A couple of points:

config CRYPTO_DEV_CCP_DD
        tristate "Secure Processor device driver"

If this is going to be the top-level menu item for the SP, call that

 CRYPTO_DEV_SP

to mean, this is the security processor. CCP_DD is confusing because you
have CRYPTO_DEV_SP_CCP which is the crypto coprocessor support.

And "DD" for device driver is a pure tautology - most of the Kconfig
items are device drivers :)

Then,

 config KVM_AMD_SEV
        def_bool y
        bool "AMD Secure Encrypted Virtualization (SEV) support"
        depends on KVM_AMD && X86_64
        depends on CRYPTO_DEV_CCP && CRYPTO_DEV_CCP_DD && CRYPTO_DEV_SP_PSP

that last line is pulling the required functionality for SEV but - and
I *think* we have talked about this before - having a hierarchical
dependency should make this a lot clearer and fix the build issues along
the way.

Because, IMHO, KVM_AMD_SEV should depend only on CRYPTO_DEV_SP_PSP -
i.e., the PSP device because SEV needs the PSP, right?

Now, the PSP device *itself* should depend on whatever it needs to
function properly, CRYPTO_DEV_CCP_DD I guess.

But SEV should not depend on CRYPTO_DEV_CCP - which is the top-level
Kconfig item - that should be expressed implicitly through the
dependency chain where PSP ends up depending on it.

So that you have one-hop deps:

KVM_SEV -> PSP -> CCP -> ...

IOW, a config item, say PSP - if enabled - should make sure it
selects/depends on everything it needs to function. The upper level
item KVM_SEV - which selects/depends on that config item shouldn't
be responsible for making sure the correct items for PSP's proper
functioning are enabled - that's PSP's item's job.

Makes sense?

Maybe I'm missing something but applying this simple logic would prevent
such Kconfig build issues and make the whole dependency chain almost
trivial.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
