Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF27C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B38720834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UI6FuOG5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B38720834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbeLACLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:11:10 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53883 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbeLACLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 21:11:10 -0500
Received: by mail-wm1-f66.google.com with SMTP id y1so6089776wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 07:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5v3thboC36qMqiYQEzRoMJvB5PdXPEOtVD+0/oFSLec=;
        b=UI6FuOG5YyYA5mZHXku+fNWp66cGkgHBdcmuOJZsJg5fPpzxIjbDOkSJhMR+h9fpQ+
         wwbluF0zqeEYIOClg4PudZ9GM3ZMQxjncS1CvHr0w/Qov5CjwIEntRi/PSKHbkHp6qpo
         jUB8ZRN7lpgNvd8x0etf3A09gh2Nrl4srxw8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5v3thboC36qMqiYQEzRoMJvB5PdXPEOtVD+0/oFSLec=;
        b=t2w0YrxptTGzp2zvvnFgzxU6EeDYs/TEH0zIH7P81QlHqb74VfTtxkc8VqC1A3GDkJ
         fjueWD+OCDVVR80OZEuBqHVk0GBlj6bX87OyGXctNj9AsKdWWtSkAc4cti/NdAx9rD6e
         JPov+BlyPzJ5i2vDGTZ7xr1470YDvi8sYRS/Ycea7Y8Llt6VemZLQXWVgjd8+2p5mKwY
         /n8nrw0t6waNSqs0m5TB9AlFOswHngS46GzvYkAf0eRa+XrM7U+kB6q7pd03S2wiKHHa
         gaW/+D+tslcbluXM1yDXfsvvFJkrGBHqMb0ZderegAfvT5sPeVYs91B/XlU4XMnh4P41
         V0DQ==
X-Gm-Message-State: AA+aEWbkIOq8kJ7RYQLb3IYO2F/njSuUX/qm6rQOqDcEKU1Lq9l4lPuF
        WSxivsJ1wDcp3Ps8wzsBm0uSjg==
X-Google-Smtp-Source: AFSGD/XyVwt0K1bXp86witGrFKeOy37WEuxz2Svl3AJLi31cI7NE+Db0qqY6Nd50RpusNGeKgHtbQQ==
X-Received: by 2002:a1c:8548:: with SMTP id h69mr5556804wmd.11.1543590092599;
        Fri, 30 Nov 2018 07:01:32 -0800 (PST)
Received: from [192.168.86.29] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id n6sm4678868wmk.9.2018.11.30.07.01.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 07:01:32 -0800 (PST)
Subject: Re: [RFC PATCH 3/6] char: fastrpc: Add support for context Invoke
 method
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, bkumar@qti.qualcomm.com,
        thierry.escande@linaro.org
References: <20181130104657.14875-1-srinivas.kandagatla@linaro.org>
 <20181130104657.14875-4-srinivas.kandagatla@linaro.org>
 <CAK8P3a1mFWJyXCn74_Yd_y3Df0JN=qM4nw4-2t_LjRO7yXmXBw@mail.gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <3c177508-cf6f-1f8d-a324-5bec40fd9a9c@linaro.org>
Date:   Fri, 30 Nov 2018 15:01:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1mFWJyXCn74_Yd_y3Df0JN=qM4nw4-2t_LjRO7yXmXBw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Arnd for the review comments!

On 30/11/18 13:41, Arnd Bergmann wrote:
> On Fri, Nov 30, 2018 at 11:48 AM Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org> wrote:
>>
>> This patch adds support to compute context invoke method
>> on the remote processor (DSP).
>> This involves setting up the functions input and output arguments,
>> input and output handles and mapping the dmabuf fd for the
>> argument/handle buffers.
>>
>> Most of the work is derived from various downstream Qualcomm kernels.
>> Credits to various Qualcomm authors who have contributed to this code.
>> Specially Tharun Kumar Merugu <mtharu@codeaurora.org>
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
>> +
>> +       INIT_LIST_HEAD(&ctx->node);
>> +       ctx->fl = user;
>> +       ctx->maps = (struct fastrpc_map **)(&ctx[1]);
>> +       ctx->lpra = (remote_arg_t *)(&ctx->maps[bufs]);
>> +       ctx->fds = (int *)(&ctx->lpra[bufs]);
>> +       ctx->attrs = (unsigned int *)(&ctx->fds[bufs]);
>> +
>> +       if (!kernel) {
>> +               if (copy_from_user(ctx->lpra,
>> +                                    (void const __user *)inv->pra,
>> +                                    bufs * sizeof(*ctx->lpra))) {
>> +                       err = -EFAULT;
>> +                       goto err;
>> +               }
>> +
>> +               if (inv->fds) {
>> +                       if (copy_from_user(ctx->fds,
>> +                                            (void const __user *)inv->fds,
>> +                                            bufs * sizeof(*ctx->fds))) {
>> +                               err = -EFAULT;
>> +                               goto err;
>> +                       }
>> +               }
>> +               if (inv->attrs) {
>> +                       if (copy_from_user(
>> +                                       ctx->attrs,
>> +                                       (void const __user *)inv->attrs,
>> +                                       bufs * sizeof(*ctx->attrs))) {
>> +                               err = -EFAULT;
>> +                               goto err;
>> +                       }
>> +               }
>> +       } else {
>> +               memcpy(ctx->lpra, inv->pra, bufs * sizeof(*ctx->lpra));
>> +               if (inv->fds)
>> +                       memcpy(ctx->fds, inv->fds,
>> +                              bufs * sizeof(*ctx->fds));
>> +               if (inv->attrs)
>> +                       memcpy(ctx->attrs, inv->attrs,
>> +                              bufs * sizeof(*ctx->attrs));
>> +       }
> 
> I'd split this function into multiple pieces: the internal one that
> just takes kernel pointers, and a wrapper for the ioctl
> that copies the user space data into the kernel before calling
> the second one.

Sure, will be done in next version!
> 
>> +static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
>> +                           uint32_t kernel, remote_arg_t *upra)
>> +{
>> +       remote_arg64_t *rpra = ctx->rpra;
>> +       int i, inbufs, outbufs, handles;
>> +       struct fastrpc_invoke_buf *list;
>> +       struct fastrpc_phy_page *pages;
>> +       struct fastrpc_map *mmap;
>> +       uint32_t sc = ctx->sc;
>> +       uint64_t *fdlist;
>> +       uint32_t *crclist;
>> +       int err = 0;
>> +
>> +       inbufs = REMOTE_SCALARS_INBUFS(sc);
>> +       outbufs = REMOTE_SCALARS_OUTBUFS(sc);
>> +       handles = REMOTE_SCALARS_INHANDLES(sc) + REMOTE_SCALARS_OUTHANDLES(sc);
>> +       list = fastrpc_invoke_buf_start(ctx->rpra, sc);
>> +       pages = fastrpc_phy_page_start(sc, list);
>> +       fdlist = (uint64_t *)(pages + inbufs + outbufs + handles);
>> +       crclist = (uint32_t *)(fdlist + FASTRPC_MAX_FDLIST);
>> +
>> +       for (i = inbufs; i < inbufs + outbufs; ++i) {
>> +               if (!ctx->maps[i]) {
>> +                       if (!kernel)
>> +                               err =
>> +                               copy_to_user((void __user *)ctx->lpra[i].buf.pv,
>> +                                      (void *)rpra[i].buf.pv, rpra[i].buf.len);
>> +                       else
>> +                               memcpy(ctx->lpra[i].buf.pv,
>> +                                      (void *)rpra[i].buf.pv, rpra[i].buf.len);
>> +
>> +                       if (err)
>> +                               goto bail;
>> +               } else {
>> +                       fastrpc_map_put(ctx->maps[i]);
>> +                       ctx->maps[i] = NULL;
>> +               }
>> +       }
> 
> Same here.
> 
>> +static int fastrpc_internal_invoke(struct fastrpc_user *fl,
>> +                                  uint32_t kernel,
>> +                                  struct fastrpc_ioctl_invoke *inv)
>> +{
>> +       struct fastrpc_invoke_ctx *ctx = NULL;
>> +       int err = 0;
>> +
>> +       if (!fl->sctx)
>> +               return -EINVAL;
>> +
>> +       ctx = fastrpc_context_alloc(fl, kernel, inv);
>> +       if (IS_ERR(ctx))
>> +               return PTR_ERR(ctx);
>> +
>> +       if (REMOTE_SCALARS_LENGTH(ctx->sc)) {
>> +               err = fastrpc_get_args(kernel, ctx);
>> +               if (err)
>> +                       goto bail;
>> +       }
>> +
>> +       err = fastrpc_invoke_send(fl->sctx, ctx, kernel, inv->handle);
>> +       if (err)
>> +               goto bail;
>> +
>> +       err = wait_for_completion_interruptible(&ctx->work);
>> +       if (err)
>> +               goto bail;
> 
> Can you add comments here to explain the control flow?
> What exactly are we waiting for here? Does the completion
> indicate that the remote side is done executing the code
> and ready to do something else?

Sure I will add some detailed comment here, completion here means that 
the remote side has finished with the execution of that particular context.

> 
>> +static long fastrpc_device_ioctl(struct file *file, unsigned int cmd,
>> +                                unsigned long arg)
>> +{
>> +       struct fastrpc_user *fl = (struct fastrpc_user *)file->private_data;
>> +       struct fastrpc_channel_ctx *cctx = fl->cctx;
>> +       char __user *argp = (char __user *)arg;
>> +       int err;
>> +
>> +       if (!fl->sctx) {
>> +               fl->sctx = fastrpc_session_alloc(cctx, 0);
>> +               if (!fl->sctx)
>> +                       return -ENOENT;
>> +       }
> 
> Shouldn't that session be allocated during open()?
> 
Yes, and no, we do not need context in all the cases. In cases like we 
just want to allocate dmabuf.

>> +static void fastrpc_notify_users(struct fastrpc_user *user)
>> +{
>> +       struct fastrpc_invoke_ctx *ctx, *n;
>> +
>> +       spin_lock(&user->lock);
>> +       list_for_each_entry_safe(ctx, n, &user->pending, node)
>> +               complete(&ctx->work);
>> +       spin_unlock(&user->lock);
>> +}
> 
> Can you explain here what it means to have multiple 'users'
> a 'fastrpc_user' structure? Why are they all done at the same time?
> 
This is the case where users need to be notified if the dsp goes down 
due to crash or shut down!

>> +struct remote_dma_handle64 {
>> +       int fd;
>> +       uint32_t offset;
>> +       uint32_t len;
>> +};
> 
> Maybe always make the offset/len fields and others 64 bit?
> 
yes, I will do that.
>> +union remote_arg64 {
>> +       struct remote_buf64     buf;
>> +       struct remote_dma_handle64 dma;
>> +       uint32_t h;
>> +};
>> +
>> +#define remote_arg_t    union remote_arg
>> +
>> +struct remote_buf {
>> +       void *pv;               /* buffer pointer */
>> +       size_t len;             /* length of buffer */
>> +};
>> +
>> +struct remote_dma_handle {
>> +       int fd;
>> +       uint32_t offset;
>> +};
>> +
>> +union remote_arg {
>> +       struct remote_buf buf;  /* buffer info */
>> +       struct remote_dma_handle dma;
>> +       uint32_t h;             /* remote handle */
>> +};
> 
> Try to avoid the padding at the end of the structure,
> if you can't, then add a __reserved member.
> 
> I'd also recommend avoiding nested structures and
> unions. Add more commands if necessary.
I will revisit all the data structures and make sure we do not leave any 
holes in the structure!
> 
>> +struct fastrpc_ioctl_invoke {
>> +       uint32_t handle;        /* remote handle */
>> +       uint32_t sc;            /* scalars describing the data */
>> +       remote_arg_t *pra;      /* remote arguments list */
>> +       int *fds;               /* fd list */
>> +       unsigned int *attrs;    /* attribute list */
>> +       unsigned int *crc;
>> +};
> 
> This seems too complex for an ioctl argument, with
> multiple levels of pointer indirections. I'd normally
> try to make each ioctl argument either a scalar, or a
> structure with only fixed-length members.
> 
I totally agree with you and many thanks for your expert inputs,
May be something like below with fixed length members would work?

struct fastrpc_remote_arg {
	__u64 ptr;	/* buffer ptr */
	__u64 len;	/* length */
	__u32 fd;	/* dmabuf fd */
	__u32 reserved1
	__u64 reserved2
};

struct fastrpc_remote_fd {
	__u64 fd;
	__u64 reserved1
	__u64 reserved2
	__u64 reserved3
};

struct fastrpc_remote_attr {
	__u64 attr;
	__u64 reserved1
	__u64 reserved2
	__u64 reserved3
};

struct fastrpc_remote_crc {
	__u64 crc;
	__u64 reserved1
	__u64 reserved2
	__u64 reserved3
};

struct fastrpc_ioctl_invoke {
	__u32 handle;
	__u32 sc;
	/* The minimum size is scalar_length * 32 */
	struct fastrpc_remote_args *rargs;
	struct fastrpc_remote_fd *fds;
	struct fastrpc_remote_attr *attrs;
	struct fastrpc_remote_crc *crc;
};

> The way we did this in spufs was to set up a context
> first with all the information it needed, and make the
> actual context switch from host CPU to remote a very
> simple operation that took as few arguments as possible,
> in case of spu_run() only the instruction pointer and
> the location of the return status.

thanks,
srini
> 
>        Arnd
> 
