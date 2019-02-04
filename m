Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A969C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5330120820
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="W4S3u3SL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbfBDX56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 18:57:58 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42707 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfBDX56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 18:57:58 -0500
Received: by mail-wr1-f66.google.com with SMTP id q18so1775019wrx.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 15:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M5LxtiaLrwNYmxAzewqdE7BKm4uCmKthl2fCcxdImwg=;
        b=W4S3u3SLWQ/g97C8A1p9QU+w6eY0VHIiaZtlvriTLsk+8mMRR4HSP8kKq4C9L+iB1L
         d+L/MiYmyWShEot0EZUi+uzr5vO9upFglilxcU5NBlV4QySwLPoUiePL7lc0Cf1kurro
         bOw/6Rm7CppsYoF4YC8MenKtFwJFwkZmjxJ1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M5LxtiaLrwNYmxAzewqdE7BKm4uCmKthl2fCcxdImwg=;
        b=iMt4Vc6Mvzev5Htb8BvAKZw15lGzDh0Mp93gX84vKarL/h1Q6RgMivzh45ykqMsw9a
         J8hdmmCtKQBxLd+9fh/wa2vzjCLN4VlHn1UzDlzbYuE+mT0/GGpx3XSBXvDw7dgyv1Vv
         f8hZRDoQ8CYrbWOFJdkdatQwAf1FCXUZ8xitYmcCEMEDvrROCPtWF4pzzz3VcSriDMVw
         ufqB7ZJ7G/Xq9LIVunY0O/vjfR/FsBeTH7dtU91QsdIh8rtwCUBNXW+tcw7T40B1eAsp
         PcZPUk6BanczbMx+B+MfC8fPa0nuUJpyqhIc6QJBA1aBLpcnAt0i3Ld6zc5kvt7my2mS
         4aew==
X-Gm-Message-State: AHQUAuamvQd7BaksbZQsQYyl/Cv3M50oN88UHIMZJNdBsIcMhTic2Fz5
        oqrwHPJFna8sP1pUzAvicDc4tBa+WVwRiIy/LQVfZzsL
X-Google-Smtp-Source: AHgI3IYg1QKqnpxQE1npAk5O9zacRJ35Kk8ybTQhMrblbFmcT1HCa+gQnlF0QqlFl6j9ypFCeuYglFzsyO77gdj/Onc=
X-Received: by 2002:a5d:4c8a:: with SMTP id z10mr1292184wrs.75.1549324676529;
 Mon, 04 Feb 2019 15:57:56 -0800 (PST)
MIME-Version: 1.0
References: <CALAqxLXy1zSTSoDEfYN0VJBbf=Q0N6kH+S_1hTTgEb6dQi0XrQ@mail.gmail.com>
 <Pine.LNX.4.44L0.1902021155520.14150-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1902021155520.14150-100000@netrider.rowland.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 4 Feb 2019 15:57:45 -0800
Message-ID: <CALAqxLU1uLAAzPWK0MYLauAP9AfPY=9CFNYgFHxLxKxsCdhGrw@mail.gmail.com>
Subject: Re: Frequent dwc3 crashes on suspend or reboot since 5.0-rc1
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Zeng Tao <prime.zeng@hisilicon.com>,
        Jack Pham <jackp@codeaurora.org>,
        Thinh Nguyen <thinh.nguyen@synopsys.com>,
        Chen Yu <chenyu56@huawei.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 2, 2019 at 9:00 AM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Fri, 1 Feb 2019, John Stultz wrote:
>
> > Hey all,
> >   Since the 5.0 merge window opened, I've been tripping on frequent
> > dwc3 crashes on reboot and suspend, which I've added an example to the
> > bottom of this mail.
> >
> > I've dug in a little bit and sort of have a sense of whats going on.
> >
> > In ffs_epfile_io():
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/gadget/function/f_fs.c#n1065
> >
> > The completion done is setup on the stack:
> >   DECLARE_COMPLETION_ONSTACK(done);
> >
> > Then later we setup a request and queue it:
> >   req->context  = &done;
> >   ...
> >   ret = usb_ep_queue(ep->ep, req, GFP_ATOMIC);
> >
> > Then wait for it:
> >   if (unlikely(wait_for_completion_interruptible(&done))) {
> >     /*
> >     * To avoid race condition with ffs_epfile_io_complete,
> >     * dequeue the request first then check
> >     * status. usb_ep_dequeue API should guarantee no race
> >     * condition with req->complete callback.
> >     */
> >     usb_ep_dequeue(ep->ep, req);
>
> This code contains a bug: It assumes that usb_ep_dequeue() waits until
> the request has been completed.  You should insert
>
>         wait_for_completion(&done);
>
> right here.
>
> >     interrupted = ep->status < 0;
> >   }
>

Thanks! This does seem to resolve the issue I'm seeing.

Are you planning to send in such a patch, or would it help if I sent it out?

thanks
-john
