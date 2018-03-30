Return-Path: <kernel-hardening-return-12834-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4/rcURORgPO2U6xyv7LOp/V0qFxaAm1l3f9AY+zVfky6hhlfpLMqtRu3gqhUrUQSgSQta16
ARC-Seal: i=1; a=rsa-sha256; t=1522420460; cv=none;
        d=google.com; s=arc-20160816;
        b=MO2ys9Xcv6onx8T9/XPbqegn7DluouMxTZQATUz9qeJvti/K0HJ9y/xWQ+ie/jTKR/
         c11bJ5L50GgkzfyRN1f+jZK2iJ/IANpKt1CE+dLicseXwtwszUi3TziJ1iIEpcLjTvwO
         2ed0M0GTsh0qhEqDVJej3p0EbY0IgX+MyPFJP94zgiuYjAd14o1IrwrfgFkaXvCrQPh7
         urKw3JShg0T9DtFaBXf+NrOrSRKyJGxAZWQEvRG2rCBiaPdyKSU69dYCWx0Dyv8/0NWf
         9PEMZCjR/SEYGHZk6ExsCniOqnjqvACGItil8rk08g5duGXaWLVw1+RbnovQl+mtXe5X
         NJsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=/HZVPAaSaPNPDRPjYKQ71qhIU20IEgB9M8FYbMdSmmA=;
        b=zKo28C8S1NAcYbUV2VUVBLsdlLApj3HzCzooyzgdlDeSVrt1lSCF+NochyHW1eKIVA
         hU+d9qUxda/gvuzMq18WZDF5kaNYY88p+S59dLjUfYbs3z2+HBmLLFpvg+gYw3JhROSK
         5ZPypVXLdJuV+9rZeekW8eZdWkH4OK2UpnHsx2g5rr/5IgAXxNFl8CnqCzqAj+F5Bi+7
         2y+poZ6HPs7Yc1DYJSUBfoQF7ViRxBliwOtwHTzHcoEnEVy4vhrdrQrwBSvRIuM/M65o
         p1ikJIrCuhdUzZ6v7GjyKPYytSGiCk0oKrKhW0+UMtzODRBm1ZvImvccUyCaEpRjPVxy
         9Xpg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=oL3CVSuZ;
       spf=pass (google.com: domain of kernel-hardening-return-12834-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12834-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=oL3CVSuZ;
       spf=pass (google.com: domain of kernel-hardening-return-12834-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12834-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <20180328181809.24505-1-labbott@redhat.com>
References: <20180328181809.24505-1-labbott@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 30 Mar 2018 17:33:55 +0300
Message-ID: <CAHp75VdZOiJgzt3nhdeqwTXC=jsbndLWOV3eF_XmgFU-eHjYSg@mail.gmail.com>
Subject: Re: [PATCHv3] gpio: Remove VLA from gpiolib
To: Laura Abbott <labbott@redhat.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Kees Cook <keescook@chromium.org>,
	Lukas Wunner <lukas@wunner.de>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kernel-hardening@lists.openwall.com,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596206473991489239?=
X-GMAIL-MSGID: =?utf-8?q?1596373556471504750?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 9:18 PM, Laura Abbott <labbott@redhat.com> wrote:
> The new challenge is to remove VLAs from the kernel
> (see https://lkml.org/lkml/2018/3/7/621) to eventually
> turn on -Wvla.
>
> Using a kmalloc array is the easy way to fix this but kmalloc is still
> more expensive than stack allocation. Introduce a fast path with a
> fixed size stack array to cover most chip with gpios below some fixed
> amount. The slow path dynamically allocates an array to cover those
> chips with a large number of gpios.

> +               ret = gpiod_set_array_value_complex(false,
>                                               true,
>                                               lh->numdescs,
>                                               lh->descs,
>                                               vals);
> +               if (ret)
> +                       return ret;
> +
>                 return 0;

Can't we

return gpiod_set_array_value_complex(); ?


> +                       slowpath = kcalloc(2 * BITS_TO_LONGS(chip->ngpio),
> +                                          sizeof(*slowpath),
> +                                          can_sleep ? GFP_KERNEL : GFP_ATOMIC);


> +                       if (slowpath)
> +                               kfree(slowpath);

> +               if (slowpath)
> +                       kfree(slowpath);

Since slowpath is a pointer, conditionals above are redundant.

> +                       slowpath = kcalloc(2 * BITS_TO_LONGS(chip->ngpio),
> +                                          sizeof(*slowpath),
> +                                          can_sleep ? GFP_KERNEL : GFP_ATOMIC);

> +               if (slowpath)
> +                       kfree(slowpath);

Ditto.

-- 
With Best Regards,
Andy Shevchenko
