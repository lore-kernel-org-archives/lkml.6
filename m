Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754644AbeE1QAo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 12:00:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:35898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936934AbeE1KPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:15:46 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 039/268] scsi: fas216: fix sense buffer initialization
Date: Mon, 28 May 2018 12:00:13 +0200
Message-Id: <20180528100206.481220518@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100202.045206534@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 96d5eaa9bb74d299508d811d865c2c41b38b0301 ]

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/arm/fas216.c |    2 +-
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
