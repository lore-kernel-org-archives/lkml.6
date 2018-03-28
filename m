Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753924AbeC1PHv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 11:07:51 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:46627 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753327AbeC1PHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 11:07:49 -0400
X-Google-Smtp-Source: AIpwx49Ny8uZa3pOy1gEBHJAt3YI6+ZPO6I+C3zCf64TV1n35tJtWaQo+1T3ajvp5EYf3XTKVvmNhg==
To: linux-kernel@vger.kernel.org
From: Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH v3] dell_rbu: make firmware payload memory uncachable
Cc: Douglas_Warzecha@Dell.com
Message-ID: <26829bed-39e5-c35d-8800-7116adaea603@gmail.com>
Date: Wed, 28 Mar 2018 10:07:47 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dell_rbu driver takes firmware update payloads and puts them in memory so
the system BIOS can find them after a reboot.  This sometimes fails (though
rarely), because the memory containing the payload is in the CPU cache but
never gets written back to main memory before the system is rebooted (CPU
cache contents are lost on reboot).

With this patch, the payload memory will be changed to uncachable to ensure
that the payload is actually in main memory before the system is rebooted.

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
---
v2 Added include, removed extra parentheses
v3 Corrected formatting and include line

This driver has no maintainer.


diff --git a/drivers/firmware/dell_rbu.c b/drivers/firmware/dell_rbu.c
index 2f452f1f7c8a..778efbb72c76 100644
--- a/drivers/firmware/dell_rbu.c
+++ b/drivers/firmware/dell_rbu.c
@@ -45,6 +45,7 @@
 #include <linux/moduleparam.h>
 #include <linux/firmware.h>
 #include <linux/dma-mapping.h>
+#include <asm/set_memory.h>
 
 MODULE_AUTHOR("Abhay Salunke <abhay_salunke@dell.com>");
 MODULE_DESCRIPTION("Driver for updating BIOS image on DELL systems");
@@ -180,6 +181,12 @@ static int create_packet(void *data, size_t length)
 			invalid_addr_packet_array[idx++] = packet_data_temp_buf;
 			packet_data_temp_buf = NULL;
 		}
+		/*
+		 * set to uncachable or it may never get written back before
+		 * reboot
+		 */
+		set_memory_uc((unsigned long)packet_data_temp_buf,
+			1 << ordernum);
 	}
 	spin_lock(&rbu_data.lock);
 
@@ -349,6 +356,8 @@ static void packet_empty_list(void)
 		 * to make sure there are no stale RBU packets left in memory
 		 */
 		memset(newpacket->data, 0, rbu_data.packetsize);
+		set_memory_wb((unsigned long)newpacket->data,
+			1 << newpacket->ordernum);
 		free_pages((unsigned long) newpacket->data,
 			newpacket->ordernum);
 		kfree(newpacket);
