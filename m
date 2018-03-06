Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AG47ELui6mOpha3GePkJGE3EjadswWJP1b/d1SPq8rYY+/8Naq/Th3kqFU47OwXBtM7JJ1oU8u83
ARC-Seal: i=1; a=rsa-sha256; t=1520295962; cv=none;
        d=google.com; s=arc-20160816;
        b=yxa0lh4xkz6EzL+aCeyl+cPEENzuptJ/gkW/s9Nj+kgN7Enyum1+EyZLb6QM3mj6lV
         TjpIefR49M4yMq08/jgFl9TUj8ydbhU/9TnQvjNQrmKvnf+oYVEqZEA4mIEbqXuJ2wkP
         QTTnWybCq/Et3HWERFQyN7WYw2k3yfOUyyboFy6CzLlsFJHlcbZdFoe+mqSPA6Ekx3Pv
         ju4P3xRtfVzWYXZXuMBkFONGTK1MUQ5I7CK1bBmwZIw+i8v73JYE8UD/hg5HLMEAUp4a
         I6DeJ80AXKe1sMjfMxRX7aETyqiiKpH42YyHWxsY6tMQRJSk7QHyjm8ybcT7fXUPm5MS
         JVpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :dkim-signature:arc-authentication-results;
        bh=bbbZNlQR1zRCJ8uxrvwncBKDWqm4wopjwMGTfoLTDHY=;
        b=GvMEjxtOGI3+EhiWwVdAuMvoqUv6nNWxN1n/Hwf/i0dfH2GTyqFEXJ+5QcU+ea0Snn
         CdqJf/Oi2mTsB3UtepEWqbLBXseQnIO7YhMjiCVRNb3EDnuzsRi9RtcTaZqDBzxpqkfB
         +f/mRiPi5SVhpqT4xSCrlD1W5dVC2jf++0xmN8HEnlqe1UTGu1wCdzzrVDkfPaoF/Ljg
         Ou25f3zds3bD04USmHS0lMmqNf3izaABFL66ZM7oTvGNwvpbqswofRuQP1TnVv541jPb
         mu6gx7HGNEOhmPlB/8dSQO7JqWaR4UYeb+LbeKDm8YBRTapHocwOiMan3OIHksm+qIC6
         8g1Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=FFtw3RGo;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=FFtw3RGo;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        cminyard@mvista.com, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4.1 04/65] x86/mm: If INVPCID is available, use it to flush global mappings
Date: Mon,  5 Mar 2018 19:24:37 -0500
Message-Id: <20180306002538.1761-5-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306002538.1761-1-pasha.tatashin@oracle.com>
References: <20180306002538.1761-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=934
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060003
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594145858840407281?=
X-GMAIL-MSGID: =?utf-8?q?1594145858840407281?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andy Lutomirski <luto@kernel.org>

commit d8bced79af1db6734f66b42064cc773cada2ce99 upstream.

On my Skylake laptop, INVPCID function 2 (flush absolutely
everything) takes about 376ns, whereas saving flags, twiddling
CR4.PGE to flush global mappings, and restoring flags takes about
539ns.

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
Link: http://lkml.kernel.org/r/ed0ef62581c0ea9c99b9bf6df726015e96d44743.1454096309.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 85d3700c744a11ee2989252acf50ccbbd814167a)
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/x86/include/asm/tlbflush.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index ed2317f19ec7..433eeaafe498 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -152,6 +152,15 @@ static inline void __native_flush_tlb_global(void)
 {
 	unsigned long flags;
 
+	if (static_cpu_has(X86_FEATURE_INVPCID)) {
+		/*
+		 * Using INVPCID is considerably faster than a pair of writes
+		 * to CR4 sandwiched inside an IRQ flag save/restore.
+		 */
+		invpcid_flush_all();
+		return;
+	}
+
 	/*
 	 * Read-modify-write to CR4 - protect it from preemption and
 	 * from interrupts. (Use the raw variant because this code can
-- 
2.16.2
