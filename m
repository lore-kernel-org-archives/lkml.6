Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELviUZ8R24WmmZILNJdVpl2w/rgvLfv62joyRCXFn9oTzZ4VWiFOljdJ4YDKfcKKG6aINS6V
ARC-Seal: i=1; a=rsa-sha256; t=1521799769; cv=none;
        d=google.com; s=arc-20160816;
        b=xybb46v5jJvS04duS0FAFslXg1qqGDr7CRtQT4AKlSkgf7Iuuno3SM+w75ZxDNQJ9v
         u6qw7F2VbAvrpBZmlAtGO1ObPwYBqzB9oqMqfBpKd5zRBg9mQFxNW5oTJusCqvfcbZNN
         tZuZTVVd1xuh9YqX7FB6mnihEuOORjxpLjO3GeSy0O8/fvzOW/qdSjSOHuEC2Qd7t7Uf
         OY+i6pcZFiyenceeX+r3wTYhs5+6nQmFOyD1Kyw+TMg46Q+pjKLgu0/YgE1m8GkSlB9f
         y9T1+5DSKW3fMaQAD1CU35VuQS7udyig+H0Lbxb8xJAxnjJzM/iwvwvGfuMYCgvay4G5
         i4Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=njdNo5lY1qZI4jY9GgIqgpDY0cK6bKuHhQIOHXorEV4=;
        b=IH5gvUjyeoI+MeKFOfqvMcyK30j7tg6WL5lGVaNEtKl8sppA/HHr4S/CFAEntol4pb
         0Mf+nbmq3hWBgIkRaGFc1XiI2QXSIFB5rf/A7/3OLw0HUHJshcZ3402gD0TaditjTZKS
         O78medpTP1ckN7UC9XIwXiltLpQTJJXAg+f00MyOYTylma1Z0vuOSbEXg5k6hnFsak8H
         csWRmWRqHiUjWgG1+THaudlQ/ViX6Uwv4Ao9DIY2cXFDilrubJ4ZDvEY8lbRhooCa73F
         d1W/iKBID5LNT3R5d3/hYIS0u7XYSQIgUkuQxDu4RisCUwE0y7kpyL3Kxy+PidWwetZN
         zf5Q==
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
Subject: [PATCH 4.9 118/177] ia64: fix module loading for gcc-5.4
Date: Fri, 23 Mar 2018 10:54:06 +0100
Message-Id: <20180323094210.463109442@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722714775958192?=
X-GMAIL-MSGID: =?utf-8?q?1595722714775958192?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
