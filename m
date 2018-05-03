Return-Path: <udknight@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525346263; cv=none;
        d=google.com; s=arc-20160816;
        b=uNiziJI8VWH4YttfalTecrFLJb0SY2lqESvJdPgUOZG0vNPU28MBWcWSKvvqZ4G+0S
         oztnsUTciwy3HlLkBwajq4BinL+LYFdI0TRoYsUpyZwIZ+AvMzqGdtYlJofqle3xpTOo
         XnkrwjPQml9ruHVdXUe4bmGEmNVpZl+VCys6vNPb9ZfH2R6+uelktHizRBQlo0xij/Qc
         BVpJTbmfF3dP6+QXTDesiPkHqWnoV/eQ/qKfK/0is5sovNqTONU/Ge62nBXdAqVRidss
         rD0rIB+EYY0YhO6nMjfZ9EH60q0oEQddnflpvl4dwa8Q/kLSNnHzrAXpy+1n+KbPUAPk
         DHQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:mail-followup-to
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=d/cLCMPf1qoYgQ/hxmrBn4Uvy4y9T+9HtwufPvX/3tM=;
        b=PqnRR8sBc00Y+0xuD8CwqBbroRK6mUOcHtfLDmX9PJHOLR+YbwpGUL8tQ86+nJaDWL
         I13V7xqvVtt4KsBw35wVWAHeBNhk43xBlEGsGtsawIlsGk5JM9DWJ7X8IfJZ7Jixo0GV
         PhDEDzTsKpP4NCBXDNLSxv2LE2EiuMh5sY9RyHwt6Eyk7uDbQKAXxiuecUDkwLsGNapV
         bwCWqsJQg6A4aL4PJqJtExWgk2rJWl60YkqKOelxzSr1qWHh2xYp1WQCNpJJng639Q6p
         +QU0cgK4UwsTSjmTip2p6XkNSjxS/IQpf4IwGpniCPFnB+KfDO6A/PHrPArkGabxBGjw
         0NGw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ujaeEuGc;
       spf=pass (google.com: domain of udknight@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=udknight@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ujaeEuGc;
       spf=pass (google.com: domain of udknight@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=udknight@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZre0jSWi/Gnd5+9tZxI26gFusieXZkkisVfC6q2J51SkMEynMZF7zBDC0CEZ9Wu7TuxXHA9HQ==
Date: Thu, 3 May 2018 19:17:48 +0800
From: Wang YanQing <udknight@gmail.com>
To: axboe@kernel.dk
Cc: gregkh@linuxfoundation.org, pombredanne@nexb.com, tglx@linutronix.de,
        caizhiyong@huawei.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] block: add verifier for cmdline partition
Message-ID: <20180503111748.GA904@udknight>
Mail-Followup-To: Wang YanQing <udknight@gmail.com>, axboe@kernel.dk,
	gregkh@linuxfoundation.org, pombredanne@nexb.com,
	tglx@linutronix.de, caizhiyong@huawei.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.1 (2016-10-04)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599441484038057319?=
X-GMAIL-MSGID: =?utf-8?q?1599441484038057319?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I meet strange filesystem corruption issue recently, the reason
is there are overlaps partitions in cmdline partition argument.

This patch add verifier for cmdline partition, then if there are
overlaps partitions, cmdline_partition will return error and log
a error message.

Signed-off-by: Wang YanQing <udknight@gmail.com>
---
 block/partitions/cmdline.c | 63 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

diff --git a/block/partitions/cmdline.c b/block/partitions/cmdline.c
index e333583..6754c2a 100644
--- a/block/partitions/cmdline.c
+++ b/block/partitions/cmdline.c
@@ -58,6 +58,62 @@ static int __init cmdline_parts_setup(char *s)
 }
 __setup("blkdevparts=", cmdline_parts_setup);
 
+static bool has_overlaps(sector_t from, sector_t size,
+			 sector_t from2, sector_t size2)
+{
+	sector_t end = from + size;
+	sector_t end2 = from2 + size2;
+
+	if (from >= from2 && from < end2)
+		return true;
+
+	if (end > from2 && end <= end2)
+		return true;
+
+	if (from2 >= from && from2 < end)
+		return true;
+
+	if (end2 > from && end2 <= end)
+		return true;
+
+	return false;
+}
+
+static bool cmdline_parts_verifier(int slot, struct parsed_partitions *state)
+{
+	int i, j = slot;
+	bool ret = true;
+
+	for (; state->parts[slot].has_info; slot++) {
+		for (i = j; state->parts[i].has_info; i++) {
+			if (i == slot)
+				continue;
+
+			if (has_overlaps(state->parts[slot].from,
+					 state->parts[slot].size,
+					 state->parts[i].from,
+					 state->parts[i].size)) {
+				pr_err("Invalid cmdline partition:"
+				       "%s[%llu,%llu] overlaps with "
+				       "%s[%llu,%llu]",
+				       state->parts[slot].info.volname,
+				       (u64)state->parts[slot].from << 9,
+				       (u64)state->parts[slot].size << 9,
+				       state->parts[i].info.volname,
+				       (u64)state->parts[i].from << 9,
+				       (u64)state->parts[i].size << 9);
+				ret = false;
+				break;
+			}
+		}
+
+		if (!ret)
+			break;
+	}
+
+	return ret;
+}
+
 /*
  * Purpose: allocate cmdline partitions.
  * Returns:
@@ -70,6 +126,7 @@ int cmdline_partition(struct parsed_partitions *state)
 	sector_t disk_size;
 	char bdev[BDEVNAME_SIZE];
 	struct cmdline_parts *parts;
+	int ret;
 
 	if (cmdline) {
 		if (bdev_parts)
@@ -93,8 +150,12 @@ int cmdline_partition(struct parsed_partitions *state)
 	disk_size = get_capacity(state->bdev->bd_disk) << 9;
 
 	cmdline_parts_set(parts, disk_size, 1, add_part, (void *)state);
+	if (!cmdline_parts_verifier(1, (void *)state))
+		ret = -1;
+	else
+		ret = 1;
 
 	strlcat(state->pp_buf, "\n", PAGE_SIZE);
 
-	return 1;
+	return ret;
 }
-- 
1.8.5.6.2.g3d8a54e.dirty
