Return-Path: <kernel-hardening-return-11760-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x2246HkK8ZhcWzE2r16Ni6AvloHlu0r2RYrawx9ND5PDO4purcSaK49NAb9AX/PCGWBXDjauV
ARC-Seal: i=1; a=rsa-sha256; t=1518636485; cv=none;
        d=google.com; s=arc-20160816;
        b=b7THujspwhzP/NO8uHDeXSBhcrZsCOSMd4a6iscnQSexn2t5/xPUe+/VCdcH4R6JZ6
         UKvnqa3Gw98CmPVWU11ir0SlXOMW+i2kXc90UZKBk5v0JzeziWaJ8Ytny4l0QnJBZWTD
         Wj8bBpP6AkVAhejraJdSgayplUQeooCftLoCyHCqYYu90c6pO26qUcagMvJ7d0hq7QbT
         1XIXZ3GlIP3Xd36Pd7O2CtWZToak9pgtiqAVTxE02JDaW9BpozBg+j1K867KMW8dHWB3
         7trWJhy+ahVVJILE8433fyRFmeBBOD/hOpZ+RA+AfL9IwwgJYHp1hkZ5xRNYO2/fdlYl
         LRCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=MN1F2np1bJafkAF/Bd3V73K6ITijlYNY3Y/66BI8LzQ=;
        b=y7pgqPqyfkVd2k4jovhhf1xXmMpvM/soYX/Sb1TRpmBFSagoONWqGz3iCZijid6sJF
         qS3/RkEuKcrmsyr6EaHPl1IF4nznXcuIkKe9r7FGLkowDgtkd0ckLAfeO95irtU7Ze3U
         sMpZ/4+uyo/E7HP9fc0UfRWzDt5VKclTdZ1OvSciw1lA5ec0prbDqaO7AqLYDOQQnTa0
         LT/s6Amu3kibluya1TBuyY5w4M61DDC3ifrZ61AdwkR5upQ//hEHHg8KPl0IxTe/W40Z
         daacJd3ked4oQRlqHj/i0V4v7vRgRnpVSgCSXo4Ts/U4ofvI9D+DFbYr3LsIuNd+BNN+
         p4/g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11760-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11760-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11760-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11760-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-IronPort-AV: E=Sophos;i="5.46,513,1511823600";
   d="scan'208";a="254816015"
Date: Wed, 14 Feb 2018 20:27:46 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Kees Cook <keescook@chromium.org>
cc: Matthew Wilcox <willy@infradead.org>,
    Andrew Morton <akpm@linux-foundation.org>,
    Matthew Wilcox <mawilcox@microsoft.com>, Linux-MM <linux-mm@kvack.org>,
    LKML <linux-kernel@vger.kernel.org>,
    Kernel Hardening <kernel-hardening@lists.openwall.com>,
    cocci@systeme.lip6.fr
Subject: Re: [PATCH 2/2] mm: Add kvmalloc_ab_c and kvzalloc_struct
In-Reply-To: <CAGXu5jL9hqQGe672CmvFwqNbtTr=qu7WRwHuS4Vy7o5sX_UTgg@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1802142026520.2178@hadrien>
References: <20180214182618.14627-1-willy@infradead.org> <20180214182618.14627-3-willy@infradead.org> <CAGXu5jL9hqQGe672CmvFwqNbtTr=qu7WRwHuS4Vy7o5sX_UTgg@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592401933337716102?=
X-GMAIL-MSGID: =?utf-8?q?1592405771572776420?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On Wed, 14 Feb 2018, Kees Cook wrote:

> On Wed, Feb 14, 2018 at 10:26 AM, Matthew Wilcox <willy@infradead.org> wrote:
> > From: Matthew Wilcox <mawilcox@microsoft.com>
> >
> > We have kvmalloc_array in order to safely allocate an array with a
> > number of elements specified by userspace (avoiding arithmetic overflow
> > leading to a buffer overrun).  But it's fairly common to have a header
> > in front of that array (eg specifying the length of the array), so we
> > need a helper function for that situation.
> >
> > kvmalloc_ab_c() is the workhorse that does the calculation, but in spite
> > of our best efforts to name the arguments, it's really hard to remember
> > which order to put the arguments in.  kvzalloc_struct() eliminates that
> > effort; you tell it about the struct you're allocating, and it puts the
> > arguments in the right order for you (and checks that the arguments
> > you've given are at least plausible).
> >
> > For comparison between the three schemes:
> >
> >         sev = kvzalloc(sizeof(*sev) + sizeof(struct v4l2_kevent) * elems,
> >                         GFP_KERNEL);
> >         sev = kvzalloc_ab_c(elems, sizeof(struct v4l2_kevent), sizeof(*sev),
> >                         GFP_KERNEL);
> >         sev = kvzalloc_struct(sev, events, elems, GFP_KERNEL);
> >
> > Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
> > ---
> >  include/linux/mm.h | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 81bd7f0be286..ddf929c5aaee 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -557,6 +557,57 @@ static inline void *kvmalloc_array(size_t n, size_t size, gfp_t flags)
> >         return kvmalloc(n * size, flags);
> >  }
> >
> > +/**
> > + * kvmalloc_ab_c() - Allocate memory.
>
> Longer description, maybe? "Allocate a *b + c bytes of memory"?
>
> > + * @n: Number of elements.
> > + * @size: Size of each element (should be constant).
> > + * @c: Size of header (should be constant).
>
> If these should be constant, should we mark them as "const"? Or WARN
> if __builtin_constant_p() isn't true?
>
> > + * @gfp: Memory allocation flags.
> > + *
> > + * Use this function to allocate @n * @size + @c bytes of memory.  This
> > + * function is safe to use when @n is controlled from userspace; it will
> > + * return %NULL if the required amount of memory cannot be allocated.
> > + * Use kvfree() to free the allocated memory.
> > + *
> > + * The kvzalloc_hdr_arr() function is easier to use as it has typechecking
>
> renaming typo? Should this be "kvzalloc_struct()"?
>
> > + * and you do not need to remember which of the arguments should be constants.
> > + *
> > + * Context: Process context.  May sleep; the @gfp flags should be based on
> > + *         %GFP_KERNEL.
> > + * Return: A pointer to the allocated memory or %NULL.
> > + */
> > +static inline __must_check
> > +void *kvmalloc_ab_c(size_t n, size_t size, size_t c, gfp_t gfp)
> > +{
> > +       if (size != 0 && n > (SIZE_MAX - c) / size)
> > +               return NULL;
> > +
> > +       return kvmalloc(n * size + c, gfp);
> > +}
> > +#define kvzalloc_ab_c(a, b, c, gfp)    kvmalloc_ab_c(a, b, c, gfp | __GFP_ZERO)
>
> Nit: "(gfp) | __GFP_ZERO" just in case of insane usage.
>
> > +
> > +/**
> > + * kvzalloc_struct() - Allocate and zero-fill a structure containing a
> > + *                    variable length array.
> > + * @p: Pointer to the structure.
> > + * @member: Name of the array member.
> > + * @n: Number of elements in the array.
> > + * @gfp: Memory allocation flags.
> > + *
> > + * Allocate (and zero-fill) enough memory for a structure with an array
> > + * of @n elements.  This function is safe to use when @n is specified by
> > + * userspace as the arithmetic will not overflow.
> > + * Use kvfree() to free the allocated memory.
> > + *
> > + * Context: Process context.  May sleep; the @gfp flags should be based on
> > + *         %GFP_KERNEL.
> > + * Return: Zero-filled memory or a NULL pointer.
> > + */
> > +#define kvzalloc_struct(p, member, n, gfp)                             \
> > +       (typeof(p))kvzalloc_ab_c(n,                                     \
> > +               sizeof(*(p)->member) + __must_be_array((p)->member),    \
> > +               offsetof(typeof(*(p)), member), gfp)
> > +
> >  extern void kvfree(const void *addr);
> >
> >  static inline atomic_t *compound_mapcount_ptr(struct page *page)
>
> It might be nice to include another patch that replaces some of the
> existing/common uses of a*b+c with the new function...
>
> Otherwise, yes, please. We could build a coccinelle rule for
> additional replacements...

Thanks for the suggestion.  I will look into it.

julia
