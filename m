Return-Path: <udknight@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525584303; cv=none;
        d=google.com; s=arc-20160816;
        b=i/45GMM4fVCYlXbIF0esPZZ236PKHYQM8hOcCwlVGiXUbUSsRTX7zDCXEdiA5kFes1
         gTreVHKY/YuApWd5w5sLgMiZkxYdj0AZz07U2h9ff4NgcPTF1ivuzqRkvOtcM4C9GNIT
         ZaZF6RhYmisNyy44CVAk/LEkQxE+xkYEn6ihnIQVPFjKoDMR0hbjlZpHQ6HGheRdkbsC
         yHqfaUWxOCyOiHXAaJgetbnsa1AFKyG5WsetM+AVWNejj86qW5nAdu/RWBSF5Zo6dHx9
         oMApVthtQA3jRye6fOho3ssuZIi91GWuIXdp93Voz6+z9W4U4UuW8TEAMdwYHx6FIacz
         id9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:mail-followup-to
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=lBctqYJO3nJYcA6+wg9jmVBMWfjN54WqVNNJzg0dSvw=;
        b=lYhwpfFS1/7E5BTKUUu45i9QAqpxJB15wRkeZvVgtdHufYu5aR+SzAX+EsIwi6jVLa
         Xj+5ra/65JN1VUK3SxCfgCxYz+CIRL614GMWScaOsqmtLyx8qAm+Yo75ZzKRD7ZAO1Z9
         g32l9/9Gm1ZX+U3/Qulph/uwt9PCZW1kbTIW1r2oNS281yc+6+yqtQ+GK+cZrJ0Nn/3Z
         5mwC01wgIyLBLMQ0fAOlOhGyIUoCOBEJWyztCWWVp86RgXsv1dTaWw9pi1120Dk/Gsto
         relr8eVOOuYg6IPZnaFP7szeId4X3k9NjwZmVPEtD8Lw98ir2dzqiRuS3IyhKqAvoKYA
         OQUw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ddUO5kLU;
       spf=pass (google.com: domain of udknight@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=udknight@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ddUO5kLU;
       spf=pass (google.com: domain of udknight@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=udknight@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZootIAHVlbz86HB4T0Nz1T0mMkAKioHF5uPAgFv8AqITWxdWp3TygJIChDX19BlajPbcJx2hw==
Date: Sun, 6 May 2018 13:23:56 +0800
From: Wang YanQing <udknight@gmail.com>
To: axboe@kernel.dk
Cc: gregkh@linuxfoundation.org, pombredanne@nexb.com, tglx@linutronix.de,
        caizhiyong@hisilicon.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] block: add verifier for cmdline partition
Message-ID: <20180506052356.GA11163@udknight>
Mail-Followup-To: Wang YanQing <udknight@gmail.com>, axboe@kernel.dk,
	gregkh@linuxfoundation.org, pombredanne@nexb.com,
	tglx@linutronix.de, caizhiyong@hisilicon.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.1 (2016-10-04)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599689092526143942?=
X-GMAIL-MSGID: =?utf-8?q?1599691086398960284?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I meet strange filesystem corruption issue recently, the reason
is there are overlaps partitions in cmdline partition argument.

This patch add verifier for cmdline partition, then if there are
overlaps partitions, cmdline_partition will log a warning.

Signed-off-by: Wang YanQing <udknight@gmail.com>
---
 Changes
 v2-v3:
 1:Fix log one pair of overlaps partitions twice in cmdline_parts_verifier.
 2:Fix out of bound access in cmdline_parts_verifier.

 v1-v2:
 1:Don't treat overlaps partition as a error, but log a warning.

 block/partitions/cmdline.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/block/partitions/cmdline.c b/block/partitions/cmdline.c
index e333583..fefcc72 100644
--- a/block/partitions/cmdline.c
+++ b/block/partitions/cmdline.c
@@ -58,6 +58,71 @@ static int __init cmdline_parts_setup(char *s)
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
+static inline void overlaps_warns_header(void)
+{
+	pr_warn("\n");
+	pr_warn("Overlaps partitions being used in command line partition.\n");
+	pr_warn("Don't use filesystems on overlaps partitions:\n");
+}
+
+static inline void overlaps_warns_tailer(void)
+{
+	pr_warn("\n");
+}
+
+static void cmdline_parts_verifier(int slot, struct parsed_partitions *state)
+{
+	int i;
+	bool header = true;
+
+	for (; slot < state->limit && state->parts[slot].has_info; slot++) {
+		for (i = slot+1; i < state->limit && state->parts[i].has_info;
+		     i++) {
+			if (has_overlaps(state->parts[slot].from,
+					 state->parts[slot].size,
+					 state->parts[i].from,
+					 state->parts[i].size)) {
+				if (header) {
+					header = false;
+					overlaps_warns_header();
+				}
+				pr_warn("%s[%llu,%llu] overlaps with "
+					"%s[%llu,%llu].\n",
+					state->parts[slot].info.volname,
+					(u64)state->parts[slot].from << 9,
+					(u64)state->parts[slot].size << 9,
+					state->parts[i].info.volname,
+					(u64)state->parts[i].from << 9,
+					(u64)state->parts[i].size << 9);
+			}
+		}
+	}
+
+	if (!header)
+		overlaps_warns_tailer();
+}
+
 /*
  * Purpose: allocate cmdline partitions.
  * Returns:
@@ -93,6 +158,7 @@ int cmdline_partition(struct parsed_partitions *state)
 	disk_size = get_capacity(state->bdev->bd_disk) << 9;
 
 	cmdline_parts_set(parts, disk_size, 1, add_part, (void *)state);
+	cmdline_parts_verifier(1, (void *)state);
 
 	strlcat(state->pp_buf, "\n", PAGE_SIZE);
 
-- 
1.8.5.6.2.g3d8a54e.dirty
