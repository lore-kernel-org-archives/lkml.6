Return-Path: <alastair@au1.ibm.com>
X-Google-Smtp-Source: AB8JxZqCbT8woBiqeOWTCgXP5ZjbBvvazAp8mFAlLa3DVXNOZjtsdRzt7nppIhu/h+uCdLFUeDtt
ARC-Seal: i=1; a=rsa-sha256; t=1525844155; cv=none;
        d=google.com; s=arc-20160816;
        b=ZlCDFwbWVTKxh/MPM7dOnt6Pzk4CTV6xHMFdJhGT9O8gh+0gI66pSXr70+NW70m0tb
         B0MmWJut5T0kIEIIHl+lcdYDd8C9/W7CgathJb2MBRJM5sQU4O7pWykndnZwZWLwRGn8
         +nNmSdWZVIX4cfJ91ArThqMGspWFVDgvi09LeiYIZmHYPJZXcGXSX0huSS5TJlZP1u3M
         OLBEQRav86pdCRbSDirfaPwWHNzPxEY8hNyPFWfi+Zkw2H+GgeYbp1PAIPsD0NLs/1oW
         j5KhxCZNMRbPwlpj/Gs+aipT2n2S3EMUWuOwyaSSj/fDFxYOHwyeGDycZWQk5DjSuYvz
         G8fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:message-id:references
         :in-reply-to:date:subject:cc:to:from:arc-authentication-results;
        bh=Kj2GMDwC03rO5VLAOeX1gCOS/AWy1bU6GhUAM5GKC5Y=;
        b=ctx9vxRtqXZmOLSZki0jC2MZd1Ys+UhCf7tl744eOv4T2RP/i7seIA5sNixri2t/K8
         NHUjG7x3uR3D0hMeSSYS296eA+ZWjR/A+olb/0NuVniu4Z5xX3L+x4SZcpXDJ1V31eig
         ZtMClGZLe4VvcfWyE4gYOCE0P7TyPKzW+3Tx+lvceUUyrjTmj6UnLhTj77muy1jL8V9E
         QtzyPI383G6PNegzi4uODnKw+9BkrY+N6NT5uImbAJiTLpUEdb1y3dJv1sT3LZF8MQ2c
         WwBLpvQz0qUuKpCJTXkab6kL+BEWzweNCRHmOyGmtyFYVia+jtivJOZP18nDzX4iYAIn
         i1cg==
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
Subject: [PATCH v4 1/7] powerpc: Add TIDR CPU feature for POWER9
Date: Wed,  9 May 2018 15:35:00 +1000
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180509053506.9754-1-alastair@au1.ibm.com>
References: <20180509004212.4506-1-alastair@au1.ibm.com>
 <20180509053506.9754-1-alastair@au1.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18050905-0044-0000-0000-000005509EA6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050905-0045-0000-0000-00002891E432
Message-Id: <20180509053506.9754-2-alastair@au1.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-09_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805090056
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599945146111119412?=
X-GMAIL-MSGID: =?utf-8?q?1599963561827267396?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alastair D'Silva <alastair@d-silva.org>

This patch adds a CPU feature bit to show whether the CPU has
the TIDR register available, enabling as_notify/wait in userspace.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 arch/powerpc/include/asm/cputable.h | 3 ++-
 arch/powerpc/kernel/dt_cpu_ftrs.c   | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 4e332f3531c5..54c4cbbe57b4 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -215,6 +215,7 @@ static inline void cpu_feature_keys_init(void) { }
 #define CPU_FTR_P9_TM_HV_ASSIST		LONG_ASM_CONST(0x0000100000000000)
 #define CPU_FTR_P9_TM_XER_SO_BUG	LONG_ASM_CONST(0x0000200000000000)
 #define CPU_FTR_P9_TLBIE_BUG		LONG_ASM_CONST(0x0000400000000000)
+#define CPU_FTR_P9_TIDR			LONG_ASM_CONST(0x0000800000000000)
 
 #ifndef __ASSEMBLY__
 
@@ -462,7 +463,7 @@ static inline void cpu_feature_keys_init(void) { }
 	    CPU_FTR_CFAR | CPU_FTR_HVMODE | CPU_FTR_VMX_COPY | \
 	    CPU_FTR_DBELL | CPU_FTR_HAS_PPR | CPU_FTR_ARCH_207S | \
 	    CPU_FTR_TM_COMP | CPU_FTR_ARCH_300 | CPU_FTR_PKEY | \
-	    CPU_FTR_P9_TLBIE_BUG)
+	    CPU_FTR_P9_TLBIE_BUG | CPU_FTR_P9_TIDR)
 #define CPU_FTRS_POWER9_DD1 ((CPU_FTRS_POWER9 | CPU_FTR_POWER9_DD1) & \
 			     (~CPU_FTR_SAO))
 #define CPU_FTRS_POWER9_DD2_0 CPU_FTRS_POWER9
diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
index 11a3a4fed3fb..10f8b7f55637 100644
--- a/arch/powerpc/kernel/dt_cpu_ftrs.c
+++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
@@ -722,6 +722,7 @@ static __init void cpufeatures_cpu_quirks(void)
 	if ((version & 0xffff0000) == 0x004e0000) {
 		cur_cpu_spec->cpu_features &= ~(CPU_FTR_DAWR);
 		cur_cpu_spec->cpu_features |= CPU_FTR_P9_TLBIE_BUG;
+		cur_cpu_spec->cpu_features |= CPU_FTR_P9_TIDR;
 	}
 }
 
-- 
2.14.3
