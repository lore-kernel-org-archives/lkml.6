Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751443AbeDFH2E (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 03:28:04 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34603 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750815AbeDFH2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 03:28:03 -0400
X-Google-Smtp-Source: AIpwx4/UO7VC630AqBE2Fo1xcSOa7abTnR4T3swmzJd82IqlOtzyVplsKrsZjan20BXxmraXlSp9YA==
Date: Fri, 6 Apr 2018 09:18:39 +0200
From: Tobias Regnery <tobias.regnery@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pstore: fix crypto dependencies without compression
Message-ID: <20180406071839.GA3685@builder>
References: <20180406063804.30510-1-tobias.regnery@gmail.com>
 <CAK8P3a2R1R0Ag=7rQ+pHH5fXz7LqVnJug+upx3t_PmbCkg+t2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2R1R0Ag=7rQ+pHH5fXz7LqVnJug+upx3t_PmbCkg+t2g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.04.18, Arnd Bergmann wrote:
> On Fri, Apr 6, 2018 at 8:38 AM, Tobias Regnery <tobias.regnery@gmail.com> wrote:
> > Commit 58eb5b670747 ("pstore: fix crypto dependencies") fixed up the crypto
> > dependencies but missed the case when no compression is selected.
> >
> > With CONFIG_PSTORE=y, CONFIG_PSTORE_COMPRESS=n  and CONFIG_CRYPTO=m we see
> > the following link error:
> >
> > fs/pstore/platform.o: In function `pstore_register':
> > (.text+0x1b1): undefined reference to `crypto_has_alg'
> > (.text+0x205): undefined reference to `crypto_alloc_base'
> > fs/pstore/platform.o: In function `pstore_unregister':
> > (.text+0x3b0): undefined reference to `crypto_destroy_tfm'
> >
> > Fix this by selecting CONFIG_CRYPTO unconditionally.
> >
> > Fixes: 58eb5b670747 ("pstore: fix crypto dependencies")
> > Signed-off-by: Tobias Regnery <tobias.regnery@gmail.com>
> 
> Thanks, I wonder how I missed this one. Thanks for fixing it up.
> It's a bit unfortunate that it now disallows the otherwise valid
> CONFIG_PSTORE=y, CONFIG_PSTORE_COMPRESS=n
> and CONFIG_CRYPTO=n configuration, though.
> 
> Could we do this by making the calls compile-time configured
> in the pstore code instead? Please try the untested version
> below.
> 
>         Arnd
> 
> diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
> index 1143ef351c58..dc720573fd53 100644
> --- a/fs/pstore/platform.c
> +++ b/fs/pstore/platform.c
> @@ -258,7 +258,7 @@ static int pstore_decompress(void *in, void *out,
> 
>  static void allocate_buf_for_compression(void)
>  {
> -       if (!zbackend)
> +       if (!IS_ENABLED(CONFIG_PSTORE_COMPRESS) || !zbackend)
>                 return;
> 
>         if (!crypto_has_comp(zbackend->name, 0, 0)) {
> @@ -287,7 +287,7 @@ static void allocate_buf_for_compression(void)
> 
>  static void free_buf_for_compression(void)
>  {
> -       if (!IS_ERR_OR_NULL(tfm))
> +       if (IS_ENABLED(CONFIG_PSTORE_COMPRESS) && !IS_ERR_OR_NULL(tfm))
>                 crypto_free_comp(tfm);
>         kfree(big_oops_buf);
>         big_oops_buf = NULL;

Hi Arnd,

this seems to be the better fix, the link error goes away with this change.
Thanks for the suggestion, I will send an updated patch.

--
Tobias
