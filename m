Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x227zfzkJxM8oTtKshtqGJu7317J1ttLsU7eCMzyJ2yo8ka14bD7kBxFHhyuXB1s3DyR/4557
ARC-Seal: i=1; a=rsa-sha256; t=1517589138; cv=none;
        d=google.com; s=arc-20160816;
        b=AHCc95R4wtdhOTRLdx6KN6rjWL0WYwM0GHT/h1l8ad10wEMxp1MQAtuBFs09vaY2Lt
         dcWJfkOfsDCv7iFoAyf7b5b+Yz+NUr4wcLzwHTATGjigjLOCmJolVtl+wMshNmPQZbuz
         gPlHB+QWUIZ9X0yt/PUYH0XSZjRR+NYsCs6jKfEc4+jdunOw3sY8yYga6ABEU3YdYQYR
         13yscpN+2e2odM1THjSODMDt5zK+UJssaDRCGb7Y5qHM4PVvTeZZQhG1odul4nrppHQR
         7/UxE6e+vCyUCcyBXLDCv8n+y7OAp1WzlQmox32B87+HhFk6Drh/mToZyiCfDN9EIsdN
         smjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:dkim-filter:arc-authentication-results;
        bh=tgnU7NovKHYWKaTf4jZjC6wMnoyS9q1oFDFkao63j9I=;
        b=EMWw7NYJWKo7G5JrQEWGNZf51nDm06pejxG8GCtC5L5QRZexR2slpTSPwFn5MAyIUz
         p18un0lYLT186FIIsqy6VDxt2XquZeJBuWac6jAD3oTtVzw5/yJxRkhuOJ1Xg2L5AtXl
         MUqmU6MGB6V+JV3lGjo4yAswH8fmh7meJB/ge0Mh5TYL9CqFrjclF9mZBwXsoN2w0/xw
         iOdeY6b23TGkvCzxrJ6NvFBzlSfEeGO9o7BZlZvqLOk7CT19Oc5uiA7taXxOcNi4qtU3
         82lsCV6/Kbdc3HX1ufgBJFYyeFK1eG/oPc8ApxvkFB7za7xUn5vnP7vpUq+3/2QAlQwb
         CN9g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=0lS0gAIw;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.81 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=0lS0gAIw;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.81 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w12GW0Ei014501
X-Nifty-SrcIP: [209.85.213.50]
MIME-Version: 1.0
In-Reply-To: <20180202154104.1522809-2-arnd@arndb.de>
References: <20180202154104.1522809-1-arnd@arndb.de> <20180202154104.1522809-2-arnd@arndb.de>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sat, 3 Feb 2018 01:31:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNATo8y_jk0xth9xiLqGTt_f2w_ocQ2agpZqBgK_tO-MOtg@mail.gmail.com>
Message-ID: <CAK7LNATo8y_jk0xth9xiLqGTt_f2w_ocQ2agpZqBgK_tO-MOtg@mail.gmail.com>
Subject: Re: [PATCH 2/2] Kbuild: always define endianess in kconfig.h
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nicolas Pitre <nico@linaro.org>,
        Andi Kleen <ak@linux.intel.com>, Babu Moger <babu.moger@oracle.com>,
        Will Deacon <will.deacon@arm.com>, stable <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591304720690698857?=
X-GMAIL-MSGID: =?utf-8?q?1591307548609519521?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Arnd,


2018-02-03 0:40 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> Build testing with LTO found a couple of files that get compiled
> differently depending on whether asm/byteorder.h gets included early
> enough or not. In particular, include/asm-generic/qrwlock_types.h is
> affected by this, but there are probably others as well.
>
> The symptom is a series of LTO link time warnings, including these:
>
> net/netlabel/netlabel_unlabeled.h:223: error: type of 'netlbl_unlhsh_add' does not match original declaration [-Werror=lto-type-mismatch]
>  int netlbl_unlhsh_add(struct net *net,
> net/netlabel/netlabel_unlabeled.c:377: note: 'netlbl_unlhsh_add' was previously declared here
>
> include/net/ipv6.h:360: error: type of 'ipv6_renew_options_kern' does not match original declaration [-Werror=lto-type-mismatch]
>  ipv6_renew_options_kern(struct sock *sk,
> net/ipv6/exthdrs.c:1162: note: 'ipv6_renew_options_kern' was previously declared here
>
> net/core/dev.c:761: note: 'dev_get_by_name_rcu' was previously declared here
>  struct net_device *dev_get_by_name_rcu(struct net *net, const char *name)
> net/core/dev.c:761: note: code may be misoptimized unless -fno-strict-aliasing is used
>
> drivers/gpu/drm/i915/i915_drv.h:3377: error: type of 'i915_gem_object_set_to_wc_domain' does not match original declaration [-Werror=lto-type-mismatch]
>  i915_gem_object_set_to_wc_domain(struct drm_i915_gem_object *obj, bool write);
> drivers/gpu/drm/i915/i915_gem.c:3639: note: 'i915_gem_object_set_to_wc_domain' was previously declared here
>
> include/linux/debugfs.h:92:9: error: type of 'debugfs_attr_read' does not match original declaration [-Werror=lto-type-mismatch]
>  ssize_t debugfs_attr_read(struct file *file, char __user *buf,
> fs/debugfs/file.c:318: note: 'debugfs_attr_read' was previously declared here
>
> include/linux/rwlock_api_smp.h:30: error: type of '_raw_read_unlock' does not match original declaration [-Werror=lto-type-mismatch]
>  void __lockfunc _raw_read_unlock(rwlock_t *lock) __releases(lock);
> kernel/locking/spinlock.c:246:26: note: '_raw_read_unlock' was previously declared here
>
> include/linux/fs.h:3308:5: error: type of 'simple_attr_open' does not match original declaration [-Werror=lto-type-mismatch]
>  int simple_attr_open(struct inode *inode, struct file *file,
> fs/libfs.c:795: note: 'simple_attr_open' was previously declared here
>
> All of the above are caused by include/asm-generic/qrwlock_types.h failing
> to include asm/byteorder.h after commit e0d02285f16e ("locking/qrwlock:
> Use 'struct qrwlock' instead of 'struct __qrwlock'") in linux-4.15.
>
> Similar bugs may or may not exist in older kernels as well, but there
> is no easy way to test those with link-time optimizations, and kernels
> before 4.14 are harder to fix because they don't have Babu's patch series


Is this patch only for stable kernel,
not for the mainline?


> We had similar issues with CONFIG_ symbols in the past and ended up
> always including the configuration headers though linux/kconfig.h.
> This works around the issue through that same file, defining either
> __BIG_ENDIAN or __LITTLE_ENDIAN depending on CONFIG_CPU_BIG_ENDIAN,
> which is now always set on all architectures since commit 4c97a0c8fee3
> ("arch: define CPU_BIG_ENDIAN for all fixed big endian archs").
>
> Cc: stable@vger.kernel.org
> Cc: Babu Moger <babu.moger@oracle.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/linux/kconfig.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/include/linux/kconfig.h b/include/linux/kconfig.h
> index fec5076eda91..cc8fa109cfa3 100644
> --- a/include/linux/kconfig.h
> +++ b/include/linux/kconfig.h
> @@ -4,6 +4,12 @@
>
>  #include <generated/autoconf.h>
>
> +#ifdef CONFIG_CPU_BIG_ENDIAN
> +#define __BIG_ENDIAN 4321
> +#else
> +#define __LITTLE_ENDIAN 1234
> +#endif
> +
>  #define __ARG_PLACEHOLDER_1 0,
>  #define __take_second_arg(__ignored, val, ...) val
>
> --
> 2.9.0
>

If all architectures define
CONFIG_CPU_BIG_ENDIAN or CONFIG_CPU_LITTLE_ENDIAN,
is it possible to use this for endian test?

i.e.

Is it possible to replace like this?
   #ifdef __BIG_ENDIAN       ->  #ifdef CONFIG_CPU_BIG_ENDIAN

   #ifdef __LITTLE_ENDIAN     -> #ifdef CONFIG_CPU_LITTLE_ENDIAN






-- 
Best Regards
Masahiro Yamada
