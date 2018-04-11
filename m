Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48OAcfyW44xKkk/XEWzuZp7cjGqxrYIDIfzhL/J44Z8vXuMIhaZY5Jqe8eyrr5wusRnnCxq
ARC-Seal: i=1; a=rsa-sha256; t=1523472206; cv=none;
        d=google.com; s=arc-20160816;
        b=SmvPwIb/RPFV8PLyMVLv/4ulnJgw97XTnQV+Tcff71alByEkOggFBL7h01BxGMbAj6
         ttfQ2k5Dt8bgMGIjxkLKXVU15k94e1cEJ8zrTPdA8utoGyLRv2xjpyVusXu9sndARRhP
         aiZQfKcLJrYROihaoQYUmFqQgtPNEXwBhBc+mOBC4Bkyl9bbaxCd+If7u/h/b24/CZJM
         dWyxVK5SD1M/uPRcNJ3bcIjvB9q7KrcBAIeEvi2ohiaN2mXvh8qSH2x5fO67RTY+TYcU
         fQDSOAXBG5yyMaX0ES2r1QtCwJLs5WmtcArR7nf6Yz0rniNkPwWS5i37TP0va599tCdR
         5atA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=NIR9MvnnVtjYYmWyNkRgruF1BLq1XO7LHAY84GzAjUQ=;
        b=OJsXaPZft8WR1GYaPYBjQFFaUs6yqy3bahKqg3dfihva0tlmLuPH/giGIt9VGwTjL1
         AgPt8lWY3rJWv88HFnlSiNwmR/gx+Mr8Iv8RC979CQ0bN+07lctUFxJk+yPT26BcbbyN
         1stl0qy/5BUNeXbuY+97ps/BhtFIaTw/WSb8+xeqn0/Dvh7POVtnv0NwopBaOz1TuHXn
         glZts1On0zjKSYtcv1nowdh22NmdUFkBopWczuydfutKfg2UeADqlmt/JXZjCgVCnCQA
         LljJcoQhElfYJPVWqX+NoHYtMpN9lgyI9CgVSuKUSwJWh2KzmqvojpGKnLGTLFJ4VHUQ
         oWnw==
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
Subject: [PATCH 3.18 091/121] bcache: segregate flash only volume write streams
Date: Wed, 11 Apr 2018 20:36:34 +0200
Message-Id: <20180411183502.021295374@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476392008535759?=
X-GMAIL-MSGID: =?utf-8?q?1597476392008535759?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -514,15 +514,21 @@ struct open_bucket {
 
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
@@ -539,7 +545,10 @@ static struct open_bucket *pick_data_buc
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
