Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49RkFO2nQESLKNYOPiLBoUvzz1t6/dTfRwjrfMxUnhFEKb+o6NvyQPqICpfLv3rl3lI334Z
ARC-Seal: i=1; a=rsa-sha256; t=1523021862; cv=none;
        d=google.com; s=arc-20160816;
        b=RZHxs+SQzHUJZthTNImUwQrCDMP3iuoEX+7j+Z9rfy4FcTjrRyGZdplp36bh8GlGq8
         0fRu40u9I+6TKHuUl0MHliy2/PRYVDtij8atuGYUJ77f3P2saM0p+GTIMM+v5kjB+dcH
         XUITjl7HkvYhgQQo8dfAGwO5mWdYqZhEwvdARHX3RQD6YLOkCwwFlKDLF8GL75MWSZKA
         0u6IQ/WsYD/DEQe5hZU0kGQomf+4A6P8aiqlf4KxAmOkLnCOjVjjaMlC8xOcjFwL7673
         VcA1BmXWJ3BvfBgUqmbdg/EenkagkTlVzg1RuneysVrktb4wms0sPQuEPUON17oKK2b+
         QURA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=k1wJwr5cuM1NqXytwitgMQFdWybisSAm3QcuE0QbKUs=;
        b=pD9NPmsZGR016IRB+Nb6oyvC27V8RGEVNGG6oeafxZIy4OptxDo+P0K16GB6Xy7qwA
         Li4FyJeEqZep39fyBTonr8MRTaig/6QZHomm2pPSOGZMQhm5IfJwJ5cDZx6MGrDa7qJ0
         /jCUqYjOldqQ33SXbgg24V5DmKBJWjLlvaJiJp/jCeMQBgZgRa/78ijYaHKas/u9fZrW
         ine/KHyCS+aHVbvimVcxc1/M84Z+ZjfuGpfpoAuLWf2HRIuiPRGuORUHj/2ZncZkuul8
         hPRQ+aS+knQbjvttaBGJDWd7VoXqRMRIPMDxlbmckLIHfWEazCVcMbVk3C81twO0u/5i
         C/Gw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dave Gerlach <d-gerlach@ti.com>,
	Pavel Machek <pavel@ucw.cz>,
	Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4.14 01/67] ARM: OMAP: Fix SRAM W+X mapping
Date: Fri,  6 Apr 2018 15:23:31 +0200
Message-Id: <20180406084341.408171508@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084341.225558262@linuxfoundation.org>
References: <20180406084341.225558262@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004172006406380?=
X-GMAIL-MSGID: =?utf-8?q?1597004172006406380?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tony Lindgren <tony@atomide.com>

commit eb85a355c3afd9379f5953cfe2df73632d14c884 upstream.

We are still using custom SRAM code for some SoCs and are not marking
the PM code mapped to SRAM as read-only and executable after we're
done. With CONFIG_DEBUG_WX=y, we will get "Found insecure W+X mapping
at address" warning.

Let's fix this issue the same way as commit 728bbe75c82f ("misc: sram:
Introduce support code for protect-exec sram type") is doing for
drivers/misc/sram-exec.c.

On omap3, we need to restore SRAM when returning from off mode after
idle, so init time configuration is not enough.

And as we no longer have users for omap_sram_push_address() we can
make it static while at it.

Note that eventually we should be using sram-exec.c for all SoCs.

Cc: stable@vger.kernel.org	# v4.12+
Cc: Dave Gerlach <d-gerlach@ti.com>
Reported-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/plat-omap/include/plat/sram.h |   11 ----------
 arch/arm/plat-omap/sram.c              |   36 ++++++++++++++++++++++++++++++++-
 2 files changed, 36 insertions(+), 11 deletions(-)

--- a/arch/arm/plat-omap/include/plat/sram.h
+++ b/arch/arm/plat-omap/include/plat/sram.h
@@ -5,13 +5,4 @@ void omap_map_sram(unsigned long start,
 			unsigned long skip, int cached);
 void omap_sram_reset(void);
 
-extern void *omap_sram_push_address(unsigned long size);
-
-/* Macro to push a function to the internal SRAM, using the fncpy API */
-#define omap_sram_push(funcp, size) ({				\
-	typeof(&(funcp)) _res = NULL;				\
-	void *_sram_address = omap_sram_push_address(size);	\
-	if (_sram_address)					\
-		_res = fncpy(_sram_address, &(funcp), size);	\
-	_res;							\
-})
+extern void *omap_sram_push(void *funcp, unsigned long size);
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -23,6 +23,7 @@
 #include <asm/fncpy.h>
 #include <asm/tlb.h>
 #include <asm/cacheflush.h>
+#include <asm/set_memory.h>
 
 #include <asm/mach/map.h>
 
@@ -42,7 +43,7 @@ static void __iomem *omap_sram_ceil;
  * Note that fncpy requires the returned address to be aligned
  * to an 8-byte boundary.
  */
-void *omap_sram_push_address(unsigned long size)
+static void *omap_sram_push_address(unsigned long size)
 {
 	unsigned long available, new_ceil = (unsigned long)omap_sram_ceil;
 
@@ -60,6 +61,30 @@ void *omap_sram_push_address(unsigned lo
 	return (void *)omap_sram_ceil;
 }
 
+void *omap_sram_push(void *funcp, unsigned long size)
+{
+	void *sram;
+	unsigned long base;
+	int pages;
+	void *dst = NULL;
+
+	sram = omap_sram_push_address(size);
+	if (!sram)
+		return NULL;
+
+	base = (unsigned long)sram & PAGE_MASK;
+	pages = PAGE_ALIGN(size) / PAGE_SIZE;
+
+	set_memory_rw(base, pages);
+
+	dst = fncpy(sram, funcp, size);
+
+	set_memory_ro(base, pages);
+	set_memory_x(base, pages);
+
+	return dst;
+}
+
 /*
  * The SRAM context is lost during off-idle and stack
  * needs to be reset.
@@ -75,6 +100,9 @@ void omap_sram_reset(void)
 void __init omap_map_sram(unsigned long start, unsigned long size,
 				 unsigned long skip, int cached)
 {
+	unsigned long base;
+	int pages;
+
 	if (size == 0)
 		return;
 
@@ -95,4 +123,10 @@ void __init omap_map_sram(unsigned long
 	 */
 	memset_io(omap_sram_base + omap_sram_skip, 0,
 		  omap_sram_size - omap_sram_skip);
+
+	base = (unsigned long)omap_sram_base;
+	pages = PAGE_ALIGN(omap_sram_size) / PAGE_SIZE;
+
+	set_memory_ro(base, pages);
+	set_memory_x(base, pages);
 }
