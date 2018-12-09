Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C91C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 00:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF50C20672
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 00:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tiLxvskR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF50C20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbeLIAt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 19:49:56 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33490 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbeLIAt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 19:49:56 -0500
Received: by mail-pg1-f194.google.com with SMTP id z11so3340014pgu.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Dec 2018 16:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=wfMF8LevxtKbE2Z/fXg+jLTj/kdGEjzeFbHK4/vn/TQ=;
        b=tiLxvskRfEOSuuSvVQCYdVwFXFVz6zO+x8xNItX7nn3vUpprM2uk12GBS42Ac3HQ0e
         y28AT9V8bAzDPwdQYBcuWGgJrG/57ZK1s7dH+HKc3RHO97/A7922dpZ6pFHfYHtsyL4/
         +a6kH2yKp6zEhpDPVzPhqeeC1cmZVGceP8F2rROdRhh67SObzzwtutPdtkGk4p1nGn/5
         7dYme2d9ft+4FWGPdviMb7BtntttbheAEkOqsBsKbFcYXTzXMgX/2JVzkXMckKvkXHPM
         JI4BPmekjWrM3GaGiQQCvjedDgvIb2K6dRHG1oxYocdL87IBgZilsNUSubkc00ksysVj
         T9Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=wfMF8LevxtKbE2Z/fXg+jLTj/kdGEjzeFbHK4/vn/TQ=;
        b=SSw3e6wQShjuCsf2OrHk22MKVP0Ggdh3tOZkRULtDW9rX/8LCjfgMmI7JlwQUOCVEA
         eAoPkTnR9DxhOdA4agYNrI7rK85+U9S7OII6E6bKZfKfXMGl9EQslDmiTd2dc3/3+Oy2
         XEUgo3GNqrTxxa6J8AFZ2U+DJo7PyLtwiTh50311f1k3e+FO68AVM5b41Mpwqbohu6xU
         qNIpi+o+wY2O0/NOD4sduV1x0hAEVUd++L7rOjF59LUKzSnbBQlNUpTcTJWpGQk0scKb
         7rU+Wfhl/ah2jHoHB+1UuWq7of4P7rd/OH3Aa9kOwg+g2gI5RRIuode0Oqg2C31oou38
         IqsA==
X-Gm-Message-State: AA+aEWa+zWLphfoh6leeJHGLRczyL7YHuXJE0xeRpBLaPUxRzoE5Xm9U
        avmZ5+jXhCNzFeRJ1o5tfB8=
X-Google-Smtp-Source: AFSGD/WMffKFLX8hz3oWxhyJS5tNsw7KEA1GSkx0L7Zj13Y4EnnhYvYFTlnkiivNNKD3nBC8MvXCYg==
X-Received: by 2002:a65:57cb:: with SMTP id q11mr6556727pgr.60.1544316595354;
        Sat, 08 Dec 2018 16:49:55 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n186sm10179755pfn.137.2018.12.08.16.49.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Dec 2018 16:49:54 -0800 (PST)
Date:   Sat, 8 Dec 2018 16:49:53 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: default to 0 poll queues
Message-ID: <20181209004953.GA11638@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 19, 2018 at 08:18:24AM -0700, Jens Axboe wrote:
> We need a better way of configuring this, and given that polling is
> (still) a bit niche, let's default to using 0 poll queues. That way
> we'll have the same read/write/poll behavior as 4.20, and users that
> want to test/use polling are required to do manual configuration of the
> number of poll queues.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---

This patch results in a boot stall when booting parisc (hppa) images
from nvme in qemu.

...
Fusion MPT SAS Host driver 3.04.20
rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
rcu: 	(detected by 0, t=5252 jiffies, g=141, q=22)
rcu: All QSes seen, last rcu_sched kthread activity 5252 (-66742--71994), jiffies_till_next_fqs=1, root ->qsmask 0x0
kworker/u8:3    R  running task        0    85      2 0x00000004
Workqueue: nvme-reset-wq nvme_reset_work
Backtrace:
 [<10190d20>] show_stack+0x28/0x38
 [<101dd1e0>] sched_show_task.part.3+0xc4/0x144
 [<101dd290>] sched_show_task+0x30/0x38
 [<10221e18>] rcu_check_callbacks+0x760/0x7a4

rcu: rcu_sched kthread starved for 5252 jiffies! g141 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: RCU grace-period kthread stack dump:
rcu_sched       R  running task        0    10      2 0x00000000
Backtrace:
 [<10995b1c>] __schedule+0x214/0x648
 [<10995f94>] schedule+0x44/0xa8
 [<1099a7c4>] schedule_timeout+0x114/0x1a0
 [<10220e70>] rcu_gp_kthread+0x744/0x968
 [<101d5438>] kthread+0x154/0x15c
 [<1019501c>] ret_from_kernel_thread+0x1c/0x24

[ continued ]

This is only seen in SMP configurations; non-SMP configurations are ok.
Reverting the patch fixes the problem. v4.20-rcX and earlier kernels
also boot without problems.

For reference, here is the qemu command line. This is with qemu 3.0.

qemu-system-hppa -kernel vmlinux -no-reboot \
	-snapshot \
	-device nvme,serial=foo,drive=d0 \
	-drive file=rootfs.ext2,if=none,format=raw,id=d0 \
	-append 'root=/dev/nvme0n1 rw rootwait panic=-1 console=ttyS0,115200 ' \
	-nographic -monitor null

Please let me know if you need additional information.

Thanks,
Guenter
