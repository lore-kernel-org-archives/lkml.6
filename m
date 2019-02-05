Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5DD3C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA63217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BmBMxRhx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729893AbfBESYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 13:24:46 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33900 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729858AbfBESYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 13:24:45 -0500
Received: by mail-pf1-f193.google.com with SMTP id h3so1859728pfg.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 10:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=29P8k5ncuXKUQyRURsMYPjVkN9pG7vuj0vNBGghAWIo=;
        b=BmBMxRhx8B9FXghORrcyCycY/5e5CDa1od8MIBcw+qLJDuG5XJnLW1Di2x/8Bqb3Jo
         cLNIl9R+SjiaEGgMA0FRkwMR6cQne5LSsjvsiT/3rF7igl3R/Du5sEGtc6Qt6VxkSvne
         LrY9W08z4ocgRg08ZMnxbhap6aJwib9JR+sQLyhsY3P3R0tFSg+Y07MwNzKuBTLACCyw
         XckXyArQGdXT2o1UgeHMD+S3AipZYBn+DyslLU4gCCi/UvJcHFxJ1bk7XzqvXYPy+LLY
         vM7ePnlGSz/m/NddpPJwdbmbhDIcZIYI4NJQ9Jot/wrEEMW7UxkMsSm03ZkN93w/kALJ
         2qaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=29P8k5ncuXKUQyRURsMYPjVkN9pG7vuj0vNBGghAWIo=;
        b=IZszAgoGkYE8QAZVr0GZuT8rRnvchygobCvDq8HT94fTm+rLqq2T3Zvi9YtKED6UFN
         vqE+EY2Gq+YKXZ/s86GjG0izS9ouut8MdAcaUsOYUWKSto9EbS3PGnfqR4+g4ld04evm
         bCxti61f3ZGdfhrYGzeVjy/xdC1PXK4+ouOx4dcFqANNtbjX+QA2TyaeywTh+0E8ZoBM
         nRmhIIr9NdK8Li1ZipM+wE2jq7r471t5pBZ+0kC4H/DL0N8orv9/1D3VrsjiydRf7gtn
         7BkobN/v7nIMeKJT9UeG6OwwLIah3r1hnr8jcRvHlkkUHSX4cdkUtCvmXl/lV0T487J4
         irmw==
X-Gm-Message-State: AHQUAuZyCIzyHzPSE0aAoBNHlBcOVESqAAEyZHWOU4iQUoCM8X0J3Tc5
        f1ftLjBj5WjAua8Rv8RaZtCHoAR1z94=
X-Google-Smtp-Source: AHgI3IZaGoyes8rmaNzxuDLdGcsypja4ggGI7vJCRf9Pjz7oLWA63vhVOyOZrdP9QRf+eJNTK9lR8A==
X-Received: by 2002:a65:6094:: with SMTP id t20mr1684265pgu.285.1549391083808;
        Tue, 05 Feb 2019 10:24:43 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id b194sm6932326pga.45.2019.02.05.10.24.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Feb 2019 10:24:42 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Felipe Balbi <balbi@kernel.org>,
        Zeng Tao <prime.zeng@hisilicon.com>,
        Jack Pham <jackp@codeaurora.org>,
        Thinh Nguyen <thinh.nguyen@synopsys.com>,
        Chen Yu <chenyu56@huawei.com>,
        Jerry Zhang <zhangjerry@google.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Pelletier <plr.vincent@gmail.com>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux USB List <linux-usb@vger.kernel.org>
Subject: [RFC][PATCH] usb: f_fs: Avoid crash due to out-of-scope stack ptr access
Date:   Tue,  5 Feb 2019 10:24:40 -0800
Message-Id: <1549391080-7413-1-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the 5.0 merge window opened, I've been seeing frequent
crashes on suspend and reboot with the trace:

[   36.911170] Unable to handle kernel paging request at virtual address ffffff801153d660
[   36.912769] Unable to handle kernel paging request at virtual address ffffff800004b564
...
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

I isolated this down to in ffs_epfile_io():
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/gadget/function/f_fs.c#n1065

Where the completion done is setup on the stack:
  DECLARE_COMPLETION_ONSTACK(done);

Then later we setup a request and queue it, and wait for it:
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

The problem is, that we end up being interrupted, dequeue the
request, and exit.

But then the irq triggers and we try calling complete() on the
context pointer which points to now random stack space, which
results in the panic.

Alan Stern pointed out there is a bug here, in that the snippet
above "assumes that usb_ep_dequeue() waits until the request has
been completed." And that:

    wait_for_completion(&done);

Is needed right after the usb_ep_dequeue().

Thus this patch implements that change. With it I no longer see
the crashes on suspend or reboot.

This issue seems to have been uncovered by behavioral changes in
the dwc3 driver in commit fec9095bdef4e ("usb: dwc3: gadget:
remove wait_end_transfer").

Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: Zeng Tao <prime.zeng@hisilicon.com>
Cc: Jack Pham <jackp@codeaurora.org>
Cc: Thinh Nguyen <thinh.nguyen@synopsys.com>
Cc: Chen Yu <chenyu56@huawei.com>
Cc: Jerry Zhang <zhangjerry@google.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Vincent Pelletier <plr.vincent@gmail.com>
Cc: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux USB List <linux-usb@vger.kernel.org>
Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/usb/gadget/function/f_fs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 1e54304..0f8d16d 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1082,6 +1082,7 @@ static ssize_t ffs_epfile_io(struct file *file, struct ffs_io_data *io_data)
 			 * condition with req->complete callback.
 			 */
 			usb_ep_dequeue(ep->ep, req);
+			wait_for_completion(&done);
 			interrupted = ep->status < 0;
 		}
 
-- 
2.7.4

