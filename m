Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48DzorCQ4Z+1589MSKtBmSKErHYYgnfjZMJeZz2T0PJ+eB6TQImpTu6h30ePsbDRqYCoEor
ARC-Seal: i=1; a=rsa-sha256; t=1522168682; cv=none;
        d=google.com; s=arc-20160816;
        b=gJ0MBrP7xA3DJIxuvCritkie+mAO166G6PwoOozKgw6WM5E1a6Sdo1cY4y4x/Z5BUV
         lt3pds9pLs01pjKzfWPMTdDKLOT9TwF2J9zh4Ni1S7sf8QL0YJTo6UpEJNuz9RIZ0OY2
         0aXxGvdfA5pIzvAD3hZFXzf/eQwq8mbcF6gxEE5NtsLrzQC/9wPebXdKTssUkwJKQHw7
         0T0U0IzBrQKpE+cOkgOXlJUh7hoiLpJH8vKDpg7gpm7FYWi1HDc93hfHGh1aibGf3sUx
         dJCGklFAciJLPs6pbDtCFGHJxSA+sSBVr2f3oM0P9/lmvbrt8EaaJv9G0EP+sN+GESs4
         7mOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=pgSadQ/hRtksvrijG02qdab08/M+vcuAfZRMEmP0E1U=;
        b=amCCWG7ll/9G52hrBFEih8bi3ZVizY0r+MVa0RjYZs2RlDnpC7xDa7IjEXYG3MU6mt
         Ajkk1mB+7Wrzb3o/fd5P5uPPcf+Qqp10jccgplGzb0jYNb2yzvD3o2JGKp1Fu1puTvhI
         wFIfn043Mbuv32xhjenKKtsUch9EWeDl1DjRw9JdMbqHNjzZ0ZzrvHooc5fK5xk4ILLF
         xFXTtyEJjya0uYKvS8ZYO+Sew5AUq95qKI30FzxN99G1wgdYHHPDc5lOX8ULIs8nAQww
         RzUIlxb1CepoC1v2swunGkdQOIczURuWSnHABiseivnawdHo/XaYa4WLHwIfizQyS8kI
         6dBw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Liam Mark <lmark@codeaurora.org>,
	Laura Abbott <labbott@redhat.com>
Subject: [PATCH 4.14 094/101] staging: android: ion: Zero CMA allocated memory
Date: Tue, 27 Mar 2018 18:28:06 +0200
Message-Id: <20180327162755.773175076@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109547992105106?=
X-GMAIL-MSGID: =?utf-8?q?1596109547992105106?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liam Mark <lmark@codeaurora.org>

commit 6d79bd5bb6c79a9dba4842040c9adf39e7806330 upstream.

Since commit 204f672255c2 ("staging: android: ion: Use CMA APIs directly")
the CMA API is now used directly and therefore the allocated memory is no
longer automatically zeroed.

Explicitly zero CMA allocated memory to ensure that no data is exposed to
userspace.

Fixes: 204f672255c2 ("staging: android: ion: Use CMA APIs directly")
Signed-off-by: Liam Mark <lmark@codeaurora.org>
Acked-by: Laura Abbott <labbott@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/android/ion/ion_cma_heap.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

--- a/drivers/staging/android/ion/ion_cma_heap.c
+++ b/drivers/staging/android/ion/ion_cma_heap.c
@@ -21,6 +21,7 @@
 #include <linux/err.h>
 #include <linux/cma.h>
 #include <linux/scatterlist.h>
+#include <linux/highmem.h>
 
 #include "ion.h"
 
@@ -51,6 +52,22 @@ static int ion_cma_allocate(struct ion_h
 	if (!pages)
 		return -ENOMEM;
 
+	if (PageHighMem(pages)) {
+		unsigned long nr_clear_pages = nr_pages;
+		struct page *page = pages;
+
+		while (nr_clear_pages > 0) {
+			void *vaddr = kmap_atomic(page);
+
+			memset(vaddr, 0, PAGE_SIZE);
+			kunmap_atomic(vaddr);
+			page++;
+			nr_clear_pages--;
+		}
+	} else {
+		memset(page_address(pages), 0, size);
+	}
+
 	table = kmalloc(sizeof(*table), GFP_KERNEL);
 	if (!table)
 		goto err;
