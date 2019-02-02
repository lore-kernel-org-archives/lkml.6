Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0B5C282D8
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 00:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53CBE2148D
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 00:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qp95Uu7y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfBBAly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 19:41:54 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33554 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfBBAlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 19:41:52 -0500
Received: by mail-wm1-f66.google.com with SMTP id r24so5686660wmh.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 16:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gdJIWHRLrhfAqwDqyuvJkmkSvUC3yaG9hpuD4a8bODo=;
        b=Qp95Uu7yC8nhCTIjDnUzBj5P18YrLf8+LeKLrJ4TVYYlpySfpI3jjXaPUAm1EBZ9ro
         5RCjRMQMFG65xad9Jm8zO8/5dX3e6/PTQ7F30YM0NUzNn34Slt3fyY9E0eVCe2Ybjmw8
         IjwZkqjcrqmSGHxqDf9hdBDMikuMdPDyrFDLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gdJIWHRLrhfAqwDqyuvJkmkSvUC3yaG9hpuD4a8bODo=;
        b=GxpRdxpn0V6Uc0nytZSu+xDRsWe0zdtlw6bmF3Nx/OJLyBerJoCho8XThMJpfHKFRh
         eiXBM+uFz1+mU0FOY3hPC7ZIy+J4oRNdBO1dX5HBTqDdx3qBa9sI1J4KpJcJRsWn2k/M
         Xx9LLaPLA7+/UbMGPcdT95+i9BX0h8IpyfbHm5ucwW0aMKm1mEhGkJfni7HYSUZ1P0Oo
         mxPlSgCzBTCxG8vwyvYNmKkLgkXvGPjED6gJ2nMn37e+FpvqIOcsxm8HPzSxsPnwcxRT
         T3CdWLs/omOoABsHFNL9ZgfcS/b1amzP5JYWTcNJzCUnsnMXlNDXiQvTgRictAFuZX2p
         un9g==
X-Gm-Message-State: AHQUAuYTMyRQDI6MIgG67FlmJdJy5vu5Jtg8b231Aek28lEq2tL+iSEM
        pU5b4m4pVrmNU2LRuNEr73ljhyLYNnKs4kvo9IA1Pg==
X-Google-Smtp-Source: AHgI3IaCtQPftoSxmBzyYNnIS0wXHXt1dI0kqlRRX/YLckC34C4DvBUswuJQWiGpK7eeLNkN7Wv4PzmIFqp87Rpaz5w=
X-Received: by 2002:a1c:de57:: with SMTP id v84mr4286203wmg.55.1549068109958;
 Fri, 01 Feb 2019 16:41:49 -0800 (PST)
MIME-Version: 1.0
References: <CALAqxLXy1zSTSoDEfYN0VJBbf=Q0N6kH+S_1hTTgEb6dQi0XrQ@mail.gmail.com>
In-Reply-To: <CALAqxLXy1zSTSoDEfYN0VJBbf=Q0N6kH+S_1hTTgEb6dQi0XrQ@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 1 Feb 2019 16:41:38 -0800
Message-ID: <CALAqxLVtQPgHgo+nNQCQ3JPm3_-3nAyyCOy6p2KbqWFyL-dqcQ@mail.gmail.com>
Subject: Re: Frequent dwc3 crashes on suspend or reboot since 5.0-rc1
To:     Felipe Balbi <balbi@kernel.org>,
        Zeng Tao <prime.zeng@hisilicon.com>,
        Jack Pham <jackp@codeaurora.org>,
        Thinh Nguyen <thinh.nguyen@synopsys.com>,
        Chen Yu <chenyu56@huawei.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 1, 2019 at 4:18 PM John Stultz <john.stultz@linaro.org> wrote:
>
> Hey all,
>   Since the 5.0 merge window opened, I've been tripping on frequent
> dwc3 crashes on reboot and suspend, which I've added an example to the
> bottom of this mail.
>
> I've dug in a little bit and sort of have a sense of whats going on.
>
> In ffs_epfile_io():
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/gadget/function/f_fs.c#n1065
>
> The completion done is setup on the stack:
>   DECLARE_COMPLETION_ONSTACK(done);
>
> Then later we setup a request and queue it:
>   req->context  = &done;
>   ...
>   ret = usb_ep_queue(ep->ep, req, GFP_ATOMIC);
>
> Then wait for it:
>   if (unlikely(wait_for_completion_interruptible(&done))) {
>     /*
>     * To avoid race condition with ffs_epfile_io_complete,
>     * dequeue the request first then check
>     * status. usb_ep_dequeue API should guarantee no race
>     * condition with req->complete callback.
>     */
>     usb_ep_dequeue(ep->ep, req);
>     interrupted = ep->status < 0;
>   }
>
> The problem is, that we end up being interrupted, supposedly dequeue
> the request, and exit.
>
> But then (or in parallel) the irq triggers and we try calling
> complete() on the context pointer which points to now random stack
> space, which results in the panic.
>
> It seems like something is wrong with usb_ep_dequeue not really
> stopping the irq from happening?
>
> If I revert all the changes to dwc3 back to 4.20, I don't see the issue.
>
> I'll do some bisection to try to narrow things down, but I wanted to
> see if this was a known issue or if anyone had immediate ideas as to
> what might be wrong.

Bisecting the changes down, it seems like its due to commit
fec9095bdef4e ("usb: dwc3: gadget: remove wait_end_transfer").

It doesn't happen all the time, so I'll need to run some more testing,
but so far I've not been able to trigger it backing out the patches to
that point.

thanks
-john
