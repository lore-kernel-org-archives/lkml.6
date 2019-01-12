Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19902C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 21:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F9322086C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 21:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="thK7fyi4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfALVbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 16:31:53 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:16537 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfALVbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 16:31:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1547328711;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=IIuWuBnpby15qzYk6DAfxFgsMwgnG/3nS9KOqgcuHpw=;
        b=thK7fyi4BvlPrmgs3hFxrXdBsvirfL2r117kD7/t0mh50pALheZsq0buGjXD0xoKFD
        nF96YoV+A5TLCgirFoGN5GvikO5qUam5q4q16qVGTZRMd0QEKvKxwYKyqZ8tAOq9omv7
        cEx1ka6+GcbL2d7leN04f1x4AuqxXcPlQ3wAkW9kmGMIWeSU0sPdEBT7jnE1xlCmzt0f
        ar4hryygbH5FWbsQNWyt8UXVj43iLPWMwC+YbaQhZJ2yRBMPrOmsirFXDNtNWweaDpsO
        hPd9d9r1mXlvsoqq6nEOuVQr9Fz6RgohVPJvsGo/vs5Xkxxbznmth4YGA3QK90r2OeJp
        ZkbQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1onTMal6I4rhexKszvVI="
X-RZG-CLASS-ID: mo00
Received: from [192.168.1.200]
        by smtp.strato.de (RZmta 44.9 DYNA|AUTH)
        with ESMTPSA id j01e49v0CLPkX0j
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sat, 12 Jan 2019 22:25:46 +0100 (CET)
Subject: Re: UBSAN: Undefined behaviour in net/can/bcm.c
To:     Kyungtae Kim <kt0755@gmail.com>
Cc:     davem@davemloft.net, Arnd Bergmann <arnd@arndb.de>,
        mkl@pengutronix.de, Byoungyoung Lee <lifeasageek@gmail.com>,
        DaeRyong Jeong <threeearcat@gmail.com>,
        syzkaller@googlegroups.com, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAEAjamvf8LzpRauFhxeh-EGY_ttqeds6_UQwikc5sm7ORKdjjw@mail.gmail.com>
 <c3a95ad5-5eae-6392-f263-9f05e7f51333@hartkopp.net>
 <CAEAjamsw9uu-VwHtREqetCsQBrF4B_Hy87xxsZRhAbHUOvzF4w@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <7436eb01-c022-aadc-0d53-b23515ea42aa@hartkopp.net>
Date:   Sat, 12 Jan 2019 22:25:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <CAEAjamsw9uu-VwHtREqetCsQBrF4B_Hy87xxsZRhAbHUOvzF4w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/12/19 10:03 PM, Kyungtae Kim wrote:
> On Sat, Jan 12, 2019 at 3:02 PM Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>>
>> So there could potentially be some other users of timeval_to_ktime()
>> that might have the same issue.
>>
> 
> The following would be the one related.

Yes - it is also in bcm_rx_setup(). Same issue can potentially occur in 
bcm_tx_setup().

Will send a patch for testing in a minute.

Many thanks,
Oliver

> 
> =========================================
> UBSAN: Undefined behaviour in ./include/linux/ktime.h:42:14
> signed integer overflow:
> -3428892174463270912 * 1000000000 cannot be represented in type 'long int'
> CPU: 0 PID: 7024 Comm: syz-executor6 Not tainted 4.19.13 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0xd2/0x148 lib/dump_stack.c:113
>   ubsan_epilogue+0x12/0x94 lib/ubsan.c:159
>   handle_overflow+0x1cf/0x21a lib/ubsan.c:190
>   __ubsan_handle_mul_overflow+0x2a/0x35 lib/ubsan.c:214
>   bcm_timeval_to_ktime include/linux/ktime.h:42 [inline]
>   bcm_rx_setup net/can/bcm.c:1189 [inline]
>   bcm_sendmsg+0x35ea/0x3fd0 net/can/bcm.c:1355
>   sock_sendmsg_nosec net/socket.c:621 [inline]
>   sock_sendmsg+0xdd/0x130 net/socket.c:631
>   sock_write_iter+0x24b/0x3d0 net/socket.c:900
>   call_write_iter include/linux/fs.h:1811 [inline]
>   new_sync_write fs/read_write.c:474 [inline]
>   __vfs_write+0x538/0x6e0 fs/read_write.c:487
>   vfs_write+0x1b3/0x520 fs/read_write.c:549
>   ksys_write+0xde/0x1c0 fs/read_write.c:598
>   __do_sys_write fs/read_write.c:610 [inline]
>   __se_sys_write fs/read_write.c:607 [inline]
>   __x64_sys_write+0x7e/0xc0 fs/read_write.c:607
>   do_syscall_64+0xc4/0x510 arch/x86/entry/common.c:290
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x4497b9
> Code: e8 8c 9f 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48
> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> 01 f0 ff ff 0f 83 9b 6b fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007f6045f43c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00007f6045f446cc RCX: 00000000004497b9
> RDX: 0000000000000048 RSI: 00000000200000c0 RDI: 0000000000000013
> RBP: 000000000071bea0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
> R13: 000000000000ba60 R14: 00000000006f4b00 R15: 00007f6045f44700
> =========================================
> 
> Thanks,
> Kyungtae Kim
> 
