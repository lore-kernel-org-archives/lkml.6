Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49ZqXiAgmrsHWDN9YsywkGofyM9wX7vFtYWdhI79tVTSSovQkFX33Rwq0gCf1/Ylqq/C4Lo
ARC-Seal: i=1; a=rsa-sha256; t=1524405781; cv=none;
        d=google.com; s=arc-20160816;
        b=WBO2RcBnl2ybjJkT/tYy7zOJb7ebMaNmHONN/7gC9Szi9m/lIxylNnUvQyxw6H4h3O
         0yeZHAQi0dngl7ItPr/yVhlwTFT3p/aPnk/7Ggw6TZgcqsMmrL3RgIqmGTYRVJk3Nq6E
         0zxDOPYiank/m5qgCL5wONPLpp3UseEZq1AgSGwGOwRwlrMImIFYaUWt5Dk3RCyRo1A+
         Jme93KyEiX7jbGB66OYrUwtvREdq9Z1vqWMqBj+055Lpmy+pZs/jDTXjPYVU1JzHehgU
         J+rsucEXRBIYl2ZFzUijOr9ncoMs58t3Us6JbIJ40Xr91YNnimcGKFA5E1iHjeGeG3pB
         yXcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/gXfpYgnOo+2oq4w1iSnhtRuJ0W6iLTW54BKxZl62Fs=;
        b=UER/Ss2U8V2bIszxk+8caV1AxjU8XgPF9+tBNWySshv9R2UpyXIKq2ghg5eAt9s3E+
         gWl6lybDV39zg4Cb+fCcviuU6Nd25X3+TRpMcU5kIcLQbJJzgJxByw06u0UWbfv5AyNA
         9ZImh1pESRsD05OKgnqkgUKXckbrfg2642FhAzB41V9EckIwRUmX9u1+FATYx2FdnPEQ
         qLhmu0eefAdxpWwN+qQsAVsDzIICR1uGPKB8AmNLlETVcsuZtipyVUZmMXbnvRNKSEON
         nokMeqVxkrwpCIpGZgx7VMS4xFWARUaTjkJmylgT5ETaDcH2uykoDilglAnbEYcVRA4b
         ivpA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 4.16 191/196] device-dax: allow MAP_SYNC to succeed
Date: Sun, 22 Apr 2018 15:53:31 +0200
Message-Id: <20180422135114.135122549@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455316221551089?=
X-GMAIL-MSGID: =?utf-8?q?1598455316221551089?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Jiang <dave.jiang@intel.com>

commit ef8423022324cf79bd1b41d8707c766461e7e555 upstream.

MAP_SYNC is a nop for device-dax. Allow MAP_SYNC to succeed on device-dax
to eliminate special casing between device-dax and fs-dax as to when the
flag can be specified. Device-dax users already implicitly assume that they do
not need to call fsync(), and this enables them to explicitly check for this
capability.

Cc: <stable@vger.kernel.org>
Fixes: b6fb293f2497 ("mm: Define MAP_SYNC and VM_SYNC flags")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/dax/device.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -19,6 +19,7 @@
 #include <linux/dax.h>
 #include <linux/fs.h>
 #include <linux/mm.h>
+#include <linux/mman.h>
 #include "dax-private.h"
 #include "dax.h"
 
@@ -534,6 +535,7 @@ static const struct file_operations dax_
 	.release = dax_release,
 	.get_unmapped_area = dax_get_unmapped_area,
 	.mmap = dax_mmap,
+	.mmap_supported_flags = MAP_SYNC,
 };
 
 static void dev_dax_release(struct device *dev)
