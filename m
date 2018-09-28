Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4963FC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DABCC2168B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hthr4iIl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DABCC2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbeI1TzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 15:55:23 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39335 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728913AbeI1TzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 15:55:23 -0400
Received: by mail-io1-f66.google.com with SMTP id l7-v6so4179588iok.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 06:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2qcB572wm1dTQ8rmlM9Ij5ZlMEGmnOP+k2bDTQ4EWzE=;
        b=Hthr4iIlQ8Ww5ipeyI+e5EbEkE/UVHi4jodr00A2LtF8uqcUZMggRLrxFM0IsHEChB
         TbtXgrSws+w/L0d5/Zm7G8nEHgQ8Md0Ue4xp3L2PhCAqgG0YNVGtOzXnjPThRYTdvqfX
         SpWP4ce0d5jiwtaNpfxrAQmbOutACi2eTFiEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2qcB572wm1dTQ8rmlM9Ij5ZlMEGmnOP+k2bDTQ4EWzE=;
        b=gP4CgWM6Ue96QfwBvz/j3vSBF/5tZmCJ1FVztFYDN4xan2GObfSihdX2gxqWNgJ7eQ
         W7Y4ldE84sYOpNqM5wFpQOqoKcVg6FFsFFUBH2BMuao8rTho24ExFgZmtepIGXDVli+G
         L6Mj03nbd2LA7n17/rO/OmOQ555Wk6eDxKC+I+zmHq6uBahEuJO3k/7M8ui30q/whPbr
         MnsECY5x4SJiGTrl03tJAE8xQ8RuUbOFz9Cdv1PU6Agwk2sIBEXWmFNqR2KvhKo6ew3d
         aZb1P5XTk8SNPhCDMLmZ1RHKuksK18OQ4CYH42rvPa/P59vvf+gWu7wcqqswku39Pk+9
         e6FA==
X-Gm-Message-State: ABuFfogJNryugP33EOgVpyRwOtmIi4frsO+oAox24aWTWg4COhIsfVN1
        /NMNSxT4lp5NH+tNqinKBdScF+GVrCe4muOgl7cKSA==
X-Google-Smtp-Source: ACcGV62yggPDE31VsSj3WNAvyS3/d9kvsizRxM+PoLB+OQTTXabUnzC/0G1nkfLiO4cuX4jb9mpCsDBO/ZalaFQj104=
X-Received: by 2002:a6b:3787:: with SMTP id e129-v6mr12475414ioa.60.1538141494913;
 Fri, 28 Sep 2018 06:31:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:2848:0:0:0:0:0 with HTTP; Fri, 28 Sep 2018 06:31:34
 -0700 (PDT)
In-Reply-To: <20180921113802.26475-3-Jampala.Srikanth@cavium.com>
References: <20180921113802.26475-1-Jampala.Srikanth@cavium.com> <20180921113802.26475-3-Jampala.Srikanth@cavium.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 28 Sep 2018 15:31:34 +0200
Message-ID: <CAKv+Gu-XHRpuP5tOa+KkM_yzeauaGUrmjbxTHtjw2Q8odZ2Krg@mail.gmail.com>
Subject: Re: [PATCH cryptodev-2.6 3/3] crypto: cavium/nitrox - updated debugfs information.
To:     Srikanth Jampala <Jampala.Srikanth@cavium.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        sgadam@cavium.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 September 2018 at 13:38, Srikanth Jampala
<Jampala.Srikanth@cavium.com> wrote:
> Updated debugfs to provide device partname and frequency etc.
> New file "stats" shows the number of requests posted, dropped and
> completed.
>
> Signed-off-by: Srikanth Jampala <Jampala.Srikanth@cavium.com>
> ---
>  drivers/crypto/cavium/nitrox/Makefile         |   1 +
>  drivers/crypto/cavium/nitrox/nitrox_debugfs.c | 113 +++++++++++++++
>  drivers/crypto/cavium/nitrox/nitrox_dev.h     |  13 ++
>  drivers/crypto/cavium/nitrox/nitrox_main.c    | 129 ------------------
>  4 files changed, 127 insertions(+), 129 deletions(-)
>  create mode 100644 drivers/crypto/cavium/nitrox/nitrox_debugfs.c
>
> diff --git a/drivers/crypto/cavium/nitrox/Makefile b/drivers/crypto/caviu=
m/nitrox/Makefile
> index 6fcda6b56f7e..e12954791673 100644
> --- a/drivers/crypto/cavium/nitrox/Makefile
> +++ b/drivers/crypto/cavium/nitrox/Makefile
> @@ -9,3 +9,4 @@ n5pf-objs :=3D nitrox_main.o \
>         nitrox_algs.o
>
>  n5pf-$(CONFIG_PCI_IOV) +=3D nitrox_sriov.o
> +n5pf-$(CONFIG_DEBUG_FS) +=3D nitrox_debugfs.o
> diff --git a/drivers/crypto/cavium/nitrox/nitrox_debugfs.c b/drivers/cryp=
to/cavium/nitrox/nitrox_debugfs.c
> new file mode 100644
> index 000000000000..2f1e74ea846e
> --- /dev/null
> +++ b/drivers/crypto/cavium/nitrox/nitrox_debugfs.c
> @@ -0,0 +1,113 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/seq_file.h>
> +#include <linux/debugfs.h>
> +
> +#include "nitrox_csr.h"
> +#include "nitrox_dev.h"
> +
> +static int firmware_show(struct seq_file *s, void *v)
> +{
> +       struct nitrox_device *ndev =3D s->private;
> +
> +       seq_printf(s, "Version: %s\n", ndev->hw.fw_name);
> +       return 0;
> +}
> +
> +static int firmware_open(struct inode *inode, struct file *file)
> +{
> +       return single_open(file, firmware_show, inode->i_private);
> +}
> +
> +static const struct file_operations firmware_fops =3D {
> +       .owner =3D THIS_MODULE,
> +       .open =3D firmware_open,
> +       .read =3D seq_read,
> +       .llseek =3D seq_lseek,
> +       .release =3D single_release,
> +};
> +
> +static int device_show(struct seq_file *s, void *v)
> +{
> +       struct nitrox_device *ndev =3D s->private;
> +
> +       seq_printf(s, "NITROX [%d]\n", ndev->idx);
> +       seq_printf(s, "  Part Name: %s\n", ndev->hw.partname);
> +       seq_printf(s, "  Frequency: %d MHz\n", ndev->hw.freq);
> +       seq_printf(s, "  Device ID: 0x%0x\n", ndev->hw.device_id);
> +       seq_printf(s, "  Revision ID: 0x%0x\n", ndev->hw.revision_id);
> +       seq_printf(s, "  Cores: [AE=3D%u  SE=3D%u  ZIP=3D%u]\n",
> +                  ndev->hw.ae_cores, ndev->hw.se_cores, ndev->hw.zip_cor=
es);
> +
> +       return 0;
> +}
> +
> +static int nitrox_open(struct inode *inode, struct file *file)
> +{
> +       return single_open(file, device_show, inode->i_private);
> +}
> +
> +static const struct file_operations nitrox_fops =3D {
> +       .owner =3D THIS_MODULE,
> +       .open =3D nitrox_open,
> +       .read =3D seq_read,
> +       .llseek =3D seq_lseek,
> +       .release =3D single_release,
> +};
> +
> +static int stats_show(struct seq_file *s, void *v)
> +{
> +       struct nitrox_device *ndev =3D s->private;
> +
> +       seq_printf(s, "NITROX [%d] Request Statistics\n", ndev->idx);
> +       seq_printf(s, "  Posted: %lld\n", atomic64_read(&ndev->stats.post=
ed));
> +       seq_printf(s, "  Completed: %lld\n",
> +                  atomic64_read(&ndev->stats.completed));
> +       seq_printf(s, "  Dropped: %lld\n", atomic64_read(&ndev->stats.dro=
pped));
> +

This gives me

/home/ard/linux/drivers/crypto/cavium/nitrox/nitrox_debugfs.c: In
function =E2=80=98stats_show=E2=80=99:
/home/ard/linux/drivers/crypto/cavium/nitrox/nitrox_debugfs.c:62:30:
warning: format =E2=80=98%lld=E2=80=99 expects argument of type =E2=80=98lo=
ng long int=E2=80=99, but
argument 3 has type =E2=80=98long int=E2=80=99 [-Wformat=3D]
  seq_printf(s, "  Posted: %lld\n", atomic64_read(&ndev->stats.posted));
                              ^
/home/ard/linux/drivers/crypto/cavium/nitrox/nitrox_debugfs.c:63:33:
warning: format =E2=80=98%lld=E2=80=99 expects argument of type =E2=80=98lo=
ng long int=E2=80=99, but
argument 3 has type =E2=80=98long int=E2=80=99 [-Wformat=3D]
  seq_printf(s, "  Completed: %lld\n",
                                 ^
/home/ard/linux/drivers/crypto/cavium/nitrox/nitrox_debugfs.c:65:31:
warning: format =E2=80=98%lld=E2=80=99 expects argument of type =E2=80=98lo=
ng long int=E2=80=99, but
argument 3 has type =E2=80=98long int=E2=80=99 [-Wformat=3D]
  seq_printf(s, "  Dropped: %lld\n", atomic64_read(&ndev->stats.dropped));
                               ^

when building on arm64.


> +       return 0;
> +}
> +
> +static int nitrox_stats_open(struct inode *inode, struct file *file)
> +{
> +       return single_open(file, stats_show, inode->i_private);
> +}
> +
> +static const struct file_operations nitrox_stats_fops =3D {
> +       .owner =3D THIS_MODULE,
> +       .open =3D nitrox_stats_open,
> +       .read =3D seq_read,
> +       .llseek =3D seq_lseek,
> +       .release =3D single_release,
> +};
> +
> +void nitrox_debugfs_exit(struct nitrox_device *ndev)
> +{
> +       debugfs_remove_recursive(ndev->debugfs_dir);
> +       ndev->debugfs_dir =3D NULL;
> +}
> +
> +int nitrox_debugfs_init(struct nitrox_device *ndev)
> +{
> +       struct dentry *dir, *f;
> +
> +       dir =3D debugfs_create_dir(KBUILD_MODNAME, NULL);
> +       if (!dir)
> +               return -ENOMEM;
> +
> +       ndev->debugfs_dir =3D dir;
> +       f =3D debugfs_create_file("firmware", 0400, dir, ndev, &firmware_=
fops);
> +       if (!f)
> +               goto err;
> +       f =3D debugfs_create_file("device", 0400, dir, ndev, &nitrox_fops=
);
> +       if (!f)
> +               goto err;
> +       f =3D debugfs_create_file("stats", 0400, dir, ndev, &nitrox_stats=
_fops);
> +       if (!f)
> +               goto err;
> +
> +       return 0;
> +
> +err:
> +       nitrox_debugfs_exit(ndev);
> +       return -ENODEV;
> +}
> diff --git a/drivers/crypto/cavium/nitrox/nitrox_dev.h b/drivers/crypto/c=
avium/nitrox/nitrox_dev.h
> index a1442006f256..abb5c8ac54e5 100644
> --- a/drivers/crypto/cavium/nitrox/nitrox_dev.h
> +++ b/drivers/crypto/cavium/nitrox/nitrox_dev.h
> @@ -218,4 +218,17 @@ static inline bool nitrox_ready(struct nitrox_device=
 *ndev)
>         return atomic_read(&ndev->state) =3D=3D __NDEV_READY;
>  }
>
> +#ifdef CONFIG_DEBUG_FS
> +int nitrox_debugfs_init(struct nitrox_device *ndev);
> +void nitrox_debugfs_exit(struct nitrox_device *ndev);
> +#else
> +static inline int nitrox_debugfs_init(struct nitrox_device *ndev)
> +{
> +       return 0;
> +}
> +
> +static inline void nitrox_debugfs_exit(struct nitrox_device *ndev)
> +{ }
> +#endif
> +
>  #endif /* __NITROX_DEV_H */
> diff --git a/drivers/crypto/cavium/nitrox/nitrox_main.c b/drivers/crypto/=
cavium/nitrox/nitrox_main.c
> index 362e7217354c..5bd97cff1405 100644
> --- a/drivers/crypto/cavium/nitrox/nitrox_main.c
> +++ b/drivers/crypto/cavium/nitrox/nitrox_main.c
> @@ -323,135 +323,6 @@ static int nitrox_pf_hw_init(struct nitrox_device *=
ndev)
>         return 0;
>  }
>
> -#if IS_ENABLED(CONFIG_DEBUG_FS)
> -static int registers_show(struct seq_file *s, void *v)
> -{
> -       struct nitrox_device *ndev =3D s->private;
> -       u64 offset;
> -
> -       /* NPS DMA stats */
> -       offset =3D NPS_STATS_PKT_DMA_RD_CNT;
> -       seq_printf(s, "NPS_STATS_PKT_DMA_RD_CNT  0x%016llx\n",
> -                  nitrox_read_csr(ndev, offset));
> -       offset =3D NPS_STATS_PKT_DMA_WR_CNT;
> -       seq_printf(s, "NPS_STATS_PKT_DMA_WR_CNT  0x%016llx\n",
> -                  nitrox_read_csr(ndev, offset));
> -
> -       /* BMI/BMO stats */
> -       offset =3D BMI_NPS_PKT_CNT;
> -       seq_printf(s, "BMI_NPS_PKT_CNT  0x%016llx\n",
> -                  nitrox_read_csr(ndev, offset));
> -       offset =3D BMO_NPS_SLC_PKT_CNT;
> -       seq_printf(s, "BMO_NPS_PKT_CNT  0x%016llx\n",
> -                  nitrox_read_csr(ndev, offset));
> -
> -       return 0;
> -}
> -
> -static int registers_open(struct inode *inode, struct file *file)
> -{
> -       return single_open(file, registers_show, inode->i_private);
> -}
> -
> -static const struct file_operations register_fops =3D {
> -       .owner =3D THIS_MODULE,
> -       .open =3D registers_open,
> -       .read =3D seq_read,
> -       .llseek =3D seq_lseek,
> -       .release =3D single_release,
> -};
> -
> -static int firmware_show(struct seq_file *s, void *v)
> -{
> -       struct nitrox_device *ndev =3D s->private;
> -
> -       seq_printf(s, "Version: %s\n", ndev->hw.fw_name);
> -       return 0;
> -}
> -
> -static int firmware_open(struct inode *inode, struct file *file)
> -{
> -       return single_open(file, firmware_show, inode->i_private);
> -}
> -
> -static const struct file_operations firmware_fops =3D {
> -       .owner =3D THIS_MODULE,
> -       .open =3D firmware_open,
> -       .read =3D seq_read,
> -       .llseek =3D seq_lseek,
> -       .release =3D single_release,
> -};
> -
> -static int nitrox_show(struct seq_file *s, void *v)
> -{
> -       struct nitrox_device *ndev =3D s->private;
> -
> -       seq_printf(s, "NITROX-5 [idx: %d]\n", ndev->idx);
> -       seq_printf(s, "  Revision ID: 0x%0x\n", ndev->hw.revision_id);
> -       seq_printf(s, "  Cores [AE: %u  SE: %u]\n",
> -                  ndev->hw.ae_cores, ndev->hw.se_cores);
> -       seq_printf(s, "  Number of Queues: %u\n", ndev->nr_queues);
> -       seq_printf(s, "  Queue length: %u\n", ndev->qlen);
> -       seq_printf(s, "  Node: %u\n", ndev->node);
> -
> -       return 0;
> -}
> -
> -static int nitrox_open(struct inode *inode, struct file *file)
> -{
> -       return single_open(file, nitrox_show, inode->i_private);
> -}
> -
> -static const struct file_operations nitrox_fops =3D {
> -       .owner =3D THIS_MODULE,
> -       .open =3D nitrox_open,
> -       .read =3D seq_read,
> -       .llseek =3D seq_lseek,
> -       .release =3D single_release,
> -};
> -
> -static void nitrox_debugfs_exit(struct nitrox_device *ndev)
> -{
> -       debugfs_remove_recursive(ndev->debugfs_dir);
> -       ndev->debugfs_dir =3D NULL;
> -}
> -
> -static int nitrox_debugfs_init(struct nitrox_device *ndev)
> -{
> -       struct dentry *dir, *f;
> -
> -       dir =3D debugfs_create_dir(KBUILD_MODNAME, NULL);
> -       if (!dir)
> -               return -ENOMEM;
> -
> -       ndev->debugfs_dir =3D dir;
> -       f =3D debugfs_create_file("counters", 0400, dir, ndev, &register_=
fops);
> -       if (!f)
> -               goto err;
> -       f =3D debugfs_create_file("firmware", 0400, dir, ndev, &firmware_=
fops);
> -       if (!f)
> -               goto err;
> -       f =3D debugfs_create_file("nitrox", 0400, dir, ndev, &nitrox_fops=
);
> -       if (!f)
> -               goto err;
> -
> -       return 0;
> -
> -err:
> -       nitrox_debugfs_exit(ndev);
> -       return -ENODEV;
> -}
> -#else
> -static int nitrox_debugfs_init(struct nitrox_device *ndev)
> -{
> -       return 0;
> -}
> -
> -static void nitrox_debugfs_exit(struct nitrox_device *ndev)
> -{
> -}
> -#endif
> -
>  /**
>   * nitrox_probe - NITROX Initialization function.
>   * @pdev: PCI device information struct
> --
> 2.17.1
>
