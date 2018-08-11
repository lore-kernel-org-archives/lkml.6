Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B47C46460
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 21:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7272C2148E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 21:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elE7Q2mn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7272C2148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbeHKX7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 19:59:11 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:45333 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbeHKX7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 19:59:11 -0400
Received: by mail-oi0-f67.google.com with SMTP id q11-v6so21404371oic.12;
        Sat, 11 Aug 2018 14:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=OXOMafStcMg3YIVhEQQh+XnIWqf2q9RBfZ7CntuzRcM=;
        b=elE7Q2mn5VxYhFy8TD0+q6kFMHeYh7dHaBCIHlczmZ4eDlX3vhEueO8pe4bm8X1mC2
         svDImgh1TGhQSSgdmv+inEcqnU13dsjfY4nbZp9MQBsCSxCJULJD8FV4ts1ssZeio6fN
         uyhnrKymYUWr9voosTbNlGU+hQfShl4DkGbD+pX+9Tp4eVvwMNil0PUakxm9W+DNJUHb
         TFWGYvAummVa/JL6+SameEXwbDe8hFCEd+RNpI6LRul3sk0LWIKh3KxymvnAx23YCizJ
         AAyChx8rsRxeBbrzIgavUUNrOQGuDfs9RemaPVGhb0Z+TE4K5cHWTA3Jg/jdX/n51HJa
         ymSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:cc:from:subject:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=OXOMafStcMg3YIVhEQQh+XnIWqf2q9RBfZ7CntuzRcM=;
        b=tp2qNR98r/oKNaWIjBnocPaT4oPHCccbjwlWizEI6nOMbKpDm0NofHnZOh61pb6Qr+
         gfbivECXgxfPNpRN26hHsck7qVLpJTlFNfHtypNK+pIUEVpk5dGO7k/Quz0/efYy6w+S
         OQ2t9VEAabmnGffut15gO3nMzbct7GHIadChVIRYjkeeqtz0RdSgvOQNKnjQuq3SzdTx
         aNqpBPvLZLQ5IZkfzr3mlNhF9KvO/xDXwz5g+KDcXVp63OvyRv3Ne3vdOkeXWv/WsZIy
         bAM3h9lyZLFjh5OfBIu2wlBxxLnIesEANs0AHNNp9gCqm5mh0npW9rJwxujfc8SKcvdr
         juCw==
X-Gm-Message-State: AOUpUlFIcdMcjk8/uz9BmV+Un2f/yjeTcbofgYV5xPomgPPmZ336NFPh
        mBMIx7OE3mMOCGhy/4jmIL5neEll
X-Google-Smtp-Source: AA+uWPwTlwih9RQ0cZbtB99EU0feql68UGVgGHePcC+Wjins49rfzBJIYG0fUty6tl3IoBqxinNt0A==
X-Received: by 2002:aca:c00b:: with SMTP id q11-v6mr3686346oif.330.1534022621471;
        Sat, 11 Aug 2018 14:23:41 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id e204-v6sm23756020oif.21.2018.08.11.14.23.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Aug 2018 14:23:40 -0700 (PDT)
To:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86 <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: next-20180810: Traceback observed at at arch/x86/mm/pageattr.c:1211
 __cpa_process_fault
Message-ID: <18c3e11c-10a3-e404-3ca7-3bf1ef8cb96b@roeck-us.net>
Date:   Sat, 11 Aug 2018 14:23:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I noticed the following spurious traceback in next-20180810 when booting an i386 image in qemu.

[    0.000000] ------------[ cut here ]------------
[    0.000000] CPA: called for zero pte. vaddr = cffe0000 cpa->vaddr = cffe0000
[    0.000000] WARNING: CPU: 0 PID: 0 at arch/x86/mm/pageattr.c:1211 __cpa_process_fault+0x327/0x350
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.18.0-rc8-next-20180810 #1
[    0.000000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.11.1-0-g0551a4be2c-prebuilt.qemu-project.org 04/01/2014
[    0.000000] EIP: __cpa_process_fault+0x327/0x350
[    0.000000] Code: 10 c1 e0 0c 03 45 e0 89 45 f0 8b 45 d0 85 c0 75 28 8b 75 d4 e9 12 ff ff ff 8b 07 ff 30 ff 75 e0 68 c0 fc a7 cf e8 99 a1 00 00 <0f> 0b bb f2 ff ff ff 83 c4 0c e9 1c fe ff ff 8b 45 e0 8d b0 00 00
[    0.000000] EAX: 00000040 EBX: 0000ffdf ECX: cfba6a3c EDX: cfba6a3c
[    0.000000] ESI: cffe0000 EDI: cfb81f20 EBP: cfb81e6c ESP: cfb81e30
[    0.000000] DS: 007b ES: 007b FS: 0000 GS: 00e0 SS: 0068 EFLAGS: 00200096
[    0.000000] CR0: 80050033 CR2: ffda3000 CR3: 0fd10000 CR4: 00000690
[    0.000000] Call Trace:
[    0.000000]  __change_page_attr_set_clr+0x2e3/0x790
[    0.000000]  ? serial_putc+0x26/0x40
[    0.000000]  ? uart_console_write+0x48/0x60
[    0.000000]  ? 0xcf000000
[    0.000000]  ? 0xcf000000
[    0.000000]  ? 0xcf000000
[    0.000000]  change_page_attr_set_clr+0x109/0x3a0
[    0.000000]  set_memory_nonglobal+0x1e/0x20
[    0.000000]  pti_init+0xc7/0xdd
[    0.000000]  start_kernel+0x1ca/0x3c0
[    0.000000]  i386_start_kernel+0x94/0x98
[    0.000000]  startup_32_smp+0x164/0x168
[    0.000000] ---[ end trace 638bf57ca2d37b0e ]---

I have seen this only once; I did not see it when repeating the test.

Qemu command line:

qemu-system-i386 -kernel arch/x86/boot/bzImage -M pc -cpu Conroe \
	-no-reboot -m 256 -drive file=rootfs.ext2,if=ide,format=raw \
	--append 'earlycon=uart8250,io,0x3f8,9600n8 root=/dev/sda rw mem=256M vga=0 uvesafb.mode_option=640x480-32 oprofile.timer=1 console=ttyS0 console=tty'
	-nographic

Configuration is i386:defconfig+CONFIG_SMP=n.

Guenter
