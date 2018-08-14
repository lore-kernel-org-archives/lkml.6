Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F29C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 19:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFCB421727
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 19:01:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFCB421727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbeHNVty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 17:49:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52122 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725988AbeHNVty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 17:49:54 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2941C410BC16;
        Tue, 14 Aug 2018 19:01:19 +0000 (UTC)
Received: from jlaw-desktop.bos.csb (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E891F2026D7E;
        Tue, 14 Aug 2018 19:01:18 +0000 (UTC)
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org
From:   Joe Lawrence <joe.lawrence@redhat.com>
Subject: double clock sched_features warnings msgs
Organization: Red Hat
Message-ID: <b771a74d-d49d-c4ca-0494-097252b25dc4@redhat.com>
Date:   Tue, 14 Aug 2018 15:01:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 14 Aug 2018 19:01:19 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 14 Aug 2018 19:01:19 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'joe.lawrence@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

A QA tester here has noticed that he can regularly provoke a
"rq->clock_update_flags & RQCF_UPDATED" warning when echo'ing into the
debugfs sched_features file:

% echo WARN_DOUBLE_CLOCK > /sys/kernel/debug/sched_features

...

------------[ cut here ]------------
rq->clock_update_flags & RQCF_UPDATED
WARNING: CPU: 31 PID: 2052 at kernel/sched/core.c:203
update_rq_clock+0xdc/0x120
Modules linked in: sunrpc intel_rapl sb_edac x86_pkg_temp_thermal
intel_powerclamp coretemp kvm_intel kvm irqbypass ipmi_ssif
crct10dif_pclmul crc32_pclmul ghash_clmulni_intel intel_cstate
intel_uncore pcspkr sg intel_rapl_perf ipmi_si iTCO_wdt
iTCO_vendor_support ioatdma ipmi_devintf wmi i2c_i801 ipmi_msghandler
lpc_ich ip_tables xfs libcrc32c sr_mod cdrom sd_mod mgag200
drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm isci
drm igb libsas ahci libahci ptp scsi_transport_sas crc32c_intel libata
pps_core dca i2c_algo_bit i2c_core dm_mirror dm_region_hash dm_log dm_mod
CPU: 31 PID: 2052 Comm: (crond) Not tainted 4.18.0 #1
Hardware name: Intel Corporation SandyBridge Platform/To be filled by
O.E.M., BIOS RMLSDP.86I.R2.28.D690.1306271008 06/27/2013
RIP: 0010:update_rq_clock+0xdc/0x120
Code: a8 04 0f 84 65 ff ff ff 80 3d 31 1a 11 01 00 0f 85 58 ff ff ff 48
c7 c7 f0 38 e6 81 31 c0 c6 05 1b 1a 11 01 01 e8 74 3d fd ff <0f> 0b 8b
83 b0 09 00 00 e9 36 ff ff ff e8 72 75 f8 ff 66 90 4c 8b
RSP: 0018:ffffc90004e13e90 EFLAGS: 00010086
RAX: 0000000000000000 RBX: ffff88042ea220c0 RCX: 0000000000000006
RDX: 0000000000000000 RSI: 0000000000000096 RDI: ffff88042eed6990
RBP: 0000000000000000 R08: 0000000000000025 R09: 0000000000000550
R10: 0000000000000000 R11: 0000000000000000 R12: ffff880429bb9200
R13: ffff880425264e00 R14: 00000000000220c0 R15: 0000000000000000
FS:  00007f5bb544c940(0000) GS:ffff88042eec0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5bb3f59d40 CR3: 00000004264e4004 CR4: 00000000001606e0
Call Trace:
 online_fair_sched_group+0x53/0x110
 sched_autogroup_create_attach+0xba/0x170
 ksys_setsid+0xe7/0x100
 __ia32_sys_setsid+0xa/0x10
 do_syscall_64+0x5b/0x180
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f5bb3c42107
Code: 73 01 c3 48 8b 0d 89 fd 2f 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e
0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 70 00 00 00 0f 05 <48> 3d 01
f0 ff ff 73 01 c3 48 8b 0d 59 fd 2f 00 f7 d8 64 89 01 48
RSP: 002b:00007ffd3fa6a638 EFLAGS: 00000246 ORIG_RAX: 0000000000000070
RAX: ffffffffffffffda RBX: 0000557397d52b68 RCX: 00007f5bb3c42107
RDX: 00007f5bb3f427b8 RSI: 0000000000000000 RDI: 000000000000000f
RBP: 00007ffd3fa6a8a0 R08: 0000000000000001 R09: 0000557397ec84a5
R10: 000000000000003b R11: 0000000000000246 R12: 00001fff4fe9a99c
R13: 00007ffd3fa6a670 R14: 0000000000000000 R15: 00007ffd3fa6aa80
---[ end trace b5859b81be7e7db1 ]---

WARN_DOUBLE_CLOCK's definition in kernel/sched/features.h states that it
is "Default disabled because the annotations are not complete".  Should
we expect such warnings (false positives?) until some further work is
complete?  Just trying to figure out if these msgs are interesting or not.

Thanks,

-- Joe
