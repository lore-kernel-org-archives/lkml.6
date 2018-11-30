Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E71FC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F7A220673
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:08:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F7A220673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbeLACSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:18:01 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39241 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbeLACSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 21:18:01 -0500
Received: by mail-qk1-f194.google.com with SMTP id q70so3329638qkh.6;
        Fri, 30 Nov 2018 07:08:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KdyXIqS+A9j0W/MXgNC7z20ogxgFW9IMkEjzG6Qdkog=;
        b=qbKI2z17mqFHdOFK3BqSpa5pUVtlwI2J8o/f07uJQ8f+qr0adsZHvi6nb0HHiCxP5X
         ++jEyGTcACrhb3kZeXWzQeJs7Gsg1eTZNM1J18zGDjVO0fou/P+Qvjf2rx6oqhOP4cFD
         BVCmFXwJWtdvM8ou3fk/LloJ0l35RHu3ewOR8qm1VHavKo70HPDh/i+xjqDPDjGEtzl/
         8sMH5B6epnDiYiXTsWBRJdsEwD0PD3xgsc9xOrlNCrtomwbZW2CQZWNPOsKV8OKE3Wls
         VX/i+vYnEXnsj9ccbR4G/4wuLPPYzLk/cApqY2dCD+VeHFqs6cJruzvdRrfUKhsHMHjt
         T9Lg==
X-Gm-Message-State: AA+aEWZGs71Ew1P0nlWpBXbB5svLBV9cPT49CVJQtzWzG+m/2fVNQm+e
        uVEfebItscE6aADXrYjmoGqxrFjRGY6io/gQAp/i3B18
X-Google-Smtp-Source: AFSGD/UTIPE5dFZ98tnRQPMbPc9+f//BhxtfHMe37YZYgWHdjWRWXWqLhTum/Cc2SXs68uAMH/hNAsdOAnBfh/LYGzo=
X-Received: by 2002:ae9:e102:: with SMTP id g2mr5257639qkm.343.1543590502512;
 Fri, 30 Nov 2018 07:08:22 -0800 (PST)
MIME-Version: 1.0
References: <20181130104657.14875-1-srinivas.kandagatla@linaro.org>
 <20181130104657.14875-4-srinivas.kandagatla@linaro.org> <CAK8P3a1mFWJyXCn74_Yd_y3Df0JN=qM4nw4-2t_LjRO7yXmXBw@mail.gmail.com>
 <3c177508-cf6f-1f8d-a324-5bec40fd9a9c@linaro.org>
In-Reply-To: <3c177508-cf6f-1f8d-a324-5bec40fd9a9c@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 30 Nov 2018 16:08:03 +0100
Message-ID: <CAK8P3a0d=VRP+9vZm+eJeJM933PWYL4sruMAYBYzWjg5B_kL2g@mail.gmail.com>
Subject: Re: [RFC PATCH 3/6] char: fastrpc: Add support for context Invoke method
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, bkumar@qti.qualcomm.com,
        thierry.escande@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 4:01 PM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
> Thanks Arnd for the review comments!
> On 30/11/18 13:41, Arnd Bergmann wrote:
> > On Fri, Nov 30, 2018 at 11:48 AM Srinivas Kandagatla
> > <srinivas.kandagatla@linaro.org> wrote:

> >> +static long fastrpc_device_ioctl(struct file *file, unsigned int cmd,
> >> +                                unsigned long arg)
> >> +{
> >> +       struct fastrpc_user *fl = (struct fastrpc_user *)file->private_data;
> >> +       struct fastrpc_channel_ctx *cctx = fl->cctx;
> >> +       char __user *argp = (char __user *)arg;
> >> +       int err;
> >> +
> >> +       if (!fl->sctx) {
> >> +               fl->sctx = fastrpc_session_alloc(cctx, 0);
> >> +               if (!fl->sctx)
> >> +                       return -ENOENT;
> >> +       }
> >
> > Shouldn't that session be allocated during open()?
> >
> Yes, and no, we do not need context in all the cases. In cases like we
> just want to allocate dmabuf.

Can you give an example what that would be good for?

>
> >> +static void fastrpc_notify_users(struct fastrpc_user *user)
> >> +{
> >> +       struct fastrpc_invoke_ctx *ctx, *n;
> >> +
> >> +       spin_lock(&user->lock);
> >> +       list_for_each_entry_safe(ctx, n, &user->pending, node)
> >> +               complete(&ctx->work);
> >> +       spin_unlock(&user->lock);
> >> +}
> >
> > Can you explain here what it means to have multiple 'users'
> > a 'fastrpc_user' structure? Why are they all done at the same time?
> >
> This is the case where users need to be notified if the dsp goes down
> due to crash or shut down!

What is a 'user' then? My point is that it seems to refer to two
different things here. I assume 'fastrpc_user' is whoever
has opened the file descriptor.

> >
> >> +struct fastrpc_ioctl_invoke {
> >> +       uint32_t handle;        /* remote handle */
> >> +       uint32_t sc;            /* scalars describing the data */
> >> +       remote_arg_t *pra;      /* remote arguments list */
> >> +       int *fds;               /* fd list */
> >> +       unsigned int *attrs;    /* attribute list */
> >> +       unsigned int *crc;
> >> +};
> >
> > This seems too complex for an ioctl argument, with
> > multiple levels of pointer indirections. I'd normally
> > try to make each ioctl argument either a scalar, or a
> > structure with only fixed-length members.
> >
> I totally agree with you and many thanks for your expert inputs,
> May be something like below with fixed length members would work?
>
> struct fastrpc_remote_arg {
>         __u64 ptr;      /* buffer ptr */
>         __u64 len;      /* length */
>         __u32 fd;       /* dmabuf fd */
>         __u32 reserved1
>         __u64 reserved2
> };
>
> struct fastrpc_remote_fd {
>         __u64 fd;
>         __u64 reserved1
>         __u64 reserved2
>         __u64 reserved3
> };
>
> struct fastrpc_remote_attr {
>         __u64 attr;
>         __u64 reserved1
>         __u64 reserved2
>         __u64 reserved3
> };
>
> struct fastrpc_remote_crc {
>         __u64 crc;
>         __u64 reserved1
>         __u64 reserved2
>         __u64 reserved3
> };

I don't see a need to add extra served fields for structures
that are already naturally aligned here, e.g. in
fastrpc_remote_arg we need the 'reserved1' but not
the 'reserved2'.

>
> struct fastrpc_ioctl_invoke {
>         __u32 handle;
>         __u32 sc;
>         /* The minimum size is scalar_length * 32 */
>         struct fastrpc_remote_args *rargs;
>         struct fastrpc_remote_fd *fds;
>         struct fastrpc_remote_attr *attrs;
>         struct fastrpc_remote_crc *crc;
> };

Do these really have to be indirect then? Are they all
lists of variable length? How do you know how long?

      Arnd
