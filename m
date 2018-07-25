Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D179C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 11:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D05DF20882
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 11:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLBBiOfS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D05DF20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbeGYMnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 08:43:41 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:42140 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728474AbeGYMnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 08:43:41 -0400
Received: by mail-oi0-f65.google.com with SMTP id n84-v6so13225114oib.9;
        Wed, 25 Jul 2018 04:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=WWXRa/geaDX7N/7gqDUTKBM6a9EHNiVAdzlCOQrJR9o=;
        b=fLBBiOfSjGB8rjudPfv78kYfJ+3uwhcvwnlUY7dxZ8Q7HxwuAWPVYppbW0s/zHIkv3
         QSVuEkBKwjit8nOXoSNr6UMwejGTVAio3Bflg8XVmVOTakdF9y8RJKA93cl2+6ck83z3
         aFZEOxtzX3f50kYYRaMblASzBHsWboNZHHzNau4ifuhjBv3XT3UrUjLfvmiQhf0c4NYl
         +CK6HsYD3q7ecn3wDyF7H7G+DH6MpE3/yZnooUR2kYt/E1vq2czTPL9C+Gh+Fkki/9cD
         qnRQ3bcjQvi7nz56uw0DK1ZqZ2tWgE4CgkYn5/ynkUt8aL1ytvz9/M0cWsH976qZFJCg
         QDGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=WWXRa/geaDX7N/7gqDUTKBM6a9EHNiVAdzlCOQrJR9o=;
        b=kaAdx9iuT3b03n251ycJlgmCq8i+oeLOjIhuI0zGV88stYfMa5Bo7zXxBWxFMLHAGq
         HdacFaR0d3gCTH6Wpwh6GnJKgX9UJZ50p4RRBtZ28sXfkZzx5OblhvrNucE0mRdKYWIE
         4ourJeOB93ddkQv9xQqPFUW2FVWbbU8Z8z74O/ZBpmRepCvhPJNuH68e0bpqnFNqlr1m
         ZMCJsjKx51gi0VIJeI3+vfTghTGcnv/Di+bqLU3YSQsEHVYjbK5CSc/4qe1qUjGl7RF6
         /zT5Aa0XGUuqOK1tbGPAKirGlbA2qRiJu6JUZlkzrr75crKVT/j8fLOu/1tQtraa4Bu9
         TzeA==
X-Gm-Message-State: AOUpUlEnaJfdkVpbvF9LEtnyt2e4/x0Ib+WIGQrdfH2DbNTZb9Kt5tcV
        Zt//AdO+iliY9WiuOAsx/xNryXGe/6MUAh7bCss=
X-Google-Smtp-Source: AAOMgpfo5R+y6U9LMg6xLiY+KXiw1FPHd0eV1OYPazEq+sQppQ8Txx/o2UU9rr0TEb50XrsfNGCRK+jpDPdGZlT84Jk=
X-Received: by 2002:aca:42:: with SMTP id 63-v6mr2725365oia.154.1532518344061;
 Wed, 25 Jul 2018 04:32:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Wed, 25 Jul 2018 04:32:23
 -0700 (PDT)
In-Reply-To: <20180724164936.37477-11-keescook@chromium.org>
References: <20180724164936.37477-1-keescook@chromium.org> <20180724164936.37477-11-keescook@chromium.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 25 Jul 2018 13:32:23 +0200
X-Google-Sender-Auth: aGoZuBFE4M8I61P2pBXlCMLSMW0
Message-ID: <CAJZ5v0gVDotjufLKUW0YuQu2vA4fmU_gqia=ZA4DocW4XHxx0w@mail.gmail.com>
Subject: Re: [PATCH v6 10/18] x86/power/64: Remove VLA usage
To:     Kees Cook <keescook@chromium.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Alasdair Kergon <agk@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Howells <dhowells@redhat.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Tudor-Dan Ambarus <tudor.ambarus@microchip.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Will Deacon <will.deacon@arm.com>, dm-devel@redhat.com,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-crypto@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, qat-linux@intel.com,
        linux-ppp@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        devel@driverdev.osuosl.org, linux-afs@lists.infradead.org,
        "open list:NETWORKING DRIVERS (WIRELESS)" 
        <linux-wireless@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 6:49 PM, Kees Cook <keescook@chromium.org> wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this
> removes the discouraged use of AHASH_REQUEST_ON_STACK by switching to
> shash directly and allocating the descriptor in heap memory (which should
> be fine: the tfm has already been allocated there too).
>
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Acked-by: Pavel Machek <pavel@ucw.cz>

I think I can queue this up if there are no objections from others.

Do you want me to do that?

> ---
>  arch/x86/power/hibernate_64.c | 36 ++++++++++++++++++++---------------
>  1 file changed, 21 insertions(+), 15 deletions(-)
>
> diff --git a/arch/x86/power/hibernate_64.c b/arch/x86/power/hibernate_64.c
> index 67ccf64c8bd8..f8e3b668d20b 100644
> --- a/arch/x86/power/hibernate_64.c
> +++ b/arch/x86/power/hibernate_64.c
> @@ -233,29 +233,35 @@ struct restore_data_record {
>   */
>  static int get_e820_md5(struct e820_table *table, void *buf)
>  {
> -       struct scatterlist sg;
> -       struct crypto_ahash *tfm;
> +       struct crypto_shash *tfm;
> +       struct shash_desc *desc;
>         int size;
>         int ret = 0;
>
> -       tfm = crypto_alloc_ahash("md5", 0, CRYPTO_ALG_ASYNC);
> +       tfm = crypto_alloc_shash("md5", 0, 0);
>         if (IS_ERR(tfm))
>                 return -ENOMEM;
>
> -       {
> -               AHASH_REQUEST_ON_STACK(req, tfm);
> -               size = offsetof(struct e820_table, entries) + sizeof(struct e820_entry) * table->nr_entries;
> -               ahash_request_set_tfm(req, tfm);
> -               sg_init_one(&sg, (u8 *)table, size);
> -               ahash_request_set_callback(req, 0, NULL, NULL);
> -               ahash_request_set_crypt(req, &sg, buf, size);
> -
> -               if (crypto_ahash_digest(req))
> -                       ret = -EINVAL;
> -               ahash_request_zero(req);
> +       desc = kmalloc(sizeof(struct shash_desc) + crypto_shash_descsize(tfm),
> +                      GFP_KERNEL);
> +       if (!desc) {
> +               ret = -ENOMEM;
> +               goto free_tfm;
>         }
> -       crypto_free_ahash(tfm);
>
> +       desc->tfm = tfm;
> +       desc->flags = 0;
> +
> +       size = offsetof(struct e820_table, entries) +
> +               sizeof(struct e820_entry) * table->nr_entries;
> +
> +       if (crypto_shash_digest(desc, (u8 *)table, size, buf))
> +               ret = -EINVAL;
> +
> +       kzfree(desc);
> +
> +free_tfm:
> +       crypto_free_shash(tfm);
>         return ret;
>  }
>
> --
> 2.17.1
>
