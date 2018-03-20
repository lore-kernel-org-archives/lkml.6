Return-Path: <wladislav.kw@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521549881; cv=none;
        d=google.com; s=arc-20160816;
        b=B3VLf9vZza1Fb+a9944ievnF3zDM46Podyx3yCbvaHdOs8OhwAfzY5tikCMPcURbTD
         K7yOV3k/Lyoy6JLIjyGw8zG2TLT8XT973OygyRYzm7zj7e0wxRGqdv2VoEN7H8GFX1tf
         VPDJMYl4CCyq9DXXujpCkAsuSAtUuOsgLRdoB6EjMgxcZTAe537LCjobFvsiLlAmsr6F
         4OSFeYl2dUAw8j5GUcuNHaRpgpGSgCx7SgORVRCxVxQUTrV9ZGYJsbiPra206d6Xk94r
         KV59pxoRkifjYsqBF3G66t7yBm1j7W3HwG+RZNmi4PxiPm+A7fzXmMGWznEpVnTTqY5O
         V78g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature
         :arc-authentication-results;
        bh=YuGed3bTMvL2n4KHmFlPFjjNMd7f3WerhMzZVu8kOEM=;
        b=VoG7Elflm/j3PCTNohEv8aYKd9YOrbe2e9+EpYP+Dvd0XFEQQohsBftZZK1XSQUdsF
         vdWXar8Cpyc1sthfOLkUagIuKeLVYf2MTWfVV7z6c8lZuko3Le8/n0u06CrE7JvCteRZ
         tmGK8/jUslnVtkmdInoaLIUZwTVJyUoN7VrPsGFfTyU5xz7Su4+qf61AmNQ2SXHIkBoW
         x5ilwvmwH2LrGcYFZdH1H7L14nTw6NXVsUWiD/msSzbmiIoy9FDgnK2NfEKs4sjMacrz
         AWGj+NPhPawwkmBkFJirV43XwYtvPqICRc/0ME8x0lUDmo67Mgr+RH7EkMbK1dHWCEWF
         tMLw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=dEBf0tmo;
       spf=pass (google.com: domain of wladislav.kw@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=wladislav.kw@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=dEBf0tmo;
       spf=pass (google.com: domain of wladislav.kw@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=wladislav.kw@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELtMQrwaBhwbzN2EmqEbQ6gUexTw7YYCh9F41HxuJkUh4nS/w1babjuoERw4B0rVkzxZwfkuE9bctidjsfaakFM=
MIME-Version: 1.0
From: Wladislav Wiebe <wladislav.kw@gmail.com>
Date: Tue, 20 Mar 2018 13:44:39 +0100
Message-ID: <CAFZK-jp5aa8ihU5TZW-sbeMDwD0Rk0UcGm9NZB=42zic7zMxtg@mail.gmail.com>
Subject: [PATCH] tools: fix another redefinition of BITS_PER_LONG
To: kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
	tglx@linutronix.de, pombredanne@nexb.com
Cc: linux-kernel@vger.kernel.org, Wladislav Wiebe <wladislav.kw@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595460687953855482?=
X-GMAIL-MSGID: =?utf-8?q?1595460687953855482?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

If BITS_PER_LONG gets already defined in
linux/tools/include/linux/bitops.h it shouldn't be
redefined in tools/include/asm-generic/bitsperlong.h.

This patch prevents such compilation error:
[..]/linux/tools/include/asm-generic/bitsperlong.h:8:0:
error: "BITS_PER_LONG" redefined [-Werror]
 #define BITS_PER_LONG (__CHAR_BIT__ * __SIZEOF_LONG__)

In file included from [..]/linux/tools/include/linux/hashtable.h:13:0,
                 from elf.h:24,
                 from check.h:22,
                 from builtin-check.c:30:
[..]/linux/tools/include/linux/bitops.h:13:0:
note: this is the location of the previous definition

Signed-off-by: Wladislav Wiebe <wladislav.kw@gmail.com>
---
 tools/include/asm-generic/bitsperlong.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/include/asm-generic/bitsperlong.h
b/tools/include/asm-generic/bitsperlong.h
index 8f2283052333..c69a5fa3a096 100644
--- a/tools/include/asm-generic/bitsperlong.h
+++ b/tools/include/asm-generic/bitsperlong.h
@@ -4,11 +4,13 @@

 #include <uapi/asm-generic/bitsperlong.h>

+#ifndef BITS_PER_LONG
 #ifdef __SIZEOF_LONG__
 #define BITS_PER_LONG (__CHAR_BIT__ * __SIZEOF_LONG__)
 #else
 #define BITS_PER_LONG __WORDSIZE
 #endif
+#endif

 #if BITS_PER_LONG != __BITS_PER_LONG
 #error Inconsistent word size. Check asm/bitsperlong.h
-- 
2.16.1
