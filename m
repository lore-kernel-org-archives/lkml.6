Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751625AbeEFKwx (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 06:52:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38873 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750967AbeEFKwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 06:52:51 -0400
Date: Sun, 6 May 2018 03:52:35 -0700
From: "tip-bot for Luck, Tony" <tipbot@zytor.com>
Message-ID: <tip-985c78d3ff8e9c74450fa2bb08eb55e680d999ca@git.kernel.org>
Cc: dvyukov@google.com, tony.luck@intel.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
        bp@suse.de, linux-edac@vger.kernel.org
Reply-To: tony.luck@intel.com, dvyukov@google.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org, bp@suse.de,
        hpa@zytor.com, mingo@kernel.org
In-Reply-To: <20180427163707.ktaiysvbk3yhk4wm@agluck-desk>
References: <20180427163707.ktaiysvbk3yhk4wm@agluck-desk>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] x86/MCE: Fix stack out-of-bounds write in
 mce-inject.c: Flags_read()
Git-Commit-ID: 985c78d3ff8e9c74450fa2bb08eb55e680d999ca
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

Commit-ID:  985c78d3ff8e9c74450fa2bb08eb55e680d999ca
Gitweb:     https://git.kernel.org/tip/985c78d3ff8e9c74450fa2bb08eb55e680d999ca
Author:     Luck, Tony <tony.luck@intel.com>
AuthorDate: Fri, 27 Apr 2018 09:37:08 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 6 May 2018 12:46:39 +0200

x86/MCE: Fix stack out-of-bounds write in mce-inject.c: Flags_read()

Each of the strings that we want to put into the buf[MAX_FLAG_OPT_SIZE]
in flags_read() is two characters long. But the sprintf() adds
a trailing newline and will add a terminating NUL byte. So
MAX_FLAG_OPT_SIZE needs to be 4.

sprintf() calls vsnprintf() and *that* does return:

" * The return value is the number of characters which would
 * be generated for the given input, excluding the trailing
 * '\0', as per ISO C99."

Note the "excluding".

Reported-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Cc: linux-edac <linux-edac@vger.kernel.org>
Link: http://lkml.kernel.org/r/20180427163707.ktaiysvbk3yhk4wm@agluck-desk
---
 arch/x86/kernel/cpu/mcheck/mce-inject.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce-inject.c b/arch/x86/kernel/cpu/mcheck/mce-inject.c
index 475cb4f5f14f..c805a06e14c3 100644
--- a/arch/x86/kernel/cpu/mcheck/mce-inject.c
+++ b/arch/x86/kernel/cpu/mcheck/mce-inject.c
@@ -48,7 +48,7 @@ static struct dentry *dfs_inj;
 
 static u8 n_banks;
 
-#define MAX_FLAG_OPT_SIZE	3
+#define MAX_FLAG_OPT_SIZE	4
 #define NBCFG			0x44
 
 enum injection_type {
