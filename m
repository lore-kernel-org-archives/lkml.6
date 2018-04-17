Return-Path: <alastair@au1.ibm.com>
X-Google-Smtp-Source: AIpwx4+yR5O9ICvF7DhmbWTL0LmTgjN1Y685ZeuQcCfSIIF9+LY1WZG1YCV1LenH8yaihC0yvtVM
ARC-Seal: i=1; a=rsa-sha256; t=1523931074; cv=none;
        d=google.com; s=arc-20160816;
        b=LbAdEksIGh5jlJLEWA10jB6vYesyLxuf1AGfsQpy5uptCJZW1rRlgDMDOHqUI2qnXn
         Aw3dfWdikeOfvresrQLpS79tLZkBkcig8sVrQzdsO/lYdePwRYOB/KOT2RLXNeHvNGOx
         4L3xYffMRl0PltL2TxDMHN48Qhtbz1TpKGm/Cggs0J0nTr6wCKBUCTGK420YGqI2Ji4f
         ORFBuZgFmspqKMDBHmJsYSCrBA+NQ1kfetiIgMbG/SNNTQtE4J3sGlt2XZ+q/VWJwe8I
         9wo7x5H+qq+yUQB+hVSMvwL3FtW3+QHeOVjLlJ0wzuw9oZkITwgStPg7MLiDyY8jjUet
         ISFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:references:in-reply-to:date:subject:cc:to:from
         :arc-authentication-results;
        bh=3HddY7CWYb/hka6Ys/c26NQwJkEdnxQz/INXxLQUBFk=;
        b=w/+u7leHtUke+XshWn0wBQuT+6yMfoUoLMbaWWQKDsnFEClVmUW2IPrxqP6JUwSpU4
         e4CBK1P2xFUWM0xq+yn60nqlzpVMjWdS+5M/g+eBFqhiFd3wSA7vttJvAaN75raZY+5R
         ixSgpxqKue3+UeGMnrEJPbG2SPUITrZ2qNJvyVzqnxi+izprNaE8lIfLsZQ/64HQbhZt
         AH8Wfx8S6cv30UWV1/mcKlbOsmm7C9vm8PApqVJg4EJvipvcQV9TfEWBNgCDhY7q6L8K
         tf8WemoUlHDGxQpWrNg518UOPqCUbHWdEVZTc0uX4A+J56NZL/WNloZwP9h7XbuPJpVY
         4ueQ==
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
Subject: [PATCH 2/7] powerpc: Use TIDR CPU feature to control TIDR allocation
Date: Tue, 17 Apr 2018 12:09:45 +1000
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180417020950.21446-1-alastair@au1.ibm.com>
References: <20180417020950.21446-1-alastair@au1.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18041702-0008-0000-0000-000004EC0E0A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041702-0009-0000-0000-00001E800EC2
Message-Id: <20180417020950.21446-3-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-17_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804170020
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597957550458920157?=
X-GMAIL-MSGID: =?utf-8?q?1597957550458920157?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alastair D'Silva <alastair@d-silva.org>

Switch the use of TIDR on it's CPU feature, rather than assuming it
is available based on architecture.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 arch/powerpc/kernel/process.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 1237f13fed51..a3e0a3e06d5a 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
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
