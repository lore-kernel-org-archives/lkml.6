Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521174077; cv=none;
        d=google.com; s=arc-20160816;
        b=vfgWVrW2yiVirucLIG2IkL42K5pScuSuks+3xzjiKqBLygU7FrNqVffe2Bjw3E88BW
         IwbokAZ2s+EgBrgcAwFnWx99V8hqZ8B0HNtHbCM7OrZeq/9WEHosPMZ+6HTnmgd2WETF
         CqFssNoZHZOuuM2ok0Odnsj68db5C7r8HNdaADXekMAxqHsQFDlK2fiv7Ise2doERTXJ
         5rTvqQgt+e/sr9S19tV652uu94znQvldaAYTyN+UdfPjqrtvHXBGfydqzZ27e8DROkKb
         881yPoOeHnK5wQQKGFg1OLBg6EcPykOflJJw8QaiojsrjaLDVZYXhvZ6IsAJ4/2wu28r
         2LVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=414MW60eI6NmcE76+qRENIsZQMki6/23Kw2kxQvowtE=;
        b=PWw5qLUUW8Y0QH+maBj9I0Tgl6NcFpX5yFiWYwl49H/Mga8gPpsWrI/cpMw0R3RFqX
         0xzCJCEebRzDQ5gucjAUIT5CRYd8iKa361QzpLhXkcuj0OdZ0Kqd/9OIsoN37AXBEKkO
         qzvJx3PqbrEBGw9l1BLhnzY+ROlYvAnainYMZfYe0ckweVcfnCJfTAAADbKpKdP8y47P
         NCzbo9GNtXzQYCESmB4oy7h6Ou3L9xuJCg3LbBucDzwgZ3oAPbvNpuYlpyT/xNt2eoDf
         NcsiIKOjB1i84hs+PP1T5LfVj3amsSC9dHkhZuZTFuL2ZOxwmJ5Ib2w0lxX/WM1OyzS9
         1fHw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=eS0dC0M/;
       dkim=pass header.i=@chromium.org header.s=google header.b=l738poce;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=eS0dC0M/;
       dkim=pass header.i=@chromium.org header.s=google header.b=l738poce;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AG47ELs1R8K2AeVNbsluCJr828QrAuPofA5GN/P9mHprGnKsri0UUxR89Wb/smVlzxCfRMZi8sTJuwky/DQjz8Mauh4=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <1521108052-26861-1-git-send-email-kieran.bingham@ideasonboard.com>
References: <1521108052-26861-1-git-send-email-kieran.bingham@ideasonboard.com>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 15 Mar 2018 21:21:15 -0700
X-Google-Sender-Auth: Xo-BvB32mssHr27Szwg0qDNDd2U
Message-ID: <CAGXu5jJETok21C7Au=+hh+1jMwTOqULXpL1QF5S2b_i-CoeoQw@mail.gmail.com>
Subject: Re: [PATCH][RFC] kernel.h: provide array iterator
To: Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-media@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Herbert Xu <herbert@gondor.apana.org.au>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Krzysztof Kozlowski <krzk@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>, Ian Abbott <abbotti@mev.co.uk>,
	Julia Lawall <julia.lawall@lip6.fr>, cocci@systeme.lip6.fr
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594997409535098266?=
X-GMAIL-MSGID: =?utf-8?q?1595066629502962040?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 15, 2018 at 3:00 AM, Kieran Bingham
<kieran.bingham@ideasonboard.com> wrote:
> Simplify array iteration with a helper to iterate each entry in an array.
> Utilise the existing ARRAY_SIZE macro to identify the length of the array
> and pointer arithmetic to process each item as a for loop.
>
> Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
> ---
>  include/linux/kernel.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> The use of static arrays to store data is a common use case throughout the
> kernel. Along with that is the obvious need to iterate that data.
>
> In fact there are just shy of 5000 instances of iterating a static array:
>         git grep "for .*ARRAY_SIZE" | wc -l
>         4943

I suspect the main question is "Does this macro make the code easier to read?"

I think it does, and we have other kinds of iterators like this in the
kernel already. Would it be worth building a Coccinelle script to do
the 5000 replacements?

-Kees

>
> When working on the UVC driver - I found that I needed to split one such
> iteration into two parts, and at the same time felt that this could be
> refactored to be cleaner / easier to read.
>
> I do however worry that this simple short patch might not be desired or could
> also be heavily bikeshedded due to it's potential wide spread use (though
> perhaps that would be a good thing to have more users) ...  but here it is,
> along with an example usage below which is part of a separate series.
>
> The aim is to simplify iteration on static arrays, in the same way that we have
> iterators for lists. The use of the ARRAY_SIZE macro, provides all the
> protections given by "__must_be_array(arr)" to this macro too.
>
> Regards
>
> Kieran
>
> =============================================================================
> Example Usage from a pending UVC development:
>
> +#define for_each_uvc_urb(uvc_urb, uvc_streaming) \
> +       for_each_array_element(uvc_urb, uvc_streaming->uvc_urb)
>
>  /*
>   * Uninitialize isochronous/bulk URBs and free transfer buffers.
>   */
>  static void uvc_uninit_video(struct uvc_streaming *stream, int free_buffers)
>  {
> -       struct urb *urb;
> -       unsigned int i;
> +       struct uvc_urb *uvc_urb;
>
>         uvc_video_stats_stop(stream);
>
> -       for (i = 0; i < UVC_URBS; ++i) {
> -               struct uvc_urb *uvc_urb = &stream->uvc_urb[i];
> +       for_each_uvc_urb(uvc_urb, stream)
> +               usb_kill_urb(uvc_urb->urb);
>
> -               urb = uvc_urb->urb;
> -               if (urb == NULL)
> -                       continue;
> +       flush_workqueue(stream->async_wq);
>
> -               usb_kill_urb(urb);
> -               usb_free_urb(urb);
> +       for_each_uvc_urb(uvc_urb, stream) {
> +               usb_free_urb(uvc_urb->urb);
>                 uvc_urb->urb = NULL;
>         }
>
>         if (free_buffers)
>                 uvc_free_urb_buffers(stream);
>  }
> =============================================================================
>
>
>
>
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index ce51455e2adf..95d7dae248b7 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -70,6 +70,16 @@
>   */
>  #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
>
> +/**
> + * for_each_array_element - Iterate all items in an array
> + * @elem: pointer of array type for iteration cursor
> + * @array: array to be iterated
> + */
> +#define for_each_array_element(elem, array) \
> +       for (elem = &(array)[0]; \
> +            elem < &(array)[ARRAY_SIZE(array)]; \
> +            ++elem)
> +
>  #define u64_to_user_ptr(x) (           \
>  {                                      \
>         typecheck(u64, x);              \
> --
> 2.7.4
>



-- 
Kees Cook
Pixel Security
