Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx491ArvnAqdO3krq0oywaYe2koCbF7vpIsNI6MRVF8zJci1tePkkvYrqBuIi+xgqy5sET17E
ARC-Seal: i=1; a=rsa-sha256; t=1523399773; cv=none;
        d=google.com; s=arc-20160816;
        b=Xcp6wAYKxv0la9ph4ewhYdwpRmZMXYYNa3dNwN9akmKS+EwJTS1a1a8ut4B1hoHwC1
         GITrgZdc0fmYgpvd085QPd5aLNVmeP73bvG/MFEEgUt0r3RVlQk1ntNx4PvcZbS2pPzY
         OXMLqx3BTMsGC7hyIxvmjT5KEX0cySsAgUl5Z/LqFk5mDZDyTRT60nvI//u1DuvuJD3j
         T1MTF6t7kE0cBrfQ0UbTPCHkhgEytMBgzJqZZTa/qUUP+ftflwOC5eWFjKF3HKpKHUeQ
         XtGi4B3ynMRf8BVqYmWgNdRAs8REVsVGKxfYq1W2H71+cuoSpUwlSy/SFj9PvQ+Feje7
         AyeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=nPKcG3wFx6suIDobgEqq5UhWpfCvvkX8HyKbv6wyPNg=;
        b=jlgn1uP9nTa6o7N7YC0GxOnHkNkC6FYWEfFd7mEWprpVlSdGFBzYkJ5Yx3E7NXxVd2
         qaHvDl+liv4hg61k8Q1sIehAt+jV7weAfMmSAAkED3h1/+8IhSd2GTKZsDgN8BL0/uFv
         6HedVIgYG8xdwvcnhGcy7/FBRyr9bFseOgy7y6StzT5EWdff2JldfRq5KqaCpGZqy38l
         4rCwURCxzq8wJbi5BM0KrxboVrPuAFUrh11A8t/bXfhlAJP3spVZszT1slxqtqiBfKxX
         X9xcSckatU39yY9ouHiqzgrxTea0XG9S3aTRdQO/7Mp2nxMxUgmUBUkGzck+qJCSqR+K
         0NyQ==
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
Subject: [PATCH 4.14 059/138] bcache: segregate flash only volume write streams
Date: Wed, 11 Apr 2018 00:24:09 +0200
Message-Id: <20180410212908.932343295@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400044698557036?=
X-GMAIL-MSGID: =?utf-8?q?1597400441574200038?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -515,15 +515,21 @@ struct open_bucket {
 
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
@@ -540,7 +546,10 @@ static struct open_bucket *pick_data_buc
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
