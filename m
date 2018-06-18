Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48408C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D729208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:00:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D729208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935318AbeFRPAK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:00:10 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:50297 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934822AbeFRPAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:00:09 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MX0aK-1fh0xs0iBQ-00W17h; Mon, 18 Jun 2018 16:59:56 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Richard Guy Briggs <rgb@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Steve Grubb <sgrubb@redhat.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] audit: use ktime_get_coarse_ts64() for time access
Date:   Mon, 18 Jun 2018 16:58:24 +0200
Message-Id: <20180618145954.785509-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:N1f/hoO75GMIw8nWsCqGXNMuJ3A7wWCJ0+uczcv8WR7B3BSvJ8U
 xXQNZ9SC4dgEwlCrmbEA81tRfLf+TwIehqT+OOEgQt+PfuzEnGRTS2izxDB+Y1NAtOlZwgm
 NFdTg3ZY6dB/LUeMkGY1nrDVORldi8AvxTuOae52nSSExYV4tTn+LD9Uz1IDAJqGL46CaC/
 LROx2gzTRvTHJHOB198ag==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ye08WftCAcc=:fH2vE+0flcfoMeiZ3qTS9Q
 CVxrcaG8yzvAn/Q+hoC08u/RCJfoN5t8HNGQ/IF4S7elpBAptWs9cUHnQIUxtM13RiDS/2zEQ
 XdS2Nm7a5oD8hIWM5wKXHPhoCdyiZfqVkecqBAcuyBF2m/YXogiuqeA0OPYmeFiciVY2964c/
 4hJkkNcBygo1oqAwkdGEZuyedsVdpGU/dtogLLwWkQuBz39yUopb4OiYuBnJgi76dBiq9Um2+
 VT9l2nMt5n3k12HBDLYjs+kQnUF0v0v6zpbv6CRhdztavyqiUepS3BmVAK3A8DeaGw2LuTTs3
 YFfYihBXH74Th43PFAh4H5LgHBWeGf+sb85NHT8OmN9nRL4ekY9xlrYfZlwAr5t2ziTbQTKB9
 sZscNZjJVq1hWs0mQFiidMY/zBeOboeWsNzOwwMUTg5qHpAZfWKTxLZJH6X4ZkS7yQr/Z0roW
 4YaJ6cCREfG5qw4l3icvqPpSI2Lg3HM+ahRKZccesHqyNX1lYc4ggTQluLq/hecI4RXIxhp9K
 jmqGXaT7yC1v3OhzMTWjb//atOl6pnyeUxDnNeA/WdzafsAjHbxehsi0d9DTpAge+wQGCmrq2
 E4d4McTzw5WbluHqQc2Iy9tn82yUH74B1PUwEgMUjPkX4VuvPI8rx3DEBJO6uLRv4KJ2jhH3C
 KczqO9UFrK0UMTZEggWn+8idquQE7ozU+graNGhIELjf+yiJlR5zIRZG2sRNbV223XTM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The API got renamed for consistency with the other time accessors,
this changes the audit caller as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/audit.c   | 2 +-
 kernel/auditsc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index e7478cb58079..3e34b9f03cfe 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1724,7 +1724,7 @@ static inline void audit_get_stamp(struct audit_context *ctx,
 				   struct timespec64 *t, unsigned int *serial)
 {
 	if (!ctx || !auditsc_get_stamp(ctx, t, serial)) {
-		*t = current_kernel_time64();
+		ktime_get_coarse_ts64(t);
 		*serial = audit_serial();
 	}
 }
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index ceb1c4596c51..dbbf02f513a8 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1540,10 +1540,10 @@ void __audit_syscall_entry(int major, unsigned long a1, unsigned long a2,
 	context->argv[2]    = a3;
 	context->argv[3]    = a4;
 	context->serial     = 0;
-	context->ctime = current_kernel_time64();
 	context->in_syscall = 1;
 	context->current_state  = state;
 	context->ppid       = 0;
+	ktime_get_coarse_ts64(&context->ctime);
 }
 
 /**
-- 
2.9.0

