Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72289C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CED2217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbeLRXD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 18:03:58 -0500
Received: from terminus.zytor.com ([198.137.202.136]:58373 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbeLRXD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 18:03:57 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBIN3pID3002209
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Dec 2018 15:03:51 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBIN3oKT3002206;
        Tue, 18 Dec 2018 15:03:50 -0800
Date:   Tue, 18 Dec 2018 15:03:50 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Colin Ian King <tipbot@zytor.com>
Message-ID: <tip-32043fa065b51e0b1433e48d118821c71b5cd65d@git.kernel.org>
Cc:     tyhicks@canonical.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, tglx@linutronix.de, colin.king@canonical.com,
        hpa@zytor.com
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org,
          tyhicks@canonical.com, hpa@zytor.com, colin.king@canonical.com,
          tglx@linutronix.de
In-Reply-To: <20181218172956.1440-1-colin.king@canonical.com>
References: <20181218172956.1440-1-colin.king@canonical.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/mtrr: Don't copy uninitialized gentry fields
 back to userspace
Git-Commit-ID: 32043fa065b51e0b1433e48d118821c71b5cd65d
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  32043fa065b51e0b1433e48d118821c71b5cd65d
Gitweb:     https://git.kernel.org/tip/32043fa065b51e0b1433e48d118821c71b5cd65d
Author:     Colin Ian King <colin.king@canonical.com>
AuthorDate: Tue, 18 Dec 2018 17:29:56 +0000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 19 Dec 2018 00:00:16 +0100

x86/mtrr: Don't copy uninitialized gentry fields back to userspace

Currently the copy_to_user of data in the gentry struct is copying
uninitiaized data in field _pad from the stack to userspace.

Fix this by explicitly memset'ing gentry to zero, this also will zero any
compiler added padding fields that may be in struct (currently there are
none).

Detected by CoverityScan, CID#200783 ("Uninitialized scalar variable")

Fixes: b263b31e8ad6 ("x86, mtrr: Use explicit sizing and padding for the 64-bit ioctls")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Tyler Hicks <tyhicks@canonical.com>
Cc: security@kernel.org
Link: https://lkml.kernel.org/r/20181218172956.1440-1-colin.king@canonical.com


---
 arch/x86/kernel/cpu/mtrr/if.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/mtrr/if.c b/arch/x86/kernel/cpu/mtrr/if.c
index 2e173d47b450..4d36dcc1cf87 100644
--- a/arch/x86/kernel/cpu/mtrr/if.c
+++ b/arch/x86/kernel/cpu/mtrr/if.c
@@ -165,6 +165,8 @@ mtrr_ioctl(struct file *file, unsigned int cmd, unsigned long __arg)
 	struct mtrr_gentry gentry;
 	void __user *arg = (void __user *) __arg;
 
+	memset(&gentry, 0, sizeof(gentry));
+
 	switch (cmd) {
 	case MTRRIOC_ADD_ENTRY:
 	case MTRRIOC_SET_ENTRY:
