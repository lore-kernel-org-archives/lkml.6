Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49cahtjHEFdqizblYFWKEacpGIxgfEKcYFTj4z5lffp0o/l823fRrQrc28dqVVDiH+V/mjh
ARC-Seal: i=1; a=rsa-sha256; t=1523399395; cv=none;
        d=google.com; s=arc-20160816;
        b=Iua+3O9OuGea/+Va+p0xsI8sujmKi0O4rCqaGmDqTfwVawrmilByctVoefPXhgBWpM
         v4SShLTRFRZi/TOTWNOZi9X6a+JvTy0FfdED9Ns6XyMR9iGoewNp7VVR3ZU52JlXKrMS
         QYg21/63/uiimCGcQapmxrmZwQu+OCBOaLmGeyt7+pusb6sm9Rbf5kec8DdWUN8ByKWy
         gTz1kp/DWs5DlyinaTVeRj/aqxVNlK4cMfzpfr6PkabvdXGJn+6o2NCmx/o06WasgEQE
         TnC+JtuVW8B7LdDma/vKHDZi8n3lsCm9teN1zq5mRFzlVJ+l+uv+UOccm7HT2fqUulIr
         iq0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=8In49jJwn31I/o/8iQCwOFJiEfMlLipXff47myKEqqM=;
        b=lZYEHtMeuxnXWyyPODWwHfOjCLR5OpBdbclL1cGRWVsZ4TSkwcWFbnoRUGmBwDxjYf
         Hc7sY9OJRfeiwqJbAKt++2TF0tg5TjEB+Ow8ChKyh8y7X1rClTjsmTVqpMzWZ1rtNgKN
         MPNFLKfPERjj3xOGdUaCOhI+sGi0Vum9hgX/kvVstLFhoQ6riZEsgdcaL6vQU6RnF3Cy
         7n5yesMiIeUaWC2uqSwykKPLKXCQ9ZnrvrYHdbAzCFKdntYwHb8hw1kZk06sRZRC9bLL
         Ktj903RsGffGJZ+qtkVlGvTdB9rJzEcW5XY28LVswQef5zhtr8IaKn9GQzHYrOqbSm6m
         wgCw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tang Junhui <tang.junhui@zte.com.cn>,
	Michael Lyle <mlyle@lyle.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 074/168] bcache: segregate flash only volume write streams
Date: Wed, 11 Apr 2018 00:23:36 +0200
Message-Id: <20180410212803.372546299@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400044698557036?=
X-GMAIL-MSGID: =?utf-8?q?1597400044698557036?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tang Junhui <tang.junhui@zte.com.cn>


[ Upstream commit 4eca1cb28d8b0574ca4f1f48e9331c5f852d43b9 ]

In such scenario that there are some flash only volumes
, and some cached devices, when many tasks request these devices in
writeback mode, the write IOs may fall to the same bucket as bellow:
| cached data | flash data | cached data | cached data| flash data|
then after writeback of these cached devices, the bucket would
be like bellow bucket:
| free | flash data | free | free | flash data |

So, there are many free space in this bucket, but since data of flash
only volumes still exists, so this bucket cannot be reclaimable,
which would cause waste of bucket space.

In this patch, we segregate flash only volume write streams from
cached devices, so data from flash only volumes and cached devices
can store in different buckets.

Compare to v1 patch, this patch do not add a additionally open bucket
list, and it is try best to segregate flash only volume write streams
from cached devices, sectors of flash only volumes may still be mixed
with dirty sectors of cached device, but the number is very small.

[mlyle: fixed commit log formatting, permissions, line endings]

Signed-off-by: Tang Junhui <tang.junhui@zte.com.cn>
Reviewed-by: Michael Lyle <mlyle@lyle.org>
Signed-off-by: Michael Lyle <mlyle@lyle.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/bcache/alloc.c |   19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

--- a/drivers/md/bcache/alloc.c
+++ b/drivers/md/bcache/alloc.c
@@ -525,15 +525,21 @@ struct open_bucket {
 
 /*
  * We keep multiple buckets open for writes, and try to segregate different
- * write streams for better cache utilization: first we look for a bucket where
- * the last write to it was sequential with the current write, and failing that
- * we look for a bucket that was last used by the same task.
+ * write streams for better cache utilization: first we try to segregate flash
+ * only volume write streams from cached devices, secondly we look for a bucket
+ * where the last write to it was sequential with the current write, and
+ * failing that we look for a bucket that was last used by the same task.
  *
  * The ideas is if you've got multiple tasks pulling data into the cache at the
  * same time, you'll get better cache utilization if you try to segregate their
  * data and preserve locality.
  *
- * For example, say you've starting Firefox at the same time you're copying a
+ * For example, dirty sectors of flash only volume is not reclaimable, if their
+ * dirty sectors mixed with dirty sectors of cached device, such buckets will
+ * be marked as dirty and won't be reclaimed, though the dirty data of cached
+ * device have been written back to backend device.
+ *
+ * And say you've starting Firefox at the same time you're copying a
  * bunch of files. Firefox will likely end up being fairly hot and stay in the
  * cache awhile, but the data you copied might not be; if you wrote all that
  * data to the same buckets it'd get invalidated at the same time.
@@ -550,7 +556,10 @@ static struct open_bucket *pick_data_buc
 	struct open_bucket *ret, *ret_task = NULL;
 
 	list_for_each_entry_reverse(ret, &c->data_buckets, list)
-		if (!bkey_cmp(&ret->key, search))
+		if (UUID_FLASH_ONLY(&c->uuids[KEY_INODE(&ret->key)]) !=
+		    UUID_FLASH_ONLY(&c->uuids[KEY_INODE(search)]))
+			continue;
+		else if (!bkey_cmp(&ret->key, search))
 			goto found;
 		else if (ret->last_write_point == write_point)
 			ret_task = ret;
