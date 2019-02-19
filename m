Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05402C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD9F221773
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxUOHsLG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbfBSQ0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:26:47 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35586 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfBSQ0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 11:26:47 -0500
Received: by mail-pl1-f196.google.com with SMTP id p8so10683228plo.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 08:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q2uKZ5NdY3IOnlUDFbFR4w2+lKabiKCzDJHG3C2+4Pg=;
        b=fxUOHsLGrdsNXpKnUYpZIwZoRVE4ukTmFmT75FMD/3bOMuaogdDfj2PpSq6jML+aV9
         QrWpY35pld+hFjAsPhTL6stiH80SQGouXHA6iOLlQ20TRW87acdmqHUB6WI7mdSbKBLK
         wldL4hE1rpeaCdF0/B2eGnqfRDN7UrTkU0hiMw61mepA94IrpdKjq+XUGaySGRI47zJf
         VACoWPveQ0JX6hcCwlkVJECPW5ptKAl9yM1kJKxNYglY0lhKVLIHx2YuYSwEIae8tNo+
         CoKxPQtQ+ycd6UNGtl6LiDjqG+iQE3vMKZNBWoRZDtIboUpoqTFpjgFq6BfUa1iXDeIZ
         5uLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=q2uKZ5NdY3IOnlUDFbFR4w2+lKabiKCzDJHG3C2+4Pg=;
        b=IatVEJ170MR0FVHHUGrB0nfSiV5BAy13vh5ReInewrKcQbuyukvHwG+8rithr58GSC
         ZSXqm9RffrKTCjAaUQxfHiSd2BTfpmomZdxY1mEsOOOF7m0OTCHqxQzOH21IDFYw8u8q
         axnbukyIg3BamDOZj0eKCfZNyjSCiZE8cW+8KppcQ3UzEgRp1YFP1CyHQt52Km83ayh6
         gZp+xNfHKW8ZdDY0VW3qmojZ4txFGAlcYMP4B/Hkp2m/J7LlJsH8HQI7z3hddAlgoMfx
         +VQ/SlCYAjXBTCLUkkVHNvN8hUL1PPEcz7adNqB+5vdE8bovTZbdBXL9g8QUcp8zSYrZ
         HQoQ==
X-Gm-Message-State: AHQUAubVnWtPa/WMFTe91ckkAG/jkD3ksvieBOrpw3YmAovGV9ipc/sa
        AWrifFC+iuOY3sHdaofrO5mzjWWy
X-Google-Smtp-Source: AHgI3IYzP6F3v0roKBK6Yt0LprIs7bbC3Sqp1MMoZqUdG9pcHvJ0qvG9vaQ5KY8oUEj31yGrcNwGqw==
X-Received: by 2002:a17:902:834b:: with SMTP id z11mr8927223pln.257.1550593605791;
        Tue, 19 Feb 2019 08:26:45 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w6sm26688744pga.72.2019.02.19.08.26.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 08:26:44 -0800 (PST)
Date:   Tue, 19 Feb 2019 08:26:43 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ben Woodard <woodard@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] exec: increase BINPRM_BUF_SIZE to 256
Message-ID: <20190219162643.GA15202@roeck-us.net>
References: <20181112160931.GA28463@redhat.com>
 <20181112160956.GA28472@redhat.com>
 <20190218193734.GA29983@roeck-us.net>
 <20190219123756.GA9210@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219123756.GA9210@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 01:37:57PM +0100, Oleg Nesterov wrote:
> On 02/18, Guenter Roeck wrote:
> >
> > Unfortunately, this patch causes one of my qemu emulations to crash.
> > The crash is not always seen, but at least with every other boot attempt.
> 
> Hmm. I can't imagine how this change can cause the null-ptr-deref in
> blk_mq_run_hw_queue().
> 
Me not either.

> > Reverting the patch fixes the problem. Crash log and bisect results
> > are attached below.
> 
> Do you mean that you applied the "revert" patch on top of linux-next ?
> 
I reverted to patch on top of linux-next (next-20190218, more specifically).
The problem was gone. I then reverted the revert and the probllem was back.

> Or did you rely on git-bisect ?
> 
Sorry, I don't understand the question. git bisect, unless I am missing
something, doesn't revert any patches.

> > [   10.681671] BUG: Kernel NULL pointer dereference at 0x00000040
> > [   10.681826] Faulting instruction address: 0xc0431480
> > [   10.682072] Oops: Kernel access of bad area, sig: 11 [#1]
> > [   10.682251] BE PAGE_SIZE=4K PREEMPT Xilinx Virtex440
> > [   10.682387] Modules linked in:
> > [   10.682528] CPU: 0 PID: 1 Comm: swapper Tainted: G        W         5.0.0-rc6-next-20190218+ #2
> > [   10.682733] NIP:  c0431480 LR: c043147c CTR: c0422ad8
> > [   10.682863] REGS: cf82fbe0 TRAP: 0300   Tainted: G        W          (5.0.0-rc6-next-20190218+)
> > [   10.683065] MSR:  00029000 <CE,EE,ME>  CR: 22000222  XER: 00000000
> > [   10.683236] DEAR: 00000040 ESR: 00000000 
> > [   10.683236] GPR00: c043147c cf82fc90 cf82ccc0 00000000 00000000 00000000 00000002 00000000 
> > [   10.683236] GPR08: 00000000 00000000 c04310bc 00000000 22000222 00000000 c0002c54 00000000 
> > [   10.683236] GPR16: 00000000 00000001 c09aa39c c09021b0 c09021dc 00000007 c0a68c08 00000000 
> > [   10.683236] GPR24: 00000001 ced6d400 ced6dcf0 c0815d9c 00000000 00000000 00000000 cedf0800 
> > [   10.684331] NIP [c0431480] blk_mq_run_hw_queue+0x28/0x114
> > [   10.684473] LR [c043147c] blk_mq_run_hw_queue+0x24/0x114
> > [   10.684602] Call Trace:
> > [   10.684671] [cf82fc90] [c043147c] blk_mq_run_hw_queue+0x24/0x114 (unreliable)
> > [   10.684854] [cf82fcc0] [c04315bc] blk_mq_run_hw_queues+0x50/0x7c
> > [   10.685002] [cf82fce0] [c0422b24] blk_set_queue_dying+0x30/0x68
> > [   10.685154] [cf82fcf0] [c0423ec0] blk_cleanup_queue+0x34/0x14c
> > [   10.685306] [cf82fd10] [c054d73c] ace_probe+0x3dc/0x508
> > [   10.685445] [cf82fd50] [c052d740] platform_drv_probe+0x4c/0xb8
> > [   10.685592] [cf82fd70] [c052abb0] really_probe+0x20c/0x32c
> > [   10.685728] [cf82fda0] [c052ae58] driver_probe_device+0x68/0x464
> > [   10.685877] [cf82fdc0] [c052b500] device_driver_attach+0xb4/0xe4
> > [   10.686024] [cf82fde0] [c052b5dc] __driver_attach+0xac/0xfc
> > [   10.686161] [cf82fe00] [c0528428] bus_for_each_dev+0x80/0xc0
> > [   10.686314] [cf82fe30] [c0529b3c] bus_add_driver+0x144/0x234
> > [   10.686457] [cf82fe50] [c052c46c] driver_register+0x88/0x15c
> > [   10.686610] [cf82fe60] [c09de288] ace_init+0x4c/0xac
> > [   10.686742] [cf82fe80] [c0002730] do_one_initcall+0xac/0x330
> > [   10.686888] [cf82fee0] [c09aafd0] kernel_init_freeable+0x34c/0x478
> > [   10.687043] [cf82ff30] [c0002c6c] kernel_init+0x18/0x114
> 
> looks unrelated...
> 

Indeed...

The underlying problem is in the error handling code of ace_setup(),
which calls put_disk() followed by blk_cleanup_queue(). put_disk()
calls disk_release(), which calls blk_put_queue(), which in turn
results in a call to blk_mq_hw_sysfs_release().

Added debug code, with your patch reverted, shows:

 ######### blk_mq_hw_sysfs_release hctx=cee4a800
 ...
 ######### blk_mq_run_hw_queue hctx=cee4a800

blk_mq_hw_sysfs_release() calls kfree(htcx), so accessing it later is most
definitely not a good idea.

No idea why this only causes problems with your patch applied.

I'll send a patch to fix the underlying problem.

Thanks,
Guenter
