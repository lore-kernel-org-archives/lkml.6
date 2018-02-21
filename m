Return-Path: <bsingharora@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519195441; cv=none;
        d=google.com; s=arc-20160816;
        b=HknVwiPuuyI8HM4DNhS3pLPVrrJquFFMK+FxmuAqUyNSR7tj2nACHfNwwWVl/2tyA6
         giEvj2D/MYHP8YPY6q9ecbPcym5QZBhMWv5PAqPC4Sq0GXIGGXJK5NxplSVWI6McmHmp
         hYOuy2g0FbtLqwQMGE3a3EojH8eDs/bwlYmBdrBnNWZnURzmjaqW3vGOUjRm6Nw7A8u1
         ROpdpdUy91yzmWggVZQf6wu0MletNxcxBywRsaxtF2+uodj4k5G2w9btMC1BbgzFoPM7
         uzU1BAX7fDQez++UFacQGx/X0zN34okuskzib0GgxRsHTW1rvOnRz9UHTVDUw+7hhzvv
         EXwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=64ry4OZkVn+2Yh1MKbAwhjodZJLnoMiKFiLy5Jp00bo=;
        b=zbuJe4foET+ZjCPDF/dzeIhPiHDIzWN+mm9yghg714t+751DVz4pTp9A/ZBFma5TaX
         IwessKBb3Y1XU+2FLHl01NhVXwEewNyKD7UIToHKazwdEfFtC+a1KwEbzgY4OoQyoRzB
         PutofcaRYcSaqHyonXJr1R3qphlhyLb+1KShjBdrtUNYBHGTpmH9LC9CtGXGfVFhUx4+
         pJdMOYVcelyF7JaQCtBWVtO51E2tsDf2Og7aq42A5Oj96oY3pcMea9eu6M0TAhf3GX9n
         Hfi62fh8pg8BkC3S54B+og2QOFVGmicrrAdCm0UIsGW0QxINYwLLdWUyeehCkQukvU7P
         2Tew==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=N6cX49/W;
       spf=pass (google.com: domain of bsingharora@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=bsingharora@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=N6cX49/W;
       spf=pass (google.com: domain of bsingharora@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=bsingharora@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x224l5byrvxJ5PeSALqIBoQpVlCb9dD+O61+qK4J/BMKMMwtc3wesawN+z1/BYxGNrPXS/kFj2Crlt1Xw8CZ4xJU=
MIME-Version: 1.0
In-Reply-To: <20180221045736.7614-1-alastair@au1.ibm.com>
References: <20180221045736.7614-1-alastair@au1.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Wed, 21 Feb 2018 17:43:59 +1100
Message-ID: <CAKTCnz=cy5CkeRjJYpZ1NQpyQN-BVTvKXUxTxOMtTNosZFqJ7A@mail.gmail.com>
Subject: Re: [PATCH] ocxl: Add get_metadata IOCTL to share OCXL information to userspace
To: "Alastair D'Silva" <alastair@au1.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, frederic.barrat@fr.ibm.com,
	Greg KH <gregkh@linuxfoundation.org>,
	Andrew Donnellan <andrew.donnellan@au1.ibm.com>, "Alastair D'Silva" <alastair@d-silva.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592985250939595866?=
X-GMAIL-MSGID: =?utf-8?q?1592991879023519933?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 21, 2018 at 3:57 PM, Alastair D'Silva <alastair@au1.ibm.com> wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
>
> Some required information is not exposed to userspace currently (eg. the
> PASID), pass this information back, along with other information which
> is currently communicated via sysfs, which saves some parsing effort in
> userspace.
>
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---
>  drivers/misc/ocxl/file.c | 27 +++++++++++++++++++++++++++
>  include/uapi/misc/ocxl.h | 22 ++++++++++++++++++++++
>  2 files changed, 49 insertions(+)
>
> diff --git a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c
> index d9aa407db06a..11514a8444e5 100644
> --- a/drivers/misc/ocxl/file.c
> +++ b/drivers/misc/ocxl/file.c
> @@ -102,10 +102,32 @@ static long afu_ioctl_attach(struct ocxl_context *ctx,
>         return rc;
>  }
>
> +static long afu_ioctl_get_metadata(struct ocxl_context *ctx,
> +               struct ocxl_ioctl_get_metadata __user *uarg)

Why do we call this metadata? Isn't this an afu_descriptor?

> +{
> +       struct ocxl_ioctl_get_metadata arg;
> +
> +       memset(&arg, 0, sizeof(arg));
> +
> +       arg.version = 0;

Does it make sense to have version 0? Even if does, you can afford
to skip initialization due to the memset above. I prefer that versions
start with 1

> +
> +       arg.afu_version_major = ctx->afu->config.version_major;
> +       arg.afu_version_minor = ctx->afu->config.version_minor;
> +       arg.pasid = ctx->pasid;
> +       arg.pp_mmio_size = ctx->afu->config.pp_mmio_stride;
> +       arg.global_mmio_size = ctx->afu->config.global_mmio_size;
> +
> +       if (copy_to_user(uarg, &arg, sizeof(arg)))
> +               return -EFAULT;
> +
> +       return 0;
> +}
> +
>  #define CMD_STR(x) (x == OCXL_IOCTL_ATTACH ? "ATTACH" :                        \
>                         x == OCXL_IOCTL_IRQ_ALLOC ? "IRQ_ALLOC" :       \
>                         x == OCXL_IOCTL_IRQ_FREE ? "IRQ_FREE" :         \
>                         x == OCXL_IOCTL_IRQ_SET_FD ? "IRQ_SET_FD" :     \
> +                       x == OCXL_IOCTL_GET_METADATA ? "GET_METADATA" : \
>                         "UNKNOWN")
>
>  static long afu_ioctl(struct file *file, unsigned int cmd,
> @@ -157,6 +179,11 @@ static long afu_ioctl(struct file *file, unsigned int cmd,
>                                         irq_fd.eventfd);
>                 break;
>
> +       case OCXL_IOCTL_GET_METADATA:
> +               rc = afu_ioctl_get_metadata(ctx,
> +                               (struct ocxl_ioctl_get_metadata __user *) args);
> +               break;
> +
>         default:
>                 rc = -EINVAL;
>         }
> diff --git a/include/uapi/misc/ocxl.h b/include/uapi/misc/ocxl.h
> index 4b0b0b756f3e..16e1f48ce280 100644
> --- a/include/uapi/misc/ocxl.h
> +++ b/include/uapi/misc/ocxl.h
> @@ -32,6 +32,27 @@ struct ocxl_ioctl_attach {
>         __u64 reserved3;
>  };
>
> +/*
> + * Version contains the version of the struct.
> + * Versions will always be backwards compatible, that is, new versions will not
> + * alter existing fields
> + */
> +struct ocxl_ioctl_get_metadata {

This sounds more like a function name, do we need it to be _get_metdata?

> +       __u16 version;
> +
> +       // Version 0 fields
> +       __u8  afu_version_major;
> +       __u8  afu_version_minor;
> +       __u32 pasid;
> +
> +       __u64 pp_mmio_size;
> +       __u64 global_mmio_size;
> +

Should we document the fields? pp_ stands for per process, but is not
very clear at first look. Why do we care to return only the size, what
about lpc size?

> +       // End version 0 fields
> +
> +       __u64 reserved[13]; // Total of 16*u64
> +};


Balbir Singh.
