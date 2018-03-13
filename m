Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsz/B0lZ1LYtEqbm+y0Ese9mFt7Aq74zc1OS9/wvNDxduqJR6hHURsH+WOiJRECe2QTms7Y
ARC-Seal: i=1; a=rsa-sha256; t=1520955007; cv=none;
        d=google.com; s=arc-20160816;
        b=JJJdhKkYpc/bK7X2DbkhVU2mbPeNi9lXAVTiDXiiSHJo18fa8yBKhOxV0BgI2GuIYG
         dVuaikyvk5dIx4GsV2fAYgF03RZmAJ2HGfXXMuTr/Knk8yVOwOS3imTpSqzI4/xm5M4w
         wXU4YNp/oqJL6I2B3K6qh5JcmR6od1NaAj9X8BrHbEzV8TLiwbm3MgOpOkpm1DMxTnlN
         nlFo0cRIM/DGk78oVtB2OtG2aMDOb+DNaa3AllXrBzRBKmac7v18Ci4jpWM7x+Lkasik
         L3u83yFsCmLHNVwuRZeg7TKc9SagFbZJyoyPu3pUla9NpYB97HGN+FAUuNbMfcRAcPXE
         qekQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=q6+RHH/XL/RnxLVerK2mTJ4jEsF2SjB69ZoWozUaJnI=;
        b=BPkLf3XMagilrX2L13M6Ztw1hoUIGANbvvp0LspZ+3i5qxhYig6QuWuCel3+vlUIiy
         cyfSkOe/ZOfqMz2cxlegmYEodyIGLBDRSGkR8NM5gW+SNbLGotm1FGCHkJI1Howcd4wT
         4WGr4cJK0bFoBSnscXtN/gGHdEWiJofuR4gC3xrVM4pcOmsxrFKK0uGA4/E/p7hWx0Wz
         ZGPr89MY0nbyf9J4dAgppi+CaB0bZ7LMHuopB8ODDYry852hE3ZqtWSVD9FrPkVA+uEQ
         w1GfutKBYxTYTec5jTnxrCbvUPSYu8zZD9wRGsnlMi+Y+Xg5Ft8e8V8l9X1WXsS/nacD
         QOlQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
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
Subject: [PATCH 4.15 057/146] kbuild: Handle builtin dtb file names containing hyphens
Date: Tue, 13 Mar 2018 16:23:44 +0100
Message-Id: <20180313152325.081990658@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836918022534430?=
X-GMAIL-MSGID: =?utf-8?q?1594836918022534430?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -287,11 +287,11 @@ cmd_dt_S_dtb=						\
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
 
