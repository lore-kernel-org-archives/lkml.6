Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4148BC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 21:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E44552170E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 21:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LGKkG2bQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E44552170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbeI1EJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 00:09:47 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46630 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbeI1EJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 00:09:46 -0400
Received: by mail-pf1-f193.google.com with SMTP id d8-v6so2787079pfo.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 14:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B6l8jerKtTXk/CrbjKV62VlnykqbZHG54l7LeLJ9htE=;
        b=LGKkG2bQXPyM8blizifIVSWcoqHPbKj7O9hqFQi0c1itiZJHa2styZZCa4Rxcvk33C
         s+lrcTT9qdZYZ3gh1owwm5/auOyCTBultFBN9DCko+Ojjny085HKBvl25/FKG2wHZdRy
         SpIAWKgWkXsvgTwEdiQNMFn2cZzuxGyBK3cuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B6l8jerKtTXk/CrbjKV62VlnykqbZHG54l7LeLJ9htE=;
        b=lKb5vpMMCoFjyMojvOVfuK4XXvUIgHLIrj5NiB28qFPMzv/X9zu32NEwVdU7IMXys3
         gdzumT86bC47Y5Jhse8KhoZf4NvtlCaHs5I5XOXbGEXHCLf6wvVKqjXxnyzWpwKgWNQj
         cmMoCtBgkomcfiZGyArKtj59lFn+2MzB/BQ6AJSrl/nFMnMNvY23uB82eaDkRmiFYgmG
         D25zVjNQPtawdyiuPH6JIoLw0P/n8Cq7t4lyJxDvHozLRqZJjvLJAfrD4rMFs+jRtQ4x
         SFdEBz8hWtKHNDUtAtu5tFiuZRY+hggN4TLT3uguUCB+qyj0JuMWFjQDm5b/DYXzJpQw
         5Jvg==
X-Gm-Message-State: ABuFfoivdP224O46l6StlW7Mr5e5UZBUHGqrJFlno5/Kkm0Lg2tZHqb6
        sc7Z4Q3uhV0HAmtjgTEZuDC+EA==
X-Google-Smtp-Source: ACcGV63Y9kwmBUJmdP2zJfqbh4L+wGL+PXoqNoX9ix39uSNFTX6i0f6B8jTSwZIpvZeznJED9P1QaA==
X-Received: by 2002:a62:c60e:: with SMTP id m14-v6mr13645704pfg.40.1538084964943;
        Thu, 27 Sep 2018 14:49:24 -0700 (PDT)
Received: from zsm-linux.mtv.corp.google.com ([2620:15c:202:201:1b7c:8280:c835:b226])
        by smtp.googlemail.com with ESMTPSA id h10-v6sm5042350pfj.78.2018.09.27.14.49.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 14:49:23 -0700 (PDT)
From:   Zubin Mithra <zsm@chromium.org>
To:     john.johansen@canonical.com, jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, groeck@chromium.org,
        dvyukov@google.com, zsm@chromium.org
Subject: [PATCH] apparmor: Fix uninitialized value in aa_split_fqname
Date:   Thu, 27 Sep 2018 14:49:17 -0700
Message-Id: <20180927214917.10486-1-zsm@chromium.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzkaller reported a OOB-read with the stacktrace below. This occurs
inside __aa_lookupn_ns as `n` is not initialized. `n` is obtained from
aa_splitn_fqname. In cases where `name` is invalid, aa_splitn_fqname
returns without initializing `ns_name` and `ns_len`.

Fix this by always initializing `ns_name` and `ns_len`.

	__dump_stack lib/dump_stack.c:77 [inline]
	dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
	print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
	kasan_report_error mm/kasan/report.c:354 [inline]
	kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
	__asan_report_load1_noabort+0x14/0x20 mm/kasan/report.c:430
	memcmp+0xe3/0x160 lib/string.c:861
	strnstr+0x4b/0x70 lib/string.c:934
	__aa_lookupn_ns+0xc1/0x570 security/apparmor/policy_ns.c:209
	aa_lookupn_ns+0x88/0x1e0 security/apparmor/policy_ns.c:240
	aa_fqlookupn_profile+0x1b9/0x1010 security/apparmor/policy.c:468
	fqlookupn_profile+0x80/0xc0 security/apparmor/label.c:1844
	aa_label_strn_parse+0xa3a/0x1230 security/apparmor/label.c:1908
	aa_label_parse+0x42/0x50 security/apparmor/label.c:1943
	aa_change_profile+0x513/0x3510 security/apparmor/domain.c:1362
	apparmor_setprocattr+0xaa4/0x1150 security/apparmor/lsm.c:658
	security_setprocattr+0x66/0xc0 security/security.c:1298
	proc_pid_attr_write+0x301/0x540 fs/proc/base.c:2555
	__vfs_write+0x119/0x9f0 fs/read_write.c:485
	vfs_write+0x1fc/0x560 fs/read_write.c:549
	ksys_write+0x101/0x260 fs/read_write.c:598
	__do_sys_write fs/read_write.c:610 [inline]
	__se_sys_write fs/read_write.c:607 [inline]
	__x64_sys_write+0x73/0xb0 fs/read_write.c:607
	do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
	entry_SYSCALL_64_after_hwframe+0x49/0xbe

Fixes: 3b0aaf5866bf ("apparmor: add lib fn to find the "split" for fqnames")
Reported-by: syzbot+61e4b490d9d2da591b50@syzkaller.appspotmail.com
Signed-off-by: Zubin Mithra <zsm@chromium.org>
---
 security/apparmor/lib.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/security/apparmor/lib.c b/security/apparmor/lib.c
index 974affe50531..76491e7f4177 100644
--- a/security/apparmor/lib.c
+++ b/security/apparmor/lib.c
@@ -90,10 +90,12 @@ const char *aa_splitn_fqname(const char *fqname, size_t n, const char **ns_name,
 	const char *end = fqname + n;
 	const char *name = skipn_spaces(fqname, n);
 
-	if (!name)
-		return NULL;
 	*ns_name = NULL;
 	*ns_len = 0;
+
+	if (!name)
+		return NULL;
+
 	if (name[0] == ':') {
 		char *split = strnchr(&name[1], end - &name[1], ':');
 		*ns_name = skipn_spaces(&name[1], end - &name[1]);
-- 
2.19.0.605.g01d371f741-goog

