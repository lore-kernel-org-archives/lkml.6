Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5B202C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0615120693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DsoYIbb+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0615120693
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934757AbeFLUmC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 16:42:02 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36099 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933625AbeFLUmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 16:42:00 -0400
Received: by mail-pg0-f65.google.com with SMTP id m5-v6so133638pgd.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 13:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=MN2Mkrop9rn4sGIjmy5kPrbZmlWwdDZjAPMMFqsDt7A=;
        b=DsoYIbb+BC27uVzGP+QnthGXJbTZ0l4UtLq4+YPGe9E4MxtS685p2b7QbdzepgIIoq
         nqXhQM7h5M3CDZWzJR7mpyYP7LSWOgs0VZ8R/vySjUDuCd9KpSMmMNl/1eaDKMJaFutz
         r94+ruPrt0yPhHy/rKmk/Qog47XO4Jy7ZJkDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=MN2Mkrop9rn4sGIjmy5kPrbZmlWwdDZjAPMMFqsDt7A=;
        b=jCR3DIWU/Q1b9mL7QP4lhq/UPWqXtZ8TsK79nWYrCy97e7UYkLb4c6KTyra//l81Y4
         BNcRkiwn87evH7JYPB0Ng5GUvfSAf8IqMwcesSkCctOk1PZpGDxsuNBfSsib4M8wsFRy
         POtQdCHYg2CBMHjGBoLD3hQgZNd/+5OdZrsMvTkdy2VdHH0+XwOvDdXnSvlqWxH2yary
         pohwqRpXXs5ak3FNc6Esaoy5WwEQehGvG3e8oJRaXQYpOdLPFClIaPvKcgWCu0Oeu6EW
         cdHsk/Ue2vZ//+nmtm5Cbx1DiltE4ShFkmWmfQ5qa1HYv3eUSakA+5+8wu7NdIRgOb75
         i1Cw==
X-Gm-Message-State: APt69E39mCgRDfszODUUv9o3iWFI8E4Wo3iqh4Fp+zCf7sezLFUvLctH
        LQEcOA3c+Ms7rUlhhFh4yzv4tQ==
X-Google-Smtp-Source: ADUXVKIzphimoBbte73x58NhaM0mA9V3dYhKgOBDwoA+bcK27h44kMZzOoa51Y7vqO8USuLVCdF7jA==
X-Received: by 2002:a63:6f8a:: with SMTP id k132-v6mr1615383pgc.153.1528836119871;
        Tue, 12 Jun 2018 13:41:59 -0700 (PDT)
Received: from [10.69.55.99] ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id c27-v6sm1745146pfl.63.2018.06.12.13.41.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 13:41:59 -0700 (PDT)
Subject: Re: [PATCH 5/5] nvmet: fcloop: use irqsave spinlocks
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        Keith Busch <keith.busch@intel.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>
References: <20180515074043.22843-1-jthumshirn@suse.de>
 <20180515074043.22843-6-jthumshirn@suse.de>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <03515e30-e614-3c1d-314e-ef0be6248d92@broadcom.com>
Date:   Tue, 12 Jun 2018 13:41:55 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180515074043.22843-6-jthumshirn@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/15/2018 12:40 AM, Johannes Thumshirn wrote:
> Lockdep complains about inconsistent hardirq states when using
> nvme-fcloop. So use the irqsave variant of spin_locks for the
> nvmefc_fcp_req's reqlock.
>
> Here's the lockdep report:
> [   11.138417] ================================
> [   11.139085] WARNING: inconsistent lock state
> [   11.139207] nvmet: creating controller 2 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:046394e7-bff7-4403-9502-1816800efaa0.
> [   11.139727] 4.17.0-rc5+ #883 Not tainted
> [   11.139732] --------------------------------
> [   11.144441] inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
> [   11.145341] swapper/8/0 [HC1[1]:SC0[0]:HE0:SE1] takes:
> [   11.146108]         (ptrval) (&(&tfcp_req->reqlock)->rlock){?.+.}, at: fcloop_fcp_op+0x20/0x1d0 [nvme_fcloop]
> [   11.148633] {HARDIRQ-ON-W} state was registered at:
> [   11.149380]   _raw_spin_lock+0x34/0x70
> [   11.149940]   fcloop_fcp_recv_work+0x17/0x90 [nvme_fcloop]
> [   11.150746]   process_one_work+0x1d8/0x5c0
> [   11.151346]   worker_thread+0x45/0x3e0
> [   11.151886]   kthread+0x101/0x140
> [   11.152370]   ret_from_fork+0x3a/0x50
> [   11.152903] irq event stamp: 36666
> [   11.153402] hardirqs last  enabled at (36663): [<ffffffffafc601c3>] default_idle+0x13/0x180
> [   11.154601] hardirqs last disabled at (36664): [<ffffffffafe00964>] interrupt_entry+0xc4/0xe0
> [   11.155817] softirqs last  enabled at (36666): [<ffffffffaf267409>] irq_enter+0x59/0x60
> [   11.156952] softirqs last disabled at (36665): [<ffffffffaf2673ee>] irq_enter+0x3e/0x60
> [   11.158092]
> [   11.158092] other info that might help us debug this:
> [   11.159436]  Possible unsafe locking scenario:
> [   11.159436]
> [   11.160299]        CPU0
> [   11.160663]        ----
> [   11.161026]   lock(&(&tfcp_req->reqlock)->rlock);
> [   11.161709]   <Interrupt>
> [   11.162091]     lock(&(&tfcp_req->reqlock)->rlock);
> [   11.163148]
> [   11.163148]  *** DEADLOCK ***
> [   11.163148]
> [   11.164007] no locks held by swapper/8/0.
> [   11.164596]
> [   11.164596] stack backtrace:
> [   11.165238] CPU: 8 PID: 0 Comm: swapper/8 Not tainted 4.17.0-rc5+ #883
> [   11.166180] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.0.0-prebuilt.qemu-project.org 04/01/2014
> [   11.167673] Call Trace:
> [   11.168037]  <IRQ>
> [   11.168349]  dump_stack+0x78/0xb3
> [   11.168864]  print_usage_bug+0x1ed/0x1fe
> [   11.169440]  ? check_usage_backwards+0x110/0x110
> [   11.170111]  mark_lock+0x263/0x2a0
> [   11.170995]  __lock_acquire+0x675/0x1870
> [   11.171865]  ? __lock_acquire+0x48d/0x1870
> [   11.172460]  lock_acquire+0xd4/0x220
> [   11.172981]  ? fcloop_fcp_op+0x20/0x1d0 [nvme_fcloop]
> [   11.173709]  _raw_spin_lock+0x34/0x70
> [   11.174243]  ? fcloop_fcp_op+0x20/0x1d0 [nvme_fcloop]
> [   11.174978]  fcloop_fcp_op+0x20/0x1d0 [nvme_fcloop]
> [   11.175673]  nvmet_fc_transfer_fcp_data+0x9b/0x130 [nvmet_fc]
> [   11.176507]  nvmet_req_complete+0x10/0x110 [nvmet]
> [   11.177210]  nvmet_bio_done+0x23/0x40 [nvmet]
> [   11.177837]  blk_update_request+0xab/0x3b0
> [   11.178434]  blk_mq_end_request+0x13/0x60
> [   11.179033]  flush_smp_call_function_queue+0x58/0x150
> [   11.179755]  smp_call_function_single_interrupt+0x49/0x260
> [   11.180531]  call_function_single_interrupt+0xf/0x20
> [   11.181236]  </IRQ>
> [   11.181542] RIP: 0010:native_safe_halt+0x2/0x10
> [   11.182186] RSP: 0018:ffffa481006cbec0 EFLAGS: 00000206 ORIG_RAX: ffffffffffffff04
> [   11.183265] RAX: ffff9f54f8b86200 RBX: ffff9f54f8b86200 RCX: 0000000000000000
> [   11.184264] RDX: ffff9f54f8b86200 RSI: 0000000000000001 RDI: ffff9f54f8b86200
> [   11.185270] RBP: 0000000000000008 R08: 0000000000000000 R09: 0000000000000000
> [   11.186271] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
> [   11.187280] R13: 0000000000000000 R14: ffff9f54f8b86200 R15: ffff9f54f8b86200
> [   11.188280]  default_idle+0x18/0x180
> [   11.188806]  do_idle+0x176/0x260
> [   11.189273]  cpu_startup_entry+0x5a/0x60
> [   11.189832]  start_secondary+0x18f/0x1b0
>
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> Cc: James Smart <james.smart@broadcom.com>
> ---
>   drivers/nvme/target/fcloop.c | 52 ++++++++++++++++++++++++--------------------
>   1 file changed, 29 insertions(+), 23 deletions(-)
>

Looks ok. I assume it is as the bio_done call can be in an interrupt 
handler.

Reviewed-by:   James Smart  <james.smart@broadcom.com>


