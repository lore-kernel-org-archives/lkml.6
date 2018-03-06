Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AG47ELvGqvQ/kEbYvaEnEzicdgWfH7DmTlSNsnVBBkzvCcXlUMFvh7hz/c3k48Ho9jjeLhZFZ/tN
ARC-Seal: i=1; a=rsa-sha256; t=1520295962; cv=none;
        d=google.com; s=arc-20160816;
        b=LqLi9KhDjldDJdcqGOG++zB8hWchTJDUT2LjFgXkcKktmYcX+yxJeGokzRD9/uF364
         MGlTpEWyqlWU25YyBxAxe6OE2AEJU8CbdavepgmLXNs8kH/M1Ufc12K8ilDG3wKjk9ai
         fJgsyxn0SPctGlQ9wx2DnG7rCPPPul/FMHuAZVS1oiXmwNafizqTLa+bkcMRuauzoeLQ
         Fo6L3yTWxXNIYeEHeVN/MUo3J1GGKOUqbJCy1utc/TJddmC8LcsnstDPExcnm5RunbYd
         BozDJ5NWuqjj4Gk2Efy9FKT1TqHEJWmZezm9KunOpdc5YxSKnqVRtDbXWqxJYi49uz2s
         ibZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :dkim-signature:arc-authentication-results;
        bh=7JCwPZhWmhXE8JhuZ96IN4amCZr1NWomJ5OlnuqK8rY=;
        b=lz5aSvKj411Aa8ZVTornBV+r92RF0QNPJUpdcEIpGxHMTcaZPWDFeGCu3rzAELo6uy
         mADdjQ2SDXooezgsQuiTLehgPmeNTz+rIZOWdN1yA36ntVIpDAFYgE8Of8N2LZZcEQcC
         FsP3OeG1iSKNCqSQQ7eoXJFw9cwDApaKwA52QsW+cl9frRxiriPx+yvOr499LS+JjDX3
         FU0C/tG0YbL6v7UxhyO9+QSr3yY8fpT/TscfxoO3zSMHxYlCXFcySKrVPCfcJ7VDz/Ck
         /a3rvKGbPeLn50HzDq2gPawOGVYUwUb62wchGvxwYjht8gupQej3qleRosyOO4/QbCc3
         LKcg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=oG02c+pa;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=oG02c+pa;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        cminyard@mvista.com, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4.1 03/65] x86/mm: Add a 'noinvpcid' boot option to turn off INVPCID
Date: Mon,  5 Mar 2018 19:24:36 -0500
Message-Id: <20180306002538.1761-4-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306002538.1761-1-pasha.tatashin@oracle.com>
References: <20180306002538.1761-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060003
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594145858480269001?=
X-GMAIL-MSGID: =?utf-8?q?1594145858480269001?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andy Lutomirski <luto@kernel.org>

commit d12a72b844a49d4162f24cefdab30bed3f86730e upstream.

This adds a chicken bit to turn off INVPCID in case something goes
wrong.  It's an early_param() because we do TLB flushes before we
parse __setup() parameters.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Reviewed-by: Borislav Petkov <bp@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luis R. Rodriguez <mcgrof@suse.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Toshi Kani <toshi.kani@hp.com>
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/f586317ed1bc2b87aee652267e515b90051af385.1454096309.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 791a0f3fecdabe18cc291e5f9b7ebbdc81895975)
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 Documentation/kernel-parameters.txt |  2 ++
 arch/x86/kernel/cpu/common.c        | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 08dc303d0d47..ceaab09a279e 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -2435,6 +2435,8 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 
 	nointroute	[IA-64]
 
+	noinvpcid	[X86] Disable the INVPCID cpu feature.
+
 	nojitter	[IA-64] Disables jitter checking for ITC timers.
 
 	no-kvmclock	[X86,KVM] Disable paravirtualized KVM clock driver
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 5732326ec126..90ef802d9d90 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -172,6 +172,22 @@ static int __init x86_xsaves_setup(char *s)
 }
 __setup("noxsaves", x86_xsaves_setup);
 
+static int __init x86_noinvpcid_setup(char *s)
+{
+	/* noinvpcid doesn't accept parameters */
+	if (s)
+		return -EINVAL;
+
+	/* do not emit a message if the feature is not present */
+	if (!boot_cpu_has(X86_FEATURE_INVPCID))
+		return 0;
+
+	setup_clear_cpu_cap(X86_FEATURE_INVPCID);
+	pr_info("noinvpcid: INVPCID feature disabled\n");
+	return 0;
+}
+early_param("noinvpcid", x86_noinvpcid_setup);
+
 #ifdef CONFIG_X86_32
 static int cachesize_override = -1;
 static int disable_x86_serial_nr = 1;
-- 
2.16.2
