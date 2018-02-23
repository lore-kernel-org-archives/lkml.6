Return-Path: <f.fainelli@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519420192; cv=none;
        d=google.com; s=arc-20160816;
        b=GLX43Kcng5pg0pf4hxbbvG58ngjab8WmgGmn3RPgmvyPrympltNFg15fsRKWxVpOUn
         4oVoH/2u3ClsdsNDMkUPnJqPelECQruuoAPpAVwmwYxkZl9slco1ht1DuH9piemukgXk
         YlcQy4END7PVLLQZlZ7ISQXAbkN9bQIrGB4mVKo32IDSMoW1xfT4JxurqYoFDjFzGtMs
         ymms43Hypmirm3VW9EKIWjPvyElJeLV3sXndK8beQ1udfzwfVLDfxANAmxy5bLEP4zGJ
         jGOyTpxl3xEgFH2dXiqIDcuH9HwO7px0aiZuBXkgVo7aFOxYfRuDodfMnyVARnpmiA2U
         vutA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=v8P8mYb7KVpQTvBbAGl7l1RRTcejKQ4TtODObPu7HUg=;
        b=SmccxsJq5TvzutGQ9tXXOeLDn5jL5F7d9p2ZsOQheDtCrxCl7zYpAlo2cpMYvclNlG
         Yoj7RcRAtCvFSyNIR5PhaRrjfruC1rTBnARz0NemFYVfpXzsIZY5rqQN5SjLB7aTp1kr
         qggL6eBFuzrJcDF55WM4yuKaZAD90Wvv5w9Ni7q60p0y+H8gPslG0DXkWfpVruqv8TRS
         0NTjMzwwVmw2zlFW2mdPbrtqELWGzpD9ex5sLbtlvE65UiYn8CgJGtDcHJm7eppeDXPU
         KvwMV7vmQ9bqqHOcP+CvgY6y5rV2OrSLisIculUeJusVRH4jZ5w046ZYkO6CzHL0TdJU
         PmNA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=k6Y6//SX;
       spf=pass (google.com: domain of f.fainelli@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=f.fainelli@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=k6Y6//SX;
       spf=pass (google.com: domain of f.fainelli@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=f.fainelli@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELvy1SVwSixWGDL50b0ZAUgbx0OSAGeUsM6vD19+I4RwRFF1Es5M+5xsn/VtlNNAVVQztNAP8w==
From: Florian Fainelli <f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Brian Norris <computersforpeace@gmail.com>,
	Gregory Fong <gregory.0xf0@gmail.com>,
	bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE),
	Vladimir Murzin <vladimir.murzin@arm.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 4/4] ARM: brcmstb: Add support for the V7 memory map
Date: Fri, 23 Feb 2018 13:09:23 -0800
Message-Id: <20180223210923.544-5-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180223210923.544-1-f.fainelli@gmail.com>
References: <20180223210923.544-1-f.fainelli@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593227538446054373?=
X-GMAIL-MSGID: =?utf-8?q?1593227548095358785?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Doug Berger <opendmb@gmail.com>

The 7278 device is the first device that includes support for the V7
memory map developed for use in 64-bit architecture brcmstb devices.
This map relocates the register physical offset from 0xF0000000 to
0x0000000008000000.

Since the ARM PERIPHBASE value is also relocated in the V7 memory map
we can use its value to determine whether this device uses the new
V7 memory map and therefore where to look for the SUN_TOP_CTRL
register used to identify the chip family.

Signed-off-by: Doug Berger <opendmb@gmail.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/include/debug/brcmstb.S | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/debug/brcmstb.S b/arch/arm/include/debug/brcmstb.S
index c826f15d2f80..0f580caa81e5 100644
--- a/arch/arm/include/debug/brcmstb.S
+++ b/arch/arm/include/debug/brcmstb.S
@@ -11,20 +11,25 @@
  * GNU General Public License for more details.
  */
 #include <linux/serial_reg.h>
+#include <asm/cputype.h>
 
 /* Physical register offset and virtual register offset */
 #define REG_PHYS_BASE		0xf0000000
+#define REG_PHYS_BASE_V7	0x08000000
 #define REG_VIRT_BASE		0xfc000000
 #define REG_PHYS_ADDR(x)	((x) + REG_PHYS_BASE)
+#define REG_PHYS_ADDR_V7(x)	((x) + REG_PHYS_BASE_V7)
 
 /* Product id can be read from here */
 #define SUN_TOP_CTRL_BASE	REG_PHYS_ADDR(0x404000)
+#define SUN_TOP_CTRL_BASE_V7	REG_PHYS_ADDR_V7(0x404000)
 
 #define UARTA_3390		REG_PHYS_ADDR(0x40a900)
 #define UARTA_7250		REG_PHYS_ADDR(0x40b400)
 #define UARTA_7260		REG_PHYS_ADDR(0x40c000)
 #define UARTA_7268		UARTA_7260
 #define UARTA_7271		UARTA_7268
+#define UARTA_7278		REG_PHYS_ADDR_V7(0x40c000)
 #define UARTA_7364		REG_PHYS_ADDR(0x40b000)
 #define UARTA_7366		UARTA_7364
 #define UARTA_74371		REG_PHYS_ADDR(0x406b00)
@@ -55,8 +60,21 @@
 		mov	\rv, #0			@ yes; record init is done
 		str	\rv, [\tmp]
 
+		/* Check for V7 memory map if B53 */
+		mrc	p15, 0, \rv, c0, c0, 0	@ get Main ID register
+		ldr	\rp, =ARM_CPU_PART_MASK
+		and	\rv, \rv, \rp
+		ldr	\rp, =ARM_CPU_PART_BRAHMA_B53	@ check for B53 CPU
+		cmp	\rv, \rp
+		bne	10f
+
+		/* if PERIPHBASE doesn't overlap REG_PHYS_BASE use V7 map */
+		mrc	p15, 1, \rv, c15, c3, 0	@ get PERIPHBASE from CBAR
+		ands	\rv, \rv, #REG_PHYS_BASE
+		ldreq	\rp, =SUN_TOP_CTRL_BASE_V7
+
 		/* Check SUN_TOP_CTRL base */
-		ldr	\rp, =SUN_TOP_CTRL_BASE	@ load SUN_TOP_CTRL PA
+10:		ldrne	\rp, =SUN_TOP_CTRL_BASE	@ load SUN_TOP_CTRL PA
 		ldr	\rv, [\rp, #0]		@ get register contents
 ARM_BE8(	rev	\rv, \rv )
 		and	\rv, \rv, #0xffffff00	@ strip revision bits [7:0]
@@ -72,6 +90,7 @@ ARM_BE8(	rev	\rv, \rv )
 27:		checkuart(\rp, \rv, 0x07437100, 74371)
 28:		checkuart(\rp, \rv, 0x74390000, 7439)
 29:		checkuart(\rp, \rv, 0x74450000, 7445)
+30:		checkuart(\rp, \rv, 0x72780000, 7278)
 
 		/* No valid UART found */
 90:		mov	\rp, #0
-- 
2.14.1
