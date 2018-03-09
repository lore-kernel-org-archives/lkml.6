Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751878AbeCIJOn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 04:14:43 -0500
Received: from terminus.zytor.com ([198.137.202.136]:42473 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751190AbeCIJOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 04:14:40 -0500
Date: Fri, 9 Mar 2018 01:14:19 -0800
From: tip-bot for Andy Shevchenko <tipbot@zytor.com>
Message-ID: <tip-44612d7e0c379001460b37a29721128715bdcb02@git.kernel.org>
Cc: mingo@kernel.org, peterz@infradead.org, lukas@wunner.de,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        matt@codeblueprint.co.uk, hpa@zytor.com, tglx@linutronix.de,
        andriy.shevchenko@linux.intel.com, ard.biesheuvel@linaro.org
Reply-To: torvalds@linux-foundation.org, lukas@wunner.de,
        linux-kernel@vger.kernel.org, hpa@zytor.com, matt@codeblueprint.co.uk,
        ard.biesheuvel@linaro.org, tglx@linutronix.de,
        andriy.shevchenko@linux.intel.com, mingo@kernel.org,
        peterz@infradead.org
In-Reply-To: <20180308080020.22828-12-ard.biesheuvel@linaro.org>
References: <20180308080020.22828-12-ard.biesheuvel@linaro.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:efi/core] efi/apple-properties: Use memremap() instead of
 ioremap()
Git-Commit-ID: 44612d7e0c379001460b37a29721128715bdcb02
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

Commit-ID:  44612d7e0c379001460b37a29721128715bdcb02
Gitweb:     https://git.kernel.org/tip/44612d7e0c379001460b37a29721128715bdcb02
Author:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate: Thu, 8 Mar 2018 08:00:19 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 9 Mar 2018 08:58:23 +0100

efi/apple-properties: Use memremap() instead of ioremap()

The memory we are accessing through virtual address has no IO side
effects. Moreover, for IO memory we have to use special accessors,
which we don't use.

Due to above, convert the driver to use memremap() instead of ioremap().

Tested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20180308080020.22828-12-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/firmware/efi/apple-properties.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/efi/apple-properties.c b/drivers/firmware/efi/apple-properties.c
index b9602e0d7b50..adaa9a3714b9 100644
--- a/drivers/firmware/efi/apple-properties.c
+++ b/drivers/firmware/efi/apple-properties.c
@@ -19,6 +19,7 @@
 
 #include <linux/bootmem.h>
 #include <linux/efi.h>
+#include <linux/io.h>
 #include <linux/platform_data/x86/apple.h>
 #include <linux/property.h>
 #include <linux/slab.h>
@@ -189,7 +190,7 @@ static int __init map_properties(void)
 
 	pa_data = boot_params.hdr.setup_data;
 	while (pa_data) {
-		data = ioremap(pa_data, sizeof(*data));
+		data = memremap(pa_data, sizeof(*data), MEMREMAP_WB);
 		if (!data) {
 			pr_err("cannot map setup_data header\n");
 			return -ENOMEM;
@@ -197,14 +198,14 @@ static int __init map_properties(void)
 
 		if (data->type != SETUP_APPLE_PROPERTIES) {
 			pa_data = data->next;
-			iounmap(data);
+			memunmap(data);
 			continue;
 		}
 
 		data_len = data->len;
-		iounmap(data);
+		memunmap(data);
 
-		data = ioremap(pa_data, sizeof(*data) + data_len);
+		data = memremap(pa_data, sizeof(*data) + data_len, MEMREMAP_WB);
 		if (!data) {
 			pr_err("cannot map setup_data payload\n");
 			return -ENOMEM;
@@ -229,7 +230,7 @@ static int __init map_properties(void)
 		 * to avoid breaking the chain of ->next pointers.
 		 */
 		data->len = 0;
-		iounmap(data);
+		memunmap(data);
 		free_bootmem_late(pa_data + sizeof(*data), data_len);
 
 		return ret;
