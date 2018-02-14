Return-Path: <kernel-hardening-return-11758-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x224BtEnteEeaJ39yMokl9SFF4RWVxTm7JxzkZzvdsjKL1CB795JXE4wS4osTKH3IHkdWhzEI
ARC-Seal: i=1; a=rsa-sha256; t=1518636179; cv=none;
        d=google.com; s=arc-20160816;
        b=DXBvxdVFUM4cRkTkcO8wraQc7g0J+QyPJfBMc4HIW0xl4jTWPpHuGBfprYQVxP0q00
         HFT4RGPPJffJycU8zPPsEiQr4BV1jJ69xAFNudg92oV3BJX2+gIImwL+qOpxIxYfdQCX
         uRN97wBXYM79Bf+Gtw1eQyo/u4vDz29/G2c3Uu2VGfp/rDTWsqoG/rJ23eEI57fKb/Ph
         AolEDXjaqTV8WRZgA63CGXT/AEIaBT1FuxEzFwWbfREHWquaGL+ES6sCVzz82pEAO6AB
         F3x3UpyePlgCWyowBQyxGlLCCkFxu2MGfHk24zevi5tiS8KhJ2keoh66tq0Io73V+jSw
         3iUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=Z2pU7HGIN5elFF5sBLj9vrV0QhrOAG6lcSSEkEP+iGQ=;
        b=SmiiyvA53cBDlTv80MmQnmCM5DvIrvhtlyGiVMOz2RMzKQJ8iG8r+SZb5GD/qk8ZyW
         e0+XKCqlz3KLkLDpd2ac3L5J4Kyi+2CtiBG4lIoI3ZgViVQE0Xn3GBR7e5pDjhBWpnaX
         bpgfDIxbCh02K9kPrLSpXtwv9KNkd2/B6Sss8+j77aJdYBOVXvuKi1OgbsUD3YshFxVI
         gXSoHOOptz+5tUwAWRxvOTnOMr81l7xGuRNLNNcTZw+/pPmuAXFBsNT/h3sumgLPDWO3
         T0fGfE6OcOpf9ZE2bJEb0ORpeyN5CUMmBIbsd8rsnozCONqcCkUM5/YW/ZckLHDmz5VO
         uNFA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=jN/E4YbA;
       dkim=pass header.i=@chromium.org header.s=google header.b=FtfEjZeh;
       spf=pass (google.com: domain of kernel-hardening-return-11758-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11758-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=jN/E4YbA;
       dkim=pass header.i=@chromium.org header.s=google header.b=FtfEjZeh;
       spf=pass (google.com: domain of kernel-hardening-return-11758-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11758-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180214182618.14627-3-willy@infradead.org>
References: <20180214182618.14627-1-willy@infradead.org> <20180214182618.14627-3-willy@infradead.org>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 14 Feb 2018 11:22:38 -0800
X-Google-Sender-Auth: xD-1pg1Xule7hFvixBJzy0-yDKM
Message-ID: <CAGXu5jL9hqQGe672CmvFwqNbtTr=qu7WRwHuS4Vy7o5sX_UTgg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: Add kvmalloc_ab_c and kvzalloc_struct
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <mawilcox@microsoft.com>,
	Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, Julia Lawall <julia.lawall@lip6.fr>,
	cocci@systeme.lip6.fr
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592401933337716102?=
X-GMAIL-MSGID: =?utf-8?q?1592405450777445639?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 14, 2018 at 10:26 AM, Matthew Wilcox <willy@infradead.org> wrote:
> From: Matthew Wilcox <mawilcox@microsoft.com>
>
> We have kvmalloc_array in order to safely allocate an array with a
> number of elements specified by userspace (avoiding arithmetic overflow
> leading to a buffer overrun).  But it's fairly common to have a header
> in front of that array (eg specifying the length of the array), so we
> need a helper function for that situation.
>
> kvmalloc_ab_c() is the workhorse that does the calculation, but in spite
> of our best efforts to name the arguments, it's really hard to remember
> which order to put the arguments in.  kvzalloc_struct() eliminates that
> effort; you tell it about the struct you're allocating, and it puts the
> arguments in the right order for you (and checks that the arguments
> you've given are at least plausible).
>
> For comparison between the three schemes:
>
>         sev = kvzalloc(sizeof(*sev) + sizeof(struct v4l2_kevent) * elems,
>                         GFP_KERNEL);
>         sev = kvzalloc_ab_c(elems, sizeof(struct v4l2_kevent), sizeof(*sev),
>                         GFP_KERNEL);
>         sev = kvzalloc_struct(sev, events, elems, GFP_KERNEL);
>
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
> ---
>  include/linux/mm.h | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 81bd7f0be286..ddf929c5aaee 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -557,6 +557,57 @@ static inline void *kvmalloc_array(size_t n, size_t size, gfp_t flags)
>         return kvmalloc(n * size, flags);
>  }
>
> +/**
> + * kvmalloc_ab_c() - Allocate memory.

Longer description, maybe? "Allocate a *b + c bytes of memory"?

> + * @n: Number of elements.
> + * @size: Size of each element (should be constant).
> + * @c: Size of header (should be constant).

If these should be constant, should we mark them as "const"? Or WARN
if __builtin_constant_p() isn't true?

> + * @gfp: Memory allocation flags.
> + *
> + * Use this function to allocate @n * @size + @c bytes of memory.  This
> + * function is safe to use when @n is controlled from userspace; it will
> + * return %NULL if the required amount of memory cannot be allocated.
> + * Use kvfree() to free the allocated memory.
> + *
> + * The kvzalloc_hdr_arr() function is easier to use as it has typechecking

renaming typo? Should this be "kvzalloc_struct()"?

> + * and you do not need to remember which of the arguments should be constants.
> + *
> + * Context: Process context.  May sleep; the @gfp flags should be based on
> + *         %GFP_KERNEL.
> + * Return: A pointer to the allocated memory or %NULL.
> + */
> +static inline __must_check
> +void *kvmalloc_ab_c(size_t n, size_t size, size_t c, gfp_t gfp)
> +{
> +       if (size != 0 && n > (SIZE_MAX - c) / size)
> +               return NULL;
> +
> +       return kvmalloc(n * size + c, gfp);
> +}
> +#define kvzalloc_ab_c(a, b, c, gfp)    kvmalloc_ab_c(a, b, c, gfp | __GFP_ZERO)

Nit: "(gfp) | __GFP_ZERO" just in case of insane usage.

> +
> +/**
> + * kvzalloc_struct() - Allocate and zero-fill a structure containing a
> + *                    variable length array.
> + * @p: Pointer to the structure.
> + * @member: Name of the array member.
> + * @n: Number of elements in the array.
> + * @gfp: Memory allocation flags.
> + *
> + * Allocate (and zero-fill) enough memory for a structure with an array
> + * of @n elements.  This function is safe to use when @n is specified by
> + * userspace as the arithmetic will not overflow.
> + * Use kvfree() to free the allocated memory.
> + *
> + * Context: Process context.  May sleep; the @gfp flags should be based on
> + *         %GFP_KERNEL.
> + * Return: Zero-filled memory or a NULL pointer.
> + */
> +#define kvzalloc_struct(p, member, n, gfp)                             \
> +       (typeof(p))kvzalloc_ab_c(n,                                     \
> +               sizeof(*(p)->member) + __must_be_array((p)->member),    \
> +               offsetof(typeof(*(p)), member), gfp)
> +
>  extern void kvfree(const void *addr);
>
>  static inline atomic_t *compound_mapcount_ptr(struct page *page)

It might be nice to include another patch that replaces some of the
existing/common uses of a*b+c with the new function...

Otherwise, yes, please. We could build a coccinelle rule for
additional replacements...

-Kees

-- 
Kees Cook
Pixel Security
