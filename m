Return-Path: <natechancellor@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526323845; cv=none;
        d=google.com; s=arc-20160816;
        b=UflDps7JoHarPtsRIBeDUkhOrLqDEMXYlo5Edpu8Uie65k+lPO7IuvydxDzLEs3kF2
         KPdoYkKq9F2ke81LplTG+EiRKdk8AAcePjbrCzfSgFf7aa3pptt8E0KUtZ7XhR+kJlgc
         wgdhoePXU52f3vcXkI/EkbVkRWsq7AFZcdJ7QWLPiVJ8gwDSdl6eGDgv88Heki+LWpBv
         e/m0RD88mbc1M6Kf7B7Hm7FUeB+Oyp8fQK2clb8B5RvqhvCvaTwRHIUmvj3wzU6UW2aE
         /rXhI+OqIOl1/NBHhDtRq3jRG+g2PEhPLpoWtGC6KSk1amc2e3EZADAmHA5drfcOqNi9
         XOhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=+Gj/qVgzlXI3uT9KjcF83v7SvQtEDhrbk1NormCD/sA=;
        b=kZ1BNED2J/Z4BFeOxBEH0P2kYH1z2xmCG71/fP3Tf6b5/yDpQoY8WJSPRxYc3kVMkB
         6YklFPaLve8iyC94Yy1ezSOIOCU5xgDSh4rjGI9V3iBh12cYfCAEJm1EMDobmmttVNlE
         oWKv12AKY6ruwYOywfjU11d/k6gprhcl7DVJX8Oe52lsankrQb+EJ65jmi9oZsqxBp7q
         zqBYKr7kDRMXqunsaJEz9nO3FiCOJ9zwWwcovZoIoUPV+gmXaa1nkjcg13uWQxReQbNF
         Rr8yK57HUy29o/uofU14rqictMotpulpX79idsqSHVk0vXn1p/tYTPDdhOoLuPRdGwDK
         lXDA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Hf6tZCnR;
       spf=pass (google.com: domain of natechancellor@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=natechancellor@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Hf6tZCnR;
       spf=pass (google.com: domain of natechancellor@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=natechancellor@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZoHvFia0+DQUevdWoL+Og4UIlxBoga79F5y8HnREPbNLsh6dhH441jbB2q6jvTRvz+4uNefYw==
From: Nathan Chancellor <natechancellor@gmail.com>
To: devel@driverdev.osuosl.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Laura Abbott <labbott@redhat.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
	Martijn Coenen <maco@android.com>,
	Todd Kjos <tkjos@android.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] staging: android: ion: Check return value of ion_buffer_kmap_get
Date: Mon, 14 May 2018 11:50:44 -0700
Message-Id: <20180514185044.19367-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.17.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600466552340337405?=
X-GMAIL-MSGID: =?utf-8?q?1600466552340337405?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

GCC warns that vaddr is set but unused. Check the return value of
ion_buffer_kmap_get to make vaddr useful and make sure everything
is properly configured before beginning a DMA.

Suggested-by: Laura Abbott <labbott@redhat.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/staging/android/ion/ion.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
index d10b60fe4a29..af682cbde767 100644
--- a/drivers/staging/android/ion/ion.c
+++ b/drivers/staging/android/ion/ion.c
@@ -315,6 +315,7 @@ static int ion_dma_buf_begin_cpu_access(struct dma_buf *dmabuf,
 	struct ion_buffer *buffer = dmabuf->priv;
 	void *vaddr;
 	struct ion_dma_buf_attachment *a;
+	int ret = 0;
 
 	/*
 	 * TODO: Move this elsewhere because we don't always need a vaddr
@@ -322,6 +323,10 @@ static int ion_dma_buf_begin_cpu_access(struct dma_buf *dmabuf,
 	if (buffer->heap->ops->map_kernel) {
 		mutex_lock(&buffer->lock);
 		vaddr = ion_buffer_kmap_get(buffer);
+		if (IS_ERR(vaddr)) {
+			ret = PTR_ERR(vaddr);
+			goto unlock;
+		}
 		mutex_unlock(&buffer->lock);
 	}
 
@@ -330,9 +335,10 @@ static int ion_dma_buf_begin_cpu_access(struct dma_buf *dmabuf,
 		dma_sync_sg_for_cpu(a->dev, a->table->sgl, a->table->nents,
 				    direction);
 	}
-	mutex_unlock(&buffer->lock);
 
-	return 0;
+unlock:
+	mutex_unlock(&buffer->lock);
+	return ret;
 }
 
 static int ion_dma_buf_end_cpu_access(struct dma_buf *dmabuf,
-- 
2.17.0
