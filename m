Return-Path: <catalin.marinas@arm.com>
X-Google-Smtp-Source: AB8JxZplXu/Awjminna7Rc+Xi9tPigkgqzH4idmu7sE05VKZGrRryUtpyCKddVCLt+x3l1m0GBa9
ARC-Seal: i=1; a=rsa-sha256; t=1524757653; cv=none;
        d=google.com; s=arc-20160816;
        b=EpPSRPcJstc4CUrT65bMnUwubUHIdbZrvZzydWOj7ClaQOuaHCFM9aDphbVMgA7Qjz
         PoFWqqbn08tIdf0yg96+qTiak/odk4poICEnmezYw+iytKYK1zjl9NsLZihq4Q7Yd0Fy
         dWCX3XnC1vd87XidCpo71yptSEr2UcafXMKJRg2ujGtyCufASDV5Ik8UyWsTG0EFsdnu
         qEYgggI06aE2Fi4ykAnn8iBpClOMdinpSpjBExqVF1nhxhxJ5CqdUIJP/DeGKLNsEuSV
         mccgBp/OMnfXv+zI/xVBQ4/Ihx4Lo/NCtCBcyPn9sak6L7dWhMpRE2Zl7ih3rr+dnt2h
         Oi7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=OG9B5dNycAAY30vBTOJqUq+f3w3nvMf2/Po6sjvVRCU=;
        b=bLkmH29jR/9LqxkojvyHerR5IeexVayfAOi0D3BWwib3bFWYsalax7/IiCyonbzJeC
         MnpyVN17E4IT0LnkPkPC5ZZgiljSoI4jNkAG+GvN+Z3MS31jrGFbTdOBPR4uEms7DXF+
         fDkMno+mqvUbM5UoNZ+Fa2ozcXhOcswlIod84Ja5Fu8m9U26+sCpD3ABjS0MvgHbn+9C
         czgqUUBz/NOeyhVQxGj/j9XcPnncfyzoAtg4nvRgxjX+GhleD00de/eWcqc0gOjulO39
         jlYvbL3m5rVWLUguX/P7rzzalMoMQCn5Pahghl1QSp81t5iRTKY27cRA4IFMwOR+vfMA
         XIHQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of catalin.marinas@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=catalin.marinas@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of catalin.marinas@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=catalin.marinas@arm.com
Date: Thu, 26 Apr 2018 16:47:25 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Andrey Konovalov <andreyknvl@google.com>
Cc: Will Deacon <will.deacon@arm.com>, Jonathan Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	James Morse <james.morse@arm.com>,
	Kees Cook <keescook@chromium.org>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@kernel.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
	Zi Yan <zi.yan@cs.rutgers.edu>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Jacob Bramley <Jacob.Bramley@arm.com>,
	Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
	Lee Smith <Lee.Smith@arm.com>, Kostya Serebryany <kcc@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
	Evgeniy Stepanov <eugenis@google.com>
Subject: Re: [PATCH 3/6] arm64: untag user addresses in copy_from_user and
 others
Message-ID: <20180426154725.74a33tnevvbtqx63@armageddon.cambridge.arm.com>
References: <cover.1524077494.git.andreyknvl@google.com>
 <949c343a4b02b41b80f324c2b7cd56b75e6a04f3.1524077494.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <949c343a4b02b41b80f324c2b7cd56b75e6a04f3.1524077494.git.andreyknvl@google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598111197844196620?=
X-GMAIL-MSGID: =?utf-8?q?1598824281513969643?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 18, 2018 at 08:53:12PM +0200, Andrey Konovalov wrote:
> @@ -238,12 +239,15 @@ static inline void uaccess_enable_not_uao(void)
>  /*
>   * Sanitise a uaccess pointer such that it becomes NULL if above the
>   * current addr_limit.
> + * Also untag user pointers that have the top byte tag set.
>   */
>  #define uaccess_mask_ptr(ptr) (__typeof__(ptr))__uaccess_mask_ptr(ptr)
>  static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
>  {
>  	void __user *safe_ptr;
>  
> +	ptr = untagged_addr(ptr);
> +
>  	asm volatile(
>  	"	bics	xzr, %1, %2\n"
>  	"	csel	%0, %1, xzr, eq\n"

First of all, passing a tagged user pointer throughout the kernel is
safe with uaccess routines but not suitable for find_vma() etc.

With this change, we may have an inconsistent behaviour on the tag
masking, depending on whether the entry code uses __uaccess_mask_ptr()
or not. We could preserve the tag with something like:

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index e66b0fca99c2..ed15bfcbd797 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -244,10 +244,11 @@ static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
 	void __user *safe_ptr;
 
 	asm volatile(
-	"	bics	xzr, %1, %2\n"
+	"	bics	xzr, %3, %2\n"
 	"	csel	%0, %1, xzr, eq\n"
 	: "=&r" (safe_ptr)
-	: "r" (ptr), "r" (current_thread_info()->addr_limit)
+	: "r" (ptr), "r" (current_thread_info()->addr_limit),
+	  "r" (untagged_addr(ptr))
 	: "cc");
 
 	csdb();

-- 
Catalin
