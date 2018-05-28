Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968656AbeE1KRL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:17:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:37204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966943AbeE1KRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:17:03 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tang Junhui <tang.junhui@zte.com.cn>,
        Michael Lyle <mlyle@lyle.org>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 068/268] bcache: return attach error when no cache set exist
Date: Mon, 28 May 2018 12:00:42 +0200
Message-Id: <20180528100209.580998816@linuxfoundation.org>
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

From: Tang Junhui <tang.junhui@zte.com.cn>

[ Upstream commit 7f4fc93d4713394ee8f1cd44c238e046e11b4f15 ]

I attach a back-end device to a cache set, and the cache set is not
registered yet, this back-end device did not attach successfully, and no
error returned:
[root]# echo 87859280-fec6-4bcc-20df7ca8f86b > /sys/block/sde/bcache/attach
[root]#

In sysfs_attach(), the return value "v" is initialized to "size" in
the beginning, and if no cache set exist in bch_cache_sets, the "v" value
would not change any more, and return to sysfs, sysfs regard it as success
since the "size" is a positive number.

This patch fixes this issue by assigning "v" with "-ENOENT" in the
initialization.

Signed-off-by: Tang Junhui <tang.junhui@zte.com.cn>
Reviewed-by: Michael Lyle <mlyle@lyle.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/bcache/sysfs.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -191,7 +191,7 @@ STORE(__cached_dev)
 {
 	struct cached_dev *dc = container_of(kobj, struct cached_dev,
 					     disk.kobj);
-	ssize_t v = size;
+	ssize_t v;
 	struct cache_set *c;
 	struct kobj_uevent_env *env;
 
@@ -268,6 +268,7 @@ STORE(__cached_dev)
 		if (bch_parse_uuid(buf, set_uuid) < 16)
 			return -EINVAL;
 
+		v = -ENOENT;
 		list_for_each_entry(c, &bch_cache_sets, list) {
 			v = bch_cached_dev_attach(dc, c, set_uuid);
 			if (!v)
@@ -275,7 +276,7 @@ STORE(__cached_dev)
 		}
 
 		pr_err("Can't attach %s: cache set not found", buf);
-		size = v;
+		return v;
 	}
 
 	if (attr == &sysfs_detach && dc->disk.c)
