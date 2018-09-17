Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45121ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 07:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E59CA214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 07:06:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E59CA214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbeIQMcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 08:32:06 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42144 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbeIQMcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 08:32:05 -0400
Received: from mail-pg1-f200.google.com ([209.85.215.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1g1nbb-0003pB-Oz
        for linux-kernel@vger.kernel.org; Mon, 17 Sep 2018 07:05:59 +0000
Received: by mail-pg1-f200.google.com with SMTP id v195-v6so6091322pgb.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 00:05:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=PHSZRbkmG0Zb2jEBiSePQgWCCtGMw9HYLC7XywLoCtc=;
        b=fQSCu1QFvvrUD6qP0kNxiTAzWKVBvu+qfPd3cFYDdZp+r5ejKnVTuKx2n8OhA3qBgz
         9hcHn8tgXgzi8yfnxEqNMCrm6LQBLu+PjEbVJrLtn+NQbOgOwEO1hjl1V2w8O/vMflEA
         2I9HhyzzCeaTQ/zzbFttbdwEKUIo8vSgUJaP3J6WkLsf/iSsvsxiCb3xpphWhcfxDLKf
         GIGdjZ+Yb5HOsV0ljrN2zUDWrWTweeI0B+8HTEy95QjqPcrS3iPkseH2VqhdGOn/C1sO
         9Fr8Jkpb8fjXd2LEQHL0+tETgJhbmW14JbYAc6hLP6vA7SivmBBTtf8f/DD5ghgIwbBy
         CRJg==
X-Gm-Message-State: APzg51C5UXCLx9ZDU0Ee9Bg2Py0cGyRZBQWmFz1eRqAVpumOvgBZ5OCp
        MtAuNnNbHHAz0qaqAw+fVG4oJLoKtHjsI//g1z2sokaKo7GY1lvhzt4DkoOMzTQf3b2sjLl7pln
        /gzOmuJ/lnevc95onjj3sO0Y9EnSrkCMoan9k3ZbtIA==
X-Received: by 2002:a17:902:47:: with SMTP id 65-v6mr23062649pla.293.1537167958353;
        Mon, 17 Sep 2018 00:05:58 -0700 (PDT)
X-Google-Smtp-Source: ANB0Vdb2bakt4ZEQz/O90cPst7Yi3SXO5TGsdqAL5qkf50n4fUH8qR9kZsrj+D5Y1wwINnsa96RvuQ==
X-Received: by 2002:a17:902:47:: with SMTP id 65-v6mr23062605pla.293.1537167957972;
        Mon, 17 Sep 2018 00:05:57 -0700 (PDT)
Received: from [192.168.1.206] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id w5-v6sm16770209pfn.44.2018.09.17.00.05.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 00:05:56 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] usb: core: safely deal with the dynamic quirk lists
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20180914085816.10888-1-harry.pan@intel.com>
Date:   Mon, 17 Sep 2018 15:05:51 +0800
Cc:     LKML <linux-kernel@vger.kernel.org>, gs0622@gmail.com,
        jongpil19.jung@samsung.com, rajatja@chromium.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        snecknico@gmail.com, jackstocker.93@gmail.com, oneukum@suse.com,
        linux-usb@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <8950C3C8-AF9B-49DF-BE29-5F6892FCCEC8@canonical.com>
References: <20180914085816.10888-1-harry.pan@intel.com>
To:     Harry Pan <harry.pan@intel.com>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 16:58, Harry Pan <harry.pan@intel.com> wrote:

> Applying dynamic usbcore quirks in early booting when the slab is
> not yet ready would cause kernel panic of null pointer dereference
> because the quirk_count has been counted as 1 while the quirk_list
> was failed to allocate.
>
> i.e.,
> [    1.044970] BUG: unable to handle kernel NULL pointer dereference  
> at           (null)
> [    1.044995] IP: [<ffffffffb0953ec7>] usb_detect_quirks+0x88/0xd1
> [    1.045016] PGD 0
> [    1.045026] Oops: 0000 [#1] PREEMPT SMP
> [    1.046986] gsmi: Log Shutdown Reason 0x03
> [    1.046995] Modules linked in:
> [    1.047008] CPU: 0 PID: 81 Comm: kworker/0:3 Not tainted 4.4.154 #28
> [    1.047016] Hardware name: Google Coral/Coral, BIOS  
> Google_Coral.10068.27.0 12/04/2017
> [    1.047028] Workqueue: usb_hub_wq hub_event
> [    1.047037] task: ffff88017a321c80 task.stack: ffff88017a384000
> [    1.047044] RIP: 0010:[<ffffffffb0953ec7>]  [<ffffffffb0953ec7>]  
> usb_detect_quirks+0x88/0xd1
>
> To tackle this odd, let's balance the quirk_count to 0 when the kcalloc
> call fails, and defer the quirk setting into a lower level callback
> which ensures that the kernel memory management has been initialized.
>
> Fixes: 027bd6cafd9a ("usb: core: Add "quirks" parameter for usbcore")
>
> Signed-off-by: Harry Pan <harry.pan@intel.com>

Thanks for the catch!

This issue doesn't appear when usbcore is built as module.

Acked-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

> ---
>  drivers/usb/core/quirks.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
> index 097057d2eacf..1fe9843fb9c8 100644
> --- a/drivers/usb/core/quirks.c
> +++ b/drivers/usb/core/quirks.c
> @@ -58,6 +58,7 @@ static int quirks_param_set(const char *val, const  
> struct kernel_param *kp)
>  	quirk_list = kcalloc(quirk_count, sizeof(struct quirk_entry),
>  			     GFP_KERNEL);
>  	if (!quirk_list) {
> +		quirk_count = 0;
>  		mutex_unlock(&quirk_mutex);
>  		return -ENOMEM;
>  	}
> @@ -154,7 +155,7 @@ static struct kparam_string quirks_param_string = {
>  	.string = quirks_param,
>  };
>
> -module_param_cb(quirks, &quirks_param_ops, &quirks_param_string, 0644);
> +device_param_cb(quirks, &quirks_param_ops, &quirks_param_string, 0644);
>  MODULE_PARM_DESC(quirks, "Add/modify USB quirks by specifying quirks=vendorID:productID:quirks");
>
>  /* Lists of quirky USB devices, split in device quirks and interface quirks.
> -- 
> 2.16.4


