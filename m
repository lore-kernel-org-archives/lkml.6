Return-Path: <alastair@au1.ibm.com>
X-Google-Smtp-Source: AB8JxZpeC6x+CZoW+BIpuxFtmpaooDXAoOy31Z2BmTDsSUdHWGLn/8NRD3afAzXlSZD3h8AeuUEi
ARC-Seal: i=1; a=rsa-sha256; t=1525844158; cv=none;
        d=google.com; s=arc-20160816;
        b=NHmBl7H2X/RFX9j2iDGfsX36FNAxLAooLulSX7hqY/ncD5xy4fUUaldAyL+aTeOLZk
         H+jpr8jzBS1ZKbhSJqlMShDLQPH8hYHTwK+/s3nUgftug6vlHvvqlHqcOHeMo7hOLI9h
         P2t8OHZB1CeuTM0DWTXcINM9VIXnDIQL4P4p46adPnvy0hwkgFwXI1/Gsnf7f5RJh3OB
         ji6JUUHN+ZXdyaAfzKGKRj6TaPQb9Y/CGIgxEhK7vbTKLYwRA5QerxxxkliKFg0RaAH9
         J/rO0pzrlprmeXSCRPxW4qyNr2/OqjAcYmzez6hz4BF2qMtXgsxOj11B2eBrQrDT7Qio
         KDSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:message-id:references
         :in-reply-to:date:subject:cc:to:from:arc-authentication-results;
        bh=d5SMlkYFn+AMvSZwvaRGcgvYpwjLb/Ku4/LTSnmt9aI=;
        b=MbtThJh9QvzGHJ5S3G7lxxvI5M440xr+iuetJyfp34CEgt4aIrSut9esDqP0tnX9o6
         MPbmdiwXbFjA9uDpk6eHZJ8850ZpbOW7q1DJbQGNCwJbM1RW+PsR1vHgH5b1sJ1afoXU
         akclUd1HvwZGhtl1Kvtq+tR19k9EVWn6iGMY21Y9srqOKRlf2yMRD9S/yjCm7W+g3jiN
         T2yEv/vHmYv1uhOg8MX6aoDK+T+VZmyrm3/MlEU5Kf18ZKQRxOLi1Phtn6Dhxk5qj2Xh
         QcvG7moPn4ohZq3ddlBvedO6t3Zv7boWraZBBvAD5hJUOyPsL8wZlKemoRycIfSLqvzq
         CN1A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of alastair@au1.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=alastair@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of alastair@au1.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=alastair@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, mikey@neuling.org,
        vaibhav@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        malat@debian.org, felix@linux.vnet.ibm.com, pombredanne@nexb.com,
        sukadev@linux.vnet.ibm.com, npiggin@gmail.com,
        gregkh@linuxfoundation.org, arnd@arndb.de,
        andrew.donnellan@au1.ibm.com, fbarrat@linux.vnet.ibm.com,
        corbet@lwn.net, "Alastair D'Silva" <alastair@d-silva.org>
Subject: [PATCH v4 5/7] ocxl: Expose the thread_id needed for wait on POWER9
Date: Wed,  9 May 2018 15:35:04 +1000
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180509053506.9754-1-alastair@au1.ibm.com>
References: <20180509004212.4506-1-alastair@au1.ibm.com>
 <20180509053506.9754-1-alastair@au1.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18050905-0040-0000-0000-0000045791A4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050905-0041-0000-0000-000020FB9AD7
Message-Id: <20180509053506.9754-6-alastair@au1.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-09_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805090056
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599945148775984066?=
X-GMAIL-MSGID: =?utf-8?q?1599963564185833427?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alastair D'Silva <alastair@d-silva.org>

In order to successfully issue as_notify, an AFU needs to know the TID
to notify, which in turn means that this information should be
available in userspace so it can be communicated to the AFU.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 drivers/misc/ocxl/context.c       |  5 +++-
 drivers/misc/ocxl/file.c          | 53 +++++++++++++++++++++++++++++++++++++++
 drivers/misc/ocxl/link.c          | 36 ++++++++++++++++++++++++++
 drivers/misc/ocxl/ocxl_internal.h |  1 +
 include/misc/ocxl.h               |  9 +++++++
 include/uapi/misc/ocxl.h          | 10 ++++++++
 6 files changed, 113 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/ocxl/context.c b/drivers/misc/ocxl/context.c
index 909e8807824a..95f74623113e 100644
--- a/drivers/misc/ocxl/context.c
+++ b/drivers/misc/ocxl/context.c
@@ -34,6 +34,8 @@ int ocxl_context_init(struct ocxl_context *ctx, struct ocxl_afu *afu,
 	mutex_init(&ctx->xsl_error_lock);
 	mutex_init(&ctx->irq_lock);
 	idr_init(&ctx->irq_idr);
+	ctx->tidr = 0;
+
 	/*
 	 * Keep a reference on the AFU to make sure it's valid for the
 	 * duration of the life of the context
@@ -65,6 +67,7 @@ int ocxl_context_attach(struct ocxl_context *ctx, u64 amr)
 {
 	int rc;
 
+	// Locks both status & tidr
 	mutex_lock(&ctx->status_mutex);
 	if (ctx->status != OPENED) {
 		rc = -EIO;
@@ -72,7 +75,7 @@ int ocxl_context_attach(struct ocxl_context *ctx, u64 amr)
 	}
 
 	rc = ocxl_link_add_pe(ctx->afu->fn->link, ctx->pasid,
-			current->mm->context.id, 0, amr, current->mm,
+			current->mm->context.id, ctx->tidr, amr, current->mm,
 			xsl_fault_error, ctx);
 	if (rc)
 		goto out;
diff --git a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c
index 038509e5d031..eb409a469f21 100644
--- a/drivers/misc/ocxl/file.c
+++ b/drivers/misc/ocxl/file.c
@@ -5,6 +5,8 @@
 #include <linux/sched/signal.h>
 #include <linux/uaccess.h>
 #include <uapi/misc/ocxl.h>
+#include <asm/reg.h>
+#include <asm/switch_to.h>
 #include "ocxl_internal.h"
 
 
@@ -123,11 +125,55 @@ static long afu_ioctl_get_metadata(struct ocxl_context *ctx,
 	return 0;
 }
 
+#ifdef CONFIG_PPC64
+static long afu_ioctl_enable_p9_wait(struct ocxl_context *ctx,
+		struct ocxl_ioctl_p9_wait __user *uarg)
+{
+	struct ocxl_ioctl_p9_wait arg;
+
+	memset(&arg, 0, sizeof(arg));
+
+	if (cpu_has_feature(CPU_FTR_P9_TIDR)) {
+		enum ocxl_context_status status;
+
+		// Locks both status & tidr
+		mutex_lock(&ctx->status_mutex);
+		if (!ctx->tidr) {
+			if (set_thread_tidr(current))
+				return -ENOENT;
+
+			ctx->tidr = current->thread.tidr;
+		}
+
+		status = ctx->status;
+		mutex_unlock(&ctx->status_mutex);
+
+		if (status == ATTACHED) {
+			int rc;
+			struct link *link = ctx->afu->fn->link;
+
+			rc = ocxl_link_update_pe(link, ctx->pasid, ctx->tidr);
+			if (rc)
+				return rc;
+		}
+
+		arg.thread_id = ctx->tidr;
+	} else
+		return -ENOENT;
+
+	if (copy_to_user(uarg, &arg, sizeof(arg)))
+		return -EFAULT;
+
+	return 0;
+}
+#endif
+
 #define CMD_STR(x) (x == OCXL_IOCTL_ATTACH ? "ATTACH" :			\
 			x == OCXL_IOCTL_IRQ_ALLOC ? "IRQ_ALLOC" :	\
 			x == OCXL_IOCTL_IRQ_FREE ? "IRQ_FREE" :		\
 			x == OCXL_IOCTL_IRQ_SET_FD ? "IRQ_SET_FD" :	\
 			x == OCXL_IOCTL_GET_METADATA ? "GET_METADATA" :	\
+			x == OCXL_IOCTL_ENABLE_P9_WAIT ? "ENABLE_P9_WAIT" :	\
 			"UNKNOWN")
 
 static long afu_ioctl(struct file *file, unsigned int cmd,
@@ -186,6 +232,13 @@ static long afu_ioctl(struct file *file, unsigned int cmd,
 				(struct ocxl_ioctl_metadata __user *) args);
 		break;
 
+#ifdef CONFIG_PPC64
+	case OCXL_IOCTL_ENABLE_P9_WAIT:
+		rc = afu_ioctl_enable_p9_wait(ctx,
+				(struct ocxl_ioctl_p9_wait __user *) args);
+		break;
+#endif
+
 	default:
 		rc = -EINVAL;
 	}
diff --git a/drivers/misc/ocxl/link.c b/drivers/misc/ocxl/link.c
index 656e8610eec2..88876ae8f330 100644
--- a/drivers/misc/ocxl/link.c
+++ b/drivers/misc/ocxl/link.c
@@ -544,6 +544,42 @@ int ocxl_link_add_pe(void *link_handle, int pasid, u32 pidr, u32 tidr,
 }
 EXPORT_SYMBOL_GPL(ocxl_link_add_pe);
 
+int ocxl_link_update_pe(void *link_handle, int pasid, __u16 tid)
+{
+	struct link *link = (struct link *) link_handle;
+	struct spa *spa = link->spa;
+	struct ocxl_process_element *pe;
+	int pe_handle, rc;
+
+	if (pasid > SPA_PASID_MAX)
+		return -EINVAL;
+
+	pe_handle = pasid & SPA_PE_MASK;
+	pe = spa->spa_mem + pe_handle;
+
+	mutex_lock(&spa->spa_lock);
+
+	pe->tid = tid;
+
+	/*
+	 * The barrier makes sure the PE is updated
+	 * before we clear the NPU context cache below, so that the
+	 * old PE cannot be reloaded erroneously.
+	 */
+	mb();
+
+	/*
+	 * hook to platform code
+	 * On powerpc, the entry needs to be cleared from the context
+	 * cache of the NPU.
+	 */
+	rc = pnv_ocxl_spa_remove_pe_from_cache(link->platform_data, pe_handle);
+	WARN_ON(rc);
+
+	mutex_unlock(&spa->spa_lock);
+	return rc;
+}
+
 int ocxl_link_remove_pe(void *link_handle, int pasid)
 {
 	struct link *link = (struct link *) link_handle;
diff --git a/drivers/misc/ocxl/ocxl_internal.h b/drivers/misc/ocxl/ocxl_internal.h
index 5d421824afd9..a32f2151029f 100644
--- a/drivers/misc/ocxl/ocxl_internal.h
+++ b/drivers/misc/ocxl/ocxl_internal.h
@@ -77,6 +77,7 @@ struct ocxl_context {
 	struct ocxl_xsl_error xsl_error;
 	struct mutex irq_lock;
 	struct idr irq_idr;
+	u16 tidr; // Thread ID used for P9 wait implementation
 };
 
 struct ocxl_process_element {
diff --git a/include/misc/ocxl.h b/include/misc/ocxl.h
index 51ccf76db293..9ff6ddc28e22 100644
--- a/include/misc/ocxl.h
+++ b/include/misc/ocxl.h
@@ -188,6 +188,15 @@ extern int ocxl_link_add_pe(void *link_handle, int pasid, u32 pidr, u32 tidr,
 		void (*xsl_err_cb)(void *data, u64 addr, u64 dsisr),
 		void *xsl_err_data);
 
+/**
+ * Update values within a Process Element
+ *
+ * link_handle: the link handle associated with the process element
+ * pasid: the PASID for the AFU context
+ * tid: the new thread id for the process element
+ */
+extern int ocxl_link_update_pe(void *link_handle, int pasid, __u16 tid);
+
 /*
  * Remove a Process Element from the Shared Process Area for a link
  */
diff --git a/include/uapi/misc/ocxl.h b/include/uapi/misc/ocxl.h
index 0af83d80fb3e..8d2748e69c84 100644
--- a/include/uapi/misc/ocxl.h
+++ b/include/uapi/misc/ocxl.h
@@ -48,6 +48,15 @@ struct ocxl_ioctl_metadata {
 	__u64 reserved[13]; // Total of 16*u64
 };
 
+struct ocxl_ioctl_p9_wait {
+	__u16 thread_id; // The thread ID required to wake this thread
+	__u16 reserved1;
+	__u32 reserved2;
+	__u64 reserved3[3];
+};
+
+};
+
 struct ocxl_ioctl_irq_fd {
 	__u64 irq_offset;
 	__s32 eventfd;
@@ -62,5 +71,6 @@ struct ocxl_ioctl_irq_fd {
 #define OCXL_IOCTL_IRQ_FREE	_IOW(OCXL_MAGIC, 0x12, __u64)
 #define OCXL_IOCTL_IRQ_SET_FD	_IOW(OCXL_MAGIC, 0x13, struct ocxl_ioctl_irq_fd)
 #define OCXL_IOCTL_GET_METADATA _IOR(OCXL_MAGIC, 0x14, struct ocxl_ioctl_metadata)
+#define OCXL_IOCTL_ENABLE_P9_WAIT	_IOR(OCXL_MAGIC, 0x15, struct ocxl_ioctl_p9_wait)
 
 #endif /* _UAPI_MISC_OCXL_H */
-- 
2.14.3
