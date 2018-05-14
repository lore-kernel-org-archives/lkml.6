Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753414AbeENMnU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 08:43:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44449 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753144AbeENMnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 08:43:14 -0400
Date: Mon, 14 May 2018 05:42:47 -0700
From: tip-bot for Dave Hansen <tipbot@zytor.com>
Message-ID: <tip-7e7fd67ca39335a49619729821efb7cbdd674eb0@git.kernel.org>
Cc: hpa@zytor.com, torvalds@linux-foundation.org, mingo@kernel.org,
        tglx@linutronix.de, dave.hansen@intel.com, shuah@kernel.org,
        peterz@infradead.org, mpe@ellerman.id.au, linuxram@us.ibm.com,
        linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
        akpm@linux-foundation.org
Reply-To: akpm@linux-foundation.org, dave.hansen@linux.intel.com,
        linux-kernel@vger.kernel.org, mpe@ellerman.id.au, linuxram@us.ibm.com,
        shuah@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        dave.hansen@intel.com, torvalds@linux-foundation.org, mingo@kernel.org,
        hpa@zytor.com
In-Reply-To: <20180509171345.7FC7DA00@viggo.jf.intel.com>
References: <20180509171345.7FC7DA00@viggo.jf.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/pkeys/selftests: Allow faults on unknown keys
Git-Commit-ID: 7e7fd67ca39335a49619729821efb7cbdd674eb0
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  7e7fd67ca39335a49619729821efb7cbdd674eb0
Gitweb:     https://git.kernel.org/tip/7e7fd67ca39335a49619729821efb7cbdd674eb0
Author:     Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate: Wed, 9 May 2018 10:13:46 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 14 May 2018 11:14:45 +0200

x86/pkeys/selftests: Allow faults on unknown keys

The exec-only pkey is allocated inside the kernel and userspace
is not told what it is.  So, allow PK faults to occur that have
an unknown key.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michael Ellermen <mpe@ellerman.id.au>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ram Pai <linuxram@us.ibm.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/20180509171345.7FC7DA00@viggo.jf.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/testing/selftests/x86/protection_keys.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/x86/protection_keys.c b/tools/testing/selftests/x86/protection_keys.c
index 5f5aedb80e7b..7d95acd2aec3 100644
--- a/tools/testing/selftests/x86/protection_keys.c
+++ b/tools/testing/selftests/x86/protection_keys.c
@@ -921,13 +921,21 @@ void *malloc_pkey(long size, int prot, u16 pkey)
 }
 
 int last_pkru_faults;
+#define UNKNOWN_PKEY -2
 void expected_pk_fault(int pkey)
 {
 	dprintf2("%s(): last_pkru_faults: %d pkru_faults: %d\n",
 			__func__, last_pkru_faults, pkru_faults);
 	dprintf2("%s(%d): last_si_pkey: %d\n", __func__, pkey, last_si_pkey);
 	pkey_assert(last_pkru_faults + 1 == pkru_faults);
-	pkey_assert(last_si_pkey == pkey);
+
+       /*
+	* For exec-only memory, we do not know the pkey in
+	* advance, so skip this check.
+	*/
+	if (pkey != UNKNOWN_PKEY)
+		pkey_assert(last_si_pkey == pkey);
+
 	/*
 	 * The signal handler shold have cleared out PKRU to let the
 	 * test program continue.  We now have to restore it.
