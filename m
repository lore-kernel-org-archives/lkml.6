Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A048BC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6322C208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:36:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6322C208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754666AbeFTIgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:36:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47298 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752792AbeFTIgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:36:02 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EDFEB307D858;
        Wed, 20 Jun 2018 07:17:33 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D7E6060F80;
        Wed, 20 Jun 2018 07:17:33 +0000 (UTC)
Received: from zmail17.collab.prod.int.phx2.redhat.com (zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id B99144BB78;
        Wed, 20 Jun 2018 07:17:33 +0000 (UTC)
Date:   Wed, 20 Jun 2018 03:17:33 -0400 (EDT)
From:   Jan Stancek <jstancek@redhat.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     ltp@lists.linux.it, open list <linux-kernel@vger.kernel.org>,
        mmoese@suse.de, Rafael Tinoco <rafael.tinoco@linaro.org>,
        ebiggers@google.com, dave hansen <dave.hansen@linux.intel.com>
Message-ID: <288130293.27700033.1529479053494.JavaMail.zimbra@redhat.com>
In-Reply-To: <CA+G9fYsRgGsmi-tE8dU=pfSDDLg3bUuii_0KUPZ71jFLNre-5g@mail.gmail.com>
References: <CA+G9fYsRgGsmi-tE8dU=pfSDDLg3bUuii_0KUPZ71jFLNre-5g@mail.gmail.com>
Subject: Re: LTP CVE cve-2017-17053 test failed on x86_64 device
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.17.9, 10.4.195.10]
Thread-Topic: LTP CVE cve-2017-17053 test failed on x86_64 device
Thread-Index: dLjUDIlHx+ZlF1lzceSCtvKG3/l3Uw==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 20 Jun 2018 07:17:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



----- Original Message -----
> LTP CVE cve-2017-17053 test failed on x86_64 device.
> FAIL on linux-next, mainline, and stable-rc-4.17.
> PASS on stable-rc 4.16, 4.14, 4.9 and 4.4 kernel.
> 
> Test FAIL case output,
> tst_test.c:1015: INFO: Timeout per run is 0h 15m 00s
> tst_taint.c:88: BROK: Kernel is already tainted: 512

You seem to be running into some nfs warning early during boot [1][2],
that taints the kernel. cve-2017-17053 test doesn't do much,
it fails in setup because it finds kernel already tainted.

Looks similar to:
  https://www.spinics.net/lists/linux-nfs/msg68064.html

Regards,
Jan

[1]
[   78.886529] ------------[ cut here ]------------
[   78.891155] DEBUG_LOCKS_WARN_ON(sem->owner != ((struct task_struct *)(1UL << 0)))
[   78.891161] WARNING: CPU: 0 PID: 33 at /srv/oe/build/tmp-rpb-glibc/work-shared/intel-core2-32/kernel-source/kernel/locking/rwsem.c:217 up_read_non_owner+0x5d/0x70
[   78.913141] Modules linked in: fuse
[   78.916633] CPU: 0 PID: 33 Comm: kworker/0:1 Not tainted 4.18.0-rc1 #1
[   78.923150] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS 2.0b 07/27/2017
[   78.930623] Workqueue: nfsiod rpc_async_release
[   78.935154] RIP: 0010:up_read_non_owner+0x5d/0x70
[   78.939851] Code: 00 5b 5d c3 e8 54 9f 3a 00 85 c0 74 de 8b 05 ba 40 6a 02 85 c0 75 d4 48 c7 c6 c8 ce 8f 9c 48 c7 c7 93 8e 8e 9c e8 33 6b fa ff <0f> 0b eb bd 0f 1f 44 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 
[   78.958717] RSP: 0018:ffffb46b419ebdd0 EFLAGS: 00010282
[   78.963935] RAX: 0000000000000000 RBX: ffff882d1c390130 RCX: 0000000000000006
[   78.971059] RDX: 0000000000000007 RSI: 0000000000000001 RDI: ffff882d2fc15730
[   78.978184] RBP: ffffb46b419ebdd8 R08: 0000000000000000 R09: 0000000000000000
[   78.985318] R10: ffffb46b419ebdd0 R11: 0000000000000000 R12: ffff882d1ad56800
[   78.985319] R13: ffff882d1d133000 R14: 0000000000000000 R15: ffff882d1f047840
[   78.985319] FS:  0000000000000000(0000) GS:ffff882d2fc00000(0000) knlGS:0000000000000000
[   78.985320] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   78.985321] CR2: 000056385d962ae0 CR3: 0000000021e1e002 CR4: 00000000003606f0
[   78.985321] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   78.985322] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   78.985322] Call Trace:
[[0;32m  OK  [[   78.985327]  nfs_async_unlink_release+0x32/0x80
[   78.985329]  rpc_free_task+0x30/0x50
[   78.985330]  rpc_async_release+0x12/0x20
[   78.985332]  process_one_work+0x278/0x670
0m] [   78.985335]  worker_thread+0x4d/0x410
[   78.985337]  kthread+0x10d/0x140
[   78.985338]  ? rescuer_thread+0x3a0/0x3a0
[   78.985339]  ? kthread_create_worker_on_cpu+0x70/0x70
[   78.985341]  ret_from_fork+0x3a/0x50
[   78.985344] irq event stamp: 36545
[   78.985346] hardirqs last  enabled at (36545): [<ffffffff9c008d5c>] _raw_spin_unlock_irq+0x2c/0x40
[   78.985347] hardirqs last disabled at (36544): [<ffffffff9c008af3>] _raw_spin_lock_irq+0x13/0x50
[   78.985348] softirqs last  enabled at (34878): [<ffffffff9bf0ae50>] reg_todo+0x260/0x2f0
[   78.985350] softirqs last disabled at (34876): [<ffffffff9bf0ad61>] reg_todo+0x171/0x2f0
[   79.111787] ---[ end trace bed1f41cfea3a4c5 ]---

[2] https://lkft.validation.linaro.org/scheduler/job/290429#L893

> Summary:
> passed   0
> failed   0
> skipped  0
> warnings 0
> 
> Test comments,
> /* Regression test for CVE-2017-17053, original reproducer can be found
>  * here:
>  *
>  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ccd5b3235180eef3cfec337df1c8554ab151b5cc
>  *
>  * Be careful! This test may crash your kernel!
>  */
> 
> Full test log:
> https://lkft.validation.linaro.org/scheduler/job/290429#L9581
> https://lkft.validation.linaro.org/scheduler/job/259217#L10308
> 
> History of the test case shows failed on
> Linux next kernel,
> https://qa-reports.linaro.org/lkft/linux-next-oe/tests/ltp-cve-tests/cve-2017-17053
> 
> Linux mainline kernel,
> https://qa-reports.linaro.org/lkft/linux-mainline-oe/tests/ltp-cve-tests \
> /cve-2017-17053
> ^ Please join link
> 
> Linux stable rc 4.17,
> https://qa-reports.linaro.org/lkft/linux-stable-rc-4.17-oe/tests/ltp-cve-tests
> \
> /cve-2017-17053
> ^ Please join link
> 
> Test PASS on 4.16 kernel.
> https://qa-reports.linaro.org/lkft/linux-stable-rc-4.16-oe/tests/ltp-cve-tests
> \
> /cve-2017-17053
> ^ Please join link
> 
> Best regards
> Naresh Kamboju
> 
