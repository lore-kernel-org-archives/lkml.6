Return-Path: <alastair@au1.ibm.com>
X-Google-Smtp-Source: AG47ELslvvtzZAjNgYMAzyfYCv/OMIRg5Qz4HFQskMRCVQhIz5rtyCsiJhlWksAGI3moxZ7g+0wM
ARC-Seal: i=1; a=rsa-sha256; t=1519189120; cv=none;
        d=google.com; s=arc-20160816;
        b=WbF/JqdSczpaYe0a3r4IgCS+5kLaZ6t4Uk0w/ilNw+sFtMi1rfEk4aPCi2smKbEgdv
         0NpzE3vNtiNqc2+PzvLwaVQHh6YtNY9hW0u/sQM9qJjnffNCnPaa9bFW85gfIifVtORU
         YaAhzL5mVdKvP7QxXsuPAi58WmwqWvfyN/vCFve9yg4Pb9KBjYRPdq7WK9VCH4BXs5Md
         cRj/z2VOnl4ZVy67S3YayrJbvWXtVu1jy3dV/Bc9qtJD1V5lq5RPiChB17H1eeF4BJtu
         aLC82iG/wTcepm9cYSskOU58g9M660iNdIxchjHAlkrxwtY4pKb/S9pd9anHYWV8Z4oH
         Vbog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=BzbeQmlxLXOdPaZ6c41xLKG9Xt+aQCC+elXz00mLPww=;
        b=S6bO3v2A11I7IXsx7yBNYxXjBukdqrufyOJUq1nytVIHsrb4Cqxvn4AjueTAZ83iXG
         vOKmdy43oQktTn+XrX4y0g4jLUXPNFmjGkfMKwVeMGqZZmj8tfhBshVI+Hh2q4+1lqhw
         hWgDy8CRtdE1y7hDTGQopB3B/eWJ6zKkodX+C1MhufyA8qqU0qXB6p1d+JPZQFMKZRB2
         qHvZEWO7JWRcbWKMP13Sz1x6Xoq4dhM0vA3HdlvAHBdMKbuKYyuStBkV72Vk4gSlfOWo
         Rn0Rf6syNfvV1FnlGHhcEbqXLtUUVoO+JNXB4A40eFOzZUGV9AKgbTqR+4L4fL8EhWTG
         UpvQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of alastair@au1.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=alastair@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of alastair@au1.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=alastair@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Cc: frederic.barrat@fr.ibm.com, andrew.donnellan@au1.ibm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, alastair@au1.ibm.com,
        "Alastair D'Silva" <alastair@d-silva.org>
Subject: [PATCH] ocxl: Add get_metadata IOCTL to share OCXL information to userspace
Date: Wed, 21 Feb 2018 15:57:36 +1100
X-Mailer: git-send-email 2.14.3
X-TM-AS-GCONF: 00
x-cbid: 18022104-0040-0000-0000-00000435DFAD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022104-0041-0000-0000-000020D7F27C
Message-Id: <20180221045736.7614-1-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-21_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802210059
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592985250939595866?=
X-GMAIL-MSGID: =?utf-8?q?1592985250939595866?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alastair D'Silva <alastair@d-silva.org>

Some required information is not exposed to userspace currently (eg. the
PASID), pass this information back, along with other information which
is currently communicated via sysfs, which saves some parsing effort in
userspace.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 drivers/misc/ocxl/file.c | 27 +++++++++++++++++++++++++++
 include/uapi/misc/ocxl.h | 22 ++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c
index d9aa407db06a..11514a8444e5 100644
--- a/drivers/misc/ocxl/file.c
+++ b/drivers/misc/ocxl/file.c
@@ -102,10 +102,32 @@ static long afu_ioctl_attach(struct ocxl_context *ctx,
 	return rc;
 }
 
+static long afu_ioctl_get_metadata(struct ocxl_context *ctx,
+		struct ocxl_ioctl_get_metadata __user *uarg)
+{
+	struct ocxl_ioctl_get_metadata arg;
+
+	memset(&arg, 0, sizeof(arg));
+
+	arg.version = 0;
+
+	arg.afu_version_major = ctx->afu->config.version_major;
+	arg.afu_version_minor = ctx->afu->config.version_minor;
+	arg.pasid = ctx->pasid;
+	arg.pp_mmio_size = ctx->afu->config.pp_mmio_stride;
+	arg.global_mmio_size = ctx->afu->config.global_mmio_size;
+
+	if (copy_to_user(uarg, &arg, sizeof(arg)))
+		return -EFAULT;
+
+	return 0;
+}
+
 #define CMD_STR(x) (x == OCXL_IOCTL_ATTACH ? "ATTACH" :			\
 			x == OCXL_IOCTL_IRQ_ALLOC ? "IRQ_ALLOC" :	\
 			x == OCXL_IOCTL_IRQ_FREE ? "IRQ_FREE" :		\
 			x == OCXL_IOCTL_IRQ_SET_FD ? "IRQ_SET_FD" :	\
+			x == OCXL_IOCTL_GET_METADATA ? "GET_METADATA" :	\
 			"UNKNOWN")
 
 static long afu_ioctl(struct file *file, unsigned int cmd,
@@ -157,6 +179,11 @@ static long afu_ioctl(struct file *file, unsigned int cmd,
 					irq_fd.eventfd);
 		break;
 
+	case OCXL_IOCTL_GET_METADATA:
+		rc = afu_ioctl_get_metadata(ctx,
+				(struct ocxl_ioctl_get_metadata __user *) args);
+		break;
+
 	default:
 		rc = -EINVAL;
 	}
diff --git a/include/uapi/misc/ocxl.h b/include/uapi/misc/ocxl.h
index 4b0b0b756f3e..16e1f48ce280 100644
--- a/include/uapi/misc/ocxl.h
+++ b/include/uapi/misc/ocxl.h
@@ -32,6 +32,27 @@ struct ocxl_ioctl_attach {
 	__u64 reserved3;
 };
 
+/*
+ * Version contains the version of the struct.
+ * Versions will always be backwards compatible, that is, new versions will not
+ * alter existing fields
+ */
+struct ocxl_ioctl_get_metadata {
+	__u16 version;
+
+	// Version 0 fields
+	__u8  afu_version_major;
+	__u8  afu_version_minor;
+	__u32 pasid;
+
+	__u64 pp_mmio_size;
+	__u64 global_mmio_size;
+
+	// End version 0 fields
+
+	__u64 reserved[13]; // Total of 16*u64
+};
+
 struct ocxl_ioctl_irq_fd {
 	__u64 irq_offset;
 	__s32 eventfd;
@@ -45,5 +66,6 @@ struct ocxl_ioctl_irq_fd {
 #define OCXL_IOCTL_IRQ_ALLOC	_IOR(OCXL_MAGIC, 0x11, __u64)
 #define OCXL_IOCTL_IRQ_FREE	_IOW(OCXL_MAGIC, 0x12, __u64)
 #define OCXL_IOCTL_IRQ_SET_FD	_IOW(OCXL_MAGIC, 0x13, struct ocxl_ioctl_irq_fd)
+#define OCXL_IOCTL_GET_METADATA _IOR(OCXL_MAGIC, 0x14, struct ocxl_ioctl_get_metadata)
 
 #endif /* _UAPI_MISC_OCXL_H */
-- 
2.14.3
