Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752019AbeENHvZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 03:51:25 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50361 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751584AbeENHvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 03:51:23 -0400
Date: Mon, 14 May 2018 00:50:55 -0700
From: tip-bot for Shunyong Yang <tipbot@zytor.com>
Message-ID: <tip-83f0a7c7b265a56d757f7e3a80622e5b0b7ebc46@git.kernel.org>
Cc: yu.zheng@hxt-semitech.com, peterz@infradead.org,
        shunyong.yang@hxt-semitech.com, hpa@zytor.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, matt@codeblueprint.co.uk,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        ard.biesheuvel@linaro.org
Reply-To: ard.biesheuvel@linaro.org, torvalds@linux-foundation.org,
        tglx@linutronix.de, matt@codeblueprint.co.uk,
        linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
        shunyong.yang@hxt-semitech.com, peterz@infradead.org,
        yu.zheng@hxt-semitech.com
In-Reply-To: <20180504060003.19618-17-ard.biesheuvel@linaro.org>
References: <20180504060003.19618-17-ard.biesheuvel@linaro.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:efi/core] efi/capsule-loader: Don't output reset log when
 reset flags are not set
Git-Commit-ID: 83f0a7c7b265a56d757f7e3a80622e5b0b7ebc46
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  83f0a7c7b265a56d757f7e3a80622e5b0b7ebc46
Gitweb:     https://git.kernel.org/tip/83f0a7c7b265a56d757f7e3a80622e5b0b7ebc46
Author:     Shunyong Yang <shunyong.yang@hxt-semitech.com>
AuthorDate: Fri, 4 May 2018 08:00:02 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 14 May 2018 08:57:49 +0200

efi/capsule-loader: Don't output reset log when reset flags are not set

When reset flags in capsule header are not set, it means firmware
attempts to immediately process or launch the capsule. Moreover, reset
is not needed in this case. The current code will output log to indicate
reset.

This patch adds a branch to avoid reset log output when the flags are not
set.

[ardb: use braces in multi-line 'if', clarify comment and commit log]
Signed-off-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Joey Zheng <yu.zheng@hxt-semitech.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20180504060003.19618-17-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/firmware/efi/capsule-loader.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/capsule-loader.c b/drivers/firmware/efi/capsule-loader.c
index e456f4602df1..96688986da56 100644
--- a/drivers/firmware/efi/capsule-loader.c
+++ b/drivers/firmware/efi/capsule-loader.c
@@ -134,10 +134,16 @@ static ssize_t efi_capsule_submit_update(struct capsule_info *cap_info)
 
 	/* Indicate capsule binary uploading is done */
 	cap_info->index = NO_FURTHER_WRITE_ACTION;
-	pr_info("Successfully upload capsule file with reboot type '%s'\n",
-		!cap_info->reset_type ? "RESET_COLD" :
-		cap_info->reset_type == 1 ? "RESET_WARM" :
-		"RESET_SHUTDOWN");
+
+	if (cap_info->header.flags & EFI_CAPSULE_PERSIST_ACROSS_RESET) {
+		pr_info("Successfully uploaded capsule file with reboot type '%s'\n",
+			!cap_info->reset_type ? "RESET_COLD" :
+			cap_info->reset_type == 1 ? "RESET_WARM" :
+			"RESET_SHUTDOWN");
+	} else {
+		pr_info("Successfully processed capsule file\n");
+	}
+
 	return 0;
 }
 
