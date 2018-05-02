Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751365AbeEBLI2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 07:08:28 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55868 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751271AbeEBLIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 07:08:20 -0400
X-Google-Smtp-Source: AB8JxZrPHtoI/75RKweS9DIoVu7UdR89rCcEoKpjHh4n0zWecudKwDv8AQ1BYN+OgtRWcgjybEs/bA==
From: Gioh Kim <gi-oh.kim@profitbricks.com>
To: shli@kernel.org
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gioh Kim <gi-oh.kim@profitbricks.com>
Subject: [PATCH] md/raid1: add error handling of read error from FailFast device
Date: Wed,  2 May 2018 13:08:11 +0200
Message-Id: <20180502110811.10886-1-gi-oh.kim@profitbricks.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current handle_read_error() function calls fix_read_error()
only if md device is RW and rdev does not include FailFast flag.
It does not handle a read error from a RW device including
FailFast flag.

I am not sure it is intended. But I found that write IO error
sets rdev faulty. The md module should handle the read IO error and
write IO error equally. So I think read IO error should set rdev faulty.

Signed-off-by: Gioh Kim <gi-oh.kim@profitbricks.com>
---
 drivers/md/raid1.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index e9e3308cb0a7..4445179aa4c8 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2474,6 +2474,8 @@ static void handle_read_error(struct r1conf *conf, struct r1bio *r1_bio)
 		fix_read_error(conf, r1_bio->read_disk,
 			       r1_bio->sector, r1_bio->sectors);
 		unfreeze_array(conf);
+	} else if (mddev->ro == 0 && test_bit(FailFast, &rdev->flags)) {
+		md_error(mddev, rdev);
 	} else {
 		r1_bio->bios[r1_bio->read_disk] = IO_BLOCKED;
 	}
-- 
2.14.1
