Return-Path: <udknight@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525582402; cv=none;
        d=google.com; s=arc-20160816;
        b=CCN4PS8JG2g7Yabgw55Q3d/LnJyc501YuCcNZck4Rd3i8XjpEVfwed/P74tvH58N31
         RKuVsHKzxccBiZNZ7E5LcLMXReJLQhdKKGTny9vreYW3Q0TwGzIyOkvXrhCz7vAnHea3
         6XiIrfdqXk92cK0wPMRp59Pej82Qc2rHPGgPA8mMUel+bdIa+LvrD+R7OKpddxiKJcUj
         kPbZvabHVbrLt0KZYgAm8L55o3vEO1TfPBQ3EVrabKDZsBGwN/T3soc8aknEPdBm2Ywf
         1quKrKRNFhoUZkL+g+Bexye88+Eqam1R3fAJV1cD6g5D+VFmQlwV33+/4QYc9lXb51cW
         G38A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:mail-followup-to
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=fcs/vjkX5NHq4Y0zoeJPWpJAxZHmkMS6I/v5QYjalCo=;
        b=uEBA+skMP9ffamoI6doapqdj38uAQOxRBL8H3qmsRUut73/n3H8NS3SczXOKKzHm5y
         6LZOZSLTCLbz+NjBgsmqV5u1I9HZkIkrda3/HD5T2IFQ+g3dAn5M0reVQ8wS0ojz0rH/
         YJqGH5a1hPJrAKNsFTCaOH9A8v2LcYoLsYYLxxorlyGaewker2gIzsEZT6nUQfu9U2sT
         +rleYDbNniOU4RHoAvBnp5tb1Jhauu/Vz9NwZHDel26mEDbyPEyxYYvUthbGp2K7JoBO
         syfnZm2c1Vwy2LIicQAJ/1bk74XPi96mPqwt+OmSFkUR92QNoFRb6Nz5hpcd0d6RrOTh
         CqOA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=MzAIEuhG;
       spf=pass (google.com: domain of udknight@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=udknight@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=MzAIEuhG;
       spf=pass (google.com: domain of udknight@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=udknight@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZo2bviZwB49SZnB2OFjXJxTi7p/zvZu0XonkM0AYee6Gh4qi7ERlkn2hs2NxxAQnl75iI0oKg==
Date: Sun, 6 May 2018 12:52:16 +0800
From: Wang YanQing <udknight@gmail.com>
To: axboe@kernel.dk
Cc: gregkh@linuxfoundation.org, pombredanne@nexb.com, tglx@linutronix.de,
        caizhiyong@hisilicon.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] block: add verifier for cmdline partition
Message-ID: <20180506045215.GA9738@udknight>
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
X-GMAIL-MSGID: =?utf-8?q?1599689092526143942?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I meet strange filesystem corruption issue recently, the reason
is there are overlaps partitions in cmdline partition argument.

This patch add verifier for cmdline partition, then if there are
overlaps partitions, cmdline_partition will log a warning. We don't
treat overlaps partition as a error:
"
Caizhiyong <caizhiyong@hisilicon.com> said:
Partition overlap was intentionally designed in this cmdline partition.
reference http://lists.infradead.org/pipermail/linux-mtd/2013-August/048092.html
"

Signed-off-by: Wang YanQing <udknight@gmail.com>
---
 Changes
 v1-v2:
 1:Don't treat overlaps partition as a error, but log a warning.

 block/partitions/cmdline.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/block/partitions/cmdline.c b/block/partitions/cmdline.c
index e333583..7d70046 100644
--- a/block/partitions/cmdline.c
+++ b/block/partitions/cmdline.c
@@ -58,6 +58,73 @@ static int __init cmdline_parts_setup(char *s)
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
+	int i, j = slot;
+	bool header = true;
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
@@ -93,6 +160,7 @@ int cmdline_partition(struct parsed_partitions *state)
 	disk_size = get_capacity(state->bdev->bd_disk) << 9;
 
 	cmdline_parts_set(parts, disk_size, 1, add_part, (void *)state);
+	cmdline_parts_verifier(1, (void *)state);
 
 	strlcat(state->pp_buf, "\n", PAGE_SIZE);
 
-- 
1.8.5.6.2.g3d8a54e.dirty
