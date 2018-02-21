Return-Path: <khalid.aziz@oracle.com>
X-Google-Smtp-Source: AH8x226UKJZftn43kSYrKXMmrMTz/pHpQdwQn/r5sPFPXCPNX/PdFh9bz/U3uOmnFrbvjbJwRO6c
ARC-Seal: i=1; a=rsa-sha256; t=1519233431; cv=none;
        d=google.com; s=arc-20160816;
        b=H1azGZr/KuBe1J69EQz01WV0PNpJOjM0tIkpnvVG9q358L0DObkXObdas7Mc0c/1nU
         rMLTwEUJpmMSFjgr/hG+OBYRBE+trYw7Z9QqtSRBTUGWEVyBCQJyfb6gXpR9aj+JpnjO
         F8JMeyhSyKamz1DyA1iLcz42fSP2I1Rux1tZh+5VRMpXVO9UqIPDchNRpuRV5/k4WsdD
         nNUmYW+AGXvNomAy3ps7Iqm5ZpIcGo3x3DhozZ3Qm/B3C7IKrJyPwgokUXQjzrg9vadh
         EAiCztVGIR/SewX3iL7xp+bbkyKH+EfffGEKAx3J56zxvFKGkyDkr6GY4CkCOwrKp604
         iu3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=I0UP/esg2v2hf2NPXwTxSgx4NMM3+FY2gamsXfraMy8=;
        b=uy9yBIxZUykcpIH9LI5MPCmkjCCEPmmpw0xW0rMv9daud0NMTH1pyreFINSfpr2AnM
         47E6QEJ1TuZ38kD5HF0Lf314BpO2Vuq0YUI1hWf1ShfSqokn+J3jzlf3+f+aveijGNVr
         7/es5bfJKXF9VB+q0udEr0P2XqJA82XvaJbyJ07r7P0PoSwAjxXLzEvygOaW6py+n2fE
         4OZCLjFgynpWPn6FAKjzwNL/R1h+D/HAtCGWXfybDHPbN/0Rff/oJm19o5ONrnqi1YTp
         n9e9bARkPWLPEQwOf31F2GKjcwAmUiq8dZkJaNYyHvOc+VcmnRaxI1dqP14vXfwpGbLi
         IaYg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=PN/kcReI;
       spf=pass (google.com: domain of khalid.aziz@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=khalid.aziz@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=PN/kcReI;
       spf=pass (google.com: domain of khalid.aziz@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=khalid.aziz@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Khalid Aziz <khalid.aziz@oracle.com>
To: arnd@arndb.de, hpa@zytor.com, davem@davemloft.net,
        dave.hansen@linux.intel.com
Cc: Khalid Aziz <khalid.aziz@oracle.com>, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, ebiederm@xmission.com, anthony.yznaga@oracle.com,
        pombredanne@nexb.com, jroedel@suse.de, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, sparclinux@vger.kernel.org,
        Khalid Aziz <khalid@gonehiking.org>
Subject: [PATCH v12 01/11] signals, sparc: Add signal codes for ADI violations
Date: Wed, 21 Feb 2018 10:15:43 -0700
Message-Id: <b1712b03774934c31afd9e394f07aae51eca74f8.1519227112.git.khalid.aziz@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1519227112.git.khalid.aziz@oracle.com>
References: <cover.1519227112.git.khalid.aziz@oracle.com>
In-Reply-To: <cover.1519227112.git.khalid.aziz@oracle.com>
References: <cover.1519227112.git.khalid.aziz@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8811 signatures=668676
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802210211
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593031714313554791?=
X-GMAIL-MSGID: =?utf-8?q?1593031714313554791?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

SPARC M7 processor introduces a new feature - Application Data
Integrity (ADI). ADI allows MMU to  catch rogue accesses to memory.
When a rogue access occurs, MMU blocks the access and raises an
exception. In response to the exception, kernel sends the offending
task a SIGSEGV with si_code that indicates the nature of exception.
This patch adds three new signal codes specific to ADI feature:

1. ADI is not enabled for the address and task attempted to access
   memory using ADI
2. Task attempted to access memory using wrong ADI tag and caused
   a deferred exception.
3. Task attempted to access memory using wrong ADI tag and caused
   a precise exception.

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
Cc: Khalid Aziz <khalid@gonehiking.org>
Reviewed-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
v10:
	- Updated si_code definitions to match other definitions

 arch/x86/kernel/signal_compat.c    | 2 +-
 include/uapi/asm-generic/siginfo.h | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/signal_compat.c b/arch/x86/kernel/signal_compat.c
index ac057f9b0763..41cf5996a2a9 100644
--- a/arch/x86/kernel/signal_compat.c
+++ b/arch/x86/kernel/signal_compat.c
@@ -27,7 +27,7 @@ static inline void signal_compat_build_tests(void)
 	 */
 	BUILD_BUG_ON(NSIGILL  != 11);
 	BUILD_BUG_ON(NSIGFPE  != 13);
-	BUILD_BUG_ON(NSIGSEGV != 4);
+	BUILD_BUG_ON(NSIGSEGV != 7);
 	BUILD_BUG_ON(NSIGBUS  != 5);
 	BUILD_BUG_ON(NSIGTRAP != 4);
 	BUILD_BUG_ON(NSIGCHLD != 6);
diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index 85dc965afd89..e94f03b3ee6f 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -246,7 +246,10 @@ typedef struct siginfo {
 #else
 # define SEGV_PKUERR	4	/* failed protection key checks */
 #endif
-#define NSIGSEGV	4
+#define SEGV_ACCADI	5	/* ADI not enabled for mapped object */
+#define SEGV_ADIDERR	6	/* Disrupting MCD error */
+#define SEGV_ADIPERR	7	/* Precise MCD exception */
+#define NSIGSEGV	7
 
 /*
  * SIGBUS si_codes
-- 
2.11.0
