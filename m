Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751895AbeBTNJq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 08:09:46 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:36153 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751765AbeBTNJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 08:09:44 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Shaohua Li <shli@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, NeilBrown <neilb@suse.com>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        Jens Axboe <axboe@kernel.dk>, Song Liu <songliubraving@fb.com>,
        Guoqing Jiang <gqjiang@suse.com>, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] md: raid5: avoid string overflow warning
Date: Tue, 20 Feb 2018 14:09:11 +0100
Message-Id: <20180220130924.3698067-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:p3I0b1eRFlBMxwtZdHbpsKL1CFNPd2/H9fb4bKdb6AkYeRFRSoA
 uitQbRtznPdvS+xFfuHW55ftpVn833p3Xq4E7KCJ5N6du9opiqE+wT13nuNA+RQ034PM/lu
 i2avxqXUIHJWWWaejyOaWtYo1sVvEXJiu7b7ycPHNnH6U57ObOdn2VdfiB5TrYVqodSMSQf
 +VQslFjGTmvxDhoMsCWpQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+UYEshBExo8=:ZGP9TgxeC1EI8ZAp2SM0Mc
 CXT8GdWpsb2VlJ2MeTRPiDOWmjIQ1YhfIimX+yn9n8AYvdSbpkW/62AEjoXvz/Tmd759TOV7E
 M4tK35I7m6jSkpTaritqxnx3tmPufBRdQANeXhFlrjPk6OpUgHECQHCs5DnIzzhWNU2gpkZ0e
 R+jbI8scyhh+e675xiCOt3Le7p5aFXRCUM1K9hiQaXCNxKO0j9OCj/r+eamHFkg2OhCE8ZsaA
 18aPbc6DnnhsAcXsd3g9HCtubVxQnOPC8bNZ+0Vhqqo3J6yC6jLB+foeNT48CMbBGMW/Rtbrq
 t15aU2yx2bVnHmN0kCGTRXFxbjY/tlmQuXvFEPEDy3VD8bOP7mCC/pWycyMyCcyrmgHuUVUfw
 VonmqSxtaWxwSIPm+FyC/WsHDifmsvZgAcI+6BdhxLr5dCGjJuSauer8EXuyPkJsRmKvjhPMg
 dNcEPG7VvOWY8uezkdehEMH+DwRtEXRBSgupcdySLHJ/09ozKQB2B12A4/qqMv86NVEwFR3Vs
 1Lt9a8/gh+MbPtx+NroH6PwGhB7ES9YI6B56aQdTwO5qfnXrMhHRlVT/WXuNWx5EsMdTQ7xzv
 ihDfDbz9N3b5LEvdgeXKW4Vx+0eUGE/qUauWjy74Xahl7mtG4LXjtDvhtXNcFMyH8QIt5OZ7f
 fGrz0ZCsOU40qBhxH+l7K+OTuxfv0Q517mgfrKnqMapfR9X+DQaXwlgreSQx+CU80Yno76pL3
 +ViOKyXcCa97KzFDxkFsI0+Rum7LH2TKbj4NMw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc warns about a possible overflow of the kmem_cache string, when adding
four characters to a string of the same length:

drivers/md/raid5.c: In function 'setup_conf':
drivers/md/raid5.c:2207:34: error: '-alt' directive writing 4 bytes into a region of size between 1 and 32 [-Werror=format-overflow=]
  sprintf(conf->cache_name[1], "%s-alt", conf->cache_name[0]);
                                  ^~~~
drivers/md/raid5.c:2207:2: note: 'sprintf' output between 5 and 36 bytes into a destination of size 32
  sprintf(conf->cache_name[1], "%s-alt", conf->cache_name[0]);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If I'm counting correctly, we need 11 characters for the fixed part
of the string and 18 characters for a 64-bit pointer (when no gendisk
is used), so that leaves three characters for conf->level, which should
always be sufficient.

This makes the code use snprintf() with the correct length, to
make the code more robust against changes, and to get the compiler
to shut up.

In commit f4be6b43f1ac ("md/raid5: ensure we create a unique name for
kmem_cache when mddev has no gendisk") from 2010, Neil said that
the pointer could be removed "shortly" once devices without gendisk
are disallowed. I have no idea if that happened, but if it did, that
should probably be changed as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/md/raid5.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 50d01144b805..7ef368061424 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -2196,15 +2196,16 @@ static int grow_one_stripe(struct r5conf *conf, gfp_t gfp)
 static int grow_stripes(struct r5conf *conf, int num)
 {
 	struct kmem_cache *sc;
+	size_t namelen = sizeof(conf->cache_name[0]);
 	int devs = max(conf->raid_disks, conf->previous_raid_disks);
 
 	if (conf->mddev->gendisk)
-		sprintf(conf->cache_name[0],
+		snprintf(conf->cache_name[0], namelen,
 			"raid%d-%s", conf->level, mdname(conf->mddev));
 	else
-		sprintf(conf->cache_name[0],
+		snprintf(conf->cache_name[0], namelen,
 			"raid%d-%p", conf->level, conf->mddev);
-	sprintf(conf->cache_name[1], "%s-alt", conf->cache_name[0]);
+	snprintf(conf->cache_name[1], namelen, "%.27s-alt", conf->cache_name[0]);
 
 	conf->active_name = 0;
 	sc = kmem_cache_create(conf->cache_name[conf->active_name],
-- 
2.9.0
