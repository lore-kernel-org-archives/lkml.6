Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1094CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 00:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C254721582
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 00:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="C4lxMJ8y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C254721582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731174AbeKNK3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 05:29:43 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37983 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbeKNK3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 05:29:42 -0500
Received: by mail-qk1-f193.google.com with SMTP id d19so22919619qkg.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 16:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:subject:to:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0RNTxFjbQq58Op+ya8W9qcu0R86lvryq/TnFHS4tY7E=;
        b=C4lxMJ8ydy3oql27mAPgcGJFcchQJAiScanW6xPio00ns1HXKqa5IRW4uJRPAhGGKc
         qXEE9p++BJt5/LTDBksedxdn91yGgJM+f2Ehyy+QZEewobMQCUJKiOpimg1wB8KgIUjs
         CRCtM6oYM3K4r/GYxttZ4LRH9JSqAy6CAXPxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0RNTxFjbQq58Op+ya8W9qcu0R86lvryq/TnFHS4tY7E=;
        b=qaefdIACDkM6sEUzPKFEX0G7eYjEIErOtySgguzc9eEYEI6LIf/IUwD0frQPFlH82F
         OOFNYXaGcAocLYGnLH1m/x1c7WgCqnAuwCPNd2Avw4DAaYefuJzA9Lc2SOwT/mtLF0PF
         xX3KL3OQkmRMne0NWGh78YARQFKARxclmUlZeID0kDntcy5GwyuHMIyi0huY8BO2rk69
         lM/qrQGqRtWhTP7R3eoAucF025BBGpgk97EyHo54p4wSIfDG9k2Bi2NxA5ANr+9lHCF9
         5paGzogYE0wLM6+ec4MmLIP38EBLamHHlBwGZfOXIqbeysXQ+u7xT/qNsveXG08AN8z4
         jDng==
X-Gm-Message-State: AGRZ1gLtexwSLpR0awDFLG8FOtoAHCj0um68MxKdPXVRnt3rQDuUHMQ8
        eznsolcYkUIY/gcituGqAwrAwQ==
X-Google-Smtp-Source: AJdET5f0/9J1C2IEjHL4pT99PySqUXxRnWZ/+Wvj4OG3P7+q6t/tK7apX3SNKdlj7oRXRhFJHQe3Ew==
X-Received: by 2002:ac8:6151:: with SMTP id d17mr7097847qtm.194.1542155336351;
        Tue, 13 Nov 2018 16:28:56 -0800 (PST)
Received: from [192.168.48.13] ([168.181.50.245])
        by smtp.gmail.com with ESMTPSA id h25-v6sm15278656qta.89.2018.11.13.16.28.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 16:28:54 -0800 (PST)
Cc:     rafael.tinoco@linaro.org, Waiman Long <longman@redhat.com>
Subject: Re: nfs: possible sync issue between nfs_call_unlink <->
 nfs_async_unlink_release
To:     linux-kernel@vger.kernel.org
References: <CADtBP2AaVMgmYGsvBjsVjw9M4hCiYOcMMbPu6nS3Fmo8i4wY3w@mail.gmail.com>
From:   Rafael David Tinoco <rafael.tinoco@linaro.org>
Organization: Linaro
Message-ID: <c351b04b-e83e-d090-a6b2-b8b08a688872@linaro.org>
Date:   Tue, 13 Nov 2018 22:28:52 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CADtBP2AaVMgmYGsvBjsVjw9M4hCiYOcMMbPu6nS3Fmo8i4wY3w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/18 6:04 PM, Rafael Tinoco wrote:
> BUG: https://bugs.linaro.org/show_bug.cgi?id=3731
> 
> During Linaro's Kernel Functional tests, we have observed the
> following situation:
> 
> [   52.651490] DEBUG_LOCKS_WARN_ON(sem->owner != ((struct task_struct *)1UL))
> [   52.651506] WARNING: CPU: 2 PID: 1457 at
> ./kernel/locking/rwsem.c:217 up_read_non_owner+0x5d/0x70
> [   52.674398] Modules linked in: x86_pkg_temp_thermal fuse
> [   52.679719] CPU: 2 PID: 1457 Comm: kworker/2:2 Not tainted 4.16.0 #1
> [   52.687448] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> 2.0b 07/27/2017
> [   52.694922] Workqueue: nfsiod rpc_async_release
> [   52.699454] RIP: 0010:up_read_non_owner+0x5d/0x70
> [   52.704157] RSP: 0018:ffff9cbf81a23dd0 EFLAGS: 00010282
> [   52.709376] RAX: 0000000000000000 RBX: ffff8dc1983c76c0 RCX: 0000000000000000
> [   52.716500] RDX: ffffffffbd2d26c9 RSI: 0000000000000001 RDI: ffffffffbd2d2889
> [   52.723652] RBP: ffff9cbf81a23dd8 R08: 0000000000000000 R09: 0000000000000000
> [   52.730782] R10: ffff9cbf81a23dd0 R11: 0000000000000000 R12: ffff8dc19abf8600
> [   52.737906] R13: ffff8dc19b6c0000 R14: 0000000000000000 R15: ffff8dc19bacad80
> [   52.745029] FS:  0000000000000000(0000) GS:ffff8dc1afd00000(0000)
> knlGS:0000000000000000
> [   52.753108] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   52.758845] CR2: 00007f33794665d8 CR3: 000000016c41e006 CR4: 00000000003606e0
> [   52.765968] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   52.773091] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   52.780215] Call Trace:
> [   52.782695]  nfs_async_unlink_release+0x32/0x80
> [   52.787220]  rpc_free_task+0x30/0x50
> [   52.790789]  rpc_async_release+0x12/0x20
> [   52.794707]  process_one_work+0x25e/0x660
> [   52.798713]  worker_thread+0x4b/0x410
> [   52.802377]  kthread+0x10d/0x140
> [   52.805600]  ? rescuer_thread+0x3a0/0x3a0
> [   52.809652]  ? kthread_create_worker_on_cpu+0x70/0x70
> [   52.814702]  ? do_syscall_64+0x69/0x1b0
> [   52.818540]  ret_from_fork+0x3a/0x50

Full explanation: https://bugs.linaro.org/show_bug.cgi?id=3731#c15

Appears that:

commit 925b9cd1b89a94b7124d128c80dfc48f78a63098
Author: Waiman Long <longman@redhat.com>
Date:   Thu Sep 6 17:18:34 2018

     locking/rwsem: Make owner store task pointer of last owning reader

seem to have fixed this warning:

DEBUG_RWSEMS_WARN_ON() started differentiating unknown owners for 
semaphores, like in this case, when RPC function forces the release the 
dentry's semaphore to avoid issues with NFS filesystem logic (nfs_rmdir, 
the real user for the semaphore in question).

Thanks Waiman!
-
Rafael D. Tinoco
Linaro Kernel Validation
