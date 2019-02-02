Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C38C7C282D8
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 00:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F25F21872
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 00:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RDtqFacO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfBBASb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 19:18:31 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36043 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbfBBASa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 19:18:30 -0500
Received: by mail-wm1-f66.google.com with SMTP id p6so7869220wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 16:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=61y5ENS1IprE4e/ZfJKMv0QresyoCgKAs8JLXZdOoGA=;
        b=RDtqFacO7aJplOnpka/6hbs7blnnI4509JRwsQ6y0m4O4+paVjV56d93xEmyqoOXwb
         x7+SZSHGZiSb5k7Op56zLwfCpsgzVCTisCCtsM5+CAb1NnfGtHNJWzcqXOh9h4MdsJbe
         f9uKlZ7BWmdeYQuWjipw70OaYMsJC03ylDA/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=61y5ENS1IprE4e/ZfJKMv0QresyoCgKAs8JLXZdOoGA=;
        b=O39nnmQcOXKO2BXqzUnj4uD7iEAfYtG2oa3MiLSM6TdA5J82zmkAJVHIigAb5leLmd
         Gtl9ZBZ8f7gVcSlKtCFVu+/sRYeNV0draRA4J9m9EgZkNLrojGQPlVT/V7Qbm5GVDNZd
         E1rhXM63OLItiO9keJ5tvA5p8TbaM1l5ih8NYytSWjUUlyPPi6+qsJP6C1r42phO51GX
         b2EIpAFWAWl/vbNKS2FpopMaWP3ElNB3BPE2FQQWfwrv8qZmbmnv3slojXmuYlYvDiWN
         QuI96ypcBa3mVjL6VFej1gOl7c1ONmb9FR5khvjGh2HP67CFgVoh+zoChVw9YS4+IrlQ
         y7gw==
X-Gm-Message-State: AHQUAuYqjVW3WSUohGHl/gFQf0Z9jtuX/0wr6EUlZDjjI4jA90tUUmvE
        PZsknpfo0jaYX4Io6q1P/0jrVQgKidW4OgKEVworYQ==
X-Google-Smtp-Source: AHgI3IbCPwhuvNKbtlStjBbb9jUtmKb+Ux2VHzRmLQzGlVllLucm9xALq1yo5lPD3yd+UClKcDe2WBMpEtkzRXiTXPA=
X-Received: by 2002:a1c:b456:: with SMTP id d83mr4459433wmf.115.1549066707932;
 Fri, 01 Feb 2019 16:18:27 -0800 (PST)
MIME-Version: 1.0
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 1 Feb 2019 16:18:16 -0800
Message-ID: <CALAqxLXy1zSTSoDEfYN0VJBbf=Q0N6kH+S_1hTTgEb6dQi0XrQ@mail.gmail.com>
Subject: Frequent dwc3 crashes on suspend or reboot since 5.0-rc1
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

Hey all,
  Since the 5.0 merge window opened, I've been tripping on frequent
dwc3 crashes on reboot and suspend, which I've added an example to the
bottom of this mail.

I've dug in a little bit and sort of have a sense of whats going on.

In ffs_epfile_io():
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/gadget/function/f_fs.c#n1065

The completion done is setup on the stack:
  DECLARE_COMPLETION_ONSTACK(done);

Then later we setup a request and queue it:
  req->context  = &done;
  ...
  ret = usb_ep_queue(ep->ep, req, GFP_ATOMIC);

Then wait for it:
  if (unlikely(wait_for_completion_interruptible(&done))) {
    /*
    * To avoid race condition with ffs_epfile_io_complete,
    * dequeue the request first then check
    * status. usb_ep_dequeue API should guarantee no race
    * condition with req->complete callback.
    */
    usb_ep_dequeue(ep->ep, req);
    interrupted = ep->status < 0;
  }

The problem is, that we end up being interrupted, supposedly dequeue
the request, and exit.

But then (or in parallel) the irq triggers and we try calling
complete() on the context pointer which points to now random stack
space, which results in the panic.

It seems like something is wrong with usb_ep_dequeue not really
stopping the irq from happening?

If I revert all the changes to dwc3 back to 4.20, I don't see the issue.

I'll do some bisection to try to narrow things down, but I wanted to
see if this was a known issue or if anyone had immediate ideas as to
what might be wrong.

thanks
-john

[   36.911170] Unable to handle kernel paging request at virtual
address ffffff801153d660
[   36.912769] Unable to handle kernel paging request at virtual
address ffffff800004b564
[   36.919881] Mem abort info:
[   36.919884]   ESR = 0x96000047
[   36.919888]   Exception class = DABT (current EL), IL = 32 bits
[   36.919890]   SET = 0, FnV = 0
[   36.919895]   EA = 0, S1PTW = 0
[   36.927875] Mem abort info:
[   36.935718] Data abort info:
[   36.935721]   ISV = 0, ISS = 0x00000047
[   36.935723]   CM = 0, WnR = 1
[   36.935730] swapper pgtable: 4k pages, 39-bit VAs, pgdp = 00000000f1b819ef
[   36.935733] [ffffff801153d660] pgd=000000021ffff803,
pud=000000021ffff803, pmd=000000021fffb803, pte=0000000000000000
[   36.935744] Internal error: Oops: 96000047 [#1] PREEMPT SMP
[   36.935748] Modules linked in:
[   36.938552]   ESR = 0x86000006
[   36.941601] CPU: 0 PID: 2656 Comm: irq/69-dwc3 Tainted: G S
       4.20.0-10778-gadc8369 #210
[   36.941603] Hardware name: HiKey960 (DT)
[   36.941610] pstate: 00400085 (nzcv daIf +PAN -UAO)
[   36.947554]   Exception class = IABT (current EL), IL = 32 bits
[   36.950594] pc : queued_spin_lock_slowpath+0x1cc/0x2c8
[   36.950601] lr : queued_spin_lock_slowpath+0xd0/0x2c8
[   36.950603] sp : ffffff8011e13be0
[   36.950607] x29: ffffff8011e13be0 x28: 0000000000000000
[   36.950611] x27: ffffff801186d000 x26: ffffff8010159000
[   36.950615] x25: ffffff801186d000 x24: ffffffc218be36e8
[   36.950619] x23: ffffff801186e910 x22: 0000000000040000
[   36.950622] x21: ffffffc21f71b640 x20: ffffff801153d000
[   36.950626] x19: ffffff8011e1bbe8 x18: 0000000000000000
[   36.950629] x17: 00000000100eb564 x16: 00000000100eb564
[   36.950633] x15: 0000000000000000 x14: ffffff801187cf80
[   36.950636] x13: 000000420e1de000 x12: 0000000034d4d91d
[   36.950640] x11: 0000000000000000 x10: 0000000000000a20
[   36.950643] x9 : ffffff8011e13d10 x8 : ffffffc218874c00
[   36.950646] x7 : 0000000000000000 x6 : ffffff801186db08
[   36.950650] x5 : 0000000000000000 x4 : 0000000000000000
[   36.950653] x3 : ffffffc21f71b640 x2 : 0000000000000000
[   36.950656] x1 : ffffff801153d660 x0 : ffffffc21f71b648
[   36.950663] Process irq/69-dwc3 (pid: 2656, stack limit = 0x00000000b627af93)
[   36.950666] Call trace:
[   36.950670]  queued_spin_lock_slowpath+0x1cc/0x2c8
[   36.950681]  _raw_spin_lock_irqsave+0x64/0x78
[   36.950692]  complete+0x28/0x70
[   36.950703]  ffs_epfile_io_complete+0x3c/0x50
[   36.950713]  usb_gadget_giveback_request+0x34/0x108
[   36.950721]  dwc3_gadget_giveback+0x50/0x68
[   36.950723]  dwc3_thread_interrupt+0x358/0x1488
[   36.950731]  irq_thread_fn+0x30/0x88
[   36.950734]  irq_thread+0x114/0x1b0
[   36.950739]  kthread+0x104/0x130
[   36.950747]  ret_from_fork+0x10/0x1c
[   36.950755] Code: 91190281 8b021021 f860dae2 91002060 (f8226823)
[   36.953901]   SET = 0, FnV = 0
[   36.956685] ---[ end trace 3d13dc405c1e8aa7 ]---
[   36.965704] Kernel panic - not syncing: Fatal exception
[   36.966372]   EA = 0, S1PTW = 0
[   36.973246] SMP: stopping secondary CPUs
[   36.983855] Kernel Offset: disabled
[   36.983860] CPU features: 0x002,21882004
[   36.983861] Memory Limit: none
[   37.210976] Rebooting in 5 seconds..
