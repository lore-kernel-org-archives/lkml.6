Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69E1C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 19:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B09B21473
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 19:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SP4Z1X5M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B09B21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbeIXBzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 21:55:49 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46448 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbeIXBzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 21:55:49 -0400
Received: by mail-pg1-f194.google.com with SMTP id b129-v6so8218605pga.13
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 12:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=kRjQskwB3uZmUrgoKDiMs41KR6JEhgiwnjStvOy/g5Y=;
        b=SP4Z1X5M2bHrMWe4E0I9+plcpx0EWtDSANfHBl3dXoITqLyTfqab7YYEdaLM8piHPG
         J1mj1YG/Gbwf7M5aWRKW7BXMDoXaa51egyMEEsNX4Z++R0RhosdEe8jwEBseHPzcquRH
         v9iZk52sxhUevVLBH66r/8Y4xTsWkvkURZta15vr85vRIBEB3/J1oDfIskyU8DyuWXPn
         D1z5LjtuxdYMd4U+HBcLyPC7ulvfBs/lcM55xT73iy0OAvQgGu+Ebg3+TRqg8pq9UsX7
         QGOGxEBoQWOlBsr6KrHAir+GXqFi/kgWPkS5Z4/lU81AYHqtUrIVf/5O7iZEQV8Df2pM
         PqTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=kRjQskwB3uZmUrgoKDiMs41KR6JEhgiwnjStvOy/g5Y=;
        b=sEoziJKSiyW2S907EmdTbRLtk0p/61JHFbDTLCKhjBDt1qXghAW70XROaT8TmSE3LM
         KtJrx6lHoMT/ltjMOsckE80/Lto5UWmEdl8wpedBmzIi9JfRqb1lpkJHmMo2Qo9Et2VB
         5K1s4d7CDP8Vf6teLBOE4Kl3wMNQPzU4qX/omVTL9I3Qjnkyvoslv4s85k3ak4aRLd6h
         nKeY/KtDA/sqvaVde7T0SwkYF1Hw4FRZvIzA+fOoMg4+hnzbX4m15EIA12Z+BUlCHlEa
         oFhX5RNHsHlJL4kJr0jRybiwCi8Qg95lqxL5IizKkaOI5ylgNn8M3/unFTMSjiV4Dkf5
         4QXQ==
X-Gm-Message-State: ABuFfojjifOpb3b4lkikYXgiLMC8AfO5xPw4Ndau65jWxlJQKYU2Zwen
        8rYP+PVkTbqsi5KFWoLPbuY=
X-Google-Smtp-Source: ACcGV62ulnrGqJxFE/G3bDgd5gUfqCUSSw9PUskUf/NKPdHTRxDT/HXwwPHq7kwkvEV+ohgKBsIqbA==
X-Received: by 2002:a63:d256:: with SMTP id t22-v6mr6661588pgi.335.1537732629165;
        Sun, 23 Sep 2018 12:57:09 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id j15-v6sm39880653pfn.52.2018.09.23.12.57.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Sep 2018 12:57:08 -0700 (PDT)
Date:   Sun, 23 Sep 2018 12:57:06 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Traceback in ww_mutex test (test_cycle_work) on arm64/x86_64
Message-ID: <20180923195706.GA1538@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

when enabling CONFIG_WW_MUTEX_SELFTEST on arm64 or x86_64,
I get the following traceback.

[    3.111852] ------------[ cut here ]------------
[    3.112100] DEBUG_LOCKS_WARN_ON(__owner_task(owner) != current)
[    3.112753] WARNING: CPU: 1 PID: 771 at kernel/locking/mutex.c:1211 __mutex_unlock_slowpath+0x1a8/0x2e0
[    3.113238] Modules linked in:
[    3.113774] CPU: 1 PID: 771 Comm: kworker/u16:8 Not tainted 4.19.0-rc5-dirty #1
[    3.114025] Hardware name: linux,dummy-virt (DT)
[    3.114587] Workqueue: test-ww_mutex test_cycle_work
[    3.114950] pstate: 40000005 (nZcv daif -PAN -UAO)
[    3.115144] pc : __mutex_unlock_slowpath+0x1a8/0x2e0
[    3.115327] lr : __mutex_unlock_slowpath+0x1a8/0x2e0
[    3.115500] sp : ffff00000b7cbc40
[    3.115647] x29: ffff00000b7cbc40 x28: 0000000000000000 
[    3.115921] x27: ffff00000942f000 x26: ffff00000a204da0 
[    3.116155] x25: ffff00000a1c93d0 x24: ffff000009103cd8 
[    3.116376] x23: ffff00000a1c9000 x22: ffff00000942f000 
[    3.116596] x21: ffff00000b7cbca8 x20: ffff80001c05f8c8 
[    3.116817] x19: 0000000000000000 x18: ffffffffffffffff 
[    3.117036] x17: 0000000000000000 x16: 0000000000000000 
[    3.117256] x15: ffff00000942f808 x14: ffff00008a1c8bb7 
[    3.117476] x13: ffff00000a1c8bc5 x12: ffff00000944f000 
[    3.117695] x11: 0000000005f5e0ff x10: ffff0000094b3000 
[    3.117947] x9 : 0000000000000000 x8 : ffff00000942f808 
[    3.118172] x7 : ffff00000816153c x6 : 0000000000000000 
[    3.118392] x5 : 0000000000000000 x4 : ffff00000b7cc000 
[    3.118612] x3 : 6172e063a21fe200 x2 : ffff00000944fd80 
[    3.118830] x1 : 6172e063a21fe200 x0 : 0000000000000000 
[    3.119169] Call trace:
[    3.119348]  __mutex_unlock_slowpath+0x1a8/0x2e0
[    3.119540]  ww_mutex_unlock+0x48/0xa0
[    3.119709]  test_cycle_work+0x10c/0x220
[    3.119864]  process_one_work+0x29c/0x708
[    3.120016]  worker_thread+0x40/0x458
[    3.120179]  kthread+0x12c/0x130
[    3.120317]  ret_from_fork+0x10/0x18

Debugging shows that the traceback occurs in the following code
in test_cycle_work().

+       err = ww_mutex_lock(cycle->b_mutex, &ctx);
+       if (err == -EDEADLK) {
				# true
+               ww_mutex_unlock(&cycle->a_mutex);
+               ww_mutex_lock_slow(cycle->b_mutex, &ctx);
+               err = ww_mutex_lock(&cycle->a_mutex, &ctx);
				# returns with err == -EDEADLK
+       }
+
+       if (!err)
+               ww_mutex_unlock(cycle->b_mutex);
+       ww_mutex_unlock(&cycle->a_mutex);
				# traceback seen here:
				# unlocks a_mutex even though it was not
				# acquired by this thread

The problem is quite easy to reproduce with the following qemu command.

qemu-system-aarch64 -M virt -cpu cortex-a57 -nographic -monitor none \
	-kernel arch/arm64/boot/Image -no-reboot -smp 8 -m 512
	-device virtio-blk-pci,drive=d0 \
	-drive file=rootfs.ext2,if=none,id=d0,format=raw \
	-append 'console=ttyAMA0 root=/dev/vda rw'

or:

qemu-system-x86_64 \
	-kernel arch/x86/boot/bzImage \
	-M q35 \
	-cpu Skylake-Server \
	-no-reboot -smp 8 -m 1G \
	-usb -device usb-storage,drive=d0 \
	-drive file=rootfs.ext2,if=none,id=d0,format=raw \
	--append 'root=/dev/sda rw rootwait console=ttyS0 console=tty' \
	-nographic

Details don't really matter as long as the number of CPUs is at least 8
(I have not seen the problem with 1, 2, 4, or 6 CPUs). My test system
has 8 CPU cores (times 2 for hyperthreading), so that may be related.

The test case above is clearly wrong if both calls to ww_mutex_lock()
fail with -EDEADLK. Unfortunately I don't know the expected behavior
in this case, so I'll have to pass this on without a proposed fix.

Please let me know if there is anything I can do to help fixing
the problem.

Thanks,
Guenter
