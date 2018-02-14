Return-Path: <kernel-hardening-return-11779-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x226A+NKXquA5Y+HODZPlQYL9oB0wDaF12TDa7AqsEm3wYYECrpc+rC/m9Be9r4zKndBImpq9
ARC-Seal: i=1; a=rsa-sha256; t=1518639187; cv=none;
        d=google.com; s=arc-20160816;
        b=ftcogZXue5wmbo5ItcjRRbJBRDZawcrCkmmlDdUMV5k4kS5nMI65bVGtHi3xoTRlW0
         AM3rx8kvSbNfbjkHftBNNfrPA7so6JlnMoGY98YGdpH65XML1h2aySSZ+xzHuoRuSXli
         Rx/7edZh1HFuLf3pjZ20OqUOw+DgZ1lQYWMkv1ctXieGWfZY2uKu8R6ViRzI8B1D7ZQ9
         seh7wQQLSjggwJCdeIWvI0agXwNllEuP/DROINHfDUshn2zYe3rNJLaa1KU69QKc367W
         qNSXLcJMgwvJB8i6TMbeDbPHp99S1jvHvcSF71L7B3jpztRgppYF0zZDM87NQpxBUotj
         yTVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=WthBHKenLHBX182ogxZHxPTpCq6cnWX6LosdoqkvTKs=;
        b=fYbTf9AVCreAD4Ve2yj7A8HWc3FqIU0qXevs9DzdPL40MliguKvE/ZQdptvqLZkwG+
         bHoyDWka030t6QES7brCu7D7Mztc6ag2V3Iy+VxHHVrvSmBzErZsA0L+EzzOyDScjSXl
         XugclzA75SatBfL819GeFxTOHRuTygt+SW2lOBMdJOjrEtpePTnjPVq1xNIYJSTDaaQL
         cEb55mhkHI7U9N8sTNEy8rOJ5Z+282a9PTWgMJIl3WDXoZQe47+UVMIFmggKnn/VSntr
         VGYrSgwc7kRC0pPy88c08t8WiG/37DGMls9DKCwoB5YkLg0IlHU4Kf8gBQcSqj9w07UO
         PC8Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=KUK+5n40;
       spf=pass (google.com: domain of kernel-hardening-return-11779-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11779-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=KUK+5n40;
       spf=pass (google.com: domain of kernel-hardening-return-11779-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11779-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <mawilcox@microsoft.com>,
	linux-mm@kvack.org,
	Kees Cook <keescook@chromium.org>,
	linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com,
	Joe Perches <joe@perches.com>
Subject: [PATCH v2 3/8] Convert virtio_console to kvzalloc_struct
Date: Wed, 14 Feb 2018 12:11:49 -0800
Message-Id: <20180214201154.10186-4-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180214201154.10186-1-willy@infradead.org>
References: <20180214201154.10186-1-willy@infradead.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592408604560950999?=
X-GMAIL-MSGID: =?utf-8?q?1592408604560950999?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Matthew Wilcox <mawilcox@microsoft.com>

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 drivers/char/virtio_console.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 468f06134012..e0816cc2c6bd 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -433,8 +433,7 @@ static struct port_buffer *alloc_buf(struct virtqueue *vq, size_t buf_size,
 	 * Allocate buffer and the sg list. The sg list array is allocated
 	 * directly after the port_buffer struct.
 	 */
-	buf = kmalloc(sizeof(*buf) + sizeof(struct scatterlist) * pages,
-		      GFP_KERNEL);
+	buf = kvzalloc_struct(buf, sg, pages, GFP_KERNEL);
 	if (!buf)
 		goto fail;
 
-- 
2.15.1
