Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07160C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D27241F1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:46:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2D27241F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754184AbeFVMqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 08:46:02 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50647 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751315AbeFVMqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 08:46:00 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5MCjkjN071735
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 22 Jun 2018 05:45:46 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5MCjkvT071732;
        Fri, 22 Jun 2018 05:45:46 -0700
Date:   Fri, 22 Jun 2018 05:45:46 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Zhenzhong Duan <tipbot@zytor.com>
Message-ID: <tip-0218c766263e70795c5eaa17d75ed54bca350950@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        zhenzhong.duan@oracle.com, bp@suse.de, srinivas.eeda@oracle.com,
        hpa@zytor.com
Reply-To: hpa@zytor.com, bp@suse.de, srinivas.eeda@oracle.com,
          mingo@kernel.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, zhenzhong.duan@oracle.com
In-Reply-To: <888102f0-fd22-459d-b090-a1bd8a00cb2b@default>
References: <888102f0-fd22-459d-b090-a1bd8a00cb2b@default>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/microcode/intel: Fix memleak in
 save_microcode_patch()
Git-Commit-ID: 0218c766263e70795c5eaa17d75ed54bca350950
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

Commit-ID:  0218c766263e70795c5eaa17d75ed54bca350950
Gitweb:     https://git.kernel.org/tip/0218c766263e70795c5eaa17d75ed54bca350950
Author:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
AuthorDate: Fri, 22 Jun 2018 13:51:26 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 22 Jun 2018 14:42:59 +0200

x86/microcode/intel: Fix memleak in save_microcode_patch()

Free useless ucode_patch entry when it's replaced.

[ bp: Drop the memfree_patch() two-liner. ]

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Srinivas REDDY Eeda <srinivas.eeda@oracle.com>
Link: http://lkml.kernel.org/r/888102f0-fd22-459d-b090-a1bd8a00cb2b@default

---
 arch/x86/kernel/cpu/microcode/intel.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 1c2cfa0644aa..97ccf4c3b45b 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -190,8 +190,11 @@ static void save_microcode_patch(void *data, unsigned int size)
 			p = memdup_patch(data, size);
 			if (!p)
 				pr_err("Error allocating buffer %p\n", data);
-			else
+			else {
 				list_replace(&iter->plist, &p->plist);
+				kfree(iter->data);
+				kfree(iter);
+			}
 		}
 	}
 
