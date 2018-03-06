Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AG47ELsn6XGcO4qUJSijv6YMfx6mxUjO4bCtbXNtWdiKpoa7HHqMD2XRRuKH5IMhdxtdZzMd1uuQ
ARC-Seal: i=1; a=rsa-sha256; t=1520295961; cv=none;
        d=google.com; s=arc-20160816;
        b=MaCO+hc+icFhQqvPyzhfqPmz+4JeS83SbPm9e9c254v2Oqbcsclksc3W6l2lK622Qs
         0Y+C+L3aDECPE8olqaurR4oFyLTZ1mhQrUmoq+ZTied8ImqXBwvepr5oD+3aNn4ExViD
         6OWeNWaB9I+akbP08usmJSJzsJC3LVJD8lOi3vh+v3tM9UR+3ogrYASLaygLua3KoE4k
         dow0V3QGslfGW+shTXgy01jZ2miMY9JrVU7MqATjMQfxEmLa/YM4OXoRdrEEeEF42tL0
         t6F8T3fzHOljVwRRSshqel406Y0eXlf3Pa1HyUlaB9cwkPgkB/oa0u2WWv7z2Kih8knk
         QvIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :dkim-signature:arc-authentication-results;
        bh=EYjdlQxWzFl+5jjhOI1n2TJyVOrQr3k1kaxdqSH0Mnc=;
        b=EhmwK0qLEhHfGAKUdJHN6nPHtdevJ7C3MPLSc8A2KsMTB8LdNU0BxsJFloaJQwvexP
         bZ7iM6w8m+p2Lyl5LDD3qWuBDWpbGht2yXUdOVEE9c3U0bKHAvU8ndusb1vqWg/gnE3f
         iWDugooV/zNVtV0OMby2sofDszPxEbQroncVZOPr0pS8mxJBOFU4RvEvEhdCqjg4UYJx
         n/LQvmVXwys6fCmXWmbNnb/1YVM5SXt4EGBJPo+s16FA1lmP1QlYC90lN7WlGSaDi5IE
         0EtKGzaJSXlgOid6szqucWnVbOjIh3skDCfxdOCCjqaKKpCinm3syOtzjHJbRt7VhHzU
         TRww==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=u4qMecUA;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=u4qMecUA;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        cminyard@mvista.com, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4.1 02/65] x86/mm: Fix INVPCID asm constraint
Date: Mon,  5 Mar 2018 19:24:35 -0500
Message-Id: <20180306002538.1761-3-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306002538.1761-1-pasha.tatashin@oracle.com>
References: <20180306002538.1761-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060003
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594145858553306248?=
X-GMAIL-MSGID: =?utf-8?q?1594145858553306248?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Borislav Petkov <bp@suse.de>

commit e2c7698cd61f11d4077fdb28148b2d31b82ac848 upstream.

So we want to specify the dependency on both @pcid and @addr so that the
compiler doesn't reorder accesses to them *before* the TLB flush. But
for that to work, we need to express this properly in the inline asm and
deref the whole desc array, not the pointer to it. See clwb() for an
example.

This fixes the build error on 32-bit:

  arch/x86/include/asm/tlbflush.h: In function __invpcid
  arch/x86/include/asm/tlbflush.h:26:18: error: memory input 0 is not directly addressable

which gcc4.7 caught but 5.x didn't. Which is strange. :-\

Signed-off-by: Borislav Petkov <bp@suse.de>
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
Cc: Michael Matz <matz@suse.de>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Toshi Kani <toshi.kani@hp.com>
Cc: linux-mm@kvack.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 04ec428b15f161ce8449756fb64b6f380c8d95fd)
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/x86/include/asm/tlbflush.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 995937999e1f..ed2317f19ec7 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -10,7 +10,7 @@
 static inline void __invpcid(unsigned long pcid, unsigned long addr,
 			     unsigned long type)
 {
-	u64 desc[2] = { pcid, addr };
+	struct { u64 d[2]; } desc = { { pcid, addr } };
 
 	/*
 	 * The memory clobber is because the whole point is to invalidate
@@ -22,7 +22,7 @@ static inline void __invpcid(unsigned long pcid, unsigned long addr,
 	 * invpcid (%rcx), %rax in long mode.
 	 */
 	asm volatile (".byte 0x66, 0x0f, 0x38, 0x82, 0x01"
-		      : : "m" (desc), "a" (type), "c" (desc) : "memory");
+		      : : "m" (desc), "a" (type), "c" (&desc) : "memory");
 }
 
 #define INVPCID_TYPE_INDIV_ADDR		0
-- 
2.16.2
