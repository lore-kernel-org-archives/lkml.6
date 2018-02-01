Return-Path: <khalid.aziz@oracle.com>
X-Google-Smtp-Source: AH8x227NOk32/sTccoATadwvpQYe+89zkBbxuXk4cu98qrc1HIXFNV4tVd0njv9fDpJvmpRGu3ZL
ARC-Seal: i=1; a=rsa-sha256; t=1517508129; cv=none;
        d=google.com; s=arc-20160816;
        b=fTmXqf4bcKyLhli73izR6R9WeWTJ4HRwxijppWgXjhgD/O/N5u2WUNsPDYShSqtGHS
         IFau8KAdcPoc0nTW9IRpqsc1WdM3FQNqm938ZvTb0jAuCY9qI6vN/E30JyqrFjjvMHhV
         MX2/ucz3rE/lzr06dWPJJvXIVbe+nCbYcMR8hpt2c5C07DnpHgipNtB40nOzUd+bKKUB
         owzWWtKRCLIGtgci3Rj7TaN7YBnLcN04FExr4/9nK2s/t3cSrP2Xnylhlbup0aq0BXiK
         +/uP1/wVHeRy4bDSnvReJ3QRXAY5n6GMt5jQB9D3C771dshrgED1bM2+bZQn7RQnx+2m
         ii4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=c+THSJisc4kpeEkTQFN9rEFfWmVz1ccbo0XsLVAiv7M=;
        b=yGXpqaNrwIbTr7AM/+19Xdh4u8fBPw6h4RxkmR7zDZjRwUMGDTE42QKyL62amnRCU0
         WK7LDMUi9GtrcnN/Qgkm8ej5PQWm4c1tYzyWBVza1H0/w3/EHU4OMbyriKI8L5ROZik7
         cQTAQ3NtC2pCSI7NLZbXIYnVFlDUNyOfdH9gtW4r3/HbwY2ay9vmCnDzlqbI/BGugKPV
         m34jFc4Dzf2eWKvcUOckHngW+E80lzxqe5qME4TQNlqLH4OMZry1NRK3u+5fvRjd/cKg
         B9dHdxy9bSRWLwjFeylzDKDlS+1AWm4rtKHVjHGkgXKvhd9N0N8xIATDTvRQjNtPLUgj
         Lb8Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=s/qHQPHU;
       spf=pass (google.com: domain of khalid.aziz@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=khalid.aziz@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=s/qHQPHU;
       spf=pass (google.com: domain of khalid.aziz@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=khalid.aziz@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Khalid Aziz <khalid.aziz@oracle.com>
To: arnd@arndb.de, hpa@zytor.com, davem@davemloft.net,
        dave.hansen@linux.intel.com
Cc: Khalid Aziz <khalid.aziz@oracle.com>, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, anthony.yznaga@oracle.com, pombredanne@nexb.com,
        jroedel@suse.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        sparclinux@vger.kernel.org, Khalid Aziz <khalid@gonehiking.org>
Subject: [PATCH v11 01/10] signals, sparc: Add signal codes for ADI violations
Date: Thu,  1 Feb 2018 11:01:09 -0700
Message-Id: <0f8ef68b97eeddb189ee31b51a8508df1699dcca.1517497017.git.khalid.aziz@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1517497017.git.khalid.aziz@oracle.com>
References: <cover.1517497017.git.khalid.aziz@oracle.com>
In-Reply-To: <cover.1517497017.git.khalid.aziz@oracle.com>
References: <cover.1517497017.git.khalid.aziz@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8792 signatures=668660
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802010231
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591222603657552960?=
X-GMAIL-MSGID: =?utf-8?q?1591222603657552960?=
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
index 8c6da1a643da..20be1bc923f9 100644
--- a/arch/x86/kernel/signal_compat.c
+++ b/arch/x86/kernel/signal_compat.c
@@ -27,7 +27,7 @@ static inline void signal_compat_build_tests(void)
 	 */
 	BUILD_BUG_ON(NSIGILL  != 8);
 	BUILD_BUG_ON(NSIGFPE  != 8);
-	BUILD_BUG_ON(NSIGSEGV != 4);
+	BUILD_BUG_ON(NSIGSEGV != 7);
 	BUILD_BUG_ON(NSIGBUS  != 5);
 	BUILD_BUG_ON(NSIGTRAP != 4);
 	BUILD_BUG_ON(NSIGCHLD != 6);
diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index e447283b8f52..279b7c0d2977 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -202,7 +202,10 @@ typedef struct siginfo {
 #define SEGV_ACCERR	2	/* invalid permissions for mapped object */
 #define SEGV_BNDERR	3	/* failed address bound checks */
 #define SEGV_PKUERR	4	/* failed protection key checks */
-#define NSIGSEGV	4
+#define SEGV_ACCADI	5	/* ADI not enabled for mapped object */
+#define SEGV_ADIDERR	6	/* Disrupting MCD error */
+#define SEGV_ADIPERR	7	/* Precise MCD exception */
+#define NSIGSEGV	7
 
 /*
  * SIGBUS si_codes
-- 
2.11.0
