Return-Path: <lizhijian@cn.fujitsu.com>
X-Google-Smtp-Source: AB8JxZrwQbYDsEa2S/pbYSBjHjYxQAQfE1sII6ejDBMV/bHXZMPpycC1ip8H0JL5F0UyR9U1fWtH
ARC-Seal: i=1; a=rsa-sha256; t=1525770887; cv=none;
        d=google.com; s=arc-20160816;
        b=aaTugsO41CkDA8LSi6iDvyHX2o8ywB1UnXLPgsVOWsJv4EeVTsXf5x2nLiy9IHj4Z+
         munIldEIj9mUSg2Ezjtu7ZsLzojWM7t3DH1+EeoewfEhjIbTwZQrzgX7c/tF6nEpL59t
         ncU9ZIMgaZ+bql0u0yN9EafwfXzafOOzWUUTJEj2I/lAP3p5K9BvqVZa4xf19p7nIUFd
         3JsKcIPmHxR5XXr9oBiJJ3K8jDxgQcf5KC8LJrXXsbNAa7EXQvvZatASwjgKuIGVy5MJ
         JZ4E4+kOUe/3p0GEQhF8Xc60QsDqwaMn6NOQxDQmZud5cAv8TFfUKAQJB8z09cD+k/I3
         SU0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=M6ccYGZw9ak0UCZFmK8CafuIKhj1mwn3QGKDG9TFyhg=;
        b=Da3S/s21pCL3242Be+hl6JZcOZ/yEfyFFN3YaT3LuBH1o0CrGO2XtDSaUwZRQ4yirS
         V7qQ/tol/FbU7n7mZzWA5MLeAPxIMcxJxr6niVYF1n/XQSVUGo1HT8W/PtqSiNdODzTR
         H+wRwdg3PJ9OQ0IVg9HudAVqvyqmbm2Lvtq4ZSwxesAUsQYVUnhFxGlQVIuUZtxF4LJ3
         eaMn41OLVeZf958QRpvktjguEhQBYkMhw9oxRrFt26b1YSS57CQlV6scFjPaeMp1XB9j
         YqmnvKAu0Lyiw6SlcEuuItqtpgoe+2UhoLKHt1irPWq8vDzsi4K3z7s1nykdCdBMWYie
         g8CA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of lizhijian@cn.fujitsu.com designates 183.91.158.132 as permitted sender) smtp.mailfrom=lizhijian@cn.fujitsu.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of lizhijian@cn.fujitsu.com designates 183.91.158.132 as permitted sender) smtp.mailfrom=lizhijian@cn.fujitsu.com
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="39685155"
From: Li Zhijian <lizhijian@cn.fujitsu.com>
To: <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <mingo@kernel.org>, <tglx@linutronix.de>, <gregkh@linuxfoundation.org>,
	<pombredanne@nexb.com>, <ebiederm@xmission.com>, <luto@kernel.org>,
	<dave.hansen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<philip.li@intel.com>, <leist.fnst@cn.fujitsu.com>, <zhijianx.li@intel.com>,
	Li Zhijian <lizhijian@cn.fujitsu.com>
Subject: [PATCH 1/2] tools/testing/selftests/x86: fix warning: "SEGV_PKUERR|SEGV_BNDERR" redefined
Date: Tue, 8 May 2018 17:14:29 +0800
Message-ID: <1525770870-19067-1-git-send-email-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.226.45]
X-yoursite-MailScanner-ID: 7754D4B34D23.A0D94
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@cn.fujitsu.com
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599886734267032257?=
X-GMAIL-MSGID: =?utf-8?q?1599886734267032257?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

SEGV_PKUERR and SEGV_BNDERR are defined since glibc-2.27

fix the following issue:
-------------------
root@vm-lkp-nex04-4G-5 /usr/src/linux-selftests-x86_64-rhel-7.2-75bc37fefc4471e718ba8e651aa74673d4e0a9eb/tools/testing/selftests/x86# make
gcc -m32 -o /usr/src/linux-selftests-x86_64-rhel-7.2-75bc37fefc4471e718ba8e651aa74673d4e0a9eb/tools/testing/selftests/x86/protection_keys_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 protection_keys.c -lrt -ldl -lm
gcc -m64 -o /usr/src/linux-selftests-x86_64-rhel-7.2-75bc37fefc4471e718ba8e651aa74673d4e0a9eb/tools/testing/selftests/x86/protection_keys_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 protection_keys.c -lrt -ldl
protection_keys.c:228:0: warning: "SEGV_BNDERR" redefined
 #define SEGV_BNDERR     3  /* failed address bound checks */
 ^
In file included from /usr/include/signal.h:58:0,
                 from protection_keys.c:33:
/usr/include/bits/siginfo-consts.h:117:0: note: this is the location of the previous definition
 #  define SEGV_BNDERR SEGV_BNDERR
 ^
protection_keys.c:229:0: warning: "SEGV_PKUERR" redefined
 #define SEGV_PKUERR     4
 ^
In file included from /usr/include/signal.h:58:0,
                 from protection_keys.c:33:
/usr/include/bits/siginfo-consts.h:119:0: note: this is the location of the previous definition
 #  define SEGV_PKUERR SEGV_PKUERR
 ^
protection_keys.c:228:0: warning: "SEGV_BNDERR" redefined
 #define SEGV_BNDERR     3  /* failed address bound checks */
 ^
In file included from /usr/include/signal.h:58:0,
                 from protection_keys.c:33:
/usr/include/x86_64-linux-gnu/bits/siginfo-consts.h:117:0: note: this is the location of the previous definition
 #  define SEGV_BNDERR SEGV_BNDERR
 ^
protection_keys.c:229:0: warning: "SEGV_PKUERR" redefined
 #define SEGV_PKUERR     4
 ^
In file included from /usr/include/signal.h:58:0,
                 from protection_keys.c:33:
/usr/include/x86_64-linux-gnu/bits/siginfo-consts.h:119:0: note: this is the location of the previous definition
 #  define SEGV_PKUERR SEGV_PKUERR
 ^
-------------------

Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
 tools/testing/selftests/x86/protection_keys.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/x86/protection_keys.c b/tools/testing/selftests/x86/protection_keys.c
index f15aa5a..757bb16 100644
--- a/tools/testing/selftests/x86/protection_keys.c
+++ b/tools/testing/selftests/x86/protection_keys.c
@@ -225,8 +225,12 @@ void dump_mem(void *dumpme, int len_bytes)
 	}
 }
 
-#define SEGV_BNDERR     3  /* failed address bound checks */
-#define SEGV_PKUERR     4
+#ifndef SEGV_BNDERR
+# define SEGV_BNDERR     3  /* failed address bound checks */
+#endif
+#ifndef SEGV_PKUERR
+# define SEGV_PKUERR     4
+#endif
 
 static char *si_code_str(int si_code)
 {
-- 
2.7.4
