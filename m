Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031886AbeBNWft (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 17:35:49 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:47949 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031527AbeBNWfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 17:35:48 -0500
From: Colin King <colin.king@canonical.com>
To: "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: scsi_transport_spi make two const arrays static, shrinks object size
Date: Wed, 14 Feb 2018 22:35:43 +0000
Message-Id: <20180214223543.23237-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the const read-only arrays spi_test_unit_ready and
spi_test_unit_ready on the stack but instead make them static. Makes the
object code smaller by over 100 bytes:

Before:
   text	   data	    bss	    dec	    hex	filename
  40171	  12832	    128	  53131	   cf8b	drivers/scsi/scsi_transport_spi.o

After:
   text	   data	    bss	    dec	    hex	filename
  39922	  12976	    128	  53026	   cf22	drivers/scsi/scsi_transport_spi.o

(gcc version 7.2.0 x86_64)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/scsi_transport_spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/scsi_transport_spi.c b/drivers/scsi/scsi_transport_spi.c
index 871ea582029e..2ca150b16764 100644
--- a/drivers/scsi/scsi_transport_spi.c
+++ b/drivers/scsi/scsi_transport_spi.c
@@ -822,11 +822,11 @@ spi_dv_device_get_echo_buffer(struct scsi_device *sdev, u8 *buffer)
 	 * fails, the device won't let us write to the echo buffer
 	 * so just return failure */
 	
-	const char spi_test_unit_ready[] = {
+	static const char spi_test_unit_ready[] = {
 		TEST_UNIT_READY, 0, 0, 0, 0, 0
 	};
 
-	const char spi_read_buffer_descriptor[] = {
+	static const char spi_read_buffer_descriptor[] = {
 		READ_BUFFER, 0x0b, 0, 0, 0, 0, 0, 0, 4, 0
 	};
 
-- 
2.15.1
