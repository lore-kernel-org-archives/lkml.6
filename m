Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753205AbeE3LQJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:16:09 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60672 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751537AbeE3LHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:07:24 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Christoph Hellwig" <hch@lst.de>,
        "Jens Axboe" <axboe@kernel.dk>,
        "Dan Carpenter" <dan.carpenter@oracle.com>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.43065599@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 024/153] cdrom: information leak in cdrom_ioctl_media_changed()
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>

commit 9de4ee40547fd315d4a0ed1dd15a2fa3559ad707 upstream.

This cast is wrong.  "cdi->capacity" is an int and "arg" is an unsigned
long.  The way the check is written now, if one of the high 32 bits is
set then we could read outside the info->slots[] array.

This bug is pretty old and it predates git.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/cdrom/cdrom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -2342,7 +2342,7 @@ static int cdrom_ioctl_media_changed(str
 	if (!CDROM_CAN(CDC_SELECT_DISC) || arg == CDSL_CURRENT)
 		return media_changed(cdi, 1);
 
-	if ((unsigned int)arg >= cdi->capacity)
+	if (arg >= cdi->capacity)
 		return -EINVAL;
 
 	info = kmalloc(sizeof(*info), GFP_KERNEL);
