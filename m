Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145FEC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF388208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:31:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF388208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932422AbeFTIbd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:31:33 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:49057 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752595AbeFTIbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:31:31 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue104 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MJkO4-1fWeEr1yCq-0018NJ; Wed, 20 Jun 2018 10:17:49 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] procfs: uptime: use ktime_get_boottime_ts64
Date:   Wed, 20 Jun 2018 10:17:31 +0200
Message-Id: <20180620081746.282742-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:pwAj7eEw82m/gGe+74HXzzKRg4+7GieAut8Yu2Zf5uqU9ZIT8Uu
 yAfie19HelIP8VIv0nL83ctky5pIFIBTMndxyJkg+JvpW3BPTCeDGGQXDWbDmTp1qa/gFIg
 Y6DfN5eJd2GnyuPGxZc4XASnVFVN2SWeTuhRqFYoqQ3rYiV07wNh/P9qC4aQJtA1WDVvsGc
 WE11GAil5+EaEnlYqQa1Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8q9V/tKs4Oo=:YFWYE1Wda9x35pT8f7EkV2
 VyS+RKJgPU/vKq/VvTgJvysqct4G2k7gQqkt4H0ebRZ4Y3ka2ORIyT9hQSACaC6wQHR6TnjEi
 KoS/lwUFClxe7gdiA0aQeO1NRU6oWfAMhc0kcOKBcC0T3ixOlHgHxa0RmEke2N5htwoCz3WDU
 AMJ8ahJIpKWshI1KdoMk++DJpmyKilQgaRqf4LE3rX+Qp5pOfMbDAIPrnvAr0HIahiUl1YECL
 LeLDl2hklQ0jOqqPXo4pPDw8Gzd9KVl9EcXWommq3ltsU4oFBBPcSW7wONxivH5SqlYQKV1tv
 A48HRsYN/cVJhtIhFT5wy/6FRKkHKSH/SQRt3k4z/yFzHhAsVnji9W54J/VvPPsftkQLu3rR2
 pLRUj5ZxubwecW+8d/AkGYJZbQEUm5jRaoxLPh5TFzhdofdtOYDdH/sxA7Ej9vuZg1c5dLuCN
 YbqUwmkApKUdMoPDF2KPZIeDMCfypFj42KMvreoFc3LzCL5lmA6Tt5CCUBtwgK7yJPN1eiEqd
 Y62qpFig4p/kBbUMq81VkHtvmy8cZ1aNsszvT9il5JaYkqbOEEp0HxAQgoXB2bPGYdg7OYVqO
 d7pGi9A74eXOYRzXQzZkESF39CiHSJpbE4dU6xXij9rLdB63b/HqKxCc5fMDKPnYF9OPG+1mC
 uNbJf+4azzE/ivcrL1kjNHK/FKk1k/59Im5v04L5rLBm/1jKQwQGT/d6rQ2MSdzPFyLk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_monotonic_boottime() is deprecated and uses the old timespec
type. Let's convert /proc/uptime to use ktime_get_boottime_ts64().

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/proc/uptime.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/proc/uptime.c b/fs/proc/uptime.c
index 3f723cb478af..a4c2791ab70b 100644
--- a/fs/proc/uptime.c
+++ b/fs/proc/uptime.c
@@ -9,7 +9,7 @@
 
 static int uptime_proc_show(struct seq_file *m, void *v)
 {
-	struct timespec uptime;
+	struct timespec64 uptime;
 	struct timespec64 idle;
 	u64 nsec;
 	u32 rem;
@@ -19,7 +19,7 @@ static int uptime_proc_show(struct seq_file *m, void *v)
 	for_each_possible_cpu(i)
 		nsec += (__force u64) kcpustat_cpu(i).cpustat[CPUTIME_IDLE];
 
-	get_monotonic_boottime(&uptime);
+	ktime_get_boottime_ts64(&uptime);
 	idle.tv_sec = div_u64_rem(nsec, NSEC_PER_SEC, &rem);
 	idle.tv_nsec = rem;
 	seq_printf(m, "%lu.%02lu %lu.%02lu\n",
-- 
2.9.0

