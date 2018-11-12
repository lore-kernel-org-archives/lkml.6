Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37181C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 09:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D16DD223C6
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 09:03:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D16DD223C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbeKLSzi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 13:55:38 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:58421 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727208AbeKLSzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 13:55:38 -0500
Received: from dggeml405-hub.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 765C943744223;
        Mon, 12 Nov 2018 17:03:21 +0800 (CST)
Received: from DGGEML521-MBX.china.huawei.com ([169.254.6.159]) by
 dggeml405-hub.china.huawei.com ([10.3.17.49]) with mapi id 14.03.0415.000;
 Mon, 12 Nov 2018 17:03:12 +0800
From:   zhengchuan <zhengchuan@huawei.com>
To:     "fweisbec@gmail.com" <fweisbec@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Tangchen (UVP)" <tang.chen@huawei.com>,
        gaowanlong <gaowanlong@huawei.com>,
        "Wencongyang (UVP)" <wencongyang2@huawei.com>,
        "Wanghui (John)" <john.wanghui@huawei.com>,
        guijianfeng <guijianfeng@huawei.com>
Subject: nohz: ignore explicit nohz=off in case of nohz_full running
Thread-Topic: nohz: ignore explicit nohz=off in case of nohz_full running
Thread-Index: AdR6YI+U+sGtWseOSWuXbDAUqG1EcQ==
Date:   Mon, 12 Nov 2018 09:03:12 +0000
Message-ID: <0E8924944E28FD4A97A19E5A680D8A822DF0AF28@DGGEML521-MBX.china.huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.177.222.176]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
It seems "nohz=" is not compatible with "nohz_full=" or "isolcpus=" by now.
when both "nohz=off" and "nohz_full=[cpulist]" or "isolcpus=nohz,domain" is configured in cmdline, 
we enter an ambiguous status, that is, we do unbound timers, watchdog, RCU isolation, even show nohz_full cpu in sysfs, 
but we never enter tickless mode because one-shot mode is disable by "nohz=off" in tick_nohz_switch_to_nohz().

**************
[How I resolve it]
**************
Since we want to centralize the isolation management by housekeeping subsystem, we regard "nohz_full=" or "isolcpus=" as the controller.
Just ignore explicit nohz=off when nohz_full=[cpulist] or isolcpus=nohz,domain is configured.
---
 kernel/time/tick-sched.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c index 5b33e2f..d30d783 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -414,6 +414,8 @@ void __init tick_nohz_init(void)
        if (!tick_nohz_full_running)
                return;

+       if (!tick_nohz_enabled)
+               pr_warn("NO_HZ: NOHZ is disable explicitly, ignore it in case of NOHZ_FULL running\n");
        /*
         * Full dynticks uses irq work to drive the tick rescheduling on safe
         * locking contexts. But then we need irq work to raise its own @@ -1182,7 +1184,7 @@ static void tick_nohz_handler(struct clock_event_device *dev)

 static inline void tick_nohz_activate(struct tick_sched *ts, int mode)  {
-       if (!tick_nohz_enabled)
+       if (!tick_nohz_enabled && !tick_nohz_full_enabled())
                return;
        ts->nohz_mode = mode;
        /* One update is enough */
@@ -1198,7 +1200,7 @@ static void tick_nohz_switch_to_nohz(void)
        struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
        ktime_t next;

-       if (!tick_nohz_enabled)
+       if (!tick_nohz_enabled && !tick_nohz_full_enabled())
                return;

        if (tick_switch_to_oneshot(tick_nohz_handler))
--
1.7.12.4
