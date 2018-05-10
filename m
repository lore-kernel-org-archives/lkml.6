Return-Path: <udknight@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525921610; cv=none;
        d=google.com; s=arc-20160816;
        b=X9jaKtJa/hkDIvuqT4zHGwZFd3JsFUQSbncUvcl1Oy3HmEqAXnid/ZjxOwsscheA35
         B9k07jJkYpA83NABHoB6b5sGX/uJznjykezNpepa4aFfzFsQ83CmI85vw7P2Xz8gBMZp
         +VaZevYgfNaKW81KYR50gTCRTS7WZC9eHV7lwrIbSzf1gTXFX456fOryODi0TNYtndJS
         mKnyTy4YM+dwyYMf5gnbXWxfRocpo7F1NWbXKT+R3W7+oK+yGkefior5TjNKvi0VOGd/
         eQ17jhswZpgXZRRNp7rjMrv7T1Kb26OArYf+vB17MvVcKy5U/OL/HSRFiFFVC1NNs1hP
         1+2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:mail-followup-to
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=TNfwmFxVarWEwBcMNqYqD9/w8qmAcpi4zLogFbfvy3o=;
        b=BlFRC080tB43kgP0hqToVSZQZ/mTnDKRJnCg0DgEmAs7CFms1GsQyJijZtY+MM+piw
         xb6NiZn7ewPvf9OHrJFvyh0q1dbRS6y9CquSd85jSi4ya0o6DJtqmzVQrg8lLA4ok2nu
         smQotl11NTD94CW0DGG01vUwXEWdCFF9gc4t78G/i7nNm4Tc0p6IQn1t4sjx4btf+wh0
         uOsEW7Jc+Vu5GiOh0fPyOEiwNs7OlKTY6R7IT3KvvaXzbuM5Ui5hG5q94MGlQykBnnGG
         OpttPda942apBCWGhIeREgwWhbtadm7XoyJz9YeB87iWc3Ju52U3W4IhpjE4H5YxmNcp
         EUZA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Kh90MiGG;
       spf=pass (google.com: domain of udknight@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=udknight@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Kh90MiGG;
       spf=pass (google.com: domain of udknight@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=udknight@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZrM3boQG1c3uVty6VE5HhqfG5KPxTXuNdGvGwYgEA/goh1CkuZ9UOKJBxLzyYHc58sMIZplIg==
Date: Thu, 10 May 2018 11:06:37 +0800
From: Wang YanQing <udknight@gmail.com>
To: axboe@kernel.dk
Cc: gregkh@linuxfoundation.org, pombredanne@nexb.com, tglx@linutronix.de,
        caizhiyong@hisilicon.com, rdunlap@infradead.org,
        jiangheng@hisilicon.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5] block: add verifier for cmdline partition
Message-ID: <20180510030637.GA25734@udknight>
Mail-Followup-To: Wang YanQing <udknight@gmail.com>, axboe@kernel.dk,
	gregkh@linuxfoundation.org, pombredanne@nexb.com,
	tglx@linutronix.de, caizhiyong@hisilicon.com, rdunlap@infradead.org,
	jiangheng@hisilicon.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.1 (2016-10-04)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600044778510076654?=
X-GMAIL-MSGID: =?utf-8?q?1600044778510076654?=
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
 v4-v5:
 1:Delete unnecessary blank line at begin and end of logs.
 2:Delete newline character in log, pr_* will add newline
   automatically.

 v3-v4:
 1:Fix grammar typo, reported by Randy Dunlap.
 2:Delete unnecessary type casting, reported by Caizhiyong.
 3:Record the reason why we can't treat overlapping partitions
   as errors into changelog.

 v2-v3:
 1:Fix log one pair of overlaps partitions twice in cmdline_parts_verifier.
 2:Fix out of bound access in cmdline_parts_verifier.

 v1-v2:
 1:Don't treat overlaps partition as a error, but log a warning.

 Hi! Jens Axboe

 What is your suggestion?

 block/partitions/cmdline.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/block/partitions/cmdline.c b/block/partitions/cmdline.c
index e333583..60fb3df 100644
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
+static inline void overlaps_warns_header(void)
+{
+	pr_warn("Overlapping partitions are used in command line partitions.");
+	pr_warn("Don't use filesystems on overlapping partitions:");
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
+					"%s[%llu,%llu].",
+					state->parts[slot].info.volname,
+					(u64)state->parts[slot].from << 9,
+					(u64)state->parts[slot].size << 9,
+					state->parts[i].info.volname,
+					(u64)state->parts[i].from << 9,
+					(u64)state->parts[i].size << 9);
+			}
+		}
+	}
+}
+
 /*
  * Purpose: allocate cmdline partitions.
  * Returns:
@@ -93,6 +149,7 @@ int cmdline_partition(struct parsed_partitions *state)
 	disk_size = get_capacity(state->bdev->bd_disk) << 9;
 
 	cmdline_parts_set(parts, disk_size, 1, add_part, (void *)state);
+	cmdline_parts_verifier(1, state);
 
 	strlcat(state->pp_buf, "\n", PAGE_SIZE);
 
-- 
1.8.5.6.2.g3d8a54e.dirty
