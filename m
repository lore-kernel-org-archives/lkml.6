Return-Path: <jgross@suse.com>
X-Google-Smtp-Source: AH8x22620/t24S9g1fZY9N7vfozZqn/mPXUq95qIbIY8Mk8Rty1UuOfw/8LfK6y+cnKw9Iv8oLRE
ARC-Seal: i=1; a=rsa-sha256; t=1518601561; cv=none;
        d=google.com; s=arc-20160816;
        b=KmBxWKhnc6fagt+XhEtskyVfw2vOTUCWx33zEt90P9RY93fcNreFnnShItVDm0qNn/
         DrJXRl29uS3ztqYa12QFeqlqlvICASalyIauo1/Gk7H7wUaV9G8+xtDxz+siJzEZPruZ
         s4PfjGxnq8degBDIMyoW+XbD6g+v/gCucIu2HEfKFs8CQowZ7AHpxawLVGzv5XZiB0yI
         H5I+NAZqFjszH5D5W2yCNVoEXsQ9dyBhLZ4RqMkYyEVlM2VQ7rcStxWVBoKC8iUIyGPh
         jEZR2rYGmhWoLGBOab9lxVk0ZVWTcQTHdNuzdz14ndudnNmUlJsgdWzvtA3OzzK95UcQ
         L8Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=t/CB3WnIXo2Zhy73EmST8kiSi9tKFmudDYKZhv33N5A=;
        b=KP1rsZzP/tdWL9dfjgZBKb88loQNs7/L3FT2vSoKH3PiE4FNRN4XSaasD1IXufVEb3
         kk7lGPKSXZ+EBVb54jxjzMIvh5sq+iiaupdaxRIr6LQWHEEWQWp3qaer+5UDHNMxaEc0
         pfotDsKOD89IdFpb+GWFWF556jX1hsU0LCwkx6BvfJW9Ez2JXzkRy60w95CR0J5uXFI8
         qgBSiHjZ3QJG0F68RK8sTEiPQ1psB3D2LUhBWlgKGEwH2JrTg4XKqvm9aGrrCRlmiAWO
         qhAoKr7v6bHyOVQ2+pig2Q5lxGq+4a01tHPkhcoZhjZ+y7JeCAcDA85ooWHrlxZS7YPK
         4N/w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jgross@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=jgross@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jgross@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=jgross@suse.com
Subject: Re: [PATCH 19/31] x86/mm/pae: Populate valid user PGD entries
To: Joerg Roedel <joro@8bytes.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Brian Gerst
 <brgerst@gmail.com>, David Laight <David.Laight@aculab.com>,
 Denys Vlasenko <dvlasenk@redhat.com>, Eduardo Valentin <eduval@amazon.com>,
 Greg KH <gregkh@linuxfoundation.org>, Will Deacon <will.deacon@arm.com>,
 aliguori@amazon.com, daniel.gruss@iaik.tugraz.at, hughd@google.com,
 keescook@google.com, Andrea Arcangeli <aarcange@redhat.com>,
 Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>, jroedel@suse.de
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
 <1518168340-9392-20-git-send-email-joro@8bytes.org>
From: Juergen Gross <jgross@suse.com>
Message-ID: <3913f255-7309-58c5-b6c3-39cf0e29a844@suse.com>
Date: Wed, 14 Feb 2018 10:45:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1518168340-9392-20-git-send-email-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914908450442630?=
X-GMAIL-MSGID: =?utf-8?q?1592369151442515376?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 09/02/18 10:25, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Generic page-table code populates all non-leaf entries with
> _KERNPG_TABLE bits set. This is fine for all paging modes
> except PAE.
> 
> In PAE mode only a subset of the bits is allowed to be set.
> Make sure we only set allowed bits by masking out the
> reserved bits.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  arch/x86/include/asm/pgtable_types.h | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
> index 3696398..5027470 100644
> --- a/arch/x86/include/asm/pgtable_types.h
> +++ b/arch/x86/include/asm/pgtable_types.h
> @@ -50,6 +50,7 @@
>  #define _PAGE_GLOBAL	(_AT(pteval_t, 1) << _PAGE_BIT_GLOBAL)
>  #define _PAGE_SOFTW1	(_AT(pteval_t, 1) << _PAGE_BIT_SOFTW1)
>  #define _PAGE_SOFTW2	(_AT(pteval_t, 1) << _PAGE_BIT_SOFTW2)
> +#define _PAGE_SOFTW3	(_AT(pteval_t, 1) << _PAGE_BIT_SOFTW3)
>  #define _PAGE_PAT	(_AT(pteval_t, 1) << _PAGE_BIT_PAT)
>  #define _PAGE_PAT_LARGE (_AT(pteval_t, 1) << _PAGE_BIT_PAT_LARGE)
>  #define _PAGE_SPECIAL	(_AT(pteval_t, 1) << _PAGE_BIT_SPECIAL)
> @@ -267,14 +268,35 @@ typedef struct pgprot { pgprotval_t pgprot; } pgprot_t;
>  
>  typedef struct { pgdval_t pgd; } pgd_t;
>  
> +#ifdef CONFIG_X86_PAE
> +
> +/*
> + * PHYSICAL_PAGE_MASK might be non-constant when SME is compiled in, so we can't
> + * use it here.
> + */
> +#define PGD_PAE_PHYS_MASK	(((1ULL << __PHYSICAL_MASK_SHIFT)-1) & PAGE_MASK)

I think PAGE_MASK is a 32 bit value here, so you are chopping off
the high physical address bits.

With that corrected the kernel is coming up as Xen PV guest.


Juergen
