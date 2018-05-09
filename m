Return-Path: <alastair@au1.ibm.com>
X-Google-Smtp-Source: AB8JxZofMMAZIVtEVzzlN7RHUSE/U9opubrmUEuOwBTOP4vTOPR8s9FqmWihgdtY0blH/W7olXUu
ARC-Seal: i=1; a=rsa-sha256; t=1525844154; cv=none;
        d=google.com; s=arc-20160816;
        b=wqatvYV4dQjdXymRXvemoVhnzcCkKLAMJackNrW3AcpEZc+/wL0jrFzxZ5O3fd5v/G
         w/cZp50PrJfhCVnHY9nlQDaKX3mNZgzY2Yq4FfvVB8HjoyzUk319SGq736g3dJNLKoF5
         ebVGLY8wuU7OC6PpYfbSXWdTJzO+lWuSdmucQjMdFjafurY0Lj8ys5uxLqHj2E07/sHO
         xNUznmc6FIFl30j4IDPLaN0LOIAL4coNGqJpPyOXr1O3HFRxnEe6qh5hNqZIJHbyIgDj
         MXUzo+N/Sh4CsyfXgEHA0QGcJXLeB1/t4Q4c6R3b7atld2b0+MSFfRI6zGEYsnJMXu1l
         Awrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:message-id:references
         :in-reply-to:date:subject:cc:to:from:arc-authentication-results;
        bh=JSiedX9hDvHVmRAdYxij7LOEEFKNMF4eXGKumV4IDBw=;
        b=PR+GML6kXtcu6OYY+K8ZLTsO6glaIuXHOU/YQ2FVtd9wa65NZ9QzgDXEhArr92tSxr
         1qiBVZhCXuhyTkMoBb4vj3M3Tfb4XDMGJGW1NIU9puYTAa1Esof2WENANcBGJo1YnOH+
         Kr5ZYPPJ2CJpvxaSZ2UPjP1cd+T1tvuc1Ardxe7FPwwuRaToBGVBSwmFGWzXV9koqYnp
         yTjaAu7KOLP8OiDwB87dVxNaoViMWRieJzFguubkEUEHgzKz3yJCCG6LL/26X1nDTVpk
         kwnREZRJKASOaQixEUR41ySZcxrHDEow3EnzUUle/Lgsv/fhbmT14IXLCqeGJw/jD2Al
         +Q7w==
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
Subject: [PATCH v4 2/7] powerpc: Use TIDR CPU feature to control TIDR allocation
Date: Wed,  9 May 2018 15:35:01 +1000
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180509053506.9754-1-alastair@au1.ibm.com>
References: <20180509004212.4506-1-alastair@au1.ibm.com>
 <20180509053506.9754-1-alastair@au1.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18050905-0008-0000-0000-000004F49F56
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050905-0009-0000-0000-00001E88E4E3
Message-Id: <20180509053506.9754-3-alastair@au1.ibm.com>
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
X-GMAIL-THRID: =?utf-8?q?1597957550458920157?=
X-GMAIL-MSGID: =?utf-8?q?1599963560226069925?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alastair D'Silva <alastair@d-silva.org>

Switch the use of TIDR on it's CPU feature, rather than assuming it
is available based on architecture.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 arch/powerpc/kernel/process.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 1237f13fed51..3b00da47699b 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1154,7 +1154,7 @@ static inline void restore_sprs(struct thread_struct *old_thread,
 			mtspr(SPRN_TAR, new_thread->tar);
 	}
 
-	if (cpu_has_feature(CPU_FTR_ARCH_300) &&
+	if (cpu_has_feature(CPU_FTR_P9_TIDR) &&
 	    old_thread->tidr != new_thread->tidr)
 		mtspr(SPRN_TIDR, new_thread->tidr);
 #endif
@@ -1570,7 +1570,7 @@ void clear_thread_tidr(struct task_struct *t)
 	if (!t->thread.tidr)
 		return;
 
-	if (!cpu_has_feature(CPU_FTR_ARCH_300)) {
+	if (!cpu_has_feature(CPU_FTR_P9_TIDR)) {
 		WARN_ON_ONCE(1);
 		return;
 	}
@@ -1593,7 +1593,7 @@ int set_thread_tidr(struct task_struct *t)
 {
 	int rc;
 
-	if (!cpu_has_feature(CPU_FTR_ARCH_300))
+	if (!cpu_has_feature(CPU_FTR_P9_TIDR))
 		return -EINVAL;
 
 	if (t != current)
-- 
2.14.3
