Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3070FC5ACCD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 19:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8A262145D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 19:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="Am6vhshK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8A262145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbeJQDqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 23:46:09 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53080 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbeJQDqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 23:46:09 -0400
Received: by mail-wm1-f68.google.com with SMTP id 189-v6so23678991wmw.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 12:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/VRINgCOLjsjRKUGgbZ6dKxzCWOesG7Ozn0GZveILoU=;
        b=Am6vhshK62ZcaoFqPDeLhFjzizYRn+4kmEw/hyvsmxqUPntqAW8dhARFdaEN9nC3oB
         i9+XC2Il20rz/ShpHvbS4YN4E8Ugyg7VJZ11MuiNI96sxlHctSsZAtm/u+P5+kY/Uojf
         iEuEBW0paVhArqDOS2XuZZQehSB1aYxYIrXqmdc3nJuvxlnRuBdL4OJPWHqBTRW2PjKh
         7/p6MIob9dTB5PBQ5nx3nIqEZYGhPIPKknPVq+DX9sXouZiVeMcOPfgSwgSplR6zBBtT
         +W9GUPjtc3DEFyxcs35DN7eyeqLXn6+4RtPzpnOBFT9zNiCI1mqBNNGI+pDRUrc5K6Kk
         Sfqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/VRINgCOLjsjRKUGgbZ6dKxzCWOesG7Ozn0GZveILoU=;
        b=U36zjqRz4YeFRYeJd8+rUiE1zCkF6b2K0GP5qAc+COldacJjZ9ZKqN25LsdzaEpl2P
         6duSuJBGcsJABAKK5aqyQVBKwG+YcbPRW9AY9zT9EaHicuHgBnIJ3Z0LvQeJ9gV559wD
         J+hapW6PmxN2pw/SaP+FfXoa0Rsz6wET52bKdhnieaEfdwOvN4UuzP0xYNbFYAd+YIPa
         a6Vpntd+1mwFZkN2jjxek2XwdBH/XkPiZoclrtCHDpz3qoxaibvg7G7bNInSVguKCvcf
         EezC2G/FMhC1qy1wWiJ/4chsCkB6zKnVa97Jtgjm85RhBIOImx1EfMS/LDgksK3bWM2/
         L5vQ==
X-Gm-Message-State: ABuFfojS7kkou2ZWiGtJG4ka8l1RgZHGWuPapsXorfkNsdtsRklgSflF
        LJLD83OtPph0bcbcPWRmGMVf+g==
X-Google-Smtp-Source: ACcGV63Ar21V6QOxXP5Zo+aDW7h2M7a4f7eVUjghDU4o67LtH2LeRrWK/KzHR+dJia27F9ikt4HS2g==
X-Received: by 2002:a1c:ef15:: with SMTP id n21-v6mr16813493wmh.151.1539719646472;
        Tue, 16 Oct 2018 12:54:06 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8070:8895:9700:8197:8849:535a:4f00])
        by smtp.gmail.com with ESMTPSA id z2-v6sm10958588wrh.8.2018.10.16.12.54.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 12:54:05 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     keescook@chromium.org, linux-kernel@vger.kernel.org
Cc:     ebiederm@xmission.com, mcgrof@kernel.org,
        akpm@linux-foundation.org, joe.lawrence@redhat.com,
        longman@redhat.com, linux@dominikbrodowski.net,
        viro@zeniv.linux.org.uk, adobriyan@gmail.com,
        linux-api@vger.kernel.org, Christian Brauner <christian@brauner.io>
Subject: [PATCH v2 2/2] sysctl: handle overflow for file-max
Date:   Tue, 16 Oct 2018 21:53:37 +0200
Message-Id: <20181016195337.2440-3-christian@brauner.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016195337.2440-1-christian@brauner.io>
References: <20181016195337.2440-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, when writing

echo 18446744073709551616 > /proc/sys/fs/file-max

/proc/sys/fs/file-max will overflow and be set to 0. That quickly
crashes the system.
This commit sets the max and min value for file-max and returns -EINVAL
when a long int is exceeded. Any higher value cannot currently be used as
the percpu counters are long ints and not unsigned integers. This behavior
also aligns with other tuneables that return -EINVAL when their range is
exceeded. See e.g. [1], [2] and others.

[1]: fb910c42cceb ("sysctl: check for UINT_MAX before unsigned int min/max")
[2]: 196851bed522 ("s390/topology: correct topology mode proc handler")

Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Christian Brauner <christian@brauner.io>
---
v2->v1:
- consistenly fail on overflow
v0->v1:
- if max value is < than ULONG_MAX use max as upper bound
- (Dominik) remove double "the" from commit message
---
 kernel/sysctl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 7d98e02e5d72..0874001e5435 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -127,6 +127,7 @@ static int __maybe_unused one = 1;
 static int __maybe_unused two = 2;
 static int __maybe_unused four = 4;
 static unsigned long one_ul = 1;
+static unsigned long long_max = LONG_MAX;
 static int one_hundred = 100;
 static int one_thousand = 1000;
 #ifdef CONFIG_PRINTK
@@ -1696,6 +1697,8 @@ static struct ctl_table fs_table[] = {
 		.maxlen		= sizeof(files_stat.max_files),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
+		.extra1		= &zero,
+		.extra2		= &long_max,
 	},
 	{
 		.procname	= "nr_open",
@@ -2797,6 +2800,10 @@ static int __do_proc_doulongvec_minmax(void *data, struct ctl_table *table, int
 				break;
 			if (neg)
 				continue;
+			if ((max && val > *max) || (min && val < *min)) {
+				err = -EINVAL;
+				break;
+			}
 			val = convmul * val / convdiv;
 			if ((min && val < *min) || (max && val > *max))
 				continue;
-- 
2.17.1

