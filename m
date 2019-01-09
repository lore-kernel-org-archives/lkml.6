Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5681AC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBCB9206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="C2Tln1Qf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730405AbfAIJ2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:28:23 -0500
Received: from smtpcmd02101.aruba.it ([62.149.158.101]:45857 "EHLO
        smtpcmd02101.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728041AbfAIJ2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:28:22 -0500
X-Greylist: delayed 442 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Jan 2019 04:28:21 EST
Received: from [192.168.1.15] ([79.3.83.244])
        by smtpcmd02.ad.aruba.it with bizsmtp
        id N9Lr1z00t5GHDdK019Ltq3; Wed, 09 Jan 2019 10:20:54 +0100
Subject: Re: UBSAN: Undefined behaviour in drivers/pps/pps.c
To:     Kyungtae Kim <kt0755@gmail.com>
Cc:     Byoungyoung Lee <lifeasageek@gmail.com>,
        DaeRyong Jeong <threeearcat@gmail.com>,
        syzkaller@googlegroups.com, linux-kernel@vger.kernel.org
References: <CAEAjamus+rx1idSZrfHERXvbeWeUC3Fiy5UNL_pbp_-ZbafEjQ@mail.gmail.com>
From:   Rodolfo Giometti <giometti@enneenne.com>
Message-ID: <4f72df46-d2ca-e15d-4df1-fe525bbfcdd0@enneenne.com>
Date:   Wed, 9 Jan 2019 10:20:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAEAjamus+rx1idSZrfHERXvbeWeUC3Fiy5UNL_pbp_-ZbafEjQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aruba.it; s=a1;
        t=1547025654; bh=RwWnrw1pSn4wXEQN2YkD0UAPqdISoKl3lyXOnEPzrfY=;
        h=Subject:To:From:Date:MIME-Version:Content-Type;
        b=C2Tln1QfQdRsl32l0dnj3kVQPSOLuMpw9XeVVDAYLFBu8e5VgzJduRseWa6mbD25B
         A0SlHp0i0zzxBYAwXGImaJNVEBIKy9O2OHy9tAAO48QLWr+nKAwZuZIp/jJ9T/OtOI
         JEAk1UK0T2WPqFvyF3AJ0R4jGOIq9VwY07GUEKvkmSfc2OMpY6vknB14LIiXqG2zc0
         ZhQl4jP6l0Qjv+IJsjK/Iay49eNaiLJ5GQoztC2foEZWbeYWxQRgD+Xl2zgD4Nf5Hy
         EV7UWi2TmmbCq05qjYlsVTQQzgaJTeaSwsh3opFQ5qhoOP7gzNLK93wNccrWWbFKhm
         AKxmj5tQeuh0Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01/2019 21:24, Kyungtae Kim wrote:
> We report a bug in linux-4.20: "UBSAN: Undefined behaviour in drivers/pps/pps.c"
> 
> kernel config: https://kt0755.github.io/etc/config_v4.20_stable
> repro: https://kt0755.github.io/etc/repro.a6372.c
> 
> pps_cdev_pps_fetch() lacks the bounds checking for computing
> fdata->timeout.sec * HZ, that causes such integer overflow when the result
> is larger than the boundary.
> The  patch below checks the possibility of overflow right before the
> multiplication.
> 
> =========================================
> UBSAN: Undefined behaviour in drivers/pps/pps.c:82:30
> signed integer overflow:
> -7557201428062104791 * 100 cannot be represented in type 'long long int'
> CPU: 0 PID: 10159 Comm: syz-executor6 Not tainted 4.20.0 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0xb1/0x118 lib/dump_stack.c:113
>   ubsan_epilogue+0x12/0x94 lib/ubsan.c:159
>   handle_overflow+0x1cf/0x21a lib/ubsan.c:190
>   __ubsan_handle_mul_overflow+0x2a/0x35 lib/ubsan.c:214
>   pps_cdev_pps_fetch+0x575/0x5b0 drivers/pps/pps.c:82
>   pps_cdev_ioctl+0x567/0x910 drivers/pps/pps.c:191
>   vfs_ioctl fs/ioctl.c:46 [inline]
>   do_vfs_ioctl+0x1aa/0x1160 fs/ioctl.c:698
>   ksys_ioctl+0x9e/0xb0 fs/ioctl.c:713
>   __do_sys_ioctl fs/ioctl.c:720 [inline]
>   __se_sys_ioctl fs/ioctl.c:718 [inline]
>   __x64_sys_ioctl+0x7e/0xc0 fs/ioctl.c:718
>   do_syscall_64+0xbe/0x4f0 arch/x86/entry/common.c:290
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x4497b9
> Code: e8 8c 9f 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48
> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> 01 f0 ff ff 0f 83 9b 6b fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007f8cf875bc68 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007f8cf875c6cc RCX: 00000000004497b9
> RDX: 0000000020000240 RSI: 00000000c00870a4 RDI: 0000000000000014
> RBP: 000000000071bea0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
> R13: 0000000000005c10 R14: 00000000006eecb0 R15: 00007f8cf875c700
> =========================================
> 
> ---
>   drivers/pps/pps.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
> index 8febacb..66002e1 100644
> --- a/drivers/pps/pps.c
> +++ b/drivers/pps/pps.c
> @@ -79,6 +79,8 @@ static int pps_cdev_pps_fetch(struct pps_device
> *pps, struct pps_fdata *fdata)
>                  dev_dbg(pps->dev, "timeout %lld.%09d\n",
>                                  (long long) fdata->timeout.sec,
>                                  fdata->timeout.nsec);
> +               if (fdata->timeout.sec > S64_MAX / HZ)
> +                               return -EINVAL;
>                  ticks = fdata->timeout.sec * HZ;
>                  ticks += fdata->timeout.nsec / (NSEC_PER_SEC / HZ);

It looks good to me. Do you think is better adding a check for timeout.nsec also?

Now you have to produce a patch according to 
linux/Documentation/process/submitting-patches.rst and then submitting it! :-)

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
