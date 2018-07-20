Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1373ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99BF620850
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=katalix.com header.i=@katalix.com header.b="1OZC7FYj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99BF620850
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbeGTItA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 04:49:00 -0400
Received: from mail.katalix.com ([82.103.140.233]:36413 "EHLO mail.katalix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727103AbeGTItA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 04:49:00 -0400
X-Greylist: delayed 532 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Jul 2018 04:48:58 EDT
Received: from [192.168.1.16] (82-69-108-24.dsl.in-addr.zen.co.uk [82.69.108.24])
        (Authenticated sender: james)
        by mail.katalix.com (Postfix) with ESMTPSA id C914A9DC2F;
        Fri, 20 Jul 2018 08:53:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
        t=1532073185; bh=5VnArpkgq9zAnQPIFWmvJcFdetS4OpzBPe9O8euv4v0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=1OZC7FYjeOwoiDRRDe/+wXfSC8cUIDEPRA7MQepOifotPATVLslv4SPGkEhPCu/ut
         mBoBAcjJMY7IdapK/6mVooRlJXw6n+rWEV5AtRU6bQA+4q6I2ZF6FIPY2F1WULTVpO
         A5CgZlxUeT0Gs2ijFIH+9BAr5z11LmNZcGunPYkw=
Subject: Re: KASAN: use-after-free Read in l2tp_session_create
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     David Miller <davem@davemloft.net>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        g.nault@alphalink.fr, Hans Liljestrand <ishkamiel@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Greg Hackmann <ghackmann@google.com>,
        syzbot <syzbot+065d0fc357520c8f6039@syzkaller.appspotmail.com>,
        Guillaume Nault <g.nault@alphalink.fr>
References: <001a11405130a984300562e8e7b3@google.com>
 <CACT4Y+Y1ZskrqsmhWoHWXOigMHX5eyG5nGGyuU6cZ0uNnChSiQ@mail.gmail.com>
From:   James Chapman <jchapman@katalix.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jchapman@katalix.com; prefer-encrypt=mutual; keydata=
 xsBNBFDmvq0BCACizu6XvQjeWZ1Mnal/oG9AkCs5Rl3GULpnH0mLvPZhU7oKbgx5MHaFDKVJ
 rQTbNEchbLDN6e5+UD98qa4ebvNx1ZkoOoNxxiuMQGWaLojDKBc9x+baW1CPtX55ikq2LwGr
 0glmtUF6Aolpw6GzDrzZEqH+Nb+L3hNTLBfVP+D1scd4R7w2Nw+BSQXPQYjnOEBDDq4fSWoI
 Cm2E18s3bOHDT9a4ZuB9xLS8ZuYGW6p2SMPFHQb09G82yidgxRIbKsJuOdRTIrQD/Z3mEuT/
 3iZsUFEcUN0T/YBN3a3i0P1uIad7XfdHy95oJTAMyrxnJlnAX3F7YGs80rnrKBLZ8rFfABEB
 AAHNJEphbWVzIENoYXBtYW4gPGpjaGFwbWFuQGthdGFsaXguY29tPsLAeAQTAQIAIgUCUOa+
 rQIbIwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQINzVgFp/OkBr2gf7BA4jmtvUOGOO
 JFsj1fDmbAzyE6Q79H6qnkgYm7QNEw7o+5r7EjaUwsh0w13lNtKNS8g7ZWkiBmSOguJueKph
 GCdyY/KOHZ7NoJw39dTGVZrvJmyLDn/CQN0saRSJZXWtV31ccjfpJGQEn9Gb0Xci0KjrlH1A
 cqxzjwTmBUr4S2EHIzCcini1KTtjbtsE+dKP4zqR/T52SXVoYvqMmJOhUhXh62C0mu8FoDM0
 iFDEy4B0LcGAJt6zXy+YCqz7dOwhZBB4QX4F1N2BLF3Yd1pv8wBBZE7w70ds7rD7pnIaxXEK
 D6yCGrsZrdqAJfAgYL1lqkNffZ6uOSQPFOPod9UiZM7ATQRQ5r6tAQgAyROh3s0PyPx2L2Fb
 jC1mMi4cZSCpeX3zM9aM4aU8P16EDfzBgGv/Sme3JcrYSzIAJqxCvKpR+HoKhPk34HUR/AOk
 16pP3lU0rt6lKel2spD1gpMuCWjAaFs+dPyUAw13py4Y5Ej2ww38iKujHyT586U6skk9xixK
 1aHmGJx7IqqRXHgjb6ikUlx4PJdAUn2duqasQ8axjykIVK5xGwXnva/pnVprPSIKrydNmXUq
 BIDtFQ4Qz1PQVvK93KeCVQpxxisYNFRQ5TL6PtgVtK8uunABFdsRqlsw1Ob0+mD5fidITCIJ
 mYOL8K74RYU4LfhspS4JwT8nmKuJmJVZ5DjY2wARAQABwsBfBBgBAgAJBQJQ5r6tAhsMAAoJ
 ECDc1YBafzpA9CEH/jJ8Ye73Vgm38iMsxNYJ9Do9JvVJzq7TEduqWzAFew8Ft0F9tZAiY0J3
 U2i4vlVWK8Kbnh+44VAKXYzaddLXAxOcZ8YYy+sVfeVoJs3lAH+SuRwt0EplHWvCK5AkUhUN
 jjIvsQoNBVUP3AcswIqNOrtSkbuUkevNMyPtd0GLS9HVOW0e+7nFce7Ow9ahKA3iGg5Re9rD
 UlDluVylCCNnUD8Wxgve4K+thRL9T7kxkr7aX7WJ7A4a8ky+r3Daf7OhGN9S/Z/GMSs0E+1P
 Qm7kZ2e0J6PSfzy9xDtoRXRNigtN2o8DHf/quwckT5T6Z6WiKEaIKdgaXZVhphENThl7lp8=
Organization: Katalix Systems Ltd
Message-ID: <5308835b-b5ef-51e4-2e4f-05a9636dff55@katalix.com>
Date:   Fri, 20 Jul 2018 08:53:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+Y1ZskrqsmhWoHWXOigMHX5eyG5nGGyuU6cZ0uNnChSiQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/18 12:00, Dmitry Vyukov wrote:
> On Tue, Jan 16, 2018 at 7:29 PM, syzbot
> <syzbot+065d0fc357520c8f6039@syzkaller.appspotmail.com> wrote:
>> Hello,
>>
>> syzkaller hit the following crash on
>> a8750ddca918032d6349adbf9a4b6555e7db20da
>> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/maste=
r
>> compiler: gcc (GCC) 7.1.1 20170620
>> .config is attached
>> Raw console output is attached.
>> Unfortunately, I don't have any reproducer for this bug yet.
>>
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the com=
mit:
>> Reported-by: syzbot+065d0fc357520c8f6039@syzkaller.appspotmail.com
>> It will help syzbot understand when the bug is fixed. See footer for
>> details.
>> If you forward the report, please keep this part and the footer.
>
> James,
>
> Did you fix this? You asked syzbot to test a fix for this bug some time=
 ago.
> If yes, did you include the Reported-by tag in the commit? This bug is
> still considered open by syzbot. But it stopped happening ~4 months
> ago:

Yes, I think this has been fixed now. I think it was fixed by
Guillaume's 6b9f34239b00e6956a267abed2bc559ede556ad6 that was actually
to fix another syzbot bug fbeeb5c3b538e8545644 which looks similar to
this one.

> https://syzkaller.appspot.com/bug?id=3D6fed0854381422329e78d7e16fb9cf4a=
f8c9aef1
> We are also seeing these crashes in 4.4 and 4.9, it would be good to
> backport the fix.

It looks like 6b9f34239b00e6956a267abed2bc559ede556ad6 hasn't made it to
4.9 or 4.4.


>
> Thanks
>
>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> BUG: KASAN: use-after-free in l2tp_session_create+0xa6d/0xc60
>> net/l2tp/l2tp_core.c:1757
>> Read of size 4 at addr ffff8801d80ad868 by task syz-executor3/5462
>>
>> CPU: 0 PID: 5462 Comm: syz-executor3 Not tainted 4.15.0-rc8+ #263
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIO=
S
>> Google 01/01/2011
>> Call Trace:
>>  __dump_stack lib/dump_stack.c:17 [inline]
>>  dump_stack+0x194/0x257 lib/dump_stack.c:53
>>  print_address_description+0x73/0x250 mm/kasan/report.c:252
>>  kasan_report_error mm/kasan/report.c:351 [inline]
>>  kasan_report+0x25b/0x340 mm/kasan/report.c:409
>>  __asan_report_load4_noabort+0x14/0x20 mm/kasan/report.c:429
>>  l2tp_session_create+0xa6d/0xc60 net/l2tp/l2tp_core.c:1757
>>  pppol2tp_connect+0xed7/0x1dd0 net/l2tp/l2tp_ppp.c:748
>>  SYSC_connect+0x213/0x4a0 net/socket.c:1621
>>  SyS_connect+0x24/0x30 net/socket.c:1602
>>  entry_SYSCALL_64_fastpath+0x29/0xa0
>> RIP: 0033:0x452df9
>> RSP: 002b:00007f93ec47fc58 EFLAGS: 00000212 ORIG_RAX: 000000000000002a=

>> RAX: ffffffffffffffda RBX: 000000000071bea0 RCX: 0000000000452df9
>> RDX: 000000000000002e RSI: 00000000205fafd2 RDI: 0000000000000018
>> RBP: 00000000000005a9 R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000212 R12: 00000000006f6878
>> R13: 00000000ffffffff R14: 00007f93ec4806d4 R15: 0000000000000000
>>
>> Allocated by task 5462:
>>  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
>>  set_track mm/kasan/kasan.c:459 [inline]
>>  kasan_kmalloc+0xad/0xe0 mm/kasan/kasan.c:551
>>  kmem_cache_alloc_trace+0x136/0x750 mm/slab.c:3610
>>  kmalloc include/linux/slab.h:499 [inline]
>>  kzalloc include/linux/slab.h:688 [inline]
>>  l2tp_tunnel_create+0x5e1/0x17f0 net/l2tp/l2tp_core.c:1554
>>  pppol2tp_connect+0x14b7/0x1dd0 net/l2tp/l2tp_ppp.c:707
>>  SYSC_connect+0x213/0x4a0 net/socket.c:1621
>>  SyS_connect+0x24/0x30 net/socket.c:1602
>>  entry_SYSCALL_64_fastpath+0x29/0xa0
>>
>> Freed by task 5484:
>>  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
>>  set_track mm/kasan/kasan.c:459 [inline]
>>  kasan_slab_free+0x71/0xc0 mm/kasan/kasan.c:524
>>  __cache_free mm/slab.c:3488 [inline]
>>  kfree+0xd6/0x260 mm/slab.c:3803
>>  __rcu_reclaim kernel/rcu/rcu.h:190 [inline]
>>  rcu_do_batch kernel/rcu/tree.c:2758 [inline]
>>  invoke_rcu_callbacks kernel/rcu/tree.c:3012 [inline]
>>  __rcu_process_callbacks kernel/rcu/tree.c:2979 [inline]
>>  rcu_process_callbacks+0xe94/0x17f0 kernel/rcu/tree.c:2996
>>  __do_softirq+0x2d7/0xb85 kernel/softirq.c:285
>>
>> The buggy address belongs to the object at ffff8801d80ad780
>>  which belongs to the cache kmalloc-512 of size 512
>> The buggy address is located 232 bytes inside of
>>  512-byte region [ffff8801d80ad780, ffff8801d80ad980)
>> The buggy address belongs to the page:
>> page:ffffea0007602b40 count:1 mapcount:0 mapping:ffff8801d80ad000 inde=
x:0x0
>> flags: 0x2fffc0000000100(slab)
>> raw: 02fffc0000000100 ffff8801d80ad000 0000000000000000 00000001000000=
06
>> raw: ffffea00070e8760 ffffea00070f8ca0 ffff8801dac00940 00000000000000=
00
>> page dumped because: kasan: bad access detected
>>
>> Memory state around the buggy address:
>>  ffff8801d80ad700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>>  ffff8801d80ad780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>> ffff8801d80ad800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>                                                           ^
>>  ffff8801d80ad880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>  ffff8801d80ad900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>>
>> ---
>> This bug is generated by a dumb bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for details.
>> Direct all questions to syzkaller@googlegroups.com.
>>
>> syzbot will keep track of this bug report.
>> If you forgot to add the Reported-by tag, once the fix for this bug is=

>> merged
>> into any tree, please reply to this email with:
>> #syz fix: exact-commit-title
>> To mark this as a duplicate of another syzbot report, please reply wit=
h:
>> #syz dup: exact-subject-of-another-report
>> If it's a one-off invalid bug report, please reply with:
>> #syz invalid
>> Note: if the crash happens again, it will cause creation of a new bug
>> report.
>> Note: all commands must start from beginning of the line in the email =
body.
>>
>> --
>> You received this message because you are subscribed to the Google Gro=
ups
>> "syzkaller-bugs" group.
>> To unsubscribe from this group and stop receiving emails from it, send=
 an
>> email to syzkaller-bugs+unsubscribe@googlegroups.com.
>> To view this discussion on the web visit
>> https://groups.google.com/d/msgid/syzkaller-bugs/001a11405130a98430056=
2e8e7b3%40google.com.
>> For more options, visit https://groups.google.com/d/optout.


