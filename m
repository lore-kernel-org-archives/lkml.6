Return-Path: <tony@atomide.com>
X-Google-Smtp-Source: AIpwx493m1v4McsPIKLrV4t2VgcCM5w6ogtmY9Omv4zgnI3iXZhzt2yh8ahyePLB+THJpXZvX/tG
ARC-Seal: i=1; a=rsa-sha256; t=1524505579; cv=none;
        d=google.com; s=arc-20160816;
        b=mGsCtcIb09f4mOs5X5yZec1s2KUeJgBfoAmlL2qDETmuDOFADBw0rboPnErEV8XCBO
         GIGd5o62pKNR7nZcxshIlhQYF8BJsY2DXOG9a74n7V6jwu1YfSWkB6/g6A8a1RXY3iXt
         qZq0+v85l6JCI4fueEDfkqSEzep+UWKeXWzjmn8Y+1n0nvSvKeyyGoX0GXsbYB1BdO0w
         xC/Xp8pSRGYIYbv800uSVlWJ65CqDnADdy1qgvBuylCg1mreX2YY1a5L5WSqRL91GuYa
         m4R0l6iEld02o1HlNl+Dut5rSBMj7VDrvjHogw6O9RtTj6KtRGSZg4uL+WsUpHgKkUmT
         OZVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=K3FtbNsENvxXyHc4bOWMf58uuVuoADwRXkMD0w0Ki90=;
        b=zvI6q9gU8uDtPbnbvG03dnSkOadvxSS/MVoPheHglQcU11WrTHOrt4qosrDHh7uZDp
         zzKORuY2R6euCfsU42REVzZA7bwSMEFj4cNYMQjtSgC9xHMn87PLLOy+r/v4bektETLM
         0R+8B9pBaPOi+aXRg+oHqSeWFrZNsM/T5Fm+IvEx8hbjDgmIA8mkvs/Xx4L1qZQM8egG
         LaTcCo7ByJxgpwwkJk7CYvmJZViGY6ZXFA0lCkw71Fw14RX2FVKrAsDPpIvjaaOMQKzZ
         gs79xUloCtlY28fLW+NS68xTtwS5HcqEFxrN0Y3GVc+jKXob+MY03X8XmhmNiwKtYUb6
         cVNg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 72.249.23.125 is neither permitted nor denied by best guess record for domain of tony@atomide.com) smtp.mailfrom=tony@atomide.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 72.249.23.125 is neither permitted nor denied by best guess record for domain of tony@atomide.com) smtp.mailfrom=tony@atomide.com
From: Tony Lindgren <tony@atomide.com>
To: linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nishanth Menon <nm@ti.com>,
	Suman Anna <s-anna@ti.com>,
	Tero Kristo <t-kristo@ti.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 06/16] ARM: OMAP2+: Make display related init into device_initcall
Date: Mon, 23 Apr 2018 10:45:39 -0700
Message-Id: <20180423174549.57412-7-tony@atomide.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180423174549.57412-1-tony@atomide.com>
References: <20180423174549.57412-1-tony@atomide.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598559962236332895?=
X-GMAIL-MSGID: =?utf-8?q?1598559962236332895?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We can initialize almost everything at normal module_init time with
ti-sysc except for clocks and timers. To prepare for that, let's make
display init into device_initcall as otherwise we'll be calling
of_platform_populate() before the parent has probed.

Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-generic.c | 2 --
 arch/arm/mach-omap2/common.h        | 2 --
 arch/arm/mach-omap2/display.c       | 3 ++-
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -31,8 +31,6 @@ static const struct of_device_id omap_dt_match_table[] __initconst = {
 static void __init __maybe_unused omap_generic_init(void)
 {
 	pdata_quirks_init(omap_dt_match_table);
-
-	omapdss_init_of();
 	omap_soc_device_init();
 }
 
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -352,7 +352,5 @@ extern int omap_dss_reset(struct omap_hwmod *);
 /* SoC specific clock initializer */
 int omap_clk_init(void);
 
-int __init omapdss_init_of(void);
-
 #endif /* __ASSEMBLER__ */
 #endif /* __ARCH_ARM_MACH_OMAP2PLUS_COMMON_H */
diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -385,7 +385,7 @@ static struct device_node * __init omapdss_find_dss_of_node(void)
 	return NULL;
 }
 
-int __init omapdss_init_of(void)
+static int __init omapdss_init_of(void)
 {
 	int r;
 	struct device_node *node;
@@ -415,3 +415,4 @@ int __init omapdss_init_of(void)
 
 	return omapdss_init_fbdev();
 }
+omap_device_initcall(omapdss_init_of);
-- 
2.17.0
