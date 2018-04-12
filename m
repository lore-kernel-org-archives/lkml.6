Return-Path: <rob@landley.net>
ARC-Seal: i=1; a=rsa-sha256; t=1523497123; cv=none;
        d=google.com; s=arc-20160816;
        b=V9Gzzc2lAbw5RUHgGzCO91yrAUVE40tOe/kpzrlnTSLHQiStDGecIqxMrAn+vm9cDw
         sWYohMo4WSuw2VVF1AGg/1hHpkV7n5L/FcJgG3XTEMzqJgVInCa23JFi1K8nD9lG2Ogk
         OXEnVWNa+Bc3b08a/p2995Nr66cC9wudUhpsKUlv59CSEC+PTkNyRoaG0QEIBlo7nwjO
         ShlRBDU55xmZ7qi/hV2yQpYCcfzJEj2wS78Jfkxysl3z43invzKDRMZ7aZXdomtNZMMy
         ikTV3QNLsKxOC4jWqHzitO8Ac3bKKDYECYDc+bUUVtzGiuxmNZptk0mTAL0fayGWRv/U
         za4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:to:dkim-signature
         :arc-authentication-results;
        bh=l4HXsOkcNRUy3azLBQ+ZoeVui3d7CRjojQ1iC7Go61U=;
        b=YV9j9K+5XkSTothdo2wVQdKfvi1+Ke/fbUBh1pWfBQ1qiIKewmajfmd0nGltxnriYG
         CmMn9hwLVXdSYwJWD+4qjbZ1kjEbWbxoTBP+X6D8F5ooJXvt7OV+CkpDvsEBx59gSaWN
         nyHv58b/7aaFTFBda4MKIgVUclY9247vLyASVrXJ6aanOfCtztjIBVRgtaXyhGeBxAbV
         g7QY/n4Ap+8bnP2a+jpwaalZMzgHVhcS68paSaNhUANAlY8w9pJRYgOAbVsULjU2xFut
         dwHNSNGYhBgygp5O30baXZSJ5oBeTMP+OcpPI3i9E0YZdUFhlDqCOn2HysU8JdyOSsqo
         IRFA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@landley-net.20150623.gappssmtp.com header.s=20150623 header.b=Efpi0vEF;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of rob@landley.net) smtp.mailfrom=rob@landley.net
Authentication-Results: mx.google.com;
       dkim=pass header.i=@landley-net.20150623.gappssmtp.com header.s=20150623 header.b=Efpi0vEF;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of rob@landley.net) smtp.mailfrom=rob@landley.net
X-Google-Smtp-Source: AIpwx4/AfT5PwWlPB8zBaR9+b4j/2ENqCsAEQ49Z0WVxinKwtRhEA0DP1mcPbEsmrQ+cPH8F1AlVoA==
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux@armlinux.org.uk, kstewart@linuxfoundation.org, pombredanne@nexb.com,
 tglx@linutronix.de, gregkh@linuxfoundation.org,
 linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>,
 Keerthy <j-keerthy@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>
From: Rob Landley <rob@landley.net>
Subject: [PATCH] Replace unnecessary perl with sed, printf, and the shell $((
 )) operator.
Message-ID: <9c72100c-b3e4-07ca-1784-fda2ac9d708c@landley.net>
Date: Wed, 11 Apr 2018 20:38:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597502519965840402?=
X-GMAIL-MSGID: =?utf-8?q?1597502519965840402?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

You can build a kernel in a cross compiling environment that doesn't have perl
in the $PATH. Commit 429f7a062e3b broke that for 32 bit arm. Fix it.

Signed-off-by: Rob Landley <rob@landley.net>
---

 arch/arm/boot/compressed/Makefile |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 45a6b9b..33ebeb2 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -117,11 +117,10 @@ ccflags-y := -fpic -mno-single-pic-base -fno-builtin -I$(obj)
 asflags-y := -DZIMAGE
 
 # Supply kernel BSS size to the decompressor via a linker symbol.
-KBSS_SZ = $(shell $(CROSS_COMPILE)nm $(obj)/../../../../vmlinux | \
-		perl -e 'while (<>) { \
-			$$bss_start=hex($$1) if /^([[:xdigit:]]+) B __bss_start$$/; \
-			$$bss_end=hex($$1) if /^([[:xdigit:]]+) B __bss_stop$$/; \
-		}; printf "%d\n", $$bss_end - $$bss_start;')
+KBSS_SZ := $(shell echo $$(($$(printf '%d+%d' $$( \
+		$(CROSS_COMPILE)nm $(obj)/../../../../vmlinux | \
+		sed -n -e 's/^\([^ ]*\) B __bss_start$$/-0x\1/p' \
+		       -e 's/^\([^ ]*\) B __bss_stop$$/0x\1/p') ) )) )
 LDFLAGS_vmlinux = --defsym _kernel_bss_size=$(KBSS_SZ)
 # Supply ZRELADDR to the decompressor via a linker symbol.
 ifneq ($(CONFIG_AUTO_ZRELADDR),y)
