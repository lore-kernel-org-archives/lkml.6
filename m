Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CEAC43610
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 06:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FC572082A
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 06:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OyWxOPih"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FC572082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731787AbeKMQAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 11:00:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:60736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731362AbeKMPq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 10:46:58 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63A6522522;
        Tue, 13 Nov 2018 05:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542088231;
        bh=ReUernQqS4tozE1OPy3w7M9VZmyf+c7zWqJULAlhLVQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OyWxOPihOioyHtBfaQ7XSI8LUySN7BPJMvIcFhUD7ZHs4NJi9/6tVAI084zusvisJ
         gqn13FO+5+7UCuYmX/ITNyzVmpTCnB1ejM1lPy4iLSQWdJ8s/sZz6VT8MYhzfRwYTQ
         lwvisE2dykcDV0mKoToAYxLOtwIMRj/nlVeHHiVk=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Zubin Mithra <zsm@chromium.org>,
        John Johansen <john.johansen@canonical.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-security-module@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 28/44] apparmor: Fix uninitialized value in aa_split_fqname
Date:   Tue, 13 Nov 2018 00:49:34 -0500
Message-Id: <20181113054950.77898-28-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181113054950.77898-1-sashal@kernel.org>
References: <20181113054950.77898-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zubin Mithra <zsm@chromium.org>

[ Upstream commit 250f2da49cb8e582215a65c03f50e8ddf5cd119c ]

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
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
2.17.1

