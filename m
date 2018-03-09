Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932067AbeCIJML (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 04:12:11 -0500
Received: from terminus.zytor.com ([198.137.202.136]:33123 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751045AbeCIJMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 04:12:07 -0500
Date: Fri, 9 Mar 2018 01:11:45 -0800
From: tip-bot for Andy Shevchenko <tipbot@zytor.com>
Message-ID: <tip-6e98503dba64e721ba839e75dca036266ec0140f@git.kernel.org>
Cc: peterz@infradead.org, ard.biesheuvel@linaro.org, hpa@zytor.com,
        tglx@linutronix.de, lukas@wunner.de, torvalds@linux-foundation.org,
        andriy.shevchenko@linux.intel.com, matt@codeblueprint.co.uk,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Reply-To: torvalds@linux-foundation.org, tglx@linutronix.de, lukas@wunner.de,
        peterz@infradead.org, hpa@zytor.com, ard.biesheuvel@linaro.org,
        linux-kernel@vger.kernel.org, matt@codeblueprint.co.uk,
        mingo@kernel.org, andriy.shevchenko@linux.intel.com
In-Reply-To: <20180308080020.22828-3-ard.biesheuvel@linaro.org>
References: <20180308080020.22828-3-ard.biesheuvel@linaro.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:efi/core] efi/apple-properties: Remove redundant attribute
 initialization from unmarshal_key_value_pairs()
Git-Commit-ID: 6e98503dba64e721ba839e75dca036266ec0140f
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

Commit-ID:  6e98503dba64e721ba839e75dca036266ec0140f
Gitweb:     https://git.kernel.org/tip/6e98503dba64e721ba839e75dca036266ec0140f
Author:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate: Thu, 8 Mar 2018 08:00:10 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 9 Mar 2018 08:58:21 +0100

efi/apple-properties: Remove redundant attribute initialization from unmarshal_key_value_pairs()

There is no need to artificially supply a property length and fake data
if property has type of boolean.

Remove redundant piece of data and code.

Reviewed-and-tested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20180308080020.22828-3-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/firmware/efi/apple-properties.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/firmware/efi/apple-properties.c b/drivers/firmware/efi/apple-properties.c
index 9f6bcf173b0e..b9602e0d7b50 100644
--- a/drivers/firmware/efi/apple-properties.c
+++ b/drivers/firmware/efi/apple-properties.c
@@ -52,8 +52,6 @@ struct properties_header {
 	struct dev_header dev_header[0];
 };
 
-static u8 one __initdata = 1;
-
 static void __init unmarshal_key_value_pairs(struct dev_header *dev_header,
 					     struct device *dev, void *ptr,
 					     struct property_entry entry[])
@@ -95,14 +93,9 @@ static void __init unmarshal_key_value_pairs(struct dev_header *dev_header,
 			     key_len - sizeof(key_len));
 
 		entry[i].name = key;
-		entry[i].is_array = true;
 		entry[i].length = val_len - sizeof(val_len);
+		entry[i].is_array = !!entry[i].length;
 		entry[i].pointer.raw_data = ptr + key_len + sizeof(val_len);
-		if (!entry[i].length) {
-			/* driver core doesn't accept empty properties */
-			entry[i].length = 1;
-			entry[i].pointer.raw_data = &one;
-		}
 
 		if (dump_properties) {
 			dev_info(dev, "property: %s\n", entry[i].name);
