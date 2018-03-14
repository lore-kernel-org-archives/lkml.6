Return-Path: <djkurtz@chromium.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520986777; cv=none;
        d=google.com; s=arc-20160816;
        b=r/FTpJkEEl2GP/U7A8QRK7ZRzepAuY+8uCEvUPjwkFbhl9Nyjt/uLtBH0e6xjOjTvN
         08M+c37WO7rhzlyXHCjy3JZpCrOjPkG+rOCsJ5qeM83UkvHbExOsioqwppzRnUMzcerr
         K+4thrDFTq31J1kEm8TtWR5zD0T7rQJSX/CcyOk84IMZdBDu+pUg3BdifBQmrgRs/3H/
         c5//41n8FVcFN29TmK6f2MOBhucsUQaFWMztNdhKu+JQEE5b2i0nKcam59An2MoyGE6x
         lVxGxjMi09cZxbzCoBqjZoiIfxdo8DylqyaOeq0El6LIL8AZrcceUA5+RQo9re1EuvaM
         LsrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=4BEQ9AbPEgIIuktp1AjMgev7AKzGHfZO5h1e9RUc/A0=;
        b=zZCqd26viS8GSBV+CXr0UaNZ/XmbihQkl1ZvVIb8hTuwHEvf+Azu63cRL5Zfq9rrGk
         gFywI6cov3UJoCsDz54wiIyUA/tHui+hR6G1RlOlpGlAG7UV1o8W6OXTuFGf9F1vaKNs
         FICoocZ1tC1Es7zoKoP+p2g+bBtp2VsLByG9ttMaNcJnvHjhP4fffVJCHC0Y5RMbdAeO
         Hwk+m4Ju+rp2wPRvBbnzPOX6KX0J0PrDO//hjnE5J2YdJG9a6afwgZW7SQWtYn916U1C
         jz84QEuuai5+mGKx4UtCmMl7zy+I6RSCf0dukwt019RicAZrJi6SpPgl2tNxMllKULFN
         kOrA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=I9klFRhI;
       spf=pass (google.com: domain of djkurtz@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=djkurtz@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=I9klFRhI;
       spf=pass (google.com: domain of djkurtz@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=djkurtz@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AG47ELvI2oN+Yi0hbEOS93C2VJQaIjbpxP2v7tHXwmIB8TYNPEiVF6ut8tn1yukwGJw+VIgm/T3F/Q==
From: Daniel Kurtz <djkurtz@chromium.org>
To: 
Cc: adurbin@chromium.org,
	Daniel Kurtz <djkurtz@chromium.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>,
	linux-arch@vger.kernel.org (open list:GENERIC INCLUDE/ASM HEADER FILES),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] earlycon: Fix __earlycon_table stride... again
Date: Tue, 13 Mar 2018 18:19:33 -0600
Message-Id: <20180314001933.5302-1-djkurtz@chromium.org>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594870231377031052?=
X-GMAIL-MSGID: =?utf-8?q?1594870231377031052?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit 470ca0de69fe ("serial: earlycon: Enable earlycon without command
line param") added EARLYCON_TABLE().

Commit 99492c39f39f ("earlycon: Fix __earlycon_table stride") fixed
EARLYCON_TABLE() alignment to 32-bytes.

Commit 2eaa790989e0 ("earlycon: Use common framework for earlycon
declarations") added the compatible field, which bumped EARLYCON_TABLE()
alignment to 128 bytes (LCM of size of all fields of struct earlycon_id.

Correct the struct definition and linker alignment to match.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 include/asm-generic/vmlinux.lds.h | 2 +-
 include/linux/serial_core.h       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 1ab0e520d6fc..2f7de2e36005 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -179,7 +179,7 @@
 #endif
 
 #ifdef CONFIG_SERIAL_EARLYCON
-#define EARLYCON_TABLE() STRUCT_ALIGN();			\
+#define EARLYCON_TABLE() . = ALIGN(128);		\
 			 VMLINUX_SYMBOL(__earlycon_table) = .;	\
 			 KEEP(*(__earlycon_table))		\
 			 VMLINUX_SYMBOL(__earlycon_table_end) = .;
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index b32df49a3bd5..c9170b9ccb1b 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -351,7 +351,7 @@ struct earlycon_id {
 	char	name[16];
 	char	compatible[128];
 	int	(*setup)(struct earlycon_device *, const char *options);
-} __aligned(32);
+} __aligned(128);
 
 extern const struct earlycon_id __earlycon_table[];
 extern const struct earlycon_id __earlycon_table_end[];
-- 
2.16.2.804.g6dcf76e118-goog
