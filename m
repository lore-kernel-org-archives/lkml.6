Return-Path: <mark.rutland@arm.com>
X-Google-Smtp-Source: AIpwx4945/m2U5rAlCfn8k/l8RxFN65ilRIyFUG7DdI6Ss4/KIiz8RKbLlcNyEzMzV0tYhDuDy++
ARC-Seal: i=1; a=rsa-sha256; t=1523268466; cv=none;
        d=google.com; s=arc-20160816;
        b=mF90RXEbuDZuygFKXctzxPjf5CH1OFjbbN6/6j0zir5X2E6WWr06nObHrx0e1PDjls
         KiCU1tY5JNFbZ4bwvPA9hwEwblLJYfR2hJ5LP7NvCeOD6Bg9uXW/g574JxGzZZv6V8y7
         uWSRc42UD1NfquWGSIzaX9RyQqfu9Sqxo9DHI1EJwNlXJ52yquMGPJHQErCR3W7FwBHl
         brBeiIEcfqAwAeWViD88WImPD8v3XvgDynuWJPh8d45YT3F3feG/GqREVngLYGvgw6/0
         bxsHozUemXoXEA88YqeiRJqNtB+Rmi9xB4xJgpkKDjyIcxnToq/HyCNYQ7XkqqpcVEHz
         skSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=nNpbrpc1WY8XS3Cz/TVF1ZbskuLQyFyaTTLxM3joF8g=;
        b=BEtcDaZMDVNfHKWlvjg0YTv397Llhs1pLKxNpP1ZJlLTF8/ajylQcAsgCLKnT1eFIX
         WScAtlVzBd5OI8es32fTW4ZUAYMWvr55y7pmMiY+NVAQPG2NwSjDC09Lp2whXE2PlooY
         4wqW5jOewdnz19O8SV0YG93pejmHbn6lyncdbeVv4gntDrKdTJPqFUzF5X44ASd/ZtJx
         Y3Ly/9XtMo1gIyvevcynerUpcylMVvopO1Rx+wrcyN8pEGfn6pmrn5Eb32OHo7Vb7xrP
         TmYwdEn82wJtggAtcVXw+U0A978PX3fmQlW3FTXgmwbrAA94Cxp6LjVN0vGE9Da7G1l/
         mEmg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of mark.rutland@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=mark.rutland@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of mark.rutland@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=mark.rutland@arm.com
Date: Mon, 9 Apr 2018 11:07:41 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Jean-Baptiste Theou <jb@essential.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Will Deacon <will.deacon@arm.com>, Dan Rue <dan.rue@linaro.org>,
	Mark Brown <mark.brown@linaro.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Greg Hackmann <ghackmann@google.com>
Subject: Re: Linux 4.9.93
Message-ID: <20180409100741.pwkflhaslx43slro@lakrids.cambridge.arm.com>
References: <20180409180534.1768583293d0abe207168c5a@essential.com>
 <20180409093028.GA3398@kroah.com>
 <CAKv+Gu9Ny=EatuqrVOEFbOt+h0rH5uqxxDyHFT-PLH72ZzvZiw@mail.gmail.com>
 <20180409185751.247a0ac7@jbtheou>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409185751.247a0ac7@jbtheou>
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597258846269332204?=
X-GMAIL-MSGID: =?utf-8?q?1597262755627295507?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 09, 2018 at 06:57:51PM +0900, Jean-Baptiste Theou wrote:
> On Mon, 9 Apr 2018 11:49:37 +0200
> Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> 
> > On 9 April 2018 at 11:30, Greg KH <gregkh@linuxfoundation.org> wrote:
> > > On Mon, Apr 09, 2018 at 06:05:34PM +0900, Jean-Baptiste Theou wrote:  
> > >> Hi,
> > >>
> > >> After this patchset, a kernel built with CFI fails. Disabling
> > >> UNMAP_KERNEL_AT_EL0 fix the issue obviously.  
> > 
> > How does one 'build a kernel with CFI' for arm64?
> 
> From Google work on Android-4.9
> 
> https://android.googlesource.com/kernel/common/+/00a195e7c0752ff5d65c9caadfbcc226270ca232
> 
> I am not sure what is the plan on their side to upstream (Greg?), but definitely
> useful to isolate actual issues.
> 
> > > Is this a "clean" 4.9.93 tree or a "4.9.93 merged into
> > > android-common-4.9?
> 
> It's a "clean 4.9.93" + whatever is needed for Clang/CFI support
> 
> My take is that CFI doesn't like 
> 
>  * void __kpti_install_ng_mappings(int cpu, int num_cpus, phys_addr_t swapper)
> 
> and 
> 
> remap_fn = (void *)__pa_symbol(idmap_kpti_install_ng_mappings);
> 
> Maybe just flag this function to not use CFI? I remember that Sami Tolvanen did
> similar changes.

>From a quick scan, it looks like CFI uses shadow memory for function
prologues. Since we're taking the PA of a function pointer, presumably
this no longer maps to valid shadow.

I'd expect the same to apply to uses of cpu_replace_ttbr1(), but it
looks like the only user of that is marked as __init, and that patch
adds __nocfi to __init functions.

So you probably need to mark kpti_install_ng_mappings() as __nocfi.
 
> I know it's a bit out of context since CFI support for ARM64 is not upstream yet,
> but unfortunate that an stable patchset trigger such failures.

This is simply the nature of out-of-tree code.

In future, it would be very helpful if you could provide context for
out-of-tree patches in the initial report.

Thanks,
Mark.
