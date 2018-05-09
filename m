Return-Path: <alastair@au1.ibm.com>
X-Google-Smtp-Source: AB8JxZoKiuQYFrNKPMF16ctMJE4+kMlvHlvfcx+nzjDdRZCLB9/QRScHpexSHrLJEMJOdKe0BbwJ
ARC-Seal: i=1; a=rsa-sha256; t=1525826593; cv=none;
        d=google.com; s=arc-20160816;
        b=wl+jGNE+OJSJaBhB2KXDJVZWuKBMmoOmjA6OMjMg1lcPaXIhjW1lXcS/iXMXPbyeaQ
         9O8zMbv2qHUxg+bqDQ2BZovY1jiywmV97Kv4etIfpW/+sqjtojug7XZu42hONKj7qPMG
         /L+4RDx5Y/5DIBby75esb7qR8Zp/fXItNraRbDmTdNEaAv92jpdeiHRIlpO4XbwjM5LM
         daGNMDgJTZZtpdHGdMi5Drb50ndQ/UKKFOienFQYlcoXotY44kexRRx5TlxDrZ8WkguG
         Nolufkr2SxOG9p6vreGKkU9JJ4jnrM+ViI3EpsT4zRheC/J4jrI423kjZxTV9jiD9bz4
         MaVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:message-id:references
         :in-reply-to:date:subject:cc:to:from:arc-authentication-results;
        bh=JSiedX9hDvHVmRAdYxij7LOEEFKNMF4eXGKumV4IDBw=;
        b=hUkmfIycmI9yh9rSXg7KIFqIJ2BOA9oEuJ9bUMfaOjykPhYFFVYNKVMZbWUIjXgBrL
         eN2BhYN/gnjn9cRdWmS8Jrx0CTW850n2uB+eA3kqEttnptafLEDr2jFVajp68C9AOtQZ
         JXHLgoodHCc8ZQqGKDyML4ZIHvFDJGkdD1PKLRivcf41VUPb/C/fHgaSmkdV8HsRHc4K
         uHyJqET0HeJkl/sPMXhiKGSaRaBedy+B88NvqbrL+VwuNuJTMHxXPvZsJXqAvBxE0/zg
         7lNcZzHolEtxcdrPfCtMbaFFJOo04Ox+nGmxqRPbcQFMgjdXvnn1n/CsLvQwOGoyVoHW
         wV6Q==
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
Subject: [PATCH v3 2/7] powerpc: Use TIDR CPU feature to control TIDR allocation
Date: Wed,  9 May 2018 10:42:07 +1000
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180509004212.4506-1-alastair@au1.ibm.com>
References: <20180417020950.21446-1-alastair@au1.ibm.com>
 <20180509004212.4506-1-alastair@au1.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18050900-0040-0000-0000-0000045780C1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050900-0041-0000-0000-000020FB88A8
Message-Id: <20180509004212.4506-3-alastair@au1.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-08_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805090005
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597957550458920157?=
X-GMAIL-MSGID: =?utf-8?q?1599945145935507863?=
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
