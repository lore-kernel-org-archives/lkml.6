Return-Path: <alastair@au1.ibm.com>
X-Google-Smtp-Source: AH8x227R7xCWCM0VZRriYvpLZ3y+dMgSkKX39hgiObJQr6zh8WfdhsaB6Co6Kq7hAbkN7Ce9tl1i
ARC-Seal: i=1; a=rsa-sha256; t=1519273108; cv=none;
        d=google.com; s=arc-20160816;
        b=aAVPGvAUTjnN4ZA42Gm1lhK6Ul+DEPPcIh/Tjgv8ogP+aheesy/UNtZ4qRqLDJTi+i
         zVJUAbaqQuOd+AZOmFtdOJ44gJhP46eBU604XjKVsXwoEqaumqOS22rDYqC716rWWBa8
         F6LV/RymN9c6BziTqfZgtTMh35O5a/5DS5g2ulRx/XRF5uYtKBYePcFIZDD4up1Y+Lxz
         qhpxjrk14q3tFOdL2/wsdviHRZmPmWi5o22kPyGiqT7hut7KQqYxBTYWLjvcOA91tyFo
         R77SRBiXH5jGVcaLUTwxI1uTapzLlnmvL0PmXgtHHldxEcL5rFtGEBIZoZTDsl+O8xf/
         v4gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:references:in-reply-to:date:subject:cc:to:from
         :arc-authentication-results;
        bh=kvIUuC7fc/eohLdOKHQXiz4+/88cqty8rqWPJrycARs=;
        b=qFK8ITR2MYERS6EMjWJgFn4E3Rg6gRAcT8PpzU3tVHMC6N4oKeAUWgE0DbZrcLNfIL
         +IqdbY9ktvyT8v0qKpDl0Z1e63vUEOtJBvee0P+kCOn5OFcqSZtN3B8RC9LbsLLt9FS9
         ziYRZYiWC1qkEJrWGs2254DSvXa6it3ftEp8pWpIl2KBo/L3fFU589iOef5jbNFkiOK9
         YW/RQ9kp5Uo2IoNqMd+1bBuekmKYHZeQyxDy2NRyl2B9yHwKOZzZP67t+cw05AaX2vJ5
         0gDtZg8zjLI0xuUIdHpWzvTHOp7zkEBVcEt9dwgt5BeBuArK0fOPpdex/Cqf8IQ5BVuU
         jw/g==
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
Subject: [PATCH v3 1/2] ocxl: Add get_metadata IOCTL to share OCXL information to userspace
Date: Thu, 22 Feb 2018 15:17:38 +1100
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180222041739.27899-1-alastair@au1.ibm.com>
References: <20180222030334.14060-1-alastair@au1.ibm.com>
 <20180222041739.27899-1-alastair@au1.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18022204-0020-0000-0000-000003FA57FF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022204-0021-0000-0000-0000428E6B25
Message-Id: <20180222041739.27899-2-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-22_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802220053
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592985250939595866?=
X-GMAIL-MSGID: =?utf-8?q?1593073319167475635?=
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
 include/uapi/misc/ocxl.h | 17 +++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c
index d9aa407db06a..90df1be5ef3f 100644
--- a/drivers/misc/ocxl/file.c
+++ b/drivers/misc/ocxl/file.c
@@ -102,10 +102,32 @@ static long afu_ioctl_attach(struct ocxl_context *ctx,
 	return rc;
 }
 
+static long afu_ioctl_get_metadata(struct ocxl_context *ctx,
+		struct ocxl_ioctl_metadata __user *uarg)
+{
+	struct ocxl_ioctl_metadata arg;
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
+				(struct ocxl_ioctl_metadata __user *) args);
+		break;
+
 	default:
 		rc = -EINVAL;
 	}
diff --git a/include/uapi/misc/ocxl.h b/include/uapi/misc/ocxl.h
index 4b0b0b756f3e..0af83d80fb3e 100644
--- a/include/uapi/misc/ocxl.h
+++ b/include/uapi/misc/ocxl.h
@@ -32,6 +32,22 @@ struct ocxl_ioctl_attach {
 	__u64 reserved3;
 };
 
+struct ocxl_ioctl_metadata {
+	__u16 version; // struct version, always backwards compatible
+
+	// Version 0 fields
+	__u8  afu_version_major;
+	__u8  afu_version_minor;
+	__u32 pasid;		// PASID assigned to the current context
+
+	__u64 pp_mmio_size;	// Per PASID MMIO size
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
@@ -45,5 +61,6 @@ struct ocxl_ioctl_irq_fd {
 #define OCXL_IOCTL_IRQ_ALLOC	_IOR(OCXL_MAGIC, 0x11, __u64)
 #define OCXL_IOCTL_IRQ_FREE	_IOW(OCXL_MAGIC, 0x12, __u64)
 #define OCXL_IOCTL_IRQ_SET_FD	_IOW(OCXL_MAGIC, 0x13, struct ocxl_ioctl_irq_fd)
+#define OCXL_IOCTL_GET_METADATA _IOR(OCXL_MAGIC, 0x14, struct ocxl_ioctl_metadata)
 
 #endif /* _UAPI_MISC_OCXL_H */
-- 
2.14.3
