Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C30C282D8
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 00:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1E2C2148D
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 00:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RX/ClDZm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfBBAgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 19:36:33 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:35329 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbfBBAgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 19:36:32 -0500
Received: by mail-wm1-f53.google.com with SMTP id t200so7958972wmt.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 16:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tRLfin02duNGpkrsPDh1mXYGi2cY9dbmUwVyV7opiiY=;
        b=RX/ClDZm4hQyab+HTOrGTk3xXdv/ZooVqd6I6tM6QGt/88a4iBrdraFDRDZ91/ZqqW
         1p2w0/fOstSIbfLBEes2CwxpEwQRwEfRC+DwOogqP029vRl5ENFPltNbrEnrQFpA5x/3
         QTTv+mxAbsWuD+l9SGS40W1LE0TA9hG0OGos4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tRLfin02duNGpkrsPDh1mXYGi2cY9dbmUwVyV7opiiY=;
        b=Q//6404VOmIdfVZCmfjcRYFVKWnii/lfYl9U1M2DrinG78iaSfZEMpO7kMSB8Fyk8A
         OQ3G6E3boikKKjtO02a+JQGYQ7osgetVTLl3NZzqeNkV7I3xakPBhADNLgqMj4vfMggy
         jRJv8PoucfoYf0GGwNV8gBDfjTXiSnCB9XhQWHNVVRHuHlKF7HJkAUgiI9IcNXxIWPyg
         A/MsbdK5FCQ8lXtz3F9b6doZT/nFehqMea1DeW5u3eWu5ilcY23lSblVUKd50Up7mQDv
         abmhq9TgmJH/oJHRsZQoSCywc6E+vDqOAEvyM4uVfn7gBTyCPQL6UdvCZeZfvv70Z/Ho
         QmUQ==
X-Gm-Message-State: AHQUAuZnASylualu1G9FrQcVdv5xN8zCKIXtWaV5mLaN8QM8zg+Q/6dI
        oJaNZJQ0Tm1g+eDi7PGKJ8No3PmXoJV3XXE1Ep8V7Q==
X-Google-Smtp-Source: AHgI3IZw9NOdP17pgGIArDeN4VfAeL57al9jTV9xae2j41sK87PMkUlH3ZXMn7U0Ram5TP+7yHXW4vrpmjNHww4V02s=
X-Received: by 2002:a1c:de57:: with SMTP id v84mr4275343wmg.55.1549067790375;
 Fri, 01 Feb 2019 16:36:30 -0800 (PST)
MIME-Version: 1.0
References: <CALAqxLXy1zSTSoDEfYN0VJBbf=Q0N6kH+S_1hTTgEb6dQi0XrQ@mail.gmail.com>
 <30102591E157244384E984126FC3CB4F639BF445@us01wembx1.internal.synopsys.com>
In-Reply-To: <30102591E157244384E984126FC3CB4F639BF445@us01wembx1.internal.synopsys.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 1 Feb 2019 16:36:18 -0800
Message-ID: <CALAqxLVfFCMw0L83jNSTU3csSoY_PPmrPRChyAkG0oX_HVgQDg@mail.gmail.com>
Subject: Re: Frequent dwc3 crashes on suspend or reboot since 5.0-rc1
To:     Thinh Nguyen <thinh.nguyen@synopsys.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Zeng Tao <prime.zeng@hisilicon.com>,
        Jack Pham <jackp@codeaurora.org>,
        Chen Yu <chenyu56@huawei.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 1, 2019 at 4:31 PM Thinh Nguyen <thinh.nguyen@synopsys.com> wro=
te:
>
> Hi John,
>
> John Stultz wrote:
> > Hey all,
> >   Since the 5.0 merge window opened, I've been tripping on frequent
> > dwc3 crashes on reboot and suspend, which I've added an example to the
> > bottom of this mail.
> >
> > I've dug in a little bit and sort of have a sense of whats going on.
> >
> > In ffs_epfile_io():
> > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git.kernel.org_p=
ub_scm_linux_kernel_git_torvalds_linux.git_tree_drivers_usb_gadget_function=
_f-5Ffs.c-23n1065&d=3DDwIBaQ&c=3DDPL6_X_6JkXFx7AXWqB0tg&r=3Du9FYoxKtyhjrGFc=
yixFYqTjw1ZX0VsG2d8FCmzkTY-w&m=3Da8TU-itM8GBG_EARYf2yM-kVfCzmaPkKDNAUFQHTe3=
Q&s=3DBQiVAFiViSlxVg5_LemED0x_47FLVUD43M7R6h6T8qk&e=3D
> >
> > The completion done is setup on the stack:
> >   DECLARE_COMPLETION_ONSTACK(done);
> >
> > Then later we setup a request and queue it:
> >   req->context  =3D &done;
> >   ...
> >   ret =3D usb_ep_queue(ep->ep, req, GFP_ATOMIC);
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
> >     interrupted =3D ep->status < 0;
> >   }
> >
> > The problem is, that we end up being interrupted, supposedly dequeue
> > the request, and exit.
> >
> > But then (or in parallel) the irq triggers and we try calling
> > complete() on the context pointer which points to now random stack
> > space, which results in the panic.
> >
> > It seems like something is wrong with usb_ep_dequeue not really
> > stopping the irq from happening?
> >
> > If I revert all the changes to dwc3 back to 4.20, I don't see the issue=
.
> >
> > I'll do some bisection to try to narrow things down, but I wanted to
> > see if this was a known issue or if anyone had immediate ideas as to
> > what might be wrong.
> >
>
> I'm not sure if this is related, but can you try to test using Felipe's
> testing/next branch? There is a fix to a race condition when the gadget
> driver tries to dequeue requests.
>
> See if you run into this issue again.

I'll check that out! Thanks so much for the pointer!
-john
