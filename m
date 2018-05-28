Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939728AbeE1Pzp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:55:45 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:54309 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1425306AbeE1Pyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 11:54:39 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com
Cc: Arnd Bergmann <arnd@arndb.de>, Mikulas Patocka <mpatocka@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dm: writecache: fix format string warning
Date: Mon, 28 May 2018 17:54:08 +0200
Message-Id: <20180528155432.2864616-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:OuQAuBy5FnNSWcfQkuBi26IBYBKp7OHdZJbtdqQIvUSZKX8yCEy
 IFqksAens5aj2BW60aJ4/LQLUv15d/sh3rkuOXfM/uJZ7ifn3IVVJLMt++5o5V4GPKEWHV2
 8ts5J0MBX9mS6/w/naFo1VhAwmMWgfWIX2VS6dCl5Fen5o/CZLsnafKItIghtTqYHC1i+kg
 KzJu5TuncsiT2GOBEuTRQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:H0Ba6efZIrM=:u+MtdebvAAh2uHA+g5Ga3W
 aQAeWVE51XaYCjrqBB4FHdMFJChwaqu5ohRrUFHwRX7fU4IeuOYCIQb0uFxQrMePgrIAKTuN/
 /TJQA3CpIG/bLzhDp2vJaadO+bBjIyxqDCoJxm+51tdH+oGtqFht4wk6iGIjVqAMLey63N6+6
 N5fRFd5oue6+1tOzPjq/Q6CVfAO0kNMyxa+UESHhV/W9ZU4Ale8VaucpzqAiU8rVLOPWwJ6fA
 4Mku32PfrbPmyDjIg9ZItKva5LXVPFs0+UW2MIY7U2Fd323nBDvwPeRp9fqiQoVMPC88o5GT/
 YKLPQ0MRqBHHP+P+zsHAuDJgjwjKHHb48SwbqartJgKbVmYA+WiUbxnMoBch5eTA53PEuKFdO
 ni3f95a4XY2V40nx5Wm3lyaXLE86a7tuhYQfo4t5+qAfht2evRLVS5NPau+zZXdJ9dXdGp/Cl
 oIm+lcQXCj3din4UNFuJOricKllcvSFZ2XBJmt3aIy22vDM1Ww21/WsApMJ04qO+vbR7Z+IRl
 y1dAiS5ojz8c7s78/7zE1+meyy5zss/eGwo9TYBLHSnwrbkYrUOFHDl9jrefuAb9Ftu8M+jPp
 iAuOe1zj1yORErG/dnaDlYPJEXpcnJI0RYtzRrRZfFcm0HFY0uNGitjXFLB87qeSok4d7dRKm
 Pg6SjGqhdFcJ4fMk04ZF245UDp0xMXX34p4AwINKvdIVsUZTG1tDL71Tk1MaBiVkZSDA=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return type of ACCESS_ONCE is configuration dependent and may be either
'int' or 'long int' for the writecache_has_error() macro, so we get a warning
like this for either format string:

In file included from drivers/md/dm-writecache.c:8:
drivers/md/dm-writecache.c: In function 'writecache_status':
drivers/md/dm-writecache.c:2227:10: error: format '%ld' expects argument of type 'long int', but argument 4 has type 'int' [-Werror=format=]
   DMEMIT("%ld %llu %llu %llu", writecache_has_error(wc),
          ^~~~~~~~~~~~~~~~~~~~
include/linux/device-mapper.h:549:46: note: in definition of macro 'DMEMIT'
      0 : scnprintf(result + sz, maxlen - sz, x))
                                              ^

The code is otherwise correct, so we just need to shut up the warning,
which can be done using an extra type cast.

Fixes: bb15b431d650 ("dm: add writecache target")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/md/dm-writecache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index 1ef06e738eb6..772ac3a57287 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -2224,7 +2224,7 @@ static void writecache_status(struct dm_target *ti, status_type_t type,
 
 	switch (type) {
 	case STATUSTYPE_INFO:
-		DMEMIT("%ld %llu %llu %llu", writecache_has_error(wc),
+		DMEMIT("%ld %llu %llu %llu", (long)writecache_has_error(wc),
 		       (unsigned long long)wc->n_blocks, (unsigned long long)wc->freelist_size,
 		       (unsigned long long)wc->writeback_size);
 		break;
-- 
2.9.0
