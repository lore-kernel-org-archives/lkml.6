Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB822C282CC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 998242175B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="m1Sy539j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730141AbfBFANg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 19:13:36 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44785 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727739AbfBFALW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 19:11:22 -0500
Received: by mail-ed1-f68.google.com with SMTP id y56so4450740edd.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 16:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ax9LkXNiwakeCeb+9GNSvCgkxtYS/n0CygOT4SIDztI=;
        b=m1Sy539jErgq7yt8f0dVXpta0P5Pbz59Xz14dZlS1ma8lSmBJkNKV3siz4XYb3R86O
         wec/Q89Kyr8GKLpu5x/T1xnPYncRD5dxawp0pELW3vM0LP5qRvLquFwcvRps33Y22KJW
         Ncx0RWVQf+vMd3w80jzbbdPfwVwlxaH9YMruVTDtDFYPHexSmKwLLzxApoM0ngrQRnHe
         4rx9ALQqSJi3lJyOp0hCVcjlO3b+TU+CpLXOkhPSfp8fXvVevF9z/S1vj72RJ+tc9z0G
         A5UXyOfm9o5kykygI2c2zmMOzZdVMVc3kKoYwetobMEY0mdmyC8pgDrSI6LpUc4oiyem
         rerQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ax9LkXNiwakeCeb+9GNSvCgkxtYS/n0CygOT4SIDztI=;
        b=BaFDAy8diWOGWFgAtu6VTBcq0z4xKEFlFzYgI0cdt+EpwdJHHLmiAJZ6aqUK7i1z09
         Jxmtb3w0dTgbretcDtg5Ci4tT8oxckliVJ2nel4ODpF+s66LuCd8/ykhxgWiGEQs5+oU
         OjkinTqVXwXFWqH1TMWNVHGGuzI/WzcsbIAuAyv+OaIoWyd1D1bDVqzWGUyti+8vrD4P
         4/86QjUk1Spm3snMGgqQGOx7Xl8NUiAjRd8mcRShlCeaTeUkRgEbTomLWpBfi02dY3Yt
         6w8odnHppWa+zTEUQ+nY8kOCqLT5avlm3JpAgZKgXh5Vnc9CQsgaIeThInRA0jJTbZ/m
         pt5g==
X-Gm-Message-State: AHQUAubrvyOsGBCvg2VFdHc4dmsvU/HxKhgIsuHa/sx88OAsMV3RbPtn
        JZT99aKfc4I72/SxJT1b3HWpNXf/xkM=
X-Google-Smtp-Source: AHgI3IbYTK9a1mInS3MtxX/CNCWgCobhw+Tnq1KtyM6HNBXkvj5oAi4pWFrr55TtXLjiidv6XEKe9A==
X-Received: by 2002:a17:906:4545:: with SMTP id s5mr5327737ejq.107.1549411880194;
        Tue, 05 Feb 2019 16:11:20 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id p30sm5489594eda.68.2019.02.05.16.11.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 05 Feb 2019 16:11:19 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>, Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andrei Vagin <avagin@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andy Tucker <agtucker@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCH 08/32] timens: Shift /proc/uptime
Date:   Wed,  6 Feb 2019 00:10:42 +0000
Message-Id: <20190206001107.16488-9-dima@arista.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206001107.16488-1-dima@arista.com>
References: <20190206001107.16488-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Respect boottime inside time namespace for /proc/uptime

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 fs/proc/uptime.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/proc/uptime.c b/fs/proc/uptime.c
index a4c2791ab70b..4421ec058472 100644
--- a/fs/proc/uptime.c
+++ b/fs/proc/uptime.c
@@ -5,6 +5,7 @@
 #include <linux/sched.h>
 #include <linux/seq_file.h>
 #include <linux/time.h>
+#include <linux/time_namespace.h>
 #include <linux/kernel_stat.h>
 
 static int uptime_proc_show(struct seq_file *m, void *v)
@@ -20,6 +21,8 @@ static int uptime_proc_show(struct seq_file *m, void *v)
 		nsec += (__force u64) kcpustat_cpu(i).cpustat[CPUTIME_IDLE];
 
 	ktime_get_boottime_ts64(&uptime);
+	timens_clock_from_host(CLOCK_BOOTTIME, &uptime);
+
 	idle.tv_sec = div_u64_rem(nsec, NSEC_PER_SEC, &rem);
 	idle.tv_nsec = rem;
 	seq_printf(m, "%lu.%02lu %lu.%02lu\n",
-- 
2.20.1

