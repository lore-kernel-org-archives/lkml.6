Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuxDd46rKH9Gly4aRPeOELV5mOlorefPrtTo4upr5XB/Nh+0qDIBuW0cKSz9g+pA735gWOY
ARC-Seal: i=1; a=rsa-sha256; t=1521800219; cv=none;
        d=google.com; s=arc-20160816;
        b=om2WCoaLlOaSDAMtABgWgFQisufpCHUphQgvL8fpPXsWNCLZMgJGapLxGXjInXyLVv
         1DvU3rOeNf4avOEnMjx9bxgIXWzRf3O6OjtD6xkF9QjL1IwZiFeYQ25rHPwWzahPkaCM
         4JuDu2tiwRxwJt0Z/8EpYcF7XbLhX9dq6n0ouf5g/zAWTevuuPeAteJWVSrPTHl2O/gV
         m3XgzGax2FLA6ZmfVST3rVxUM7lHv9QWfr4tWHMzTn6iSyBJMAW4621ASpAdx8afZqUZ
         +qT6QmES7Es9XuFMnyNdwoIUB0+/NvVNoBLLSmYg4ZD832DTTJSqgDUSBdqJf1NnPv5J
         Gk3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Q4UszIgnbQa8wiCkZO6b8+CIYDjSu5Ifc9pDBJyy15U=;
        b=YvsrReIEAIbW1bR9KOy7r7gDQmN0H8HRPPleFuBG04MCKaXrnGKPR346mGWFUAU+Ne
         8ECzFSiqthyCSl12N7av/G6FDabseYmMVmNH/B2oKF8gX30pnhuPT94lZYECLPOMuWSY
         ++Nc+EXadSl9ePeTLH+c1vzLddaOeVijpQwXuB0EiLa8yUfljAOpSXOeQ5F9gRP7XPcq
         vu061j4Ixnr92+rpyuwzdRhvDjV9FLbgNWNL4fGMljpqxE9hDz8mkm+/HXKQWZ+IDLRj
         3ui8YkQo419UQA+K/B4G/xtKM2dReGIfQGwnQrgDF/a2LqGxbVAYd9squ0fOVRvJ9q8t
         x5kA==
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
Subject: [PATCH 4.4 64/97] ia64: fix module loading for gcc-5.4
Date: Fri, 23 Mar 2018 10:54:51 +0100
Message-Id: <20180323094201.218526418@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722714775958192?=
X-GMAIL-MSGID: =?utf-8?q?1595723187532460510?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
