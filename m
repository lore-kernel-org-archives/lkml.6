Return-Path: <alastair@au1.ibm.com>
X-Google-Smtp-Source: AIpwx4/XJBQehV5MN9JbGL7W+2Ox8HCCB3/6yT4rD6Zhtmm1MYZTaO0QL7fuGhPDuQId6lwm7kJy
ARC-Seal: i=1; a=rsa-sha256; t=1524013871; cv=none;
        d=google.com; s=arc-20160816;
        b=IV57YS3Oy+KlL4vuVSMT3WzL6eB9SXOSirwCFsk4mKuLqe+VanLsgXI4QuzDgwSrVg
         s2GnkLE35Tx2R6A6qrmOpcneYcXa+I4y75H48s28UKbO3RikF2dOxX0h1KcD3bjTEXVO
         dPhtEkFzDuBY5IevhmBaZfKekEITgEeVyPkFKImj9EXZtwYZYiaJCA0gldE2yqPar9ps
         36cgkHTVqNaRvVZN8eOfGaKDoys0ll4hTDx+i2k6IdryegM28hK0r+XBnE4gIsjMThvK
         R7v8czPry8JUP4eS/k1uEdVWeyUMr01qEZyUEsHvyDuQFIRtVVeWKAE5L7PKN1LPrGWz
         TKIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:references:in-reply-to:date:subject:cc:to:from
         :arc-authentication-results;
        bh=6zIKpKMjhDHtcwggrHd+lmd0SeN07CzzLfQsqoQo0TA=;
        b=zbBxy67ITobqaL3hSK48475omyPWGuGdzirv981o4Hb5wbSwZFFJSJSRT6Xh1vqHIe
         pMZazuxQGkhLUSHlIPMf9Wwj99zYuI2LMOihQhmEotxFFmcDPZ33u9EoUTmBGEhLw+5g
         2KFHRiTa4gr9IvfEbFdNYzJ9j0x/kHg8ttsd1Ay/X4FwrDDB3ruIrfjI2RlhSI1wIS+y
         WId2t3dX0KDxMa0j8mDWJSZLzLHdrnFrEBNsp2JVFEXXHNOv0mD7GdlNgA7tZL3MTPyk
         OV3iLvle2BYaVK7SdIdXpDoqhORMysTYnqGS73VUbxh37lUWl15SUvy1GDtdQ693wqeb
         0nwQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of alastair@au1.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=alastair@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of alastair@au1.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=alastair@au1.ibm.com;
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
Subject: [PATCH v2 6/7] ocxl: Add an IOCTL so userspace knows what CPU features are available
Date: Wed, 18 Apr 2018 11:08:09 +1000
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180418010810.30937-1-alastair@au1.ibm.com>
References: <20180417020950.21446-1-alastair@au1.ibm.com>
 <20180418010810.30937-1-alastair@au1.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18041801-0012-0000-0000-000005CC01F6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041801-0013-0000-0000-000019484F7D
Message-Id: <20180418010810.30937-7-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-17_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804180008
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598044369272237673?=
X-GMAIL-MSGID: =?utf-8?q?1598044369272237673?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alastair D'Silva <alastair@d-silva.org>

In order for a userspace AFU driver to call the Power9 specific
OCXL_IOCTL_ENABLE_P9_WAIT, it needs to verify that it can actually
make that call.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 Documentation/accelerators/ocxl.rst |  1 -
 drivers/misc/ocxl/file.c            | 25 +++++++++++++++++++++++++
 include/uapi/misc/ocxl.h            |  4 ++++
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/Documentation/accelerators/ocxl.rst b/Documentation/accelerators/ocxl.rst
index ddcc58d01cfb..7904adcc07fd 100644
--- a/Documentation/accelerators/ocxl.rst
+++ b/Documentation/accelerators/ocxl.rst
@@ -157,7 +157,6 @@ OCXL_IOCTL_GET_METADATA:
   Obtains configuration information from the card, such at the size of
   MMIO areas, the AFU version, and the PASID for the current context.
 
-
 mmap
 ----
 
diff --git a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c
index eb409a469f21..33ae46ce0a8a 100644
--- a/drivers/misc/ocxl/file.c
+++ b/drivers/misc/ocxl/file.c
@@ -168,12 +168,32 @@ static long afu_ioctl_enable_p9_wait(struct ocxl_context *ctx,
 }
 #endif
 
+
+static long afu_ioctl_get_features(struct ocxl_context *ctx,
+		struct ocxl_ioctl_features __user *uarg)
+{
+	struct ocxl_ioctl_features arg;
+
+	memset(&arg, 0, sizeof(arg));
+
+#ifdef CONFIG_PPC64
+	if (cpu_has_feature(CPU_FTR_P9_TIDR))
+		arg.flags[0] |= OCXL_IOCTL_FEATURES_FLAGS0_P9_WAIT;
+#endif
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
 			x == OCXL_IOCTL_GET_METADATA ? "GET_METADATA" :	\
 			x == OCXL_IOCTL_ENABLE_P9_WAIT ? "ENABLE_P9_WAIT" :	\
+			x == OCXL_IOCTL_GET_FEATURES ? "GET_FEATURES" :	\
 			"UNKNOWN")
 
 static long afu_ioctl(struct file *file, unsigned int cmd,
@@ -239,6 +259,11 @@ static long afu_ioctl(struct file *file, unsigned int cmd,
 		break;
 #endif
 
+	case OCXL_IOCTL_GET_FEATURES:
+		rc = afu_ioctl_get_features(ctx,
+				(struct ocxl_ioctl_features __user *) args);
+		break;
+
 	default:
 		rc = -EINVAL;
 	}
diff --git a/include/uapi/misc/ocxl.h b/include/uapi/misc/ocxl.h
index 8d2748e69c84..bb80f294b429 100644
--- a/include/uapi/misc/ocxl.h
+++ b/include/uapi/misc/ocxl.h
@@ -55,6 +55,9 @@ struct ocxl_ioctl_p9_wait {
 	__u64 reserved3[3];
 };
 
+#define OCXL_IOCTL_FEATURES_FLAGS0_P9_WAIT	0x01
+struct ocxl_ioctl_features {
+	__u64 flags[4];
 };
 
 struct ocxl_ioctl_irq_fd {
@@ -72,5 +75,6 @@ struct ocxl_ioctl_irq_fd {
 #define OCXL_IOCTL_IRQ_SET_FD	_IOW(OCXL_MAGIC, 0x13, struct ocxl_ioctl_irq_fd)
 #define OCXL_IOCTL_GET_METADATA _IOR(OCXL_MAGIC, 0x14, struct ocxl_ioctl_metadata)
 #define OCXL_IOCTL_ENABLE_P9_WAIT	_IOR(OCXL_MAGIC, 0x15, struct ocxl_ioctl_p9_wait)
+#define OCXL_IOCTL_GET_FEATURES _IOR(OCXL_MAGIC, 0x16, struct ocxl_ioctl_platform)
 
 #endif /* _UAPI_MISC_OCXL_H */
-- 
2.14.3
