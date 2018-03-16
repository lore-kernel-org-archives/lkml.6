Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs5KDEiYlAtkErqsiDYlaCbf5NVlNJBADO6x5jBDTW/bYbzaC9dPPXI8lIzggsb3Xqko31T
ARC-Seal: i=1; a=rsa-sha256; t=1521214548; cv=none;
        d=google.com; s=arc-20160816;
        b=TATzp4iyfTBtVQmYprDURkb6+aqb1YebeTj1kIOSYuL8tfDNOrSyx38fdjTtouJl9I
         V9yTX7YaNHUmrbMvyPJFCf0Fae39GufxcZmSWqjXCzvEOwpmbNsbFgmMPdz+8YyD6z/N
         YBCgZv28Z3ibXkyesiguVbm84g64R38rT8vHH5aYTCyY1oOsrURqK8bcR4mWQ/sjQryw
         9gZTLFRpop+QR/02zGrHFub6LqYId3WxDpV1JB3cspL/WhYlolLYfz2+h0Dki2Z3JqJU
         ye19LyJLBuifVrld9XOJSlPM2fE2is+JFC9vWDKcK7D1qO2J0n1gmbh30JZQoDjPZW77
         HyYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Qk+ZDm9BS3uhpoSTM6N9sB0MIaXr3HRjOLuPDNroMQ8=;
        b=gg0El4ou0ltgbi8Qs+SpQeyNCaVgPZ2wQxMcW/sPj7UyVjgTjuAAGLINzimZAPJFG0
         M4reYRBQ/O2NRpE2LLZQdeG6xJ6DKg20kY4O2jF0512W4X2dY6WbuHI1D40FvDoKNtQQ
         CvFlKjX3KaZEpZ8X49CM4GP9sx6YQtNtBJggYKJyo91WKnsogOsRRf07Rk/KGQFAJGFi
         +8eKpA4QIHki8Mo396cAKkWPSzcWAkuL0qACogCcxCtbmGzW51P0COHaaA3VyZ6HW9cR
         JUoZJJYoG6PYKbwMRZAYz7k9OEu1RUv9IxZIK42TM7VXqzQTkiYO72r3rgxgYGUW2sjp
         FugA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Rob Clark <robdclark@gmail.com>,
	Chris Wilson <chris@chris-wilson.co.uk>,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 028/109] dma-buf/fence: Fix lock inversion within dma-fence-array
Date: Fri, 16 Mar 2018 16:22:57 +0100
Message-Id: <20180316152331.496405243@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109065910291454?=
X-GMAIL-MSGID: =?utf-8?q?1595109065910291454?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chris Wilson <chris@chris-wilson.co.uk>


[ Upstream commit 03e4e0a9e02cf703da331ff6cfd57d0be9bf5692 ]

Ages ago Rob Clark noted,

"Currently with fence-array, we have a potential deadlock situation.  If
we fence_add_callback() on an array-fence, the array-fence's lock is
acquired first, and in it's ->enable_signaling() callback, it will install
cbs on it's array-member fences, so the array-member's lock is acquired
second.

But in the signal path, the array-member's lock is acquired first, and
the array-fence's lock acquired second."

Rob proposed either extensive changes to dma-fence to unnest the
fence-array signaling, or to defer the signaling onto a workqueue. This
is a more refined version of the later, that should keep the latency
of the fence signaling to a minimum by using an irq-work, which is
executed asap.

Reported-by: Rob Clark <robdclark@gmail.com>
Suggested-by: Rob Clark <robdclark@gmail.com>
References: 1476635975-21981-1-git-send-email-robdclark@gmail.com
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Christian König <christian.koenig@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20171114162719.30958-1-chris@chris-wilson.co.uk
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/Kconfig              |    1 +
 drivers/dma-buf/dma-fence-array.c |   14 ++++++++++++--
 include/linux/dma-fence-array.h   |    3 +++
 3 files changed, 16 insertions(+), 2 deletions(-)

--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -249,6 +249,7 @@ config DMA_SHARED_BUFFER
 	bool
 	default n
 	select ANON_INODES
+	select IRQ_WORK
 	help
 	  This option enables the framework for buffer-sharing between
 	  multiple drivers. A buffer is associated with a file using driver
--- a/drivers/dma-buf/dma-fence-array.c
+++ b/drivers/dma-buf/dma-fence-array.c
@@ -31,6 +31,14 @@ static const char *dma_fence_array_get_t
 	return "unbound";
 }
 
+static void irq_dma_fence_array_work(struct irq_work *wrk)
+{
+	struct dma_fence_array *array = container_of(wrk, typeof(*array), work);
+
+	dma_fence_signal(&array->base);
+	dma_fence_put(&array->base);
+}
+
 static void dma_fence_array_cb_func(struct dma_fence *f,
 				    struct dma_fence_cb *cb)
 {
@@ -39,8 +47,9 @@ static void dma_fence_array_cb_func(stru
 	struct dma_fence_array *array = array_cb->array;
 
 	if (atomic_dec_and_test(&array->num_pending))
-		dma_fence_signal(&array->base);
-	dma_fence_put(&array->base);
+		irq_work_queue(&array->work);
+	else
+		dma_fence_put(&array->base);
 }
 
 static bool dma_fence_array_enable_signaling(struct dma_fence *fence)
@@ -136,6 +145,7 @@ struct dma_fence_array *dma_fence_array_
 	spin_lock_init(&array->lock);
 	dma_fence_init(&array->base, &dma_fence_array_ops, &array->lock,
 		       context, seqno);
+	init_irq_work(&array->work, irq_dma_fence_array_work);
 
 	array->num_fences = num_fences;
 	atomic_set(&array->num_pending, signal_on_any ? 1 : num_fences);
--- a/include/linux/dma-fence-array.h
+++ b/include/linux/dma-fence-array.h
@@ -21,6 +21,7 @@
 #define __LINUX_DMA_FENCE_ARRAY_H
 
 #include <linux/dma-fence.h>
+#include <linux/irq_work.h>
 
 /**
  * struct dma_fence_array_cb - callback helper for fence array
@@ -47,6 +48,8 @@ struct dma_fence_array {
 	unsigned num_fences;
 	atomic_t num_pending;
 	struct dma_fence **fences;
+
+	struct irq_work work;
 };
 
 extern const struct dma_fence_ops dma_fence_array_ops;
