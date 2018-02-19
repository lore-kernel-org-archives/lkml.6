Return-Path: <david@lechnology.com>
X-Google-Smtp-Source: AH8x225Sx+U8XwjG2J1zZ4KXw/AYNcU/dQvLw978B8U0eWOVgknvD7v1cjA1XXGTI3aw5d2KbL2V
ARC-Seal: i=1; a=rsa-sha256; t=1519076587; cv=none;
        d=google.com; s=arc-20160816;
        b=wSRbJ18rbCOyNq5DJoJYHdo4qIkH7ybODr/UdDlqoZiENmo2xO+6Qb/a5kgsXuMed8
         95gsIzNkIVzooz9i0HUQ4wNDFsbUBrWofW3wjvpspoZnL/etpikVbf8g70coh3nkwfE4
         JzW0rPyMrXtfsUUH0Oiq+9s1cfjSMveeYubFh4WNZbCAiJxxOXQfE9YHb/z8C28SndRR
         rlIykhvmYBnE9VsEeHoa7baP35ZMGyKw3DR/6P3ZpTzDR+b0nLQjQcw97UA7Z5NjreKn
         zgdj6xGhf+vGuUiQZXd1xtkBBul+sJtJ0KDBHt2oy0te53xcJ1Fr0ZG5VgEHqq7eTpLO
         48pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=vF7VlahkfnBbl3Jt2vS/wscLWJ8U7ieJDyDdN4MSZm0=;
        b=vx8I3lXy19uvoiBO5+0OS9KKXShQWQnCd3avIxrT6aNOZf3AarDvTtYTU1j5tA+cAx
         NV5HW2evZUHh1DHIsUJK2PC2K31RAFsKbC8UULxxdzGESGGQnBFHVNysxo4qCddlq+MZ
         Gp3kdUZvRIr0Ole9poOBWYXIJkyIdfBwvu67YMCc17Md5dz92skDMSFdpxMIHV9aF2qW
         dktAZoRHSBJqUGiS673VJQ7UtU0JwVW5cPus5H3jL+D2wHiBF4tc8YfkXVQ0eOb/VK1r
         /FIFyyAuAC67O7oYcIQRWIlz2w89iL8ADsKJ4vsVJPfe0Ph9EGPy61ETms1I99TLVKiv
         9HNQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@lechnology.com header.s=default header.b=da5tjkJc;
       spf=pass (google.com: domain of david@lechnology.com designates 206.190.152.46 as permitted sender) smtp.mailfrom=david@lechnology.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@lechnology.com header.s=default header.b=da5tjkJc;
       spf=pass (google.com: domain of david@lechnology.com designates 206.190.152.46 as permitted sender) smtp.mailfrom=david@lechnology.com
From: David Lechner <david@lechnology.com>
To: linux-kernel@vger.kernel.org
Cc: David Lechner <david@lechnology.com>,
	Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2] regmap: fix NULL pointer dereference in regmap_name_read_file()
Date: Mon, 19 Feb 2018 15:43:01 -0600
Message-Id: <1519076582-7687-2-git-send-email-david@lechnology.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519076582-7687-1-git-send-email-david@lechnology.com>
References: <1519076582-7687-1-git-send-email-david@lechnology.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - linuxfoundation.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592867252087882948?=
X-GMAIL-MSGID: =?utf-8?q?1592867252087882948?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This fixes a possible NULL pointer dereference oops in
regmap_name_read_file() when the regmap does not have a device
associated with it. For example syscon regmaps retrieved with
syscon_regmap_lookup_by_compatible() don't have a device.

Signed-off-by: David Lechner <david@lechnology.com>
---

v2 changes:
- point out case where this can actually happen in the commit message
- print "nodev" instead of "(null)" if there is no device

 drivers/base/regmap/regmap-debugfs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index f326633..7eb512b 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -40,6 +40,7 @@ static ssize_t regmap_name_read_file(struct file *file,
 				     loff_t *ppos)
 {
 	struct regmap *map = file->private_data;
+	const char *name = "nodev";
 	int ret;
 	char *buf;
 
@@ -47,7 +48,10 @@ static ssize_t regmap_name_read_file(struct file *file,
 	if (!buf)
 		return -ENOMEM;
 
-	ret = snprintf(buf, PAGE_SIZE, "%s\n", map->dev->driver->name);
+	if (map->dev && map->dev->driver)
+		name = map->dev->driver->name;
+
+	ret = snprintf(buf, PAGE_SIZE, "%s\n", name);
 	if (ret < 0) {
 		kfree(buf);
 		return ret;
-- 
2.7.4
