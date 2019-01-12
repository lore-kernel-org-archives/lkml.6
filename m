Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EED6C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 01:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A6B720878
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 01:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SA2h5y74"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbfALBxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 20:53:24 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46357 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfALBxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 20:53:23 -0500
Received: by mail-pl1-f194.google.com with SMTP id t13so7527453ply.13
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 17:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=76fExi8BEsrpwoIGInSiwH2/pUIffTE4qAaefrvvWso=;
        b=SA2h5y74T3wpAG9v3rcrGBI361oQdNUzjf+hRyc9bLu8I77UA7vfx3pg2n0NeMt+He
         i6M0epRFBRhI+v3ayZY2BDgDw17gpdybriFu0WnJvt+mO/Dc7eGqV4U7VWXITt8+fnJ7
         8Bb69i5/IsjTGeYnsAgFe9NtRBM+ozIPwEJnz4Zlptw3DZfL71TJTM4pnitrLEOD0mjt
         bVM3CEmchOLKIFEkLN4WpqzmYyC3KgC7LQGIxFd2zMVNYTwYQ/UKlgtm9txluVHD8oBE
         rCYoCNc88Vjp2uJA7yNAYVDVN5/BCNZew9w2jua/lFp6HSfOGc1Pbuv0bMEmibQZntpu
         b61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=76fExi8BEsrpwoIGInSiwH2/pUIffTE4qAaefrvvWso=;
        b=P7L1jhWaLdvnfa3HwcGyBL0p5IVZOy06OTg/BgSNqjwsF3tH/cZ1YEl4fxJ0WYH9oB
         shWqwKtGyV4cVcbNHUt05E6qwM8dV2Uk/2jYSJOxp/CBJh+oitWAt1bxbiV0ZAYpxBCt
         Rts7mjOmPjaJvkTxM904fb8Nm+QDrl1QxiaT8gb06BO5clfZ7j5dweMaEbG8mGoOZ0OD
         bN3g1miFBcuUhBvycV3ntsDvihulh5ys7g+FjGP5M82R/nB3EMrTSz0yMqF9Rjfdi5IB
         qegsCQTCmZQj7yNcUc3wWetUIAQEGIzeJyK40qSFouwaHSncH4JUgZSCW3PbO0xvMnVx
         NC3Q==
X-Gm-Message-State: AJcUuke+AcCzhBURAy8j9TK02CUL/9N31eAan2ohP78POEHetBRkX+Pu
        KZtyLJMy8jAdd2dHI64TClFmZFYA
X-Google-Smtp-Source: ALg8bN6l5bnYv88EnWgcTahY9LldWnkcq2D3OaIrDA6EwXf16oHVFZnodEtdGVk5GbHkZmJo+6oAaA==
X-Received: by 2002:a17:902:8ec9:: with SMTP id x9mr17035668plo.27.1547258002476;
        Fri, 11 Jan 2019 17:53:22 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id e24sm113887322pfi.153.2019.01.11.17.53.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 17:53:21 -0800 (PST)
Date:   Fri, 11 Jan 2019 17:53:19 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Rodolfo Giometti <giometti@enneenne.com>
Cc:     Kyungtae Kim <kt0755@gmail.com>,
        Byoungyoung Lee <lifeasageek@gmail.com>,
        DaeRyong Jeong <threeearcat@gmail.com>,
        syzkaller@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: UBSAN: Undefined behaviour in drivers/pps/pps.c
Message-ID: <20190112015319.GD122403@dtor-ws>
References: <CAEAjamus+rx1idSZrfHERXvbeWeUC3Fiy5UNL_pbp_-ZbafEjQ@mail.gmail.com>
 <4f72df46-d2ca-e15d-4df1-fe525bbfcdd0@enneenne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f72df46-d2ca-e15d-4df1-fe525bbfcdd0@enneenne.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 10:20:50AM +0100, Rodolfo Giometti wrote:
> On 08/01/2019 21:24, Kyungtae Kim wrote:
> > We report a bug in linux-4.20: "UBSAN: Undefined behaviour in drivers/pps/pps.c"
> > 
> > kernel config: https://kt0755.github.io/etc/config_v4.20_stable
> > repro: https://kt0755.github.io/etc/repro.a6372.c
> > 
> > pps_cdev_pps_fetch() lacks the bounds checking for computing
> > fdata->timeout.sec * HZ, that causes such integer overflow when the result
> > is larger than the boundary.
> > The  patch below checks the possibility of overflow right before the
> > multiplication.
> > 
> > =========================================
> > UBSAN: Undefined behaviour in drivers/pps/pps.c:82:30
> > signed integer overflow:
> > -7557201428062104791 * 100 cannot be represented in type 'long long int'
> > CPU: 0 PID: 10159 Comm: syz-executor6 Not tainted 4.20.0 #1
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
> > Call Trace:
> >   __dump_stack lib/dump_stack.c:77 [inline]
> >   dump_stack+0xb1/0x118 lib/dump_stack.c:113
> >   ubsan_epilogue+0x12/0x94 lib/ubsan.c:159
> >   handle_overflow+0x1cf/0x21a lib/ubsan.c:190
> >   __ubsan_handle_mul_overflow+0x2a/0x35 lib/ubsan.c:214
> >   pps_cdev_pps_fetch+0x575/0x5b0 drivers/pps/pps.c:82
> >   pps_cdev_ioctl+0x567/0x910 drivers/pps/pps.c:191
> >   vfs_ioctl fs/ioctl.c:46 [inline]
> >   do_vfs_ioctl+0x1aa/0x1160 fs/ioctl.c:698
> >   ksys_ioctl+0x9e/0xb0 fs/ioctl.c:713
> >   __do_sys_ioctl fs/ioctl.c:720 [inline]
> >   __se_sys_ioctl fs/ioctl.c:718 [inline]
> >   __x64_sys_ioctl+0x7e/0xc0 fs/ioctl.c:718
> >   do_syscall_64+0xbe/0x4f0 arch/x86/entry/common.c:290
> >   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > RIP: 0033:0x4497b9
> > Code: e8 8c 9f 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48
> > 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> > 01 f0 ff ff 0f 83 9b 6b fc ff c3 66 2e 0f 1f 84 00 00 00 00
> > RSP: 002b:00007f8cf875bc68 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > RAX: ffffffffffffffda RBX: 00007f8cf875c6cc RCX: 00000000004497b9
> > RDX: 0000000020000240 RSI: 00000000c00870a4 RDI: 0000000000000014
> > RBP: 000000000071bea0 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
> > R13: 0000000000005c10 R14: 00000000006eecb0 R15: 00007f8cf875c700
> > =========================================
> > 
> > ---
> >   drivers/pps/pps.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
> > index 8febacb..66002e1 100644
> > --- a/drivers/pps/pps.c
> > +++ b/drivers/pps/pps.c
> > @@ -79,6 +79,8 @@ static int pps_cdev_pps_fetch(struct pps_device
> > *pps, struct pps_fdata *fdata)
> >                  dev_dbg(pps->dev, "timeout %lld.%09d\n",
> >                                  (long long) fdata->timeout.sec,
> >                                  fdata->timeout.nsec);
> > +               if (fdata->timeout.sec > S64_MAX / HZ)
> > +                               return -EINVAL;
> >                  ticks = fdata->timeout.sec * HZ;
> >                  ticks += fdata->timeout.nsec / (NSEC_PER_SEC / HZ);
> 
> It looks good to me. Do you think is better adding a check for timeout.nsec also?

Another option is to use check_mul_overflow().

> 
> Now you have to produce a patch according to
> linux/Documentation/process/submitting-patches.rst and then submitting it!
> :-)
> 

Thanks.

-- 
Dmitry
