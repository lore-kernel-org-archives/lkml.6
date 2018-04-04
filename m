Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751155AbeDDJto (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 05:49:44 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:39525 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750814AbeDDJtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 05:49:42 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>,
        Alex Elder <elder@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: Arnd Bergmann <arnd@arndb.de>, Jason Dillaman <dillaman@redhat.com>,
        ceph-devel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rbd: add missing return statements
Date: Wed,  4 Apr 2018 11:49:22 +0200
Message-Id: <20180404094931.2345742-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:2eqiCP0PnfsWewcUKSn2SCTy+DnBjobuJ/6VtkV4fL3opH2PuLn
 UgWodwMlMAmUymrqlrTwko3y1ThJhtvmnrJLcr/zgSCRMn5iljxc86I7Wh10hWydh7sQ06D
 cXZKgZfGqkYjW+c7YIGgL6Djf1jU7VIDw8s/XQgXJiOjajEI7XHa4tsVQ6GrgW6+mngIyzC
 6XF2+VLe1vHhHlu9qiUPA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2nZUGX+MFWo=:/DUhrwuR6joHieZ/Okh83N
 rDTMV62CpRjg+ZcL5Nsqwg54f12SFjd8+Y8vtakKsyt5OY8YuhHeMZ/LAFmHvpeb2qI/AvC7X
 u1RQH5Em731vU/H++eecubQr+6yPxpMwtkNxq/cd1C196AgCFlpVN1/7NpemmDwB7W88+HiH5
 TZI92BgqJi98SQEEyGIIT+a3P1peyADiwvDND3BtkiQa8fg+WVFuWfGusU3Q7Zk6wVuZYWDxt
 usARohLvdX+pj5xhtEMw2FwjkNbhuVEOPvQqLwGbjaWO8UBAYFRXL0/iPpiyN5Afl6EmjMjEH
 ltW5qhQfXVoi+ppNi3xKyLuQBTgghXUUdNeMBvr3V0NDcVYIESjuQZ2+V3UIQMiigGIxIr0YE
 vyoHnhwoK6XIkPKB0OUUM1HisCcOEC7Y38pLZzOasBQTSrAc9o3riXTDjdJBzDkr4V+8KhB/e
 nYrZW8SUVCF6pqa5cJJM5KqikQAujZZ7EA9PMJZ/WJtXLpV2IV95ALuvbAjZdqaMyYrJ+NGE6
 1eNkt8cs0sgRGOV1h6I8jJjL0PpLFj5mQi0N6YcGYojdc6mwTw58/Ve7bLr3mCCyYT3UZwbKx
 10h2g7S2j10g06JA+sjWxt0BD0lKRle4byFF+ACUIKB2Fzv4AfOd8Uc/fAvlbrt+lEueHnbFP
 X3TyDSmmShHGEULakvY0k/ouTHTXmUC5gxpCjLlsHKxcM+qk4Tu66xuWbgdCrbFmkj8b2b8X2
 qWXxqHUGoClHAEOiVIx3ZI/eVnieBJMWwuSzKA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A new set of warnings appeared in next-20180403 in some configurations
when gcc cannot see that rbd_assert(0) leads to an unreachable code
path:

drivers/block/rbd.c: In function 'rbd_img_is_write':
drivers/block/rbd.c:1397:1: error: control reaches end of non-void function [-Werror=return-type]
drivers/block/rbd.c: In function '__rbd_obj_handle_request':
drivers/block/rbd.c:2499:1: error: control reaches end of non-void function [-Werror=return-type]
drivers/block/rbd.c: In function 'rbd_obj_handle_write':
drivers/block/rbd.c:2471:1: error: control reaches end of non-void function [-Werror=return-type]

To work around this, we can add a return statement to each of these
cases. An alternative would be to remove the unlikely() annotation
in rbd_assert(), or to just use BUG()/BUG_ON() directly. This adds the
return statements, guessing what the most reasonable behavior
would be.

Fixes: 3da691bf4366 ("rbd: new request handling code")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/block/rbd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 07dc5419bd63..9445a71a9cd6 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1394,6 +1394,7 @@ static bool rbd_img_is_write(struct rbd_img_request *img_req)
 	default:
 		rbd_assert(0);
 	}
+	return false;
 }
 
 static void rbd_obj_handle_request(struct rbd_obj_request *obj_req);
@@ -2468,6 +2469,7 @@ static bool rbd_obj_handle_write(struct rbd_obj_request *obj_req)
 	default:
 		rbd_assert(0);
 	}
+	return true;
 }
 
 /*
@@ -2496,6 +2498,7 @@ static bool __rbd_obj_handle_request(struct rbd_obj_request *obj_req)
 	default:
 		rbd_assert(0);
 	}
+	return true;
 }
 
 static void rbd_obj_end_request(struct rbd_obj_request *obj_req)
-- 
2.9.0
