Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753160AbeE3LLE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:11:04 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60800 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752756AbeE3LHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:07:48 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Arnd Bergmann" <arnd@arndb.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.957553376@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 059/153] scsi: fas216: fix sense buffer initialization
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 96d5eaa9bb74d299508d811d865c2c41b38b0301 upstream.

While testing with the ARM specific memset() macro removed, I ran into a
compiler warning that shows an old bug:

drivers/scsi/arm/fas216.c: In function 'fas216_rq_sns_done':
drivers/scsi/arm/fas216.c:2014:40: error: argument to 'sizeof' in 'memset' call is the same expression as the destination; did you mean to provide an explicit length? [-Werror=sizeof-pointer-memaccess]

It turns out that the definition of the scsi_cmd structure changed back
in linux-2.6.25, so now we clear only four bytes (sizeof(pointer))
instead of 96 (SCSI_SENSE_BUFFERSIZE). I did not check whether we
actually need to initialize the buffer here, but it's clear that if we
do it, we should use the correct size.

Fixes: de25deb18016 ("[SCSI] use dynamically allocated sense buffer")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/scsi/arm/fas216.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/scsi/arm/fas216.c
+++ b/drivers/scsi/arm/fas216.c
@@ -2009,7 +2009,7 @@ static void fas216_rq_sns_done(FAS216_In
 		 * have valid data in the sense buffer that could
 		 * confuse the higher levels.
 		 */
-		memset(SCpnt->sense_buffer, 0, sizeof(SCpnt->sense_buffer));
+		memset(SCpnt->sense_buffer, 0, SCSI_SENSE_BUFFERSIZE);
 //printk("scsi%d.%c: sense buffer: ", info->host->host_no, '0' + SCpnt->device->id);
 //{ int i; for (i = 0; i < 32; i++) printk("%02x ", SCpnt->sense_buffer[i]); printk("\n"); }
 	/*
