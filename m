Return-Path: <alastair@au1.ibm.com>
X-Google-Smtp-Source: AIpwx4/789LqcbquH1yiDyLDqSXWbe9RmnhCyQsgmirqRGXoC5O3WhE+8Y8H4B5EyMWrre94Zv2N
ARC-Seal: i=1; a=rsa-sha256; t=1523931075; cv=none;
        d=google.com; s=arc-20160816;
        b=srzn/FSHUMNunOcFaiOuiAICyoOQpCtfyUgsnFjqzJ2TazLT5EMNBagL1YXvZPQ+ut
         QgYHhhlObfE5qRbVR8pveaidwrGRl4Xd8ElVCxeMR7qO4vxBpn0sNqQmMXZtSLR+H4tG
         VAhZnmhlA87a8l354cgy6wNz4Wz7OW6+akwZOND8KYjC+S+s2NPu7jTXoO4qLglMo89N
         Gjb9C7/uAq3PDUnm08dMqeGVxLD91g/6YSgkM9C4oIL2vYQHQedTi42h/qrxiSldrlnN
         1tczebWwI6PblfpqCik+2zXjGY7gyVpyzw/yIQd5lKka4+9dH6Ai/aCTDeHaHSTcdF8o
         kfHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:references:in-reply-to:date:subject:cc:to:from
         :arc-authentication-results;
        bh=w5sBqSiNhkN4XBTpYi3l/F4Zm0V+1NIVjo19D9CFGEw=;
        b=wG8iOKwWwyHbRzrUMTW1UWgC4k3/Mud/FJG6gB8FiJrGVwV12Xn798L4LNr04G+BcO
         0tUTVGL9qiz6m6VigXW1O0+h27+Ud/Ojkm/gBUhliwpnGoDJ7TVLKqhGciTxP2KE+4DY
         X4qdfmjhayt63zVcsOTueYhnStFGsQN7hAR0DTUyIjXbyJB5dD2SEzQ2U6q1v+Emp5M+
         PtYnHTm00LXQ2E1p+73eEVq/IGvHKYXDcYPjV0A0Tqs8898rQOuSDxJa+i9NgIxRvlN8
         p7upjRqsyjaph398tZimEWyU0VUT6IvnBDAEoyhhKnYNmk+EM4Iy5Yxi4w4LNHwO1Z4i
         eoTA==
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
Subject: [PATCH 6/7] ocxl: Add an IOCTL so userspace knows which platform the kernel requires
Date: Tue, 17 Apr 2018 12:09:49 +1000
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180417020950.21446-1-alastair@au1.ibm.com>
References: <20180417020950.21446-1-alastair@au1.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18041702-0012-0000-0000-000005CB9AB6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041702-0013-0000-0000-00001947E1DB
Message-Id: <20180417020950.21446-7-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-17_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804170020
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597957550998214565?=
X-GMAIL-MSGID: =?utf-8?q?1597957550998214565?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alastair D'Silva <alastair@d-silva.org>

In order for a userspace AFU driver to call the Power9 specific
OCXL_IOCTL_ENABLE_P9_WAIT, it needs to verify that it can actually
make that call.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 drivers/misc/ocxl/file.c | 25 +++++++++++++++++++++++++
 include/uapi/misc/ocxl.h |  4 ++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c
index eb409a469f21..5a9f4f85aafd 100644
--- a/drivers/misc/ocxl/file.c
+++ b/drivers/misc/ocxl/file.c
@@ -168,12 +168,32 @@ static long afu_ioctl_enable_p9_wait(struct ocxl_context *ctx,
 }
 #endif
 
+
+static long afu_ioctl_get_platform(struct ocxl_context *ctx,
+		struct ocxl_ioctl_platform __user *uarg)
+{
+	struct ocxl_ioctl_platform arg;
+
+	memset(&arg, 0, sizeof(arg));
+
+#ifdef CONFIG_PPC64
+	if (cpu_has_feature(CPU_FTR_P9_TIDR))
+		arg.flags[0] |= OCXL_IOCTL_PLATFORM_FLAGS0_P9_WAIT;
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
+			x == OCXL_IOCTL_GET_PLATFORM ? "GET_PLATFORM" :	\
 			"UNKNOWN")
 
 static long afu_ioctl(struct file *file, unsigned int cmd,
@@ -239,6 +259,11 @@ static long afu_ioctl(struct file *file, unsigned int cmd,
 		break;
 #endif
 
+	case OCXL_IOCTL_GET_PLATFORM:
+		rc = afu_ioctl_get_platform(ctx,
+				(struct ocxl_ioctl_platform __user *) args);
+		break;
+
 	default:
 		rc = -EINVAL;
 	}
diff --git a/include/uapi/misc/ocxl.h b/include/uapi/misc/ocxl.h
index 8d2748e69c84..7bdd3efcf294 100644
--- a/include/uapi/misc/ocxl.h
+++ b/include/uapi/misc/ocxl.h
@@ -55,6 +55,9 @@ struct ocxl_ioctl_p9_wait {
 	__u64 reserved3[3];
 };
 
+#define OCXL_IOCTL_PLATFORM_FLAGS0_P9_WAIT	0x01
+struct ocxl_ioctl_platform {
+	__u64 flags[4];
 };
 
 struct ocxl_ioctl_irq_fd {
@@ -72,5 +75,6 @@ struct ocxl_ioctl_irq_fd {
 #define OCXL_IOCTL_IRQ_SET_FD	_IOW(OCXL_MAGIC, 0x13, struct ocxl_ioctl_irq_fd)
 #define OCXL_IOCTL_GET_METADATA _IOR(OCXL_MAGIC, 0x14, struct ocxl_ioctl_metadata)
 #define OCXL_IOCTL_ENABLE_P9_WAIT	_IOR(OCXL_MAGIC, 0x15, struct ocxl_ioctl_p9_wait)
+#define OCXL_IOCTL_GET_PLATFORM _IOR(OCXL_MAGIC, 0x16, struct ocxl_ioctl_platform)
 
 #endif /* _UAPI_MISC_OCXL_H */
-- 
2.14.3
