Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtV/GjpWfZEvAH56X/HcUmUhWrS5taWoZYQDj9hfzGVVs8uUHIMfNmQk5C7hikS3p4HOem8
ARC-Seal: i=1; a=rsa-sha256; t=1521214237; cv=none;
        d=google.com; s=arc-20160816;
        b=tlhoJM2kY6KB9YWWZV18/o1mdbI4c0orlsQrg9mPDAe3J42TrteJWciBPjMDgEj9UI
         FJnihnXskZfpGUaPQK/D/6ru+/slZKf61Qc6rga0LDBiGnRuM5rVFRwwqUGcRregHKwi
         GAYuBarQCW90xp0BHcBsLmNMO8ifrALmLSW5RYDapmC/uhq3WxJnao1MW2I2QmHvUMae
         Nc1ccGTSaM2lM7nS8RuoUyFTu/VUrz/fwGUKBWwVwRX9ON+hkY9SF/ROeMdZrcxtTHoS
         ol1OuW6MqDKhj5MAn2HdAVYK5teSslI7HQD6/UA4Dpba2WsOa4SQ32zP7vh6vBGT+pZw
         Ug3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LIFVWSyi1E3FBEz/te/Ai1l1nx8W/Zg8EnJ049t/p3Y=;
        b=oxEuwxT3pnRlkFM5j7mN8tdnRsfqkye63MJTzcDr+xJ4B1zrJesVOXOi9tvqinmKVp
         8MKGbxpZo8dkiU/Qrre1iHpjV0pTgCNHKLqGO8NwF/4eYzgVR5K5noeGaR4LBmOXvPvH
         ySXpHDzmXAOKbEWvLIwP3vBYlJ9zdidLWrjSgBHXzczt9EgFhopIKbgszdyXP82sXzKT
         W5OvYEvg1gwEnUKF5/1nCI3MNfCo95wp7TNR7EgbBsOsIgNgoumTV6tODD82WRIYAppV
         2K1ZpHHkzNP5jtvcs28i1kNDX4oi/3bpsTu94dS4rB1W4PvlvBSftqPM9hk+MIUNWim7
         LaOg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	James Hogan <jhogan@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Michal Marek <michal.lkml@markovi.net>,
	Ralf Baechle <ralf@linux-mips.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Kevin Cernekee <cernekee@gmail.com>,
	Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 4.9 24/86] kbuild: Handle builtin dtb file names containing hyphens
Date: Fri, 16 Mar 2018 16:22:47 +0100
Message-Id: <20180316152319.017901982@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108611771881527?=
X-GMAIL-MSGID: =?utf-8?q?1595108739977506546?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <jhogan@kernel.org>

commit 55fe6da9efba102866e2fb5b40b04b6a4b26c19e upstream.

cmd_dt_S_dtb constructs the assembly source to incorporate a devicetree
FDT (that is, the .dtb file) as binary data in the kernel image. This
assembly source contains labels before and after the binary data. The
label names incorporate the file name of the corresponding .dtb file.
Hyphens are not legal characters in labels, so .dtb files built into the
kernel with hyphens in the file name result in errors like the
following:

bcm3368-netgear-cvg834g.dtb.S: Assembler messages:
bcm3368-netgear-cvg834g.dtb.S:5: Error: : no such section
bcm3368-netgear-cvg834g.dtb.S:5: Error: junk at end of line, first unrecognized character is `-'
bcm3368-netgear-cvg834g.dtb.S:6: Error: unrecognized opcode `__dtb_bcm3368-netgear-cvg834g_begin:'
bcm3368-netgear-cvg834g.dtb.S:8: Error: unrecognized opcode `__dtb_bcm3368-netgear-cvg834g_end:'
bcm3368-netgear-cvg834g.dtb.S:9: Error: : no such section
bcm3368-netgear-cvg834g.dtb.S:9: Error: junk at end of line, first unrecognized character is `-'

Fix this by updating cmd_dt_S_dtb to transform all hyphens from the file
name to underscores when constructing the labels.

As of v4.16-rc2, 1139 .dts files across ARM64, ARM, MIPS and PowerPC
contain hyphens in their names, but the issue only currently manifests
on Broadcom MIPS platforms, as that is the only place where such files
are built into the kernel. For example when CONFIG_DT_NETGEAR_CVG834G=y,
or on BMIPS kernels when the dtbs target is used (in the latter case it
admittedly shouldn't really build all the dtb.o files, but thats a
separate issue).

Fixes: 695835511f96 ("MIPS: BMIPS: rename bcm96358nb4ser to bcm6358-neufbox4-sercom")
Signed-off-by: James Hogan <jhogan@kernel.org>
Reviewed-by: Frank Rowand <frowand.list@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Kevin Cernekee <cernekee@gmail.com>
Cc: <stable@vger.kernel.org> # 4.9+
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 scripts/Makefile.lib |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -290,11 +290,11 @@ cmd_dt_S_dtb=						\
 	echo '\#include <asm-generic/vmlinux.lds.h>'; 	\
 	echo '.section .dtb.init.rodata,"a"';		\
 	echo '.balign STRUCT_ALIGNMENT';		\
-	echo '.global __dtb_$(*F)_begin';		\
-	echo '__dtb_$(*F)_begin:';			\
+	echo '.global __dtb_$(subst -,_,$(*F))_begin';	\
+	echo '__dtb_$(subst -,_,$(*F))_begin:';		\
 	echo '.incbin "$<" ';				\
-	echo '__dtb_$(*F)_end:';			\
-	echo '.global __dtb_$(*F)_end';			\
+	echo '__dtb_$(subst -,_,$(*F))_end:';		\
+	echo '.global __dtb_$(subst -,_,$(*F))_end';	\
 	echo '.balign STRUCT_ALIGNMENT'; 		\
 ) > $@
 
