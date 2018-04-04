Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751300AbeDDMyB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 08:54:01 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:48991 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751259AbeDDMx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 08:53:59 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>,
        Alex Elder <elder@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: Arnd Bergmann <arnd@arndb.de>, Jason Dillaman <dillaman@redhat.com>,
        ceph-devel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] rbd: avoid Wreturn-type warnings
Date: Wed,  4 Apr 2018 14:53:39 +0200
Message-Id: <20180404125345.4008862-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:AxH4I7Uo14ZknNERobRpMCUg38aF5stSqVcQeIheqj36cCr2RwS
 2+5KYv7O5iYyTmnDxW5B/7JLZ7AqX2NcaFoA71cv1K9oZiQ+XaInjOBOSoveimdcDXMUsuR
 LVKRwEqkn2kM4G60MA9uPhAf2deNze5EHRIBdTKh/+6Xhvf6jFPl2Uhhbqs/UxBhdNIJogV
 xwZyAwVeCGhJa3jxp3OQg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KnJ/7ii6FEc=:fortpCjV6CX3yTc0i1zz3y
 ixLGTUzeRE+XJ9GVu5/gBVG0NswIMU9WIZwmT7J38ChHI52MgUZmabRKrCg3mgz9o001FiG+g
 fTKkagSDJrBaPbCW1FCaJtpivhyHpv39KyfldOO6ZSFZffYi3bDnCe3cTnZKENjFePFm6nOXV
 y4bat0tXWzmzC7Uo/pkPAZwr65+wgfax4uQb/gBXxwTzrHnoG1rk092mhp7U0rBFRj2hnwcSx
 5g8l+ns2FbypCAcuncm+ggcRkWk7mEJtOyTUYLfVgR4S4oTWtuMg2+2u2QYbaYduoO7iikZCc
 19mGiYLfO9rdM+/356ZGedGMa9n2UJDJL0QcBBkijx8SVlUW8ijmyzCOVimO3rEDP2zMXwbBC
 IcowS25dZ735YqGdOYD4WW6Psje8VYxmPUqUWh2seZi20HsqRCkwGdgmyOdhQEyRPmhCS2Ky2
 4uDbLIvPDVjzxnKrme4rPiZFlE5aWvdPQciKBcpiaGKSYAXVWaN24k7eNMfLOi1HRYFRvuz48
 Gus7M9mcS6eazvO4w9DzP4GEoo1pli0YLT3YK4u/p4qr1Pdt22BMmXxfbsbFCXpyDECwXo5Up
 isNEbigH5AO9Fwk7mW8LRQYML+WOJrMmICLlTHMr4q72m1yayey5j4L2FRp589tEiBWhL68jC
 xBbZdRaiq415x8mqlf7TZp5fvXxBFSDMmaWMmrX0IN75spzqDk57Qb25FQGQ2+Z0NonYeGy7i
 a551crjZrHZshEqPXUy1b/7eqE/7bXK4rKF+fQ==
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

As the rbd_assert() here shows has no extra information beyond the verbose
BUG(), we can simply use BUG() directly in its place.  This is reliably
detected as not returning on any architecture, since it doesn't depend
on the unlikely() comparison that confused gcc.

Fixes: 3da691bf4366 ("rbd: new request handling code")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/block/rbd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 07dc5419bd63..5f7f4d4b78a8 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1392,7 +1392,7 @@ static bool rbd_img_is_write(struct rbd_img_request *img_req)
 	case OBJ_OP_DISCARD:
 		return true;
 	default:
-		rbd_assert(0);
+		BUG();
 	}
 }
 
@@ -2466,7 +2466,7 @@ static bool rbd_obj_handle_write(struct rbd_obj_request *obj_req)
 		}
 		return false;
 	default:
-		rbd_assert(0);
+		BUG();
 	}
 }
 
@@ -2494,7 +2494,7 @@ static bool __rbd_obj_handle_request(struct rbd_obj_request *obj_req)
 		}
 		return false;
 	default:
-		rbd_assert(0);
+		BUG();
 	}
 }
 
-- 
2.9.0
