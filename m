Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCF6C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6778421480
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dp3HIKfF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6778421480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbeJKWAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 18:00:32 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45694 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728609AbeJKWAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 18:00:31 -0400
Received: by mail-wr1-f65.google.com with SMTP id q5-v6so9948589wrw.12;
        Thu, 11 Oct 2018 07:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KzdJS8qd0TofkD9EiEpBrMcxbu3rxqTjimH7IHwXD9A=;
        b=Dp3HIKfF03p/sr4AagSrfCJS+QSEQkhIcXZwfaaZkb3dOz8RPZT/RGE0r6fcwitsG7
         tRTpzGNdHNWduRptBL4MIc4CnCk5BEbwB1uWpflvstzQOI/WV8bK/gvc7T/HcFFJKOF8
         nsFqy/OWGykTrFFguqK7I3hpqWA+DYlftb367hFLggQDpr3/dxTLnwrBHnmmieY0THl7
         mhwvTQ7qhZXQd86rP68o0dwmh8wB2LjyMIpd0PTcsNsTUmONyFRxPnv2eDcJYqOYZJR2
         DnhGtC2TJo60MWXF7raActmkxzxa3CLbVqkYtl02yAPfYpq2sXjYxnIET4pQuWIflvuS
         2b6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=KzdJS8qd0TofkD9EiEpBrMcxbu3rxqTjimH7IHwXD9A=;
        b=XR/FM2+djxKzDfMemlqYaqRv2roB3xuzLj98Ucdl/lBdHxSDv419RSw8vk1m28B6f3
         4vh8ORwN0XjEV805hkQDnUYNGv1BGqg3DvAcf/Mj1j1GYqB6y3iF9GlntybU+MLbd1TN
         HkZy6MvE2HieeyjPq3gwzIYJoswBBQ4seAFBCnofkzXlcneLzNnunC1ypfGWsf4tsJ1w
         M1aaJCr5Dy/OLK4K04yD8y86zmOQpJm1e4s9SzzRM3xHa+CZsFjb1zuO8XpcZdCd3Odv
         7UIQnNmCktYvhfOcJoPxqPcMSFGcZKAwG7zlASpYbLYEdyQToFFIAkdH1jHKixbO+Irw
         uaTg==
X-Gm-Message-State: ABuFfogbXs5ia3mO8oNnhPyIyOdLewqJoiPUMgCQnTAGWcwjseAoL1H6
        OLoIVYY7MRmtCZfJaKb4MQo=
X-Google-Smtp-Source: ACcGV63wiq/woe0vwdLHRju9TNAxWg54v8QKOgv1KVrMACVtDAFDR3IatnCkf4D0DmnggfsGZsGCKg==
X-Received: by 2002:adf:bc13:: with SMTP id s19-v6mr1931975wrg.255.1539268382790;
        Thu, 11 Oct 2018 07:33:02 -0700 (PDT)
Received: from [10.32.181.140] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.googlemail.com with ESMTPSA id z12-v6sm13994169wrv.46.2018.10.11.07.33.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 07:33:02 -0700 (PDT)
Subject: Re: BUG: unable to handle kernel paging request in
 refcount_inc_not_zero_checked
To:     syzbot <syzbot+e593df3bb8f541d497b9@syzkaller.appspotmail.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rkrcmar@redhat.com, syzkaller-bugs@googlegroups.com
References: <0000000000003752860577db332b@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
Message-ID: <a4200521-b766-1808-2621-75c138f608c2@redhat.com>
Date:   Thu, 11 Oct 2018 16:33:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <0000000000003752860577db332b@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/2018 09:57, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    570b7bdeaf18 Add linux-next specific files for 20181009
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=15f27959400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9b5a60e1381390c4
> dashboard link:
> https://syzkaller.appspot.com/bug?extid=e593df3bb8f541d497b9
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+e593df3bb8f541d497b9@syzkaller.appspotmail.com
> 
> BUG: unable to handle kernel paging request at ffffc90001b356b0
> PGD 1da948067 P4D 1da948067 PUD 1da949067 PMD 1ce844067 PTE 0
> Oops: 0000 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 11542 Comm: syz-executor2 Not tainted
> 4.19.0-rc7-next-20181009+ #90
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> kobject: 'queues' (00000000da0a0759): kobject_uevent_env
> RIP: 0010:__read_once_size include/linux/compiler.h:179 [inline]
> RIP: 0010:arch_atomic_read arch/x86/include/asm/atomic.h:31 [inline]
> RIP: 0010:atomic_read include/asm-generic/atomic-instrumented.h:22 [inline]
> RIP: 0010:refcount_inc_not_zero_checked+0xbb/0x2f0 lib/refcount.c:120
> Code: e7 e8 89 4b 30 fe 4c 89 e0 48 c1 e8 03 0f b6 14 18 4c 89 e0 83 e0
> 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 0b 02 00 00 49 8d 5d c0 <45> 8b 3c
> 24 48 b8 00 00 00 00 00 fc ff df 48 89 da 48 c1 ea 03 0f
> kobject: 'queues' (00000000da0a0759): kobject_uevent_env: filter
> function caused the event to drop!
> RSP: 0018:ffff88017cf9f618 EFLAGS: 00010246
> RAX: 0000000000000003 RBX: ffff88017cf9f690 RCX: ffffffff83929317
> RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffffc90001b356b0
> RBP: ffff88017cf9f6f8 R08: fffff52000366ad7 R09: fffff52000366ad6
> R10: fffff52000366ad6 R11: ffffc90001b356b3 R12: ffffc90001b356b0
> R13: ffff88017cf9f6d0 R14: ffffffff892b6d60 R15: ffff8801d4803400
> FS:  00007fb683cfa700(0000) GS:ffff8801daf00000(0000)
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> kobject: 'loop1' (00000000bc5d5992): kobject_uevent_env
> CR2: ffffc90001b356b0 CR3: 00000001d2369000 CR4: 00000000001426e0
> netlink: 72 bytes leftover after parsing attributes in process
> `syz-executor3'.
> Call Trace:
>  refcount_inc_checked+0x15/0x70 lib/refcount.c:153
> kobject: 'loop1' (00000000bc5d5992): fill_kobj_path: path =
> '/devices/virtual/block/loop1'
>  kvm_get_kvm arch/x86/kvm/../../../virt/kvm/kvm_main.c:765 [inline]
>  kvm_ioctl_create_device arch/x86/kvm/../../../virt/kvm/kvm_main.c:2923
> [inline]
>  kvm_vm_ioctl+0xedf/0x1d60 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3113
>  vfs_ioctl fs/ioctl.c:46 [inline]
>  file_ioctl fs/ioctl.c:501 [inline]
>  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
>  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
>  __do_sys_ioctl fs/ioctl.c:709 [inline]
>  __se_sys_ioctl fs/ioctl.c:707 [inline]
>  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x457579
> Code: 1d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89
> f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
> f0 ff ff 0f 83 eb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007fb683cf9c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457579
> RDX: 00000000200002c0 RSI: 00000000c00caee0 RDI: 0000000000000008
> RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007fb683cfa6d4
> R13: 00000000004bfbd1 R14: 00000000004cfc58 R15: 00000000ffffffff
> Modules linked in:
> CR2: ffffc90001b356b0
> ---[ end trace 6ee8acb8091e879f ]---
> RIP: 0010:__read_once_size include/linux/compiler.h:179 [inline]
> RIP: 0010:arch_atomic_read arch/x86/include/asm/atomic.h:31 [inline]
> RIP: 0010:atomic_read include/asm-generic/atomic-instrumented.h:22 [inline]
> RIP: 0010:refcount_inc_not_zero_checked+0xbb/0x2f0 lib/refcount.c:120
> Code: e7 e8 89 4b 30 fe 4c 89 e0 48 c1 e8 03 0f b6 14 18 4c 89 e0 83 e0
> 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 0b 02 00 00 49 8d 5d c0 <45> 8b 3c
> 24 48 b8 00 00 00 00 00 fc ff df 48 89 da 48 c1 ea 03 0f
> RSP: 0018:ffff88017cf9f618 EFLAGS: 00010246
> RAX: 0000000000000003 RBX: ffff88017cf9f690 RCX: ffffffff83929317
> RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffffc90001b356b0
> RBP: ffff88017cf9f6f8 R08: fffff52000366ad7 R09: fffff52000366ad6
> R10: fffff52000366ad6 R11: ffffc90001b356b3 R12: ffffc90001b356b0
> R13: ffff88017cf9f6d0 R14: ffffffff892b6d60 R15: ffff8801d4803400
> FS:  00007fb683cfa700(0000) GS:ffff8801daf00000(0000)
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffc90001b356b0 CR3: 00000001d2369000 CR4: 00000000001426e0
> 
> 
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
> syzbot.
> 

#syz dup: WARNING: refcount bug in kvm_vm_ioctl
