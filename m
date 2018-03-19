Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuGkNEqR03cbkE1I3l3bidjgrvhxFNm7yAgXo4wQcuZenmfeCYcd78JZn81/GiNrX4CZ/11
ARC-Seal: i=1; a=rsa-sha256; t=1521483682; cv=none;
        d=google.com; s=arc-20160816;
        b=ngCBKNVg+bOEFJ5HTIsua2WprlFGUoyLkbvvkDEE5ZRurf0Ay0KBDBCyG1AQsLxgJa
         Ei2clgPekoYShuqjB3fg/vbnLNOwFc8kNe0BU9VuoobL16/0qMvbTW9bE8+7t3jV+2rx
         ew8jNQOXVk2BGNHEUuFN/aMTl+wWHcJrog1IiKu5Ud5J9hF4zvc3aLM+I8mRNU3xwzG5
         OVI09qiY419MJVKpVHitVjU7YTYh2mfPc5OV8sm7Kl+YysLOxAPcj5ND5Kv7KGwh4pLm
         oRWOHFrAwdn+OQ9RHpo/7OU1ZmC9ODJJnyhO25J8SVsQn/yM5NIdNuPti88z5ckO10+m
         NjHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=FBn6mVRNrS/1APfQgeMVqG5Upk/4pGQLS71Snh10ukA=;
        b=0PnntCQIjq9U18BXL/SwcEuMt7t8NTKEiK9zdUK/LbU+3apbHtBsnvyCj+g6vQqDO8
         BCHNSnkKYGapsgltzg+hkCEx5vzNgt8dovoHwLsaVJM7GTQp6jHzQrNrwO4wwQ0jHDik
         EOINWn0zzzaM3y3FC+mYDeaOb8w2814RnYifHfCyCUzRSZiR25GV1wYBj3AQ9MzUk08/
         rJyrD4naaA2IKkuFGJW6CrDWHY60tvjOOFIfO1ETZPVdKTqhuqNUlvUJSzpEotpvhzv3
         V7IQE7lRxGfgsB90dYolYiMRGspSpjbd8Mrq00Veq0Av59vmSh65pjiHQLuAcy7aSpBe
         hcsw==
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
Subject: [PATCH 4.9 079/241] ARM: DRA7: hwmod_data: Prevent wait_target_disable error for usb_otg_ss
Date: Mon, 19 Mar 2018 19:05:44 +0100
Message-Id: <20180319180754.483907415@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390534800077046?=
X-GMAIL-MSGID: =?utf-8?q?1595391273779198809?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2572,6 +2572,7 @@ static struct omap_hwmod dra7xx_usb_otg_
 	.class		= &dra7xx_usb_otg_ss_hwmod_class,
 	.clkdm_name	= "l3init_clkdm",
 	.main_clk	= "dpll_core_h13x2_ck",
+	.flags		= HWMOD_CLKDM_NOAUTO,
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = DRA7XX_CM_L3INIT_USB_OTG_SS1_CLKCTRL_OFFSET,
@@ -2593,6 +2594,7 @@ static struct omap_hwmod dra7xx_usb_otg_
 	.class		= &dra7xx_usb_otg_ss_hwmod_class,
 	.clkdm_name	= "l3init_clkdm",
 	.main_clk	= "dpll_core_h13x2_ck",
+	.flags		= HWMOD_CLKDM_NOAUTO,
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = DRA7XX_CM_L3INIT_USB_OTG_SS2_CLKCTRL_OFFSET,
