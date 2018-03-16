Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtxspZLXXQuvQSfKWRaJep+TwcEipZpuSfwohZ6kVwY/qsru5nNiJpdjffploJt7P63bklA
ARC-Seal: i=1; a=rsa-sha256; t=1521214757; cv=none;
        d=google.com; s=arc-20160816;
        b=ax7eMkQimcEbFXzX6gNLUbjqCD7ePivlJTwaW1lhrD/fV1ycsKPTfkKrSi5owSQA9i
         h+UlMV3YttIBkAwftbwzv795+nce90XYKoPTup2j4L8aAw+Fj1QURH6735H2Wz+MVdbX
         YnDvCNNxoMEK4NcS9wWJ/dEhZz64AXO9v7Ay5RG3zXoM9iry3s1J38md3DeqZZJIpDZ6
         PmLt21lRzfr/gpPM58MuiPt409rdBN73yVFkNgmpn9vADsxIMO2SzHsgszsqqNoFpc6F
         9lNNol1yhs6kI0AUjaWnJWbqk/fGDe69xsoDzn67dHrGO+FlNyg84v9EnZ2CMs47UrWd
         n0Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=XeZPvwoDI7VI2zUWispMl8pWBm1xeghOTXy3xfJYkWA=;
        b=h6XVASHrXxM1t0vB0rG4qQSOQud/aNTq+AuAwH4/YlMBengg5ao4NQezLc37eQjVcQ
         erNPAQqBfGrkh02ZoJplnwivJDzx7QWtbeEqVHGHMVukHRHotG82LPj2b0kLe/fYrO0w
         GXjJzXSKoHHtWlj1s8yKdMQP9UpWmJZUd5g9IeYRZ+8FRlIiHiMuti7itFGByWPfjyh/
         fMZPIaTkL4lsgZKpC6P9TAifMI5I9lPqR8BOuNFu++rJEPo1cSVdYfcaRv2wv4F4HTPq
         /m+VZoan12crWASbgwJGPhLWatu+0LsWYOhuoJsamxZQOxqXrAOGKNoOufsy1DjqOMn2
         JDWw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"H.J. Lu" <hjl.tools@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 4.15 001/128] x86: Treat R_X86_64_PLT32 as R_X86_64_PC32
Date: Fri, 16 Mar 2018 16:22:22 +0100
Message-Id: <20180316152336.278407598@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108490440452142?=
X-GMAIL-MSGID: =?utf-8?q?1595109286318694845?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: H.J. Lu <hjl.tools@gmail.com>

commit b21ebf2fb4cde1618915a97cc773e287ff49173e upstream.

On i386, there are 2 types of PLTs, PIC and non-PIC.  PIE and shared
objects must use PIC PLT.  To use PIC PLT, you need to load
_GLOBAL_OFFSET_TABLE_ into EBX first.  There is no need for that on
x86-64 since x86-64 uses PC-relative PLT.

On x86-64, for 32-bit PC-relative branches, we can generate PLT32
relocation, instead of PC32 relocation, which can also be used as
a marker for 32-bit PC-relative branches.  Linker can always reduce
PLT32 relocation to PC32 if function is defined locally.   Local
functions should use PC32 relocation.  As far as Linux kernel is
concerned, R_X86_64_PLT32 can be treated the same as R_X86_64_PC32
since Linux kernel doesn't use PLT.

R_X86_64_PLT32 for 32-bit PC-relative branches has been enabled in
binutils master branch which will become binutils 2.31.

[ hjl is working on having better documentation on this all, but a few
  more notes from him:

   "PLT32 relocation is used as marker for PC-relative branches. Because
    of EBX, it looks odd to generate PLT32 relocation on i386 when EBX
    doesn't have GOT.

    As for symbol resolution, PLT32 and PC32 relocations are almost
    interchangeable. But when linker sees PLT32 relocation against a
    protected symbol, it can resolved locally at link-time since it is
    used on a branch instruction. Linker can't do that for PC32
    relocation"

  but for the kernel use, the two are basically the same, and this
  commit gets things building and working with the current binutils
  master   - Linus ]

Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/machine_kexec_64.c |    1 +
 arch/x86/kernel/module.c           |    1 +
 arch/x86/tools/relocs.c            |    3 +++
 3 files changed, 5 insertions(+)

--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -542,6 +542,7 @@ int arch_kexec_apply_relocations_add(con
 				goto overflow;
 			break;
 		case R_X86_64_PC32:
+		case R_X86_64_PLT32:
 			value -= (u64)address;
 			*(u32 *)location = value;
 			break;
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -191,6 +191,7 @@ int apply_relocate_add(Elf64_Shdr *sechd
 				goto overflow;
 			break;
 		case R_X86_64_PC32:
+		case R_X86_64_PLT32:
 			if (*(u32 *)loc != 0)
 				goto invalid_relocation;
 			val -= (u64)loc;
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -770,9 +770,12 @@ static int do_reloc64(struct section *se
 		break;
 
 	case R_X86_64_PC32:
+	case R_X86_64_PLT32:
 		/*
 		 * PC relative relocations don't need to be adjusted unless
 		 * referencing a percpu symbol.
+		 *
+		 * NB: R_X86_64_PLT32 can be treated as R_X86_64_PC32.
 		 */
 		if (is_percpu_sym(sym, symname))
 			add_reloc(&relocs32neg, offset);
