Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt5+9/pebKFVSWE8i95s76LtP3x4PblYi4rY0im37UQEsfg11G2pJd42po5WKsq0m7jA4W0
ARC-Seal: i=1; a=rsa-sha256; t=1521800339; cv=none;
        d=google.com; s=arc-20160816;
        b=h31a3dZe6XOAA3gdmSTruSlQ5fP9WrufeImD1V/jISpdtOZwuHlvpzxxfH+tot56L5
         +8I/XL1XIk0owNprOvsonjivG+QKiIdAcrqmPALK+O0a5r+dSrp43ExB0oAfnVghNKSc
         AMWFydABIqCsgeTTY8wKIapgTG0Xgvh85yA5aCS+G+a2AmvUbZRKhenRwHTjZhN1sGdk
         knXhBrkN15UtiPBq7zCg28keOu4dMbgpu8HjchV8KlOz0HeeGAA7gsY+vyQxkLF4i5sf
         rf5aeBCGHuGUyeniBiuulJOrou4UwmXgRy2xmb/gEbsrRCo0x6kahvQTUAEqy0trCmYU
         yULg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=oXM7XpNMz60NujJiZ1jOXaQQY7DIkhfgtciOtxriP0Y=;
        b=kocAGjbPC4SYORUhn2EVQrVvTEu0uVmT8S3NUBLCZeG0d691/yykrmnJXZevhA0Vnt
         TyzgWtMmEsjBrFpxEDS0wRVVBSiA+SMNM1MVQ0XKUK/5hc52zMIzbDI0mm/5zpu9Y0xw
         XX9yxBd5Yq/XihhoGQ33gyG97P/+CY7to3s2ngaUX2gTe3zILVjr7jZERFs0FEC5A68c
         nH5NQmNBL+FD3fLm3t9/ucleAYedK57lu2COQNx6sYpVl+8/XuGGXuvBVfloTHXJble+
         yswX8pLluRCEkYBT4axptl7j83olp6HoS47CFZgP60jw/MP7YRxtQpYugKS8DVjyn3yE
         zXcw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Markus Elfring <elfring@users.sourceforge.net>,
	H J Lu <hjl.tools@gmail.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?=C3=89meric=20MASCHINO?= <emeric.maschino@gmail.com>,
	Sergei Trofimovich <slyfox@gentoo.org>,
	Tony Luck <tony.luck@intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 33/47] ia64: fix module loading for gcc-5.4
Date: Fri, 23 Mar 2018 10:55:24 +0100
Message-Id: <20180323094249.532564482@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094248.117679641@linuxfoundation.org>
References: <20180323094248.117679641@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722714775958192?=
X-GMAIL-MSGID: =?utf-8?q?1595723312644233406?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sergei Trofimovich <slyfox@gentoo.org>


[ Upstream commit a25fb8508c1b80dce742dbeaa4d75a1e9f2c5617 ]

Starting from gcc-5.4+ gcc generates MLX instructions in more cases to
refer local symbols:

    https://gcc.gnu.org/PR60465

That caused ia64 module loader to choke on such instructions:

    fuse: invalid slot number 1 for IMM64

The Linux kernel used to handle only case where relocation pointed to
slot=2 instruction in the bundle.  That limitation was fixed in linux by
commit 9c184a073bfd ("[IA64] Fix 2.6 kernel for the new ia64 assembler")
See

    http://sources.redhat.com/bugzilla/show_bug.cgi?id=1433

This change lifts the slot=2 restriction from the kernel module loader.

Tested on 'fuse' and 'btrfs' kernel modules.

Cc: Markus Elfring <elfring@users.sourceforge.net>
Cc: H J Lu <hjl.tools@gmail.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Bug: https://bugs.gentoo.org/601014
Tested-by: Émeric MASCHINO <emeric.maschino@gmail.com>
Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/ia64/kernel/module.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/ia64/kernel/module.c
+++ b/arch/ia64/kernel/module.c
@@ -153,7 +153,7 @@ slot (const struct insn *insn)
 static int
 apply_imm64 (struct module *mod, struct insn *insn, uint64_t val)
 {
-	if (slot(insn) != 2) {
+	if (slot(insn) != 1 && slot(insn) != 2) {
 		printk(KERN_ERR "%s: invalid slot number %d for IMM64\n",
 		       mod->name, slot(insn));
 		return 0;
@@ -165,7 +165,7 @@ apply_imm64 (struct module *mod, struct
 static int
 apply_imm60 (struct module *mod, struct insn *insn, uint64_t val)
 {
-	if (slot(insn) != 2) {
+	if (slot(insn) != 1 && slot(insn) != 2) {
 		printk(KERN_ERR "%s: invalid slot number %d for IMM60\n",
 		       mod->name, slot(insn));
 		return 0;
