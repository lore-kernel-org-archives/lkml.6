Return-Path: <monstr@monstr.eu>
ARC-Seal: i=1; a=rsa-sha256; t=1523368856; cv=none;
        d=google.com; s=arc-20160816;
        b=KkwA0LT+u5pqOsM3nxv2/JY2jOj65NrldsipvDWMISgTV149aEzw5QC+nUsOQywtO9
         ddaxczqcG06TIacOLc21Lvlx+uo8xaPALjGwMceYpj+fbXAbJuX7THIr4VO8VUtabj1h
         kwiI10fGOTnw/6hjCfaxwevro3vZo4s3HcejnZUQHKWTj+SdlRMSSRM2bwTtkPoRltmT
         hnPub4CbWEcjgMg7hZbdGDv1pFPxGekXvjb0OCmT5tBGpjw1J63lhZ6cxeIp5dmSRsKR
         7RYmJ1qNQ0DAFIguT6e9GuYxB9DMUcGcxBEzMTkfmr7CrSSo5s4t0BTuy+C8dsWczlHb
         fJqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:sender:dkim-signature
         :arc-authentication-results;
        bh=XceanB33lgKu2mE1fbaQbTI19XeLbC9l6iR/ljDQk80=;
        b=Gb2F5RkYbPdajUE2B029Fi/noZ59ZUq+etIjiC6QrxFkEs7cWyU1gDoLaeg/nU09lr
         oUM/PQFkagsmW5SJYWlhAex+GmZBexcs1Ak7wocuve80f3VLX2i2x+UuZUenIcBHgkI5
         Yylsyq+aIa90yGooqxar7vs40HiB30c6YNMneVhi70MdNQNlloc8Rv4UbSsjqTtwlUj2
         zgNSNam3riUIEh3ctSbKfyFU8Dkx5ZHqhb4KguGZMbJ/3PLBVs8d9RwNTLKqE/AwuA6O
         6NgNj4nrRav+HK+ZDQYNJxfNjPas6MHMV5+dX2eEqCM9D/nchq99E1nYIaERsn8/ZOD4
         b5gw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@monstr-eu.20150623.gappssmtp.com header.s=20150623 header.b=wMIbGqzu;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of monstr@monstr.eu) smtp.mailfrom=monstr@monstr.eu
Authentication-Results: mx.google.com;
       dkim=pass header.i=@monstr-eu.20150623.gappssmtp.com header.s=20150623 header.b=wMIbGqzu;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of monstr@monstr.eu) smtp.mailfrom=monstr@monstr.eu
X-Google-Smtp-Source: AIpwx4/g3yynR+2zar7r3sBn6HTIgNcOwaS4h5bct4OP8FV+yyhhDTaYUUGz6R1VXCmEAsRwsICOYw==
Sender: Michal Simek <monstr@monstr.eu>
From: Michal Simek <michal.simek@xilinx.com>
To: linux-kernel@vger.kernel.org,
	monstr@monstr.eu
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] microblaze: Fix simpleImage format generation
Date: Tue, 10 Apr 2018 16:00:46 +0200
Message-Id: <b1738933cc6be175d4f97f11c00a05c0f3f81cad.1523368843.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597368022192081099?=
X-GMAIL-MSGID: =?utf-8?q?1597368022192081099?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

simpleImage generation was broken for some time. This patch is fixing
steps how simpleImage.*.ub file is generated. Steps are objdump of
vmlinux and create .ub.
Also make sure that there is striped elf version with .strip suffix.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/microblaze/boot/Makefile | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/microblaze/boot/Makefile b/arch/microblaze/boot/Makefile
index fd46385a4c97..600e5a198bd2 100644
--- a/arch/microblaze/boot/Makefile
+++ b/arch/microblaze/boot/Makefile
@@ -22,17 +22,19 @@ $(obj)/linux.bin.gz: $(obj)/linux.bin FORCE
 quiet_cmd_cp = CP      $< $@$2
 	cmd_cp = cat $< >$@$2 || (rm -f $@ && echo false)
 
-quiet_cmd_strip = STRIP   $@
+quiet_cmd_strip = STRIP   $< $@$2
 	cmd_strip = $(STRIP) -K microblaze_start -K _end -K __log_buf \
-				-K _fdt_start vmlinux -o $@
+				-K _fdt_start $< -o $@$2
 
 UIMAGE_LOADADDR = $(CONFIG_KERNEL_BASE_ADDR)
+UIMAGE_IN = $@
+UIMAGE_OUT = $@.ub
 
 $(obj)/simpleImage.%: vmlinux FORCE
 	$(call if_changed,cp,.unstrip)
 	$(call if_changed,objcopy)
 	$(call if_changed,uimage)
-	$(call if_changed,strip)
-	@echo 'Kernel: $@ is ready' ' (#'`cat .version`')'
+	$(call if_changed,strip,.strip)
+	@echo 'Kernel: $(UIMAGE_OUT) is ready' ' (#'`cat .version`')'
 
 clean-files += simpleImage.*.unstrip linux.bin.ub
-- 
1.9.1
