Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E96C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21987214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:20:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21987214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbeLADaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 22:30:03 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33438 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbeLADaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 22:30:03 -0500
Received: by mail-qk1-f196.google.com with SMTP id o89so3489657qko.0;
        Fri, 30 Nov 2018 08:20:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=92lJKmUQne39o4hvgBZDk6qeIkNWSwxaGv7AcYJLor0=;
        b=HZwN2DtgXIrnnETsJne1kSrBI0QgPGZdOylLChx7BHMm0mNdbWeQQMpS9bYIzLRTFM
         j9KZwG/5obqYZ+Jusb2hiHjpqEDcwtJUsqHEPpQ0d0cOfBIHnhT5kFxUPncFITULHbpD
         fW2q8ukagkHTdSjuIJ1PYW8LUFNjI6e89+PhXui6ZjHJga4sw/Ze+fgSfjsUQXCCRoHK
         Rf/iymRAlSH4PvcRN4KcEGQ62WdAbQcaTFp/hJHtH2GvPZSXLnnn2MIfcwbel9XklyDT
         hzciqGY+2+xamBx6L0l/WEbEXKUwNoq/AqGLNO+5gcRsJq9QSks9q0ludLbyjVfJycz2
         5x/Q==
X-Gm-Message-State: AA+aEWYax3g+ZnSZY9t6J1IK2gYk3oAt0RNl6Pk4s7N0MWf6WiN9xr/M
        xzGqytLOw00voc4K10dBIckIPdUZalJCPAWL8n8=
X-Google-Smtp-Source: AFSGD/WnwBwGM3aAgt4vUdVJP4HNg+OjjrXGiUXynIGDwJo/rfYgJGS2pTaod9lMEE/SMMbF7439IVN2WW9YRzdmV8I=
X-Received: by 2002:a37:a3c6:: with SMTP id m189mr5843105qke.173.1543594811954;
 Fri, 30 Nov 2018 08:20:11 -0800 (PST)
MIME-Version: 1.0
References: <20181130104657.14875-1-srinivas.kandagatla@linaro.org>
 <20181130104657.14875-4-srinivas.kandagatla@linaro.org> <CAK8P3a1mFWJyXCn74_Yd_y3Df0JN=qM4nw4-2t_LjRO7yXmXBw@mail.gmail.com>
 <3c177508-cf6f-1f8d-a324-5bec40fd9a9c@linaro.org> <CAK8P3a0d=VRP+9vZm+eJeJM933PWYL4sruMAYBYzWjg5B_kL2g@mail.gmail.com>
 <633cb111-f5d7-3648-54af-a476f3cbb279@linaro.org>
In-Reply-To: <633cb111-f5d7-3648-54af-a476f3cbb279@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 30 Nov 2018 17:19:53 +0100
Message-ID: <CAK8P3a1JSyxjuH2Xez-K3SFV20f-FJnzZHdNR1o41VrNNZkUPQ@mail.gmail.com>
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

On Fri, Nov 30, 2018 at 5:03 PM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
> On 30/11/18 15:08, Arnd Bergmann wrote:
> > On Fri, Nov 30, 2018 at 4:01 PM Srinivas Kandagatla
> > <srinivas.kandagatla@linaro.org> wrote:
> >> Thanks Arnd for the review comments!
> >> On 30/11/18 13:41, Arnd Bergmann wrote:
> >>> On Fri, Nov 30, 2018 at 11:48 AM Srinivas Kandagatla
> >>> <srinivas.kandagatla@linaro.org> wrote:
> >
> >>>> +static long fastrpc_device_ioctl(struct file *file, unsigned int cmd,
> >>>> +                                unsigned long arg)
> >>>> +{
> >>>> +       struct fastrpc_user *fl = (struct fastrpc_user *)file->private_data;
> >>>> +       struct fastrpc_channel_ctx *cctx = fl->cctx;
> >>>> +       char __user *argp = (char __user *)arg;
> >>>> +       int err;
> >>>> +
> >>>> +       if (!fl->sctx) {
> >>>> +               fl->sctx = fastrpc_session_alloc(cctx, 0);
> >>>> +               if (!fl->sctx)
> >>>> +                       return -ENOENT;
> >>>> +       }
> >>>
> >>> Shouldn't that session be allocated during open()?
> >>>
> >> Yes, and no, we do not need context in all the cases. In cases like we
> >> just want to allocate dmabuf.
> >
> > Can you give an example what that would be good for?
> >
>
> Currently the instance which does not need session is used as simple
> memory allocator (rpcmem), TBH, this is the side effect of trying to fit
> in with downstream application infrastructure which uses ion for andriod
> usecases.

That does not sound like enough of a reason then, user space is
easy to change here to just allocate the memory from the device itself.
The only reason that I can see for needing a dmabuf would be if
you have to share a buffer between two instances, and then you
can use either of them.

> >>>> +static void fastrpc_notify_users(struct fastrpc_user *user)
> >>>> +{
> >>>> +       struct fastrpc_invoke_ctx *ctx, *n;will go
> >>>> +
> >>>> +       spin_lock(&user->lock);
> >>>> +       list_for_each_entry_safe(ctx, n, &user->pending, node)
> >>>> +               complete(&ctx->work);
> >>>> +       spin_unlock(&user->lock);
> >>>> +}
> >>>
> >>> Can you explain here what it means to have multiple 'users'
> >>> a 'fastrpc_user' structure? Why are they all done at the same time?
>
> user is allocated on every open(). Having multiple users means that
> there are more than one compute sessions running on a given dsp.
>
> They reason why all the users are notified here is because the dsp is
> going down, so all the compute sessions associated with it will not see
> any response from dsp, so any pending/waiting compute contexts are
> explicitly notified.

I don't get it yet. What are 'compute sessions'? Do you have
multiple threads running on a single instance at the same time?
I would have expected to only ever see one thread in the
'wait_for_completion()' above, and others possibly waiting
for a chance to get to but not already running.

> >> struct fastrpc_remote_crc {
> >>          __u64 crc;
> >>          __u64 reserved1
> >>          __u64 reserved2
> >>          __u64 reserved3
> >> };
> >
> > I don't see a need to add extra served fields for structures
> > that are already naturally aligned here, e.g. in
> > fastrpc_remote_arg we need the 'reserved1' but not
> > the 'reserved2'.
> Yes, I see, I overdone it!
> Other idea, is, may be I can try to combine these into single structure
> something like:
>
> struct fastrpc_invoke_arg {
>         __u64 ptr;
>         __u64 len;
>         __u32 fd;
>         __u32 reserved1
>         __u64 attr;
>         __u64 crc;
> };
>
> struct fastrpc_ioctl_invoke {
>         __u32 handle;
>         __u32 sc;
>         /* The minimum size is scalar_length * 32*/
>         struct fastrpc_invoke_args *args;
> };

That is still two structure, not one ;-)

> >> struct fastrpc_ioctl_invoke {
> >>          __u32 handle;
> >>          __u32 sc;
> >>          /* The minimum size is scalar_length * 32 */
> >>          struct fastrpc_remote_args *rargs;
> >>          struct fastrpc_remote_fd *fds;
> >>          struct fastrpc_remote_attr *attrs;
> >>          struct fastrpc_remote_crc *crc;
> >> };
> >
> > Do these really have to be indirect then? Are they all
> > lists of variable length? How do you know how long?
> Yes, they are variable length and will be scalar length long.
> Scalar length is derived from sc variable in this structure.

Do you mean we have a variable number 'sc', but each array
always has the same length as the other ones? In that
case: yes, combining them seems sensible.

The other question this raises is: what is 'handle'?
Why is the file descriptor not enough to identify the
instance we want to talk to?

      Arnd
