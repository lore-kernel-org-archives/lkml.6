Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E14DC5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 22:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F88F2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 22:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="FF64v1W5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F88F2147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbeJQG0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 02:26:34 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51670 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbeJQG02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 02:26:28 -0400
Received: by mail-wm1-f65.google.com with SMTP id 143-v6so86885wmf.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 15:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sfOoDF6FWD9iasbDrAI9VfXptLBVqHrJU0kEcmR0Evw=;
        b=FF64v1W5+Q38kFsegoAzakYC0ObJRSx9FdE1BfNF7H0Pc/x2tGig/Ypb5mMrvp+B5Q
         VQD+Ejm0w4QS4JAoj8uPn7JwuauyfTStMEpUuabxiyWtWft7FhNOd4TsO8nC6pLQJhNY
         I+KEsK3L9bj/TKivZnVHoFPK9Dt5cT+LYHN7hjmNiRy0zezD65XN5esylgk2aEh6V+pH
         a/c1RJJ/oS4cqgIjKVuP3IeKUo30N/gApD01J+Gd5uCvtEfYB/04JcnyJaXLkwl3sX1a
         hA/sZtNmgkiOyOfs7R7/Lm8L+blDznMoGB2Pz6vLw8Dcwv7w/Uko/58rjiyOZcCN6n1l
         ddBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sfOoDF6FWD9iasbDrAI9VfXptLBVqHrJU0kEcmR0Evw=;
        b=mKo5N7eB1/eVB8iUbaKRleD9OTeicNnOYA4/qnsIg4CqiGFADh+dkLQ3gLg3G5h7zv
         RCDTaUoX+qzDSyn6QscjJYp4SO8AF+ezdsBIzP3+XaTCj/URoZvj9rMo+b/32VNhC77k
         9x5n8CH5WulkkRrxClokeg+Tb9alny+8osPnvZXfmraLv46hQqZneza9N0mnRQsIhFLA
         XVas2Zf/wYU0TQUTAiY+oEObjXi24qvCAoMlFfsK1Iv+o8cEimvfkBu7KiXqSumCKu10
         YeYlLCQhpT49jBNqmo3krusESLe5RVjZ5xcB/iR42BhBk4dTu39ezQ7Thsp4/coNYpqD
         UCuw==
X-Gm-Message-State: ABuFfoiIJEg9NfjXtUhWLUsSswxOqDiFUx7phadBiLtADEJeyAD7UG4q
        dm8cpV8MT1tgiDPQVnRF/HqUHA==
X-Google-Smtp-Source: ACcGV61eHCYae8+dRedCFApPOq0FPPI+l7Fgm5Cq3KqyR9VASJPUFrVpVoQMVSpt+a8CwiCc98bTew==
X-Received: by 2002:a1c:1984:: with SMTP id 126-v6mr96709wmz.7.1539729234612;
        Tue, 16 Oct 2018 15:33:54 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8070:8895:9700:8197:8849:535a:4f00])
        by smtp.gmail.com with ESMTPSA id x8-v6sm35084836wrd.54.2018.10.16.15.33.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 15:33:53 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     keescook@chromium.org, linux-kernel@vger.kernel.org
Cc:     ebiederm@xmission.com, mcgrof@kernel.org,
        akpm@linux-foundation.org, joe.lawrence@redhat.com,
        longman@redhat.com, linux@dominikbrodowski.net,
        viro@zeniv.linux.org.uk, adobriyan@gmail.com,
        linux-api@vger.kernel.org, Christian Brauner <christian@brauner.io>
Subject: [PATCH v3 2/2] sysctl: handle overflow for file-max
Date:   Wed, 17 Oct 2018 00:33:22 +0200
Message-Id: <20181016223322.16844-3-christian@brauner.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016223322.16844-1-christian@brauner.io>
References: <20181016223322.16844-1-christian@brauner.io>
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

Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Christian Brauner <christian@brauner.io>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
v2->v3:
- unchanged

v2->v1:
- consistenly fail on overflow

v0->v1:
- if max value is < than ULONG_MAX use max as upper bound
- (Dominik) remove double "the" from commit message
---
 kernel/sysctl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 102aa7a65687..93456e3a90cd 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -128,6 +128,7 @@ static int __maybe_unused one = 1;
 static int __maybe_unused two = 2;
 static int __maybe_unused four = 4;
 static unsigned long one_ul = 1;
+static unsigned long long_max = LONG_MAX;
 static int one_hundred = 100;
 static int one_thousand = 1000;
 #ifdef CONFIG_PRINTK
@@ -1697,6 +1698,8 @@ static struct ctl_table fs_table[] = {
 		.maxlen		= sizeof(files_stat.max_files),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
+		.extra1		= &zero,
+		.extra2		= &long_max,
 	},
 	{
 		.procname	= "nr_open",
@@ -2813,6 +2816,10 @@ static int __do_proc_doulongvec_minmax(void *data, struct ctl_table *table, int
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

