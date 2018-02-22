Return-Path: <bsingharora@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519270908; cv=none;
        d=google.com; s=arc-20160816;
        b=xGH0VUohF4qbZVA0MhwLvxhgcCIPoUkEF8CTZQARa5nfE2Zb/HVadhtEOGNAV4bpSM
         oSz3Yn9jTtexkGMNgDeNmWSPUNfVTMVyfj2i6KZIDCoRDTDEnhdIkH1wTTWxqxWEUvvy
         O2leGWQclSZ3O0ai2WuKMb8yrAhprCb6bzfo1XvYkT3f5Cp9UObFAr/4IrEUFgaNf2IT
         6NMbxQxQUDrK+AuiERCIpzH1CIf3FV1NiCjdXSwr17ZxjwKhQzVEZ162YPxCTPJlvQgd
         tWlXlaXCpHY+xk5MYXz1TssMbhBMLN+QtuLGhr0NVUJ5ESm1sDItHk1dM1LzzLVGZIbP
         2myg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=2Wvc2t84zX3QbVscsVI+sakdZD4tLkZKtYLKItM8rUg=;
        b=FdjFFyKspzYNfH5iinOmjKo07a5sjreAx1MdLX9UkTc6vjECGjaXW9aaqx1HOTrcLS
         toZPiWxesYFYkNwhOD5fWY/VF2iu/uxTQk6BpV0DpxxaDUin+yzWHsr1Prr6L3hesYD9
         i4OnLXeH6ajDsfqY4mxSiTCBXVphakruvgJwb1SI3K4trZWAepIpPDvXa+b5k+gBj0PO
         UwqVGxArpCTnOk+B7pIqy8B6j/A9h2IFff48G72iGi4KPM+ubsJZ+NCU4Bzm3LtSMUls
         t63q3FDzdcfNsmunCrH5bTxO94hixUlwrgRgCPGwJE46rAKgW4DM5Bb82wDs8VebydzL
         hKew==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=dd7xG9Ae;
       spf=pass (google.com: domain of bsingharora@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=bsingharora@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=dd7xG9Ae;
       spf=pass (google.com: domain of bsingharora@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=bsingharora@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x227v0j+id7SN2iXawC/q+S1zPL5OACcsS8xRuFst4RtDLbUn92lNYFsq3xVBGzLS9vdNdFOYGEEBN8NYxIgYi+g=
MIME-Version: 1.0
In-Reply-To: <1519255934.2867.3.camel@au1.ibm.com>
References: <20180221045736.7614-1-alastair@au1.ibm.com> <CAKTCnz=cy5CkeRjJYpZ1NQpyQN-BVTvKXUxTxOMtTNosZFqJ7A@mail.gmail.com>
 <1519255934.2867.3.camel@au1.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Thu, 22 Feb 2018 14:41:47 +1100
Message-ID: <CAKTCnzmmUGPNk1ggpWYQjiDLcAR_c7cqdZyPU+6rKGC6AcNW7A@mail.gmail.com>
Subject: Re: [PATCH] ocxl: Add get_metadata IOCTL to share OCXL information to userspace
To: "Alastair D'Silva" <alastair@au1.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, frederic.barrat@fr.ibm.com,
	Greg KH <gregkh@linuxfoundation.org>,
	Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592985250939595866?=
X-GMAIL-MSGID: =?utf-8?q?1593071012435008020?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 22, 2018 at 10:32 AM, Alastair D'Silva <alastair@au1.ibm.com> wrote:
>
> On Wed, 2018-02-21 at 17:43 +1100, Balbir Singh wrote:
>> On Wed, Feb 21, 2018 at 3:57 PM, Alastair D'Silva <alastair@au1.ibm.c
>> om> wrote:
>> > From: Alastair D'Silva <alastair@d-silva.org>
>> >
>> > Some required information is not exposed to userspace currently
>> > (eg. the
>> > PASID), pass this information back, along with other information
>> > which
>> > is currently communicated via sysfs, which saves some parsing
>> > effort in
>> > userspace.
>> >
>> > Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
>> > ---
>> >  drivers/misc/ocxl/file.c | 27 +++++++++++++++++++++++++++
>> >  include/uapi/misc/ocxl.h | 22 ++++++++++++++++++++++
>> >  2 files changed, 49 insertions(+)
>> >
>> > diff --git a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c
>> > index d9aa407db06a..11514a8444e5 100644
>> > --- a/drivers/misc/ocxl/file.c
>> > +++ b/drivers/misc/ocxl/file.c
>> > @@ -102,10 +102,32 @@ static long afu_ioctl_attach(struct
>> > ocxl_context *ctx,
>> >         return rc;
>> >  }
>> >
>> > +static long afu_ioctl_get_metadata(struct ocxl_context *ctx,
>> > +               struct ocxl_ioctl_get_metadata __user *uarg)
>>
>> Why do we call this metadata? Isn't this an afu_descriptor?
>>
>
> It's metadata for the descriptor.

I meant metadata is too generic, could we have other types of metadata in OCXL?

>
>> > +{
>> > +       struct ocxl_ioctl_get_metadata arg;
>> > +
>> > +       memset(&arg, 0, sizeof(arg));
>> > +
>> > +       arg.version = 0;
>>
>> Does it make sense to have version 0? Even if does, you can afford
>> to skip initialization due to the memset above. I prefer that
>> versions
>> start with 1
>>
>
> Setting it to 0 is for the reader, not the compiler. I'm not clear on
> the benefit of starting the version at 1, could you clarify?

How do I distinguish between version number never set and 0?

>
>> > +
>> > +       arg.afu_version_major = ctx->afu->config.version_major;
>> > +       arg.afu_version_minor = ctx->afu->config.version_minor;
>> > +       arg.pasid = ctx->pasid;
>> > +       arg.pp_mmio_size = ctx->afu->config.pp_mmio_stride;
>> > +       arg.global_mmio_size = ctx->afu->config.global_mmio_size;
>> > +
>> > +       if (copy_to_user(uarg, &arg, sizeof(arg)))
>> > +               return -EFAULT;
>> > +
>> > +       return 0;
>> > +}
>> > +
>> >  #define CMD_STR(x) (x == OCXL_IOCTL_ATTACH ? "ATTACH"
>> > :                        \
>> >                         x == OCXL_IOCTL_IRQ_ALLOC ? "IRQ_ALLOC"
>> > :       \
>> >                         x == OCXL_IOCTL_IRQ_FREE ? "IRQ_FREE"
>> > :         \
>> >                         x == OCXL_IOCTL_IRQ_SET_FD ? "IRQ_SET_FD"
>> > :     \
>> > +                       x == OCXL_IOCTL_GET_METADATA ?
>> > "GET_METADATA" : \
>> >                         "UNKNOWN")
>> >
>> >  static long afu_ioctl(struct file *file, unsigned int cmd,
>> > @@ -157,6 +179,11 @@ static long afu_ioctl(struct file *file,
>> > unsigned int cmd,
>> >                                         irq_fd.eventfd);
>> >                 break;
>> >
>> > +       case OCXL_IOCTL_GET_METADATA:
>> > +               rc = afu_ioctl_get_metadata(ctx,
>> > +                               (struct ocxl_ioctl_get_metadata
>> > __user *) args);
>> > +               break;
>> > +
>> >         default:
>> >                 rc = -EINVAL;
>> >         }
>> > diff --git a/include/uapi/misc/ocxl.h b/include/uapi/misc/ocxl.h
>> > index 4b0b0b756f3e..16e1f48ce280 100644
>> > --- a/include/uapi/misc/ocxl.h
>> > +++ b/include/uapi/misc/ocxl.h
>> > @@ -32,6 +32,27 @@ struct ocxl_ioctl_attach {
>> >         __u64 reserved3;
>> >  };
>> >
>> > +/*
>> > + * Version contains the version of the struct.
>> > + * Versions will always be backwards compatible, that is, new
>> > versions will not
>> > + * alter existing fields
>> > + */
>> > +struct ocxl_ioctl_get_metadata {
>>
>> This sounds more like a function name, do we need it to be
>> _get_metdata?
>>
>
> It pretty much is a function, it returns to userspace metadata about
> the descriptor being operated on.
>

It has a verb indicating action

>> > +       __u16 version;
>> > +
>> > +       // Version 0 fields
>> > +       __u8  afu_version_major;
>> > +       __u8  afu_version_minor;
>> > +       __u32 pasid;
>> > +
>> > +       __u64 pp_mmio_size;
>> > +       __u64 global_mmio_size;
>> > +
>>
>> Should we document the fields? pp_ stands for per process, but is not
>> very clear at first look. Why do we care to return only the size,
>> what
>> about lpc size?
>>
>
> Yes, I would rather call it per_pasid_mmio_size, but consistency with
> the rest of the driver (& exposed sysfs entries) is also important.
>

Balbir Singh.
