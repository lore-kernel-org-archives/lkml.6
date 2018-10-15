Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FE2C7112A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 10:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3B0C20652
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 10:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="gaahaj+o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3B0C20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbeJOSk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 14:40:59 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35948 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbeJOSk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 14:40:58 -0400
Received: by mail-wm1-f66.google.com with SMTP id a8-v6so19076231wmf.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 03:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9E3KlbbmhrZCJqeW3BNIwEFLtNJAFvWE+qZnx/vsam4=;
        b=gaahaj+ovbTRns+vDRcJ4hiMIMRbjs0kwHnQ65PLi8Hw0S2/EWtNpXXWX1iDiL5ZrH
         DG3+k1o7xPpsU5fwvVFI9tTGt7WwiUOKiDCyZswpJB01/izlc67j3nv2FZ68hFsHcRgc
         88Q9vISYiFsMMEfVnIRrMeZI2k9oo+sG3cB+ZTdJaOofv6msU/sIVCMvNbMNV/11IC1J
         k5ZVER1jsi4NPDR6migkWy7l8o7gyCiMzTeQ71hZ37vjCvCy5LOXl7arcy/Jrg8Q3pmU
         2QrpFt9EOpkUhIhHMCuv4uKUz7VGl1U1TRID0E1ROLf62mQ85v57EM9rpYrdpJs5xoK+
         r00g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9E3KlbbmhrZCJqeW3BNIwEFLtNJAFvWE+qZnx/vsam4=;
        b=Y3PXfUannMKA3qela6gIsTsJDsiDu9WfbU8D+Xw99aQovaoay9eMU/oCIBSRxmMflV
         ItlXHmo7HPzoKZRB3MncC385U1pfoBH2zebIsgY9IAkziIsMbSjlipDvOrPPN1VAuOuR
         PAXnRdk3N3GifEYHbiCFISm4hbCO6ARSjtpzkX7HHZnx7HspetdfKhUPYfYNny3W+m7T
         EdltDFcKHRIDaM9hVzLpi/UHhBZngKdVkeTpyVG6o0Sjb7KdRfCQoN+9iLnu8einatue
         esk2c+ofuZQVpvJkA8LpNPkwoVojg7u1gTGZvZLNsY7awFCbZu/o8l7HS1GGjr0YRWip
         SC0g==
X-Gm-Message-State: ABuFfohiv5UvKMzDof3/wBU00UIJMr6CdNYyfiC1Bflh+Z9obYrXZqoJ
        Xc9w5hVGIqj4LIfIM88ORuGZAoJCBuVJIg==
X-Google-Smtp-Source: ACcGV60ibD0rR8j23OaLk/tP2SoHR2oa2yK2r7nutUbRbPup3kQ73uqVe2hsbgoV79xBWozs2gJwsg==
X-Received: by 2002:a1c:e15:: with SMTP id 21-v6mr13251531wmo.35.1539600973200;
        Mon, 15 Oct 2018 03:56:13 -0700 (PDT)
Received: from localhost.localdomain (u-086-c100.eap.uni-tuebingen.de. [134.2.86.100])
        by smtp.gmail.com with ESMTPSA id a11-v6sm14236484wrp.3.2018.10.15.03.56.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 03:56:12 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     keescook@chromium.org, linux-kernel@vger.kernel.org
Cc:     ebiederm@xmission.com, mcgrof@kernel.org,
        akpm@linux-foundation.org, joe.lawrence@redhat.com,
        longman@redhat.com, linux@dominikbrodowski.net,
        viro@zeniv.linux.org.uk, Christian Brauner <christian@brauner.io>
Subject: [PATCH v1 2/2] sysctl: handle overflow for file-max
Date:   Mon, 15 Oct 2018 12:55:44 +0200
Message-Id: <20181015105544.4395-3-christian@brauner.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181015105544.4395-1-christian@brauner.io>
References: <20181015105544.4395-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, when writing

echo 18446744073709551616 > /proc/sys/fs/file-max

/proc/sys/fs/file-max will overflow and be set to 0. That quickly
crashes the system.
This commit explicitly caps the value for file-max to ULONG_MAX.

Note, this isn't technically necessary since proc_get_long() will already
return ULONG_MAX. However, two reason why we still should do this:
1. it makes it explicit what the upper bound of file-max is instead of
   making readers of the code infer it from proc_get_long() themselves
2. other tunebles than file-max may want to set a lower max value than
   ULONG_MAX and we need to enable __do_proc_doulongvec_minmax() to handle
   such cases too

Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Christian Brauner <christian@brauner.io>
---
v0->v1:
- if max value is < than ULONG_MAX use max as upper bound
- (Dominik) remove double "the" from commit message
---
 kernel/sysctl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 97551eb42946..226d4eaf4b0e 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -127,6 +127,7 @@ static int __maybe_unused one = 1;
 static int __maybe_unused two = 2;
 static int __maybe_unused four = 4;
 static unsigned long one_ul = 1;
+static unsigned long ulong_max = ULONG_MAX;
 static int one_hundred = 100;
 static int one_thousand = 1000;
 #ifdef CONFIG_PRINTK
@@ -1696,6 +1697,7 @@ static struct ctl_table fs_table[] = {
 		.maxlen		= sizeof(files_stat.max_files),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
+		.extra2		= &ulong_max,
 	},
 	{
 		.procname	= "nr_open",
@@ -2795,6 +2797,8 @@ static int __do_proc_doulongvec_minmax(void *data, struct ctl_table *table, int
 				break;
 			if (neg)
 				continue;
+			if (max && val > *max)
+				val = *max;
 			val = convmul * val / convdiv;
 			if ((min && val < *min) || (max && val > *max))
 				continue;
-- 
2.17.1

