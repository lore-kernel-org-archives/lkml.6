Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752966AbeCVBGB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 21:06:01 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:44311 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751883AbeCVBF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 21:05:59 -0400
X-Google-Smtp-Source: AG47ELsE3yb4Fi/5aUU9hVdcjVtda5516AbGy7rawmVRh+8VI0LSdDoBkz7AAjpOEq1d9ziKjMybVw==
To: linux-kernel@vger.kernel.org
From: Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH] dell_rbu: make firmware payload memory uncachable
Message-ID: <40006403-999f-fde5-316a-63e9a48ce11c@gmail.com>
Date: Wed, 21 Mar 2018 20:05:52 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
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
Note that there is no maintainer for this driver, so I'd be grateful if
someone could apply this... thank you!

diff --git a/drivers/firmware/dell_rbu.c b/drivers/firmware/dell_rbu.c
index 2f452f1..6b84814 100644
--- a/drivers/firmware/dell_rbu.c
+++ b/drivers/firmware/dell_rbu.c
@@ -180,6 +180,11 @@ static int create_packet(void *data, size_t length)
 			invalid_addr_packet_array[idx++] = packet_data_temp_buf;
 			packet_data_temp_buf = NULL;
 		}
+		/*
+		 * set to uncachable or it may never get written back before
+		 * reboot
+		 */
+		set_memory_uc(packet_data_temp_buf, 1 << (ordernum));
 	}
 	spin_lock(&rbu_data.lock);
 
@@ -349,6 +354,7 @@ static void packet_empty_list(void)
 		 * to make sure there are no stale RBU packets left in memory
 		 */
 		memset(newpacket->data, 0, rbu_data.packetsize);
+		set_memory_wb(newpacket->data, (1 << newpacket->ordernum));
 		free_pages((unsigned long) newpacket->data,
 			newpacket->ordernum);
 		kfree(newpacket);
