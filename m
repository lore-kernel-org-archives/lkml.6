Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuE+1nvAwaVeY3+IHKBtb556k35P4C55IDQEUcHZxiFNFr+kRdwRIK0ynA3tOJkHrHWS46k
ARC-Seal: i=1; a=rsa-sha256; t=1521482977; cv=none;
        d=google.com; s=arc-20160816;
        b=PGxuLg903CrnkXWZh3GqizmL+xfNjnqaKnH1UcoT9MLkxi+pbbPEtNIvqPs1Pgzbm8
         xo99xnMQmkekrJsPvg1SUChyHj6x8MxTcYsg4ltdFvIjEfu2OFaoxldscd+UlZXqlqbM
         rRA1fCx7B3k2kmRcUUShUrbHJ9+HwXZHKkL/icQHP7y2DB6e4BHbo4WQMmD/XPbnRiOX
         x1ctQOJvEP8oQczSFk4LMNDSrhtHHseJtCYwe7SQOHERfyXr/nulNC3o+XMlCNnkviNm
         vWb3hIlr44+L08xL4Tm5AA4qqwF8LQxSDGtNNnXH5sx9nYRAgFyS0cNf4cn6UipKP7s4
         MxxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=QlbgvdH/haoeVmnBmb5KMlS21l6Vg2GqJM8ojkIVoYk=;
        b=qVKXyxGjCDv7cmRA+e0GvuygBph7gOTab7EcizVOxCot6dTSRgqilNi24r/K0KnC4x
         l5Mrh49UKiCi5lyprZ2QvXweN2WXsutN5+85ZKmSjupzzlNr5yRXt+/pFJ3mW3XsXK+M
         xx+cW1X0DgGLQjyrftEQqqC4twT7csZQos95ZzZL2XZwSGVOMieweVaof2Zq7CItLcxA
         +vnQx/rqIwm4J806UhZ9RU5x84nllLH2krogUTYdZEVNjKeJAKY5mB/7/VMTc1mzNUVq
         J0QE6BZyWn6X28joGhAU5AfMIe94FJV5Lus9vlgjVvoG9/uY/7G7XbIrg6EOZSNtdfm5
         DUqg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tero Kristo <t-kristo@ti.com>,
	Roger Quadros <rogerq@ti.com>,
	Tony Lindgren <tony@atomide.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 22/68] ARM: DRA7: hwmod_data: Prevent wait_target_disable error for usb_otg_ss
Date: Mon, 19 Mar 2018 19:06:00 +0100
Message-Id: <20180319171830.959470467@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171827.899658615@linuxfoundation.org>
References: <20180319171827.899658615@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390534800077046?=
X-GMAIL-MSGID: =?utf-8?q?1595390534800077046?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Roger Quadros <rogerq@ti.com>


[ Upstream commit e2d54fe76997301b49311bde7ba8ef52b47896f9 ]

It seems that if L3_INIT clkdomain is kept in HW_AUTO while usb_otg_ss
is in use then there are random chances that the usb_otg_ss module
will fail to completely idle. i.e. IDLEST = 0x2 instead of 0x3.

Preventing L3_INIT from HW_AUTO while usb_otg_ss module is in use
fixes this issue.

We don't know yet if usb_otg_ss instances 3 and 4 are affected by this
issue or not so don't add this flag for those instances.

Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -2106,6 +2106,7 @@ static struct omap_hwmod dra7xx_usb_otg_
 	.class		= &dra7xx_usb_otg_ss_hwmod_class,
 	.clkdm_name	= "l3init_clkdm",
 	.main_clk	= "dpll_core_h13x2_ck",
+	.flags		= HWMOD_CLKDM_NOAUTO,
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = DRA7XX_CM_L3INIT_USB_OTG_SS1_CLKCTRL_OFFSET,
@@ -2127,6 +2128,7 @@ static struct omap_hwmod dra7xx_usb_otg_
 	.class		= &dra7xx_usb_otg_ss_hwmod_class,
 	.clkdm_name	= "l3init_clkdm",
 	.main_clk	= "dpll_core_h13x2_ck",
+	.flags		= HWMOD_CLKDM_NOAUTO,
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = DRA7XX_CM_L3INIT_USB_OTG_SS2_CLKCTRL_OFFSET,
