Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A52ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D97BE2148E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JsQ/G5nM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D97BE2148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbeJSXsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 19:48:54 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:42994 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbeJSXsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 19:48:54 -0400
Received: by mail-yb1-f193.google.com with SMTP id p74-v6so13410822ybc.9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 08:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=x9ZKFla8glrDERS4Gs9Sgo77xKF/nEALFb2B2FNwP6w=;
        b=JsQ/G5nMt9hQeWn2BZJqDbJ6yQLI0Xwl/sQkKSnsbMOmBF3K9vv1IjavLLHO+TqHpQ
         7cl/f/pBeHwPc2G8FFjTxqqXhvsML3P+GY/gF7bM8sueAk+J8S2uWEWOq84fY14TtVtM
         cfo71NRrLwRF8iBE+e6Uckf12wvRKzP4oFG/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=x9ZKFla8glrDERS4Gs9Sgo77xKF/nEALFb2B2FNwP6w=;
        b=X1nQC/s+SP15wvjp7lohU/QXMacAZLgj5IOiHcfy2LUrrs0E43CL8WeHBeobCYEh/G
         4DCXJOb2YaMJ/k9EhbsUGiOsMAj65cS2g0TUn2qaqHJg4hdoxs3Lf3CTB+Uh0/Co1IVs
         PcRuznFC+Pyb/4JeGKOqwfi5wgcgtEl6ymDKQLwRK6YPMpfG9EeMvInnlMoPGfFZqY6z
         2u+a9c5hMDb/H+nQto+9yusk7dAgcK748do6pGvRrZ0cygKYrFV2Wod78SJDoE/h6MPf
         1Wxh6Ivz0mNWQNF4Ru+qCZSJKDb0xrYI4fE54V1DO3q7NubXK851hjhk4/HBRUgr2e/X
         ufKA==
X-Gm-Message-State: ABuFfog4qqVXcViuHQ2WvhgaAYSHXTasM7gcy/h0SbsqY+MyF5AwnjG2
        /RCFHiOKVb72yejgdi7joWlqICv7CrA=
X-Google-Smtp-Source: ACcGV62eYQiDQbh6A22lEuRKXRTU9pAnbI2vLZc6CFEGIa76D4WxptBoY7EaMVnNIdB8mnDk8oMBqw==
X-Received: by 2002:a25:198a:: with SMTP id 132-v6mr23394480ybz.325.1539963735421;
        Fri, 19 Oct 2018 08:42:15 -0700 (PDT)
Received: from mail-yw1-f54.google.com (mail-yw1-f54.google.com. [209.85.161.54])
        by smtp.gmail.com with ESMTPSA id k85-v6sm5958047ywa.76.2018.10.19.08.42.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 08:42:14 -0700 (PDT)
Received: by mail-yw1-f54.google.com with SMTP id v1-v6so13348023ywv.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 08:42:14 -0700 (PDT)
X-Received: by 2002:a0d:d302:: with SMTP id v2-v6mr24279039ywd.124.1539963733716;
 Fri, 19 Oct 2018 08:42:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Fri, 19 Oct 2018 08:42:12
 -0700 (PDT)
In-Reply-To: <336eb81e62d6c683a69d312f533899dcb6bcf770.1539959864.git.christophe.leroy@c-s.fr>
References: <336eb81e62d6c683a69d312f533899dcb6bcf770.1539959864.git.christophe.leroy@c-s.fr>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 19 Oct 2018 08:42:12 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJzp0v_Ox4gJcSdMVT7Rzuoy4mH-J3tPfrpeyCTi4o5YQ@mail.gmail.com>
Message-ID: <CAGXu5jJzp0v_Ox4gJcSdMVT7Rzuoy4mH-J3tPfrpeyCTi4o5YQ@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: add probe_user_read() and probe_user_address()
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        LKML <linux-kernel@vger.kernel.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 8:14 AM, Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
> In the powerpc, there are several places implementing safe
> access to user data. This is sometimes implemented using
> probe_kerne_address() with additional access_ok() verification,
> sometimes with get_user() enclosed in a pagefault_disable()/enable()
> pair, etc... :
>     show_user_instructions()
>     bad_stack_expansion()
>     p9_hmi_special_emu()
>     fsl_pci_mcheck_exception()
>     read_user_stack_64()
>     read_user_stack_32() on PPC64
>     read_user_stack_32() on PPC32
>     power_pmu_bhrb_to()
>
> In the same spirit as probe_kernel_read() and probe_kernel_address(),
> this patch adds probe_user_read() and probe_user_address().
>
> probe_user_read() does the same as probe_kernel_read() but
> first checks that it is really a user address.
>
> probe_user_address() is a shortcut to probe_user_read()
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  include/linux/uaccess.h | 10 ++++++++++
>  mm/maccess.c            | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+)
>
> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> index efe79c1cdd47..fb00e3f847d7 100644
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -266,6 +266,16 @@ extern long strncpy_from_unsafe(char *dst, const void *unsafe_addr, long count);
>  #define probe_kernel_address(addr, retval)             \
>         probe_kernel_read(&retval, addr, sizeof(retval))
>
> +/**
> + * probe_user_address(): safely attempt to read from a user location
> + * @addr: address to read from
> + * @retval: read into this variable
> + *
> + * Returns 0 on success, or -EFAULT.
> + */
> +#define probe_user_address(addr, retval)               \
> +       probe_user_read(&(retval), addr, sizeof(retval))
> +
>  #ifndef user_access_begin
>  #define user_access_begin() do { } while (0)
>  #define user_access_end() do { } while (0)
> diff --git a/mm/maccess.c b/mm/maccess.c
> index ec00be51a24f..85d4a88a6917 100644
> --- a/mm/maccess.c
> +++ b/mm/maccess.c
> @@ -67,6 +67,39 @@ long __probe_kernel_write(void *dst, const void *src, size_t size)
>  EXPORT_SYMBOL_GPL(probe_kernel_write);
>
>  /**
> + * probe_user_read(): safely attempt to read from a user location
> + * @dst: pointer to the buffer that shall take the data
> + * @src: address to read from
> + * @size: size of the data chunk
> + *
> + * Safely read from address @src to the buffer at @dst.  If a kernel fault
> + * happens, handle that and return -EFAULT.
> + *
> + * We ensure that the copy_from_user is executed in atomic context so that
> + * do_page_fault() doesn't attempt to take mmap_sem.  This makes
> + * probe_user_read() suitable for use within regions where the caller
> + * already holds mmap_sem, or other locks which nest inside mmap_sem.
> + */
> +
> +long __weak probe_user_read(void *dst, const void *src, size_t size)
> +       __attribute__((alias("__probe_user_read")));

Let's use #defines to deal with per-arch aliases so we can keep the
inline I'm suggesting below...

> +
> +long __probe_user_read(void *dst, const void __user *src, size_t size)

Please make this __always_inline so the "size" variable can be
examined for const-ness by the check_object_size() in
__copy_from_user_inatomic().

-Kees

-- 
Kees Cook
Pixel Security
