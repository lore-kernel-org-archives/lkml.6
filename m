Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755237AbeCHIFU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 03:05:20 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32824 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964863AbeCHIB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 03:01:56 -0500
X-Google-Smtp-Source: AG47ELuIxdWAW+FS5bQoF/l/9e5bnOgdUbMKS+FIIf11cuE5sntY92DMuMzZRUTxoD7n7uBN4hjEgw==
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/12] efi/apple-properties: Device core takes care of empty properties
Date: Thu,  8 Mar 2018 08:00:10 +0000
Message-Id: <20180308080020.22828-3-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180308080020.22828-1-ard.biesheuvel@linaro.org>
References: <20180308080020.22828-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

There is no need to artificially supply a property length and fake data
if property has type of boolean.

Remove redundant piece of data and code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-and-tested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
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
-- 
2.15.1
