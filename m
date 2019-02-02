Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A19AC282D8
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 00:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 175F521872
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 00:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="i8KR51FX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfBBAzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 19:55:45 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35082 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfBBAzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 19:55:45 -0500
Received: by mail-wr1-f65.google.com with SMTP id r17so2986278wrp.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 16:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HWE122IdbGiQnsisAEIG7hPqm/jRt5nr7efDnXZjqbc=;
        b=i8KR51FX2F1eHMyAfXh+c/gXcXjlPkrOamFdmlXr/6EigLhf2hp9xr1igdS3qa1w6c
         EUXMVaUY3LjVM1IErZlosmHmkxfUy72GJYnN5ysrMIqOLnKB6eIC2JRhz1Ga+uhZqAle
         iPZwLLS8s/CL9gTHXOXhCjzTFLLuU2ilPlihI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HWE122IdbGiQnsisAEIG7hPqm/jRt5nr7efDnXZjqbc=;
        b=sNUgRZYxfszCGsw0PK5284DgHbxtcu+k8z0CaHGdXBT4ES3pm4awcBMsVntxg64emo
         LXx502EWxqtTDer6MjfmPcWmDS4tH5raOMjVspMOfHfg0px4TY8asoy6tCxwIIwJL8Pt
         VgAjwvHySQy6P9mZ8o6E8SVrOovhjq/NJM6p2PYdmfvI01qVtwwo1SgR6Gm4CJiASSf6
         vEywkBhYkOtsbIPZ5i2zodDnhJHejtzAYYzAwAIZffhm4+/ll7WBlJM4FFJIr5pYIIVP
         ZpYrHZyZIIgichTz9GM2XlMCl0ryD4VZOZlmKVwuo2gaKSJ2v6lt98uBa2ffbdrrhZpb
         0fjA==
X-Gm-Message-State: AJcUuke88HodyOKlcK63SZIJbWZpoQFNAdEs6PdYmz7XQH+ysN9DuAMr
        WmN2izBhALA0dJG3FUBqA93ezSkXAqA2s/dAs05VFVrl3plV1Q==
X-Google-Smtp-Source: ALg8bN7cdhCW4Lg/WJjUpui/IlhTshMgTaNsqWUEy9HAQMTwTIhLVgovXUCDIO4ZnZaTmBkoIbzSY0levDvFWfq6DjI=
X-Received: by 2002:a5d:4c8a:: with SMTP id z10mr39425330wrs.75.1549068942877;
 Fri, 01 Feb 2019 16:55:42 -0800 (PST)
MIME-Version: 1.0
References: <CALAqxLXy1zSTSoDEfYN0VJBbf=Q0N6kH+S_1hTTgEb6dQi0XrQ@mail.gmail.com>
 <CALAqxLVtQPgHgo+nNQCQ3JPm3_-3nAyyCOy6p2KbqWFyL-dqcQ@mail.gmail.com> <30102591E157244384E984126FC3CB4F639BF47B@us01wembx1.internal.synopsys.com>
In-Reply-To: <30102591E157244384E984126FC3CB4F639BF47B@us01wembx1.internal.synopsys.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 1 Feb 2019 16:55:31 -0800
Message-ID: <CALAqxLWHO_UrYYD65DTf3SBj_nyPA9r0TG0xFCci0zRXLszVwQ@mail.gmail.com>
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 1, 2019 at 4:46 PM Thinh Nguyen <thinh.nguyen@synopsys.com> wrote:
> John Stultz wrote:
> > On Fri, Feb 1, 2019 at 4:18 PM John Stultz <john.stultz@linaro.org> wrote:
> > Bisecting the changes down, it seems like its due to commit
> > fec9095bdef4e ("usb: dwc3: gadget: remove wait_end_transfer").
> >
> > It doesn't happen all the time, so I'll need to run some more testing,
> > but so far I've not been able to trigger it backing out the patches to
> > that point.
>
> Yeah, it sounds like the same issue. You can review the discussion here:
> https://www.spinics.net/lists/linux-usb/msg176110.html

Unfortunately, merging in
https://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git
testing/next seems to trigger a different issue:

[   38.585141] OOM killer enabled.
[   38.585143] Restarting tasks ...
[   38.585874] ------------[ cut here ]------------
[   38.585882] ep1out: request 0000000000000000 already in flight
[   38.585944] WARNING: CPU: 7 PID: 2545 at
drivers/usb/dwc3/gadget.c:1430 dwc3_gadget_ep_queue+0x1d4/0x200
[   38.585946] Modules linked in:
[   38.585960] CPU: 7 PID: 2545 Comm: adbd Tainted: G S
5.0.0-rc4-00110-gad0e691 #509
[   38.585963] Hardware name: HiKey960 (DT)
[   38.585968] pstate: 80400085 (Nzcv daIf +PAN -UAO)
[   38.585972] pc : dwc3_gadget_ep_queue+0x1d4/0x200
[   38.585976] lr : dwc3_gadget_ep_queue+0x1d4/0x200
[   38.585978] sp : ffffff80149fbb40
[   38.585981] x29: ffffff80149fbb40 x28: ffffffc20c72a200
[   38.585985] x27: ffffffc211376d00 x26: 0000000000000000
[   38.585990] x25: ffffff80149fbc30 x24: 0000000000000018
[   38.585994] x23: 0000000000000080 x22: ffffffc218c0a1b0
[   38.585997] x21: ffffffffffffff94 x20: ffffffc21930f600
[   38.586001] x19: ffffffc211376d00 x18: ffffff801161da88
[   38.586005] x17: 0000000000000000 x16: 0000000000000000
[   38.586008] x15: ffffff80117f8468 x14: 0000000000080000
[   38.586012] x13: ffffff80117f8088 x12: ffffff80116436b8
[   38.586016] x11: ffffff8011643000 x10: ffffff8011775000
[   38.586020] x9 : 0000000000000000 x8 : ffffff801178b33c
[   38.586023] x7 : 0000000000000000 x6 : 00000000007dd811
[   38.586027] x5 : 0000000000000000 x4 : 0000000000000000
[   38.586030] x3 : 0000000000000003 x2 : 0000000000000003
[   38.586034] x1 : e8959d459c94b400 x0 : 0000000000000000
[   38.586039] Call trace:
[   38.586043]  dwc3_gadget_ep_queue+0x1d4/0x200
[   38.586053]  usb_ep_queue+0x5c/0x120
[   38.586059]  ffs_epfile_io.isra.12+0x3dc/0x6c0
[   38.586063]  ffs_epfile_read_iter+0xbc/0x190
[   38.586073]  __vfs_read+0x10c/0x168
[   38.586077]  vfs_read+0x8c/0x148
[   38.586081]  ksys_read+0x5c/0xc8
[   38.586085]  __arm64_sys_read+0x14/0x20
[   38.586094]  el0_svc_common+0xb4/0x118
[   38.586099]  el0_svc_handler+0x2c/0x80
[   38.586105]  el0_svc+0x8/0xc
[   38.586107] ---[ end trace 65a9814dc2b21238 ]---
[   38.587826] done.
[   38.587922] PM: suspend exit
[   38.589426] ------------[ cut here ]------------
[   38.589433] ep1out: request 0000000000000000 already in flight
[   38.589489] WARNING: CPU: 7 PID: 4087 at
drivers/usb/dwc3/gadget.c:1430 dwc3_gadget_ep_queue+0x1d4/0x200
[   38.589493] Modules linked in:
[   38.589506] CPU: 7 PID: 4087 Comm: adbd Tainted: G S      W
5.0.0-rc4-00110-gad0e691 #509
[   38.589508] Hardware name: HiKey960 (DT)
[   38.589514] pstate: 80400085 (Nzcv daIf +PAN -UAO)
[   38.589518] pc : dwc3_gadget_ep_queue+0x1d4/0x200
[   38.589521] lr : dwc3_gadget_ep_queue+0x1d4/0x200
[   38.589523] sp : ffffff80149fbb40
[   38.589526] x29: ffffff80149fbb40 x28: ffffffc20c72a200
[   38.589531] x27: ffffffc211376d00 x26: 0000000000000000
[   38.589535] x25: ffffff80149fbc30 x24: 0000000000000018
[   38.589539] x23: 0000000000000080 x22: ffffffc218c0a1b0
[   38.589543] x21: ffffffffffffff94 x20: ffffffc21930f600
[   38.589546] x19: ffffffc211376d00 x18: ffffff801161da88
[   38.589550] x17: 0000000000000000 x16: 0000000000000000
[   38.589554] x15: ffffff80117f8468 x14: 0000000000080000
[   38.589557] x13: ffffff80117f8088 x12: ffffff80116436b8
[   38.589561] x11: ffffff8011643000 x10: ffffff8011775000
[   38.589565] x9 : 0000000000000000 x8 : ffffff801178bb88
[   38.589568] x7 : 0000000000000000 x6 : 00000000007dd811
[   38.589572] x5 : 0000000000000000 x4 : 0000000000000000
[   38.589576] x3 : 0000000000000003 x2 : 0000000000000003
[   38.589579] x1 : e8959d459c94b400 x0 : 0000000000000000
[   38.589584] Call trace:
[   38.589588]  dwc3_gadget_ep_queue+0x1d4/0x200
[   38.589597]  usb_ep_queue+0x5c/0x120
[   38.589603]  ffs_epfile_io.isra.12+0x3dc/0x6c0
[   38.589606]  ffs_epfile_read_iter+0xbc/0x190
[   38.589617]  __vfs_read+0x10c/0x168
[   38.589621]  vfs_read+0x8c/0x148
[   38.589625]  ksys_read+0x5c/0xc8
[   38.589630]  __arm64_sys_read+0x14/0x20
[   38.589638]  el0_svc_common+0xb4/0x118
[   38.589642]  el0_svc_handler+0x2c/0x80
[   38.589648]  el0_svc+0x8/0xc
[   38.589651] ---[ end trace 65a9814dc2b21239 ]---

Let me know if you have other ideas to try!

thanks
-john
