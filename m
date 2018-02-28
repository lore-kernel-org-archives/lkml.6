Return-Path: <mhocko@kernel.org>
X-Google-Smtp-Source: AH8x227T+sr6YkmbPS9iNdEO1ifWipj5qk1XpeX6+VMproL2Lqmg1pbCESUi1M4G75JGEWz0U89j
ARC-Seal: i=1; a=rsa-sha256; t=1519802284; cv=none;
        d=google.com; s=arc-20160816;
        b=EKPMcXtbrWTkPbD2cjFbpamw+3whYE0cHs7o7prCUAVbpzkw5VIDW/jSYu42uB3osX
         rLL26fpHsz409X9K2oNx7ZwKGd2UVqE0nJNzon00zgt+ztjvbLcD8IeoTPZjx0FmI+t9
         IM6bGYkl0D1019ncZgwMwC4m/+90QknfRrL1lm6FvdyDi4lzXGdaLUZSNtdMNyHaMbq6
         xg5qNUfISiMPRW9FGFXNheFXFAqmXxSWTrPpot8LaiYEqTVWXl3m1kcgctWxkZdE/DEl
         LjsR15iFE15fJ/IuBILi5BOmrm84S15RjVgzDXR/F3kxD7BJIGLix3IXUjoKlgPNBgX0
         7zeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=QfkF/g17/ICF8jP6X73W3lu6nSWlN3eFxkoBPer9Nro=;
        b=we6BEmlobxEW6uFVBF/TCYq3glKrnfBVAT0NNFVyA4KX+u42iIulX6q42eWNnen5li
         HuicANosAB0DVQhlyfx5C+cercbrdUG9ArYMmFO4oqMXcYkACYbC/4L4RN783+ZHerJk
         BGipuwgZlyysdiU+hAX7nnMm0O/XVMrxwnAQsR0x8i66+SgYVB4A7JoFEERquKhjxXlb
         ZDxf9f6FXK8LhWumkxfEQYuF0AyCmY/F62ATfdWT7E9v5W88EnN3KwtX4h0sUUWNi2QH
         dKgmND6LuZAUmGvdfkS8HbyCRMzZhDL1axr8L+2YpBVzGsFlR4ID/ORMyERCv4A3EjLD
         HSNg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of mhocko@kernel.org) smtp.mailfrom=mhocko@kernel.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of mhocko@kernel.org) smtp.mailfrom=mhocko@kernel.org
Date: Wed, 28 Feb 2018 08:17:59 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Ilya Smith <blackzert@gmail.com>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
	kirill.shutemov@linux.intel.com, dsafonov@virtuozzo.com,
	hughd@google.com, gregkh@linuxfoundation.org, craigb@google.com,
	oleg@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] Take mmap_min_addr into account while choosing
 unmapped address for x86-64.
Message-ID: <20180228071759.GN15357@dhcp22.suse.cz>
References: <20180226211257.63067-1-blackzert@gmail.com>
 <20180227085726.GC15357@dhcp22.suse.cz>
 <B6A5E9B0-4986-4CD4-B01A-B6218D859579@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B6A5E9B0-4986-4CD4-B01A-B6218D859579@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593499619093217840?=
X-GMAIL-MSGID: =?utf-8?q?1593628199783398427?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue 27-02-18 16:27:29, Ilya Smith wrote:
> > 
> > mmap_min_addr handling is a bit mess... As you say, we would return
> > EPERM rather than ENOMEM which can be confusing but depleting the
> > address space like that is quite unlikely on 64b unless I am missing.
> > It is good to be in sync here with the generic implementation though,
> > IMO.
> > 
> 
> If we take a look on mm/mmap.c:
> #ifndef HAVE_ARCH_UNMAPPED_AREA_TOPDOWN
> unsigned long
> arch_get_unmapped_area_topdown(
> …
> 	if (len > TASK_SIZE - mmap_min_addr)
> 		return -ENOMEM;
> …
> 	info.low_limit = max(PAGE_SIZE, mmap_min_addr);
> 
> And this one looks like a generic implementation.
> But for many other architectures like arch/parisc/kernel/sys_parisc.c 
> or arch/x86/kernel/sys_x86_64.c
> 
> 	info.low_limit = PAGE_SIZE;

Yeah, this is what I meant when saying that mmap_min_addr is a bit of a
mess. I am wondering whether the low_limit should be checked inside
vm_unmapped_area. We would still need some mmap_min_addr handling at
arch_get_unmapped_area_topdown layer which is still suboptimal but I do
not see an easy way around without reworking how the arch specific parts
are implemented currently.
-- 
Michal Hocko
SUSE Labs
