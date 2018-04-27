Return-Path: <kernel-hardening-return-13149-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AB8JxZp1UJMt80kNO5LMuvyUU7DH1OCbCjdegx2HaA6xRsDNkYAqeXYR1Zl+PerRPoTkVETotLKo
ARC-Seal: i=1; a=rsa-sha256; t=1524824846; cv=none;
        d=google.com; s=arc-20160816;
        b=Exz8g3NVbBqTWPViv5fZvSLwuPGobVXdFuuN+k6w3CWA2LANoggQnVmiO842WQ9pWf
         hvStOK5aoThPnrED/sYzlBNEy3v6jSNdoimV415reB4rdu29oI1smakMzs4xcz2UB9c9
         m8i07/NXq9jnDG6xC9BQhoLUYqjK107PciAuu1aI89te0oerpejUopnt5fDLzMEtrzGZ
         l6oPLBglipQeZ5xpmtKt7kD0F1unqzcpXjzrj3LuiqGcfMwDMXYX9YKLVmtvOZkAdXw1
         OrSPwdkEJu4AzILLzB33s4bysy8z4KD4171ABFub34+vnr5dawE5ogaqRCPkwzTGymre
         Yhsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=w3K4DloBg39nh1s4CZPnM/gL+N9ficNwzFWbgcexyCU=;
        b=R/qeTygW9N8Io2GUO6QBdxlbYFLS1Tm66S04AiqR9Lkk8grd86RNX1s0nk9zxH2JYY
         1b7m18jfyAmtsAIQ7EyCvoaQ/aBWjSRadw6R1x8JuAAuyx7T9CJs/Bv237YXCTGBPVD4
         Vp2A9d1WBIZ4onvfxaRw5thmZio1i+Dma2tpgiRQvXHHP5UaaQmBxhNF8Y9FZMEuuEEa
         h+02FuVwksR+9KOfe2ZM0i3Z9ILBHeFMkidKViDwh45GNkIfFXJDFUskFO3sCxOnJIsu
         AJ9vbNPnSCspOty20gW61hqfTYzb9MdF7jWzKT55lOhx0WinqWssdmyWhpgfoFD4XwRy
         ktDg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13149-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13149-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13149-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13149-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Fri, 27 Apr 2018 11:27:03 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
	drjones@redhat.com, cdall@kernel.org, arnd@arndb.de,
	suzuki.poulose@arm.com, marc.zyngier@arm.com,
	awallis@codeaurora.org, kernel-hardening@lists.openwall.com,
	will.deacon@arm.com, linux-kernel@vger.kernel.org,
	ramana.radhakrishnan@arm.com, kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCHv3 07/11] arm64: add basic pointer authentication support
Message-ID: <20180427102703.7azck754cnjm232p@lakrids.cambridge.arm.com>
References: <20180417183735.56985-1-mark.rutland@arm.com>
 <20180417183735.56985-8-mark.rutland@arm.com>
 <20180425112331.hke7afxnslyrwf3h@armageddon.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425112331.hke7afxnslyrwf3h@armageddon.cambridge.arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598019777095215790?=
X-GMAIL-MSGID: =?utf-8?q?1598894738365540601?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 25, 2018 at 12:23:32PM +0100, Catalin Marinas wrote:
> Hi Mark,
> 
> On Tue, Apr 17, 2018 at 07:37:31PM +0100, Mark Rutland wrote:
> > diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
> > index 39ec0b8a689e..caf0d3010112 100644
> > --- a/arch/arm64/include/asm/mmu_context.h
> > +++ b/arch/arm64/include/asm/mmu_context.h
> > @@ -29,7 +29,6 @@
> >  #include <asm/cacheflush.h>
> >  #include <asm/cpufeature.h>
> >  #include <asm/proc-fns.h>
> > -#include <asm-generic/mm_hooks.h>
> >  #include <asm/cputype.h>
> >  #include <asm/pgtable.h>
> >  #include <asm/sysreg.h>
> > @@ -168,7 +167,14 @@ static inline void cpu_replace_ttbr1(pgd_t *pgdp)
> >  #define destroy_context(mm)		do { } while(0)
> >  void check_and_switch_context(struct mm_struct *mm, unsigned int cpu);
> >  
> > -#define init_new_context(tsk,mm)	({ atomic64_set(&(mm)->context.id, 0); 0; })
> > +static inline int init_new_context(struct task_struct *tsk,
> > +			struct mm_struct *mm)
> > +{
> > +	atomic64_set(&mm->context.id, 0);
> > +	mm_ctx_ptrauth_init(&mm->context);
> > +
> > +	return 0;
> > +}
> >  
> >  #ifdef CONFIG_ARM64_SW_TTBR0_PAN
> >  static inline void update_saved_ttbr0(struct task_struct *tsk,
> > @@ -216,6 +222,8 @@ static inline void __switch_mm(struct mm_struct *next)
> >  		return;
> >  	}
> >  
> > +	mm_ctx_ptrauth_switch(&next->context);
> > +
> >  	check_and_switch_context(next, cpu);
> >  }
> >  
> > @@ -241,6 +249,19 @@ switch_mm(struct mm_struct *prev, struct mm_struct *next,
> >  void verify_cpu_asid_bits(void);
> >  void post_ttbr_update_workaround(void);
> >  
> > +static inline void arch_dup_mmap(struct mm_struct *oldmm,
> > +				 struct mm_struct *mm)
> > +{
> > +	mm_ctx_ptrauth_dup(&oldmm->context, &mm->context);
> > +}
> > +#define arch_dup_mmap arch_dup_mmap
> 
> IIUC, we could skip the arch_dup_mmap() and init_new_context() here for
> the fork() case since the ptrauth_keys would be copied as part of the
> dup_mm().

If we can hook into the exec*() path to init the keys, then I agree we
can do this...

> There is another situation where init_new_context() is called
> bprm_mm_init() -> mm_alloc() -> mm_init() -> init_new_context().
> However, in this case the core code also calls arch_bprm_mm_init(). So I
> think we only need to update the latter to get a new random key.

... and this seems to be the right place to do it, so I'll have a go.

> > diff --git a/arch/arm64/include/asm/pointer_auth.h b/arch/arm64/include/asm/pointer_auth.h
> > new file mode 100644
> > index 000000000000..a2e8fb91fdee
> > --- /dev/null
> > +++ b/arch/arm64/include/asm/pointer_auth.h
> > @@ -0,0 +1,89 @@
> > +/*
> > + * Copyright (C) 2016 ARM Ltd.
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> > + */
> 
> Nitpick: 2018. You could also use the SPDX header, save some lines.

Sure, I'll replace this with a SPDX GPL-2.0 line.

Thanks,
Mark.
