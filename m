Return-Path: <kernel-hardening-return-11797-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x226CrvuzlazeX0NtekUJ4ETbpjT5KRBNWtL0Nv0w//XmG0SGbv7IDeSDU4dQdbZsCvUyRY4v
ARC-Seal: i=1; a=rsa-sha256; t=1518652736; cv=none;
        d=google.com; s=arc-20160816;
        b=VnoSqwxvbNxwUF+tWMDpdcPKHlUirAbZ5nKjCnB1k/m75UjuJxcLGRMHZLhjC0Jdow
         r0AQHQnAN9A0TlrWgRcGOzxMWlfxXO0+U1VBaiW6CpvtmmYoXQn22obMOvN981Jhbuhx
         OBfw5u4O55V9nA5U0ApRk6hPngLc21NFnDVYuP/J1FYC533V4OAlxwpqZkT8goyvrOSs
         k47BMKeOqVKwG6J/e3SiYo08/6G3R4MTb+ObPnQfGnoiDSqjhc4LTP1QJ6qqfelEcU9X
         Rn5/dHo14V/EeKs8gIY8as2nkhvIrIPhDt0kZJ/cNu8jASa9JjMhtdbNhcmSvFfsw7rM
         e4PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=ZiXT+cUGEOWDy/r5LLscdopc05zbX2oEaRtYoJ3OJAA=;
        b=I/TF5rDz9zBrfrG6Eptu1tBwSu+1pQXot1h037WUIlSrxcx+8SIuvg/9rUG2wFhens
         w6eUjrIru4jXTUOH8KwMwjsfw2cRyVaDnQ+iz3oQqnNk5sWcfkhl1iWSTR5OwaZ559MZ
         9pukEwg2uNu6PMPfCY0/W+Vnbj25s7HK7wRj8TC+pHcseH29Bf9k3CFGe+iZcO/Ax0kv
         WBIFBCip4n1Jm2f+tqbpX8YEj4WWKnFDbjhYEbso+ZTyFLseXu7zwflK4tcQLB9YKbbE
         pF4zHCOS4iCm9kjgWz5YNfzL3rDhG5COpyqglJhEgLVV0lgbpUeRbjzLd/OU+RE2SsqW
         gsgA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11797-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11797-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11797-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11797-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Wed, 14 Feb 2018 15:58:33 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Joe Perches <joe@perches.com>, Matthew Wilcox <mawilcox@microsoft.com>,
 linux-mm@kvack.org, Kees Cook <keescook@chromium.org>,
 linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v2 2/8] mm: Add kvmalloc_ab_c and kvzalloc_struct
Message-Id: <20180214155833.9f1563b87391f7ff79ca7ed0@linux-foundation.org>
In-Reply-To: <20180214211203.GF20627@bombadil.infradead.org>
References: <20180214201154.10186-1-willy@infradead.org>
	<20180214201154.10186-3-willy@infradead.org>
	<1518641152.3678.28.camel@perches.com>
	<20180214211203.GF20627@bombadil.infradead.org>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592408583578566616?=
X-GMAIL-MSGID: =?utf-8?q?1592422811561667606?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 14 Feb 2018 13:12:03 -0800 Matthew Wilcox <willy@infradead.org> wrote:

> On Wed, Feb 14, 2018 at 12:45:52PM -0800, Joe Perches wrote:
> > On Wed, 2018-02-14 at 12:11 -0800, Matthew Wilcox wrote:
> > > We have kvmalloc_array in order to safely allocate an array with a
> > > number of elements specified by userspace (avoiding arithmetic overflow
> > > leading to a buffer overrun).  But it's fairly common to have a header
> > > in front of that array (eg specifying the length of the array), so we
> > > need a helper function for that situation.
> > > 
> > > kvmalloc_ab_c() is the workhorse that does the calculation, but in spite
> > > of our best efforts to name the arguments, it's really hard to remember
> > > which order to put the arguments in.  kvzalloc_struct() eliminates that
> > > effort; you tell it about the struct you're allocating, and it puts the
> > > arguments in the right order for you (and checks that the arguments
> > > you've given are at least plausible).
> > > 
> > > For comparison between the three schemes:
> > > 
> > > 	sev = kvzalloc(sizeof(*sev) + sizeof(struct v4l2_kevent) * elems,
> > > 			GFP_KERNEL);
> > > 	sev = kvzalloc_ab_c(elems, sizeof(struct v4l2_kevent), sizeof(*sev),
> > > 			GFP_KERNEL);
> > > 	sev = kvzalloc_struct(sev, events, elems, GFP_KERNEL);
> > 
> > Perhaps kv[zm]alloc_buf_and_array is better naming.
> 
> I think that's actively misleading.  The programmer isn't allocating a
> buf, they're allocating a struct.  kvzalloc_hdr_arr was the earlier name,
> and that made some sense; they're allocating an array with a header.
> But nobody thinks about it like that; they're allocating a structure
> with a variably sized array at the end of it.
> 
> If C macros had decent introspection, I'd like it to be:
> 
> 	sev = kvzalloc_struct(elems, GFP_KERNEL);
> 
> and have the macro examine the structure pointed to by 'sev', check
> the last element was an array, calculate the size of the array element,
> and call kvzalloc_ab_c.  But we don't live in that world, so I have to
> get the programmer to tell me the structure and the name of the last
> element in it.

hm, bikeshedding fun.


struct foo {
	whatevs;
	struct bar[0];
}


	struct foo *a_foo;

	a_foo = kvzalloc_struct_buf(foo, bar, nr_bars);

and macro magic will insert the `struct' keyword.  This will help to
force a miscompile if inappropriate types are used for foo and bar.

Problem is, foo may be a union(?) and bar may be a scalar type.  So

	a_foo = kvzalloc_struct_buf(struct foo, struct bar, nr_bars);

or, of course.

	a_foo = kvzalloc_struct_buf(typeof(*a_foo), typeof(a_foo->bar[0]),
				    nr_bars);

or whatever.

The basic idea is to use the wrapper macros to force compile errors if
these things are misused.


Also,

> +/**
> + * kvmalloc_ab_c() - Allocate (a * b + c) bytes of memory.
> + * @n: Number of elements.
> + * @size: Size of each element (should be constant).
> + * @c: Size of header (should be constant).
> + * @gfp: Memory allocation flags.
> + *
> + * Use this function to allocate @n * @size + @c bytes of memory.  This
> + * function is safe to use when @n is controlled from userspace; it will
> + * return %NULL if the required amount of memory cannot be allocated.
> + * Use kvfree() to free the allocated memory.
> + *
> + * The kvzalloc_struct() function is easier to use as it has typechecking
> + * and you do not need to remember which of the arguments should be constants.
> + *
> + * Context: Process context.  May sleep; the @gfp flags should be based on
> + *	    %GFP_KERNEL.
> + * Return: A pointer to the allocated memory or %NULL.
> + */
> +static inline __must_check
> +void *kvmalloc_ab_c(size_t n, size_t size, size_t c, gfp_t gfp)
> +{
> +	if (size != 0 && n > (SIZE_MAX - c) / size)
> +		return NULL;
> +
> +	return kvmalloc(n * size + c, gfp);
> +}

Can we please avoid the single-char identifiers?

void *kvmalloc_ab_c(size_t n_elems, size_t elem_size, size_t header_size,
		    gfp_t gfp);

makes the code so much more readable.
