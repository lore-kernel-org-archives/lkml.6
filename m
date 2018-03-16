Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvWQEOm11tOFRcBwHP+I32QUHtSNXOD28RD/UXqiMy/KtIw2IUmc5WrOUGNvhCPL+0I/2Zw
ARC-Seal: i=1; a=rsa-sha256; t=1521214129; cv=none;
        d=google.com; s=arc-20160816;
        b=RWeMzfxzt8H8x+qwhAgi7iHeLI6seEU/8b56nhHCG4ber4/eRfMluPq3kRGqmkYoLP
         PECRsXwbpRTz1YeNPEMoPEXdCYtczR4paBmOZyZEZFR2GdhFjicpYPWPRSW2HTCypvBL
         iW3xKfkbq00iB5pPgJOS7GDN7xt/VU2Je9JLrVVYh2eQ1c+5lp94HFzzFxrW8EZfhoMF
         Q7cv85sxrIQdCVIVEC4Agfm/hsYWh0Bxo60EtJJ7feHQ5rC0Q5bPsM04EabaEf8YXfZ7
         aeae4Bgo8YM+e1aNu+IYBhs1jGVnDfOcV9rauvUx8rtDImL9zq0YOmqH3WyLn4XHVF4r
         D+2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=cFtn8glGYSMV9R5x0kBIwy0NwyKSrAHKHfO3a+u0hf0=;
        b=vmT2xN5tNsrjMCCI5oOyHnEihq4H5S6NbMVcfW+lFSCT5s0uD2b8T9bRaz9woqEFa+
         eRxHuO5090BlDf/W36wIje8sSyUaWKMtR2psnPUTt6uZoAppDdLmy/ASuNKicp6wlpO3
         35ODMEB7oq0QRuHjIMKfAabbTDkA77+ps2gmJbdsR4llo7tFLjZiSo8Kjg2eoxfnkeja
         rADMZw86ouMf6gq/Pjt8yStmGZKhjgptRSLV/02khUYDs2fxt6IagA6a6cKq8hLFhhC0
         MXSU0I/7ZSJ2YLa0U+6npE+ugr49oICV7jh7/rWE7WA2How5++PnKN3MpLPpJYMrvYuK
         9eEw==
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
Subject: [PATCH 4.4 51/63] x86: Treat R_X86_64_PLT32 as R_X86_64_PC32
Date: Fri, 16 Mar 2018 16:23:23 +0100
Message-Id: <20180316152305.620032754@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152259.964532775@linuxfoundation.org>
References: <20180316152259.964532775@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108490440452142?=
X-GMAIL-MSGID: =?utf-8?q?1595108626813159466?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -519,6 +519,7 @@ int arch_kexec_apply_relocations_add(con
 				goto overflow;
 			break;
 		case R_X86_64_PC32:
+		case R_X86_64_PLT32:
 			value -= (u64)address;
 			*(u32 *)location = value;
 			break;
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -189,6 +189,7 @@ int apply_relocate_add(Elf64_Shdr *sechd
 				goto overflow;
 			break;
 		case R_X86_64_PC32:
+		case R_X86_64_PLT32:
 			if (*(u32 *)loc != 0)
 				goto invalid_relocation;
 			val -= (u64)loc;
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -769,9 +769,12 @@ static int do_reloc64(struct section *se
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
