Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751587AbeCQEoj (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 00:44:39 -0400
Received: from 4ray.co ([163.172.156.253]:53372 "EHLO 4ray.co"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750853AbeCQEoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 00:44:37 -0400
Subject: [PATCH] Input: atmel_mxt_ts: Add hook for Chromebooks with upstream
 coreboot
References: <158c166b-bd85-53ab-dc02-920667c7409d@4ray.co>
To: Nick Dyer <nick@shmanahar.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jean Lucas <jean@4ray.co>
X-Forwarded-Message-Id: <158c166b-bd85-53ab-dc02-920667c7409d@4ray.co>
Message-ID: <ccc2fe57-5d0f-4033-063f-9a9e941ef54e@4ray.co>
Date: Sat, 17 Mar 2018 00:37:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <158c166b-bd85-53ab-dc02-920667c7409d@4ray.co>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chromebooks use coreboot for system initialization. coreboot has always
had the default mainboard vendor string for Google machines set to
"Google". Google engineers set this string to "GOOGLE" in the coreboot
copies of the Chromium OS tree. The atmel_mxt_ts driver in it's current
state is set to match the latter case, i.e. it will only bind to a
Chromebook's touchscreen either if the device uses the downstream
coreboot firmware (providing the matching mainboard vendor string), or
if a user running upstream coreboot has manually set the string to
"GOOGLE". This patch adds a match for coreboot's default.

Signed-off-by: Jean Lucas <jean@4ray.co>
---
  drivers/input/touchscreen/atmel_mxt_ts.c | 8 ++++++++
  1 file changed, 8 insertions(+)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 7659bc48f1db..8c74a3e13cca 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -3038,6 +3038,14 @@ static const struct dmi_system_id mxt_dmi_table[] = {
  		},
  		.driver_data = chromebook_platform_data,
  	},
+	{
+		/* Chromebooks with upstream coreboot */
+		.ident = "Chromebook",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Google"),
+		},
+		.driver_data = chromebook_platform_data,
+	},
  	{ }
  };
  
-- 
2.16.2
