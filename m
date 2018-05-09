Return-Path: <alastair@au1.ibm.com>
X-Google-Smtp-Source: AB8JxZpsUbkqt5IjlHj7rK4PTqXKmuYWvvk+q8yq26fMThEf8wQdTrjYdJ3HfWaJlEdVO2W9mf7R
ARC-Seal: i=1; a=rsa-sha256; t=1525826595; cv=none;
        d=google.com; s=arc-20160816;
        b=jQNRczq+gsQiLp/IoOvYsEDUB8WHIA2td3YqQffAZiqX3rSTRSKbXfUKIhXPQ+oOnh
         3mOfGeqcAe50xnCeeBYkuYXhorhXJLSeONiHx0MYUFQsNxR2QajYoKW6HtGJevfeUA/l
         aWO6HaeD7TWynPwyNl7+dyUAlyzm5c2BndvuQYEBkSH0BP08Fd/0Pd++N8VW/NJT6MP8
         QDSnPAg17Gr2wBqZZj5eCspXtBrNCTfoVh7o+2l6YrFHNmYHlOMqjQTtbyprNJNrAUAb
         /wnHzxfgXAdn0yTN3KB4us/DBT495qjv/PVLdMzCSDLZc7ae5FicnxthjaahE41ITYf1
         zf5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:message-id:references
         :in-reply-to:date:subject:cc:to:from:arc-authentication-results;
        bh=bvhutUMlj7O28q6sDcDr8tjWHtm8WJASUXbGYRR6Tew=;
        b=YVU7Pn01TS2JJye0H6nWIL2HgRxqjow5RgTN/IFzjRJY1Tb5WGJ9Am1pnSBEiv0KAE
         9H6ZQtFHMUGGMRlMNnjqrp10r4MjUaNMUUmBIl/iRWyaCrLgvSb3qA7tRV26d4f0x8fS
         3iXEz/5Zi95IvRZA5n2Y2jLjWDOBgSrEmYzW6Ll9HdTchMZcekvaeHMAIplcJW+0clZX
         3FUJq0zUEHQwgscKJ6GdVCV6qkbKBVWsgJ62k7ssaxkwaD5C+iVOkZNGdqtzzdpUpsTn
         V6lC/e0Dbi1Puic02A4BK/M7mm+OixaTJJwVwD2hyD92a0/NF5CUfVk6nWV5TcyLRHAF
         HLJw==
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
Subject: [PATCH v3 6/7] ocxl: Add an IOCTL so userspace knows what OCXL features are available
Date: Wed,  9 May 2018 10:42:11 +1000
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180509004212.4506-1-alastair@au1.ibm.com>
References: <20180417020950.21446-1-alastair@au1.ibm.com>
 <20180509004212.4506-1-alastair@au1.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18050900-0040-0000-0000-000004379273
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050900-0041-0000-0000-0000263BCFA6
Message-Id: <20180509004212.4506-7-alastair@au1.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-08_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805090005
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599945147498054809?=
X-GMAIL-MSGID: =?utf-8?q?1599945147498054809?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alastair D'Silva <alastair@d-silva.org>

In order for a userspace AFU driver to call the POWER9 specific
OCXL_IOCTL_ENABLE_P9_WAIT, it needs to verify that it can actually
make that call.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 drivers/misc/ocxl/file.c | 25 +++++++++++++++++++++++++
 include/uapi/misc/ocxl.h |  4 ++++
 2 files changed, 29 insertions(+)

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
