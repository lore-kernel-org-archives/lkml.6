Return-Path: <alastair@au1.ibm.com>
X-Google-Smtp-Source: AIpwx49eQk0jhiGHfqZZIQIFqlp8cMhSfyS41nzagkkOlBw6iquj5sZHExyxT7jMkijapKXJp052
ARC-Seal: i=1; a=rsa-sha256; t=1524013868; cv=none;
        d=google.com; s=arc-20160816;
        b=apk4lIg2DdAPQUL4rb8gL/GX91WabRd/60KhMiFdBUOQa2Xt7EdP8j6kSSenKl+rSV
         GPEmy+tC5FFN6fPbE9f0pZI/evmnLj3skb95rDIZJdI28bajk/tIZAL/bKxn30M17f5w
         bhbaJ1B9MYczDRjbLzhLbwf8/NZpRP6Eg1npW6GaaiY7cYIJ7JgI6qaVYRdq9E9NS2P9
         na8qipLDkeTRDnSD9+A8ESfv+jOBKJOPMCVhuBEo1HZxNwAPypvtbcS2Uro+X2pVw3+v
         lhyM2wiLV8KLNjXS/dtbIVktH//JqxnSxfE7vF7ZbAuW1zrLYNCQ1Xa110W5nwvoOxiZ
         gGzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:references:in-reply-to:date:subject:cc:to:from
         :arc-authentication-results;
        bh=JSiedX9hDvHVmRAdYxij7LOEEFKNMF4eXGKumV4IDBw=;
        b=Wbnhq35ZOYvmSsl/0cGeuIeGXh8X6GgOWPXpxUjHcAYZxwcY6RBTmDYzQsZxJDBVCe
         ph8nmzjNuzT9OFCMGC6o4/FRLauKnTk3yA4Mawt3CH9SfhKr4zNJns0P+LBeduqt7OuJ
         62cftuVWWYjF2XgFyi/2+IWeh3+6ypWBoBo4T7VsOz79sdtKPljlNbJDmBrxdtCFgolJ
         5kNMGJ60ZrxNZdalCOtx2AbegjEM9kUYTe+51BDrLA3uXU3NIpFpX0J47dBNkOG0ZXZd
         Je3skTEu9EMJaqT5iKcovLJOccuo+b4sLTC6Yfdq88h8bRkQ9AXbnSA/UKwGsxRDMEXQ
         DlnQ==
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
Subject: [PATCH v2 2/7] powerpc: Use TIDR CPU feature to control TIDR allocation
Date: Wed, 18 Apr 2018 11:08:05 +1000
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180418010810.30937-1-alastair@au1.ibm.com>
References: <20180417020950.21446-1-alastair@au1.ibm.com>
 <20180418010810.30937-1-alastair@au1.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18041801-0020-0000-0000-0000041312D4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041801-0021-0000-0000-000042A7556F
Message-Id: <20180418010810.30937-3-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-17_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804180008
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597957550458920157?=
X-GMAIL-MSGID: =?utf-8?q?1598044366721167318?=
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
