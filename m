Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F61DC67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F30D620811
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HG76hrxn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F30D620811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbeLLAut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 19:50:49 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:45297 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbeLLAut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 19:50:49 -0500
Received: by mail-yw1-f65.google.com with SMTP id d190so6274485ywd.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 16:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xI4+euhpqjLmL2DHyTrs9ERXxJGkl+3bv2laz6Jd+eU=;
        b=HG76hrxn4WFy1Dj86ppOb0EjvMeJnH1Zdd6zeL2QaREwP8AiB5FQIyxt9Ci0t9zPgA
         VHwKIViBs6Xq780cScTrnQPJuqqc0VrXO3YRZCBr7+4V9PYOHY7XkuGP55Wq3lNwYXgX
         aCCIRBoPfXPp57NkR0/UBOxglaooBXTbTR6gU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xI4+euhpqjLmL2DHyTrs9ERXxJGkl+3bv2laz6Jd+eU=;
        b=LUiC+uhKejKJggW4WY/G4IaIoLDJH822hcjHp7faxOo5CLyBo5PtteXYQeNbeiXjjb
         NlTW68PG35d3mml3o15qhzcXf7TGppfYaLKGhcMH8j0iB5pV+RI3RZD5cw2D9N3Q3TR4
         qUfAnft1aaAnyPrQJGF0uUl4jMJtUmDA70RlUo8ZJPXTZpPW224r8e7ABYd6ib5rwhGs
         oJXdRDoJsWO6K7mDCLYGNeuv7NhWIcnG/F0cCB3eT8ffDWw+9OC/+A1G5iVq0hh2kLSj
         Hm1/+GqNXTIofYlH7aNLI2TF3yDFrr/mX4T4SocPBUD1W423AXLCDtzeKcg2/8N5Rfbu
         VQJQ==
X-Gm-Message-State: AA+aEWY5xEp039IDZCn9AsvLrMzN2XfamH028QFO64m10NuYJQSbQI4T
        zqhGYEovoTiam0UFWC7dTrzRQeMdb04=
X-Google-Smtp-Source: AFSGD/Vw8wpcFTHIm+VMnJBxUXnjCzdKHChLPUhZd8vNuI/k/5u4IVt3e4b5R0rtqasjzzfitDWZxw==
X-Received: by 2002:a81:2891:: with SMTP id o139mr18476585ywo.100.1544575847415;
        Tue, 11 Dec 2018 16:50:47 -0800 (PST)
Received: from mail-yw1-f48.google.com (mail-yw1-f48.google.com. [209.85.161.48])
        by smtp.gmail.com with ESMTPSA id r20sm6427045ywa.13.2018.12.11.16.50.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 16:50:46 -0800 (PST)
Received: by mail-yw1-f48.google.com with SMTP id i20so6270434ywc.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 16:50:46 -0800 (PST)
X-Received: by 2002:a81:29cc:: with SMTP id p195mr19368000ywp.407.1544575845490;
 Tue, 11 Dec 2018 16:50:45 -0800 (PST)
MIME-Version: 1.0
References: <20181211034032.32338-1-yuleixzhang@tencent.com>
In-Reply-To: <20181211034032.32338-1-yuleixzhang@tencent.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 11 Dec 2018 16:50:34 -0800
X-Gmail-Original-Message-ID: <CAGXu5jKkqf-9ksvNTCS5xgB_JtfvCc=Eot2uWYYP8rpoKLw=mg@mail.gmail.com>
Message-ID: <CAGXu5jKkqf-9ksvNTCS5xgB_JtfvCc=Eot2uWYYP8rpoKLw=mg@mail.gmail.com>
Subject: Re: [PATCH] kfifo: add memory barrier in kfifo to prevent data loss
To:     yulei.kernel@gmail.com, Stefani Seibold <stefani@seibold.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     mkelly@xevo.com, Jiri Kosina <jkosina@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, yuleixzhang@tencent.com,
        xiaoguangrong@tencent.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 7:41 PM <yulei.kernel@gmail.com> wrote:
>
> From: Yulei Zhang <yuleixzhang@tencent.com>
>
> Early this year we spot there may be two issues in kernel
> kfifo.
>
> One is reported by Xiao Guangrong to linux kernel.
> https://lkml.org/lkml/2018/5/11/58
> In current kfifo implementation there are missing memory
> barrier in the read side, so that without proper barrier
> between reading the kfifo->in and fetching the data there
> is potential ordering issue.
>
> Beside that, there is another potential issue in kfifo,
> please consider the following case:
> at the beginning
> ring->size =3D 4
> ring->out =3D 0
> ring->in =3D 4
>
>     Consumer                        Producer
> ---------------                  --------------
> index =3D ring->out; /* index =3D=3D 0 */
> ring->out++; /* ring->out =3D=3D 1 */
> < Re-Order >
>                                  out =3D ring->out;
>                                  if (ring->in - out >=3D ring->mask)
>                                      return -EFULL;
>                                  /* see the ring is not full */
>                                  index =3D ring->in & ring->mask;
>                                  /* index =3D=3D 0 */
>                                  ring->data[index] =3D new_data;
> =E3=80=80=E3=80=80=E3=80=80=E3=80=80=E3=80=80=E3=80=80=E3=80=80=E3=80=80=
=E3=80=80=E3=80=80=E3=80=80=E3=80=80=E3=80=80=E3=80=80=E3=80=80=E3=80=80 ri=
ng->in++;
>
> data =3D ring->data[index];
> /* you will find the old data is overwritten by the new_data */
>
> In order to avoid the issue:
> 1) for the consumer, we should read the ring->data[] out before
> updating ring->out
> 2) for the producer, we should read ring->out before updating
> ring->data[]
>
> So in this patch we introduce the following four functions which
> are wrapped with proper memory barrier and keep in pairs to make
> sure the in and out index are fetched and updated in order to avoid
> data loss.
>
> kfifo_read_index_in()
> kfifo_write_index_in()
> kfifo_read_index_out()
> kfifo_write_index_out()
>
> Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
> Signed-off-by: Guangrong Xiao <xiaoguangrong@tencent.com>

I've added some more people to CC that might want to see this. Thanks
for sending this!

-Kees

> ---
>  include/linux/kfifo.h |  70 ++++++++++++++++++++++++++-
>  lib/kfifo.c           | 107 +++++++++++++++++++++++++++---------------
>  2 files changed, 136 insertions(+), 41 deletions(-)
>
> diff --git a/include/linux/kfifo.h b/include/linux/kfifo.h
> index 89fc8dc7bf38..3bd2a869ca7e 100644
> --- a/include/linux/kfifo.h
> +++ b/include/linux/kfifo.h
> @@ -286,6 +286,71 @@ __kfifo_uint_must_check_helper( \
>  }) \
>  )
>
> +/**
> + * kfifo_read_index_in - returns the in index of the fifo
> + * @fifo: address of the kfifo to be used
> + *
> + * add memory read barrier to make sure the fifo->in index
> + * is fetched first before write data to the fifo, which
> + * is paired with the write barrier in kfifo_write_index_in
> + */
> +#define kfifo_read_index_in(kfifo) \
> +({ \
> +       typeof((kfifo) + 1) __tmp =3D (kfifo); \
> +       struct __kfifo *__kfifo =3D __tmp; \
> +       unsigned int __val =3D READ_ONCE(__kfifo->in); \
> +       smp_rmb(); \
> +       __val; \
> +})
> +
> +/**
> + * kfifo_write_index_in - updates the in index of the fifo
> + * @fifo: address of the kfifo to be used
> + *
> + * add memory write barrier to make sure the data entry is
> + * updated before increase the fifo->in
> + */
> +#define kfifo_write_index_in(kfifo, val) \
> +({ \
> +       typeof((kfifo) + 1) __tmp =3D (kfifo); \
> +       struct __kfifo *__kfifo =3D __tmp; \
> +       unsigned int __val =3D (val); \
> +       smp_wmb(); \
> +       WRITE_ONCE(__kfifo->in, __val); \
> +})
> +
> +/**
> + * kfifo_read_index_out - returns the out index of the fifo
> + * @fifo: address of the kfifo to be used
> + *
> + * add memory barrier to make sure the fifo->out index is
> + * fetched before read data from the fifo, which is paired
> + * with the memory barrier in kfifo_write_index_out
> + */
> +#define kfifo_read_index_out(kfifo) \
> +({ \
> +       typeof((kfifo) + 1) __tmp =3D (kfifo); \
> +       struct __kfifo *__kfifo =3D __tmp; \
> +       unsigned int __val =3D smp_load_acquire(&__kfifo->out); \
> +       __val; \
> +})
> +
> +/**
> + * kfifo_write_index_out - updates the out index of the fifo
> + * @fifo: address of the kfifo to be used
> + *
> + * add memory barrier to make sure reading out the entry before
> + * update the fifo->out index to avoid overwitten the entry by
> + * the producer
> + */
> +#define kfifo_write_index_out(kfifo, val) \
> +({ \
> +       typeof((kfifo) + 1) __tmp =3D (kfifo); \
> +       struct __kfifo *__kfifo =3D __tmp; \
> +       unsigned int __val =3D (val); \
> +       smp_store_release(&__kfifo->out, __val); \
> +})
> +
>  /**
>   * kfifo_skip - skip output data
>   * @fifo: address of the fifo to be used
> @@ -298,7 +363,7 @@ __kfifo_uint_must_check_helper( \
>         if (__recsize) \
>                 __kfifo_skip_r(__kfifo, __recsize); \
>         else \
> -               __kfifo->out++; \
> +               kfifo_write_index_out(__kfifo, __kfifo->out++); \
>  })
>
>  /**
> @@ -740,7 +805,8 @@ __kfifo_uint_must_check_helper( \
>         if (__recsize) \
>                 __kfifo_dma_out_finish_r(__kfifo, __recsize); \
>         else \
> -               __kfifo->out +=3D __len / sizeof(*__tmp->type); \
> +               kfifo_write_index_out(__kfifo, __kfifo->out \
> +                               + (__len / sizeof(*__tmp->type))); \
>  })
>
>  /**
> diff --git a/lib/kfifo.c b/lib/kfifo.c
> index 015656aa8182..189590d9d614 100644
> --- a/lib/kfifo.c
> +++ b/lib/kfifo.c
> @@ -32,7 +32,12 @@
>   */
>  static inline unsigned int kfifo_unused(struct __kfifo *fifo)
>  {
> -       return (fifo->mask + 1) - (fifo->in - fifo->out);
> +       /*
> +        * add memory barrier to make sure the index is fetched
> +        * before write to the buffer
> +        */
> +       return (fifo->mask + 1) -
> +               (fifo->in - kfifo_read_index_out(fifo));
>  }
>
>  int __kfifo_alloc(struct __kfifo *fifo, unsigned int size,
> @@ -116,11 +121,6 @@ static void kfifo_copy_in(struct __kfifo *fifo, cons=
t void *src,
>
>         memcpy(fifo->data + off, src, l);
>         memcpy(fifo->data, src + l, len - l);
> -       /*
> -        * make sure that the data in the fifo is up to date before
> -        * incrementing the fifo->in index counter
> -        */
> -       smp_wmb();
>  }
>
>  unsigned int __kfifo_in(struct __kfifo *fifo,
> @@ -133,7 +133,11 @@ unsigned int __kfifo_in(struct __kfifo *fifo,
>                 len =3D l;
>
>         kfifo_copy_in(fifo, buf, len, fifo->in);
> -       fifo->in +=3D len;
> +       /*
> +        * make sure that the data in the fifo is up to date before
> +        * incrementing the fifo->in index counter
> +        */
> +       kfifo_write_index_in(fifo, fifo->in + len);
>         return len;
>  }
>  EXPORT_SYMBOL(__kfifo_in);
> @@ -155,11 +159,6 @@ static void kfifo_copy_out(struct __kfifo *fifo, voi=
d *dst,
>
>         memcpy(dst, fifo->data + off, l);
>         memcpy(dst + l, fifo->data, len - l);
> -       /*
> -        * make sure that the data is copied before
> -        * incrementing the fifo->out index counter
> -        */
> -       smp_wmb();
>  }
>
>  unsigned int __kfifo_out_peek(struct __kfifo *fifo,
> @@ -167,7 +166,7 @@ unsigned int __kfifo_out_peek(struct __kfifo *fifo,
>  {
>         unsigned int l;
>
> -       l =3D fifo->in - fifo->out;
> +       l =3D kfifo_read_index_in(fifo) - fifo->out;
>         if (len > l)
>                 len =3D l;
>
> @@ -180,7 +179,11 @@ unsigned int __kfifo_out(struct __kfifo *fifo,
>                 void *buf, unsigned int len)
>  {
>         len =3D __kfifo_out_peek(fifo, buf, len);
> -       fifo->out +=3D len;
> +       /*
> +        * make sure that the data in the fifo is fetched before
> +        * incrementing the fifo->out index counter
> +        */
> +       kfifo_write_index_out(fifo, fifo->out + len);
>         return len;
>  }
>  EXPORT_SYMBOL(__kfifo_out);
> @@ -210,11 +213,6 @@ static unsigned long kfifo_copy_from_user(struct __k=
fifo *fifo,
>                 if (unlikely(ret))
>                         ret =3D DIV_ROUND_UP(ret, esize);
>         }
> -       /*
> -        * make sure that the data in the fifo is up to date before
> -        * incrementing the fifo->in index counter
> -        */
> -       smp_wmb();
>         *copied =3D len - ret * esize;
>         /* return the number of elements which are not copied */
>         return ret;
> @@ -241,7 +239,11 @@ int __kfifo_from_user(struct __kfifo *fifo, const vo=
id __user *from,
>                 err =3D -EFAULT;
>         } else
>                 err =3D 0;
> -       fifo->in +=3D len;
> +       /*
> +        * make sure that the data in the fifo is up to date before
> +        * incrementing the fifo->in index counter
> +        */
> +       kfifo_write_index_in(fifo, fifo->in + len);
>         return err;
>  }
>  EXPORT_SYMBOL(__kfifo_from_user);
> @@ -270,11 +272,6 @@ static unsigned long kfifo_copy_to_user(struct __kfi=
fo *fifo, void __user *to,
>                 if (unlikely(ret))
>                         ret =3D DIV_ROUND_UP(ret, esize);
>         }
> -       /*
> -        * make sure that the data is copied before
> -        * incrementing the fifo->out index counter
> -        */
> -       smp_wmb();
>         *copied =3D len - ret * esize;
>         /* return the number of elements which are not copied */
>         return ret;
> @@ -291,7 +288,7 @@ int __kfifo_to_user(struct __kfifo *fifo, void __user=
 *to,
>         if (esize !=3D 1)
>                 len /=3D esize;
>
> -       l =3D fifo->in - fifo->out;
> +       l =3D kfifo_read_index_in(fifo) - fifo->out;
>         if (len > l)
>                 len =3D l;
>         ret =3D kfifo_copy_to_user(fifo, to, len, fifo->out, copied);
> @@ -300,7 +297,11 @@ int __kfifo_to_user(struct __kfifo *fifo, void __use=
r *to,
>                 err =3D -EFAULT;
>         } else
>                 err =3D 0;
> -       fifo->out +=3D len;
> +       /*
> +        * make sure that the data is copied before
> +        * incrementing the fifo->out index counter
> +        */
> +       kfifo_write_index_out(fifo, fifo->out + len);
>         return err;
>  }
>  EXPORT_SYMBOL(__kfifo_to_user);
> @@ -384,7 +385,7 @@ unsigned int __kfifo_dma_out_prepare(struct __kfifo *=
fifo,
>  {
>         unsigned int l;
>
> -       l =3D fifo->in - fifo->out;
> +       l =3D kfifo_read_index_in(fifo) - fifo->out;
>         if (len > l)
>                 len =3D l;
>
> @@ -457,7 +458,11 @@ unsigned int __kfifo_in_r(struct __kfifo *fifo, cons=
t void *buf,
>         __kfifo_poke_n(fifo, len, recsize);
>
>         kfifo_copy_in(fifo, buf, len, fifo->in + recsize);
> -       fifo->in +=3D len + recsize;
> +       /*
> +        * make sure that the data in the fifo is up to date before
> +        * incrementing the fifo->in index counter
> +        */
> +       kfifo_write_index_in(fifo, fifo->in + len + recsize);
>         return len;
>  }
>  EXPORT_SYMBOL(__kfifo_in_r);
> @@ -479,7 +484,7 @@ unsigned int __kfifo_out_peek_r(struct __kfifo *fifo,=
 void *buf,
>  {
>         unsigned int n;
>
> -       if (fifo->in =3D=3D fifo->out)
> +       if (kfifo_read_index_in(fifo) =3D=3D fifo->out)
>                 return 0;
>
>         return kfifo_out_copy_r(fifo, buf, len, recsize, &n);
> @@ -491,11 +496,15 @@ unsigned int __kfifo_out_r(struct __kfifo *fifo, vo=
id *buf,
>  {
>         unsigned int n;
>
> -       if (fifo->in =3D=3D fifo->out)
> +       if (kfifo_read_index_in(fifo) =3D=3D fifo->out)
>                 return 0;
>
>         len =3D kfifo_out_copy_r(fifo, buf, len, recsize, &n);
> -       fifo->out +=3D n + recsize;
> +       /*
> +        * make sure that the fifo data is fetched before
> +        * incrementing the fifo->out index counter
> +        */
> +       kfifo_write_index_out(fifo, fifo->out + n + recsize);
>         return len;
>  }
>  EXPORT_SYMBOL(__kfifo_out_r);
> @@ -505,7 +514,11 @@ void __kfifo_skip_r(struct __kfifo *fifo, size_t rec=
size)
>         unsigned int n;
>
>         n =3D __kfifo_peek_n(fifo, recsize);
> -       fifo->out +=3D n + recsize;
> +       /*
> +        * make sure that the fifo data is fetched before
> +        * incrementing the fifo->out index counter
> +        */
> +       kfifo_write_index_out(fifo, fifo->out + n + recsize);
>  }
>  EXPORT_SYMBOL(__kfifo_skip_r);
>
> @@ -528,7 +541,11 @@ int __kfifo_from_user_r(struct __kfifo *fifo, const =
void __user *from,
>                 *copied =3D 0;
>                 return -EFAULT;
>         }
> -       fifo->in +=3D len + recsize;
> +       /*
> +        * make sure that the data in the fifo is up to date before
> +        * incrementing the fifo->in index counter
> +        */
> +       kfifo_write_index_in(fifo, fifo->in + len + recsize);
>         return 0;
>  }
>  EXPORT_SYMBOL(__kfifo_from_user_r);
> @@ -539,7 +556,7 @@ int __kfifo_to_user_r(struct __kfifo *fifo, void __us=
er *to,
>         unsigned long ret;
>         unsigned int n;
>
> -       if (fifo->in =3D=3D fifo->out) {
> +       if (kfifo_read_index_in(fifo) =3D=3D fifo->out) {
>                 *copied =3D 0;
>                 return 0;
>         }
> @@ -553,7 +570,11 @@ int __kfifo_to_user_r(struct __kfifo *fifo, void __u=
ser *to,
>                 *copied =3D 0;
>                 return -EFAULT;
>         }
> -       fifo->out +=3D n + recsize;
> +       /*
> +        * make sure that the data is copied before
> +        * incrementing the fifo->out index counter
> +        */
> +       kfifo_write_index_out(fifo, fifo->out + n + recsize);
>         return 0;
>  }
>  EXPORT_SYMBOL(__kfifo_to_user_r);
> @@ -577,7 +598,11 @@ void __kfifo_dma_in_finish_r(struct __kfifo *fifo,
>  {
>         len =3D __kfifo_max_r(len, recsize);
>         __kfifo_poke_n(fifo, len, recsize);
> -       fifo->in +=3D len + recsize;
> +       /*
> +        * make sure that the data in the fifo is updated before
> +        * incrementing the fifo->in index counter
> +        */
> +       kfifo_write_index_in(fifo, fifo->in + len + recsize);
>  }
>  EXPORT_SYMBOL(__kfifo_dma_in_finish_r);
>
> @@ -588,7 +613,7 @@ unsigned int __kfifo_dma_out_prepare_r(struct __kfifo=
 *fifo,
>
>         len =3D __kfifo_max_r(len, recsize);
>
> -       if (len + recsize > fifo->in - fifo->out)
> +       if (len + recsize > kfifo_read_index_in(fifo) - fifo->out)
>                 return 0;
>
>         return setup_sgl(fifo, sgl, nents, len, fifo->out + recsize);
> @@ -600,6 +625,10 @@ void __kfifo_dma_out_finish_r(struct __kfifo *fifo, =
size_t recsize)
>         unsigned int len;
>
>         len =3D __kfifo_peek_n(fifo, recsize);
> -       fifo->out +=3D len + recsize;
> +       /*
> +        * make sure that the data is copied before
> +        * incrementing the fifo->out index counter
> +        */
> +       kfifo_write_index_out(fifo, fifo->out + len + recsize);
>  }
>  EXPORT_SYMBOL(__kfifo_dma_out_finish_r);
> --
> 2.17.1
>


--=20
Kees Cook
