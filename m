Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoFh84awdaBXCZu1KeIOZKqUybsIhCTPfl8ieX/srE/ckttfWvq6as3st5hz1pWd1rd8UDX
ARC-Seal: i=1; a=rsa-sha256; t=1526937592; cv=none;
        d=google.com; s=arc-20160816;
        b=iIc/qBQrm86W7o/5IMvhJR1dX7tG1e8Yj7aDOt+2c1CijnVxa/DCtawhQj6dmeH4iJ
         12GjxD0HZGRn83lz1fsSm+0BnhuZalwGCuTY92k6nZToYBXJ6KJf1Cn43wytkgeA0j+K
         OVPfO3Jz4wTjspqjNUs+DO35c3gta8dt7v3zMuMF9M25UaEx2seAf0trRptIbOmz6Wa+
         Yfe71qKNfTkHgSLZVAXSAq4G8B5emKZ7iGDcuxPbL933ZtH0TTjsjDWzl42UR8Y/Ne7c
         Sht2pYsie6Fh2q5PSZoLVpL3p4L9borSP8wMrcpHRreStRRiDcYU7FqHo8OzIpgbKwJF
         AH+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=LG5aD/T2e2pbuaSqVqClgElEFl6P61OhiVJ/9lo8X9U=;
        b=J3LArNhSp6oBgX5cw2MrQfRLuCOAsBzKiuZzHbRd1urLJYRS+P3HyPEzGuJI8egKAH
         v0BBWcjS9TRkBCv4uIVV/yDTfxYG3EvrFPY9S+zDxmK0bFdfJ5ae9XNQA8YgGYV6UuOA
         KdZc7N+rBnC3BKPttmQB4yFHxgCacjOLTtFA0BORREs3F6scjMUBN2RX4b6St0fZyDFf
         efBt1fB9blJ2xmRZJKgCGOrQtZEYaniGCVXFgqOxF2LGlyj7fJJm5U3qe9Vr3Nylxxs4
         c2CW5qKhbASI0LzY3fzTdd+CBD+9850jfb592AoM3rA75a13Tky6mlgVLilFDEQzDzc2
         o17Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=FvC7gM1t;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=FvC7gM1t;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Michael Ellermen <mpe@ellerman.id.au>,
	Peter Zijlstra <peterz@infradead.org>,
	Ram Pai <linuxram@us.ibm.com>,
	Shuah Khan <shuah@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-mm@kvack.org,
	Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 4.14 33/95] x86/pkeys: Do not special case protection key 0
Date: Mon, 21 May 2018 23:11:23 +0200
Message-Id: <20180521210454.799243479@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109786925412053?=
X-GMAIL-MSGID: =?utf-8?q?1601110113849608799?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Hansen <dave.hansen@linux.intel.com>

commit 2fa9d1cfaf0e02f8abef0757002bff12dfcfa4e6 upstream.

mm_pkey_is_allocated() treats pkey 0 as unallocated.  That is
inconsistent with the manpages, and also inconsistent with
mm->context.pkey_allocation_map.  Stop special casing it and only
disallow values that are actually bad (< 0).

The end-user visible effect of this is that you can now use
mprotect_pkey() to set pkey=0.

This is a bit nicer than what Ram proposed[1] because it is simpler
and removes special-casing for pkey 0.  On the other hand, it does
allow applications to pkey_free() pkey-0, but that's just a silly
thing to do, so we are not going to protect against it.

The scenario that could happen is similar to what happens if you free
any other pkey that is in use: it might get reallocated later and used
to protect some other data.  The most likely scenario is that pkey-0
comes back from pkey_alloc(), an access-disable or write-disable bit
is set in PKRU for it, and the next stack access will SIGSEGV.  It's
not horribly different from if you mprotect()'d your stack or heap to
be unreadable or unwritable, which is generally very foolish, but also
not explicitly prevented by the kernel.

1. http://lkml.kernel.org/r/1522112702-27853-1-git-send-email-linuxram@us.ibm.com

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>p
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michael Ellermen <mpe@ellerman.id.au>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ram Pai <linuxram@us.ibm.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org
Cc: stable@vger.kernel.org
Fixes: 58ab9a088dda ("x86/pkeys: Check against max pkey to avoid overflows")
Link: http://lkml.kernel.org/r/20180509171358.47FD785E@viggo.jf.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/mmu_context.h |    2 +-
 arch/x86/include/asm/pkeys.h       |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -192,7 +192,7 @@ static inline int init_new_context(struc
 
 #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
 	if (cpu_feature_enabled(X86_FEATURE_OSPKE)) {
-		/* pkey 0 is the default and always allocated */
+		/* pkey 0 is the default and allocated implicitly */
 		mm->context.pkey_allocation_map = 0x1;
 		/* -1 means unallocated or invalid */
 		mm->context.execute_only_pkey = -1;
--- a/arch/x86/include/asm/pkeys.h
+++ b/arch/x86/include/asm/pkeys.h
@@ -51,10 +51,10 @@ bool mm_pkey_is_allocated(struct mm_stru
 {
 	/*
 	 * "Allocated" pkeys are those that have been returned
-	 * from pkey_alloc().  pkey 0 is special, and never
-	 * returned from pkey_alloc().
+	 * from pkey_alloc() or pkey 0 which is allocated
+	 * implicitly when the mm is created.
 	 */
-	if (pkey <= 0)
+	if (pkey < 0)
 		return false;
 	if (pkey >= arch_max_pkey())
 		return false;
