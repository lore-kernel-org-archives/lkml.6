Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B91C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA0892064A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="uVYVq1nk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA0892064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbeLCW7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 17:59:36 -0500
Received: from ozlabs.org ([203.11.71.1]:47861 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbeLCW7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 17:59:36 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 4380mz4wG7z9s3Z;
        Tue,  4 Dec 2018 09:59:31 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
        t=1543877973; bh=4IrH3sD/1eeRZTdHyhB754M2cg/D8VYQnUXpKwpuh6o=;
        h=Date:From:To:Cc:Subject:From;
        b=uVYVq1nk7KYtniUj+QR0wMldhCcgRLZqb8dZRk0+sspzyVcJD8PIqDPA4NLhNFwFl
         Lf7ghIPQmdFl2JPVfGAShwgMd6jFpzKmDfRI12s0NnpbmCVLZ40oUcAvX872NLjJXU
         lODQXw0RDUy9Bj4LKuDarQXMkgAHJwsId/44xX5zsmsFvs7utQOh5xvm9Jj7XjuXrD
         /kQXOa+oIogYpkB260t9cSl4tTbes7nbXDYrw8GlVRPFPaHZJj59hB19YsIwgsQ4uT
         feblNiFifDlNzL4hFLwQ8Exf6I5d+uHEy+MQzqYH8wzmYtGxCojiYuAj2sxPCDxHat
         SdXZLfSDqFP8A==
Date:   Tue, 4 Dec 2018 09:59:30 +1100
From:   Anton Blanchard <anton@ozlabs.org>
To:     npiggin@gmail.com, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, pauld@redhat.com, peterz@infradead.org,
        srikar@linux.vnet.ibm.com, pjt@google.com
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: CFS bandwidth control hits hard lockup warnings
Message-ID: <20181204095930.19818537@kryten>
X-Mailer: Mutt/1.8.0 (2017-02-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We are seeing hard lockup warnings caused by CFS bandwidth control code. The
test case below fails almost immediately on a reasonably large (144 thread)
POWER9 guest with:

watchdog: CPU 80 Hard LOCKUP
watchdog: CPU 80 TB:1134131922788, last heartbeat TB:1133207948315 (1804ms ago)
Modules linked in:
CPU: 80 PID: 0 Comm: swapper/80 Tainted: G             L    4.20.0-rc4-00156-g94f371cb7394-dirty #98
NIP:  c00000000018f618 LR: c000000000185174 CTR: c00000000018f5f0
REGS: c00000000fbbbd70 TRAP: 0100   Tainted: G             L     (4.20.0-rc4-00156-g94f371cb7394-dirty)
MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 28000222  XER: 00000000
CFAR: c000000000002440 IRQMASK: 1
GPR00: c000000000185174 c000003fef927610 c0000000010bd500 c000003fab1dbb80
GPR04: c000003ffe2d3000 c00000000018f5f0 c000003ffe2d3000 00000076e60d19fe
GPR08: c000003fab1dbb80 0000000000000178 c000003fa722f800 0000000000000001
GPR12: c00000000018f5f0 c00000000ffb3700 c000003fef927f90 0000000000000000
GPR16: 0000000000000000 c000000000f8d468 0000000000000050 c00000000004ace0
GPR20: c000003ffe743260 0000000000002a61 0000000000000001 0000000000000000
GPR24: 00000076e61c5aa0 000000003b9aca00 0000000000000000 c00000000017cdb0
GPR28: c000003fc2290000 c000003ffe2d3000 c00000000018f5f0 c000003fa74ca800
NIP [c00000000018f618] tg_unthrottle_up+0x28/0xc0
LR [c000000000185174] walk_tg_tree_from+0x94/0x120
Call Trace:
[c000003fef927610] [c000003fe3ad5000] 0xc000003fe3ad5000 (unreliable)
[c000003fef927690] [c00000000004b8ac] smp_muxed_ipi_message_pass+0x5c/0x70
[c000003fef9276e0] [c00000000019d828] unthrottle_cfs_rq+0xe8/0x300
[c000003fef927770] [c00000000019dc80] distribute_cfs_runtime+0x160/0x1d0
[c000003fef927820] [c00000000019e044] sched_cfs_period_timer+0x154/0x2f0
[c000003fef9278a0] [c0000000001f8fc0] __hrtimer_run_queues+0x180/0x430
[c000003fef927920] [c0000000001fa2a0] hrtimer_interrupt+0x110/0x300
[c000003fef9279d0] [c0000000000291d4] timer_interrupt+0x104/0x2e0
[c000003fef927a30] [c000000000009028] decrementer_common+0x108/0x110

Adding CPUs, or adding empty cgroups makes the situation worse. We haven't
had a chance to dig deeper yet.

Note: The test case makes no attempt to clean up after itself and sometimes
takes my guest down :)

Thanks,
Anton
--

#!/bin/bash -e 

echo 1 > /proc/sys/kernel/nmi_watchdog
echo 1 > /proc/sys/kernel/watchdog_thresh

mkdir -p /sys/fs/cgroup/cpu/base_cgroup
echo 1000 > /sys/fs/cgroup/cpu/base_cgroup/cpu.cfs_period_us
echo 1000000 > /sys/fs/cgroup/cpu/base_cgroup/cpu.cfs_quota_us

# Create some empty cgroups
for i in $(seq 1 1024)
do
	mkdir -p /sys/fs/cgroup/cpu/base_cgroup/$i
done

# Create some cgroups with a CPU soaker
for i in $(seq 1 144)
do
	(while :; do :; done ) &
	PID=$!
	mkdir -p /sys/fs/cgroup/cpu/base_cgroup/$PID
	echo $PID > /sys/fs/cgroup/cpu/base_cgroup/$PID/cgroup.procs
done
