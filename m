Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165854AbeE1OlB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 10:41:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:50810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161228AbeE1KbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:31:05 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qi Hou <qi.hou@windriver.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 108/329] ARM: OMAP2+: timer: fix a kmemleak caused in omap_get_timer_dt
Date: Mon, 28 May 2018 12:00:37 +0200
Message-Id: <20180528100251.740511999@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qi Hou <qi.hou@windriver.com>

[ Upstream commit db35340c536f1af0108ec9a0b2126a05d358d14a ]

When more than one GP timers are used as kernel system timers and the
corresponding nodes in device-tree are marked with the same "disabled"
property, then the "attr" field of the property will be initialized
more than once as the property being added to sys file system via
__of_add_property_sysfs().

In __of_add_property_sysfs(), the "name" field of pp->attr.attr is set
directly to the return value of safe_name(), without taking care of
whether it's already a valid pointer to a memory block. If it is, its
old value will always be overwritten by the new one and the memory block
allocated before will a "ghost", then a kmemleak happened.

That the same "disabled" property being added to different nodes of device
tree would cause that kind of kmemleak overhead, at least once.

To fix it, allocate the property dynamically, and delete static one.

Signed-off-by: Qi Hou <qi.hou@windriver.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/mach-omap2/timer.c |   19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -136,12 +136,6 @@ static struct clock_event_device clockev
 	.tick_resume		= omap2_gp_timer_shutdown,
 };
 
-static struct property device_disabled = {
-	.name = "status",
-	.length = sizeof("disabled"),
-	.value = "disabled",
-};
-
 static const struct of_device_id omap_timer_match[] __initconst = {
 	{ .compatible = "ti,omap2420-timer", },
 	{ .compatible = "ti,omap3430-timer", },
@@ -183,8 +177,17 @@ static struct device_node * __init omap_
 				  of_get_property(np, "ti,timer-secure", NULL)))
 			continue;
 
-		if (!of_device_is_compatible(np, "ti,omap-counter32k"))
-			of_add_property(np, &device_disabled);
+		if (!of_device_is_compatible(np, "ti,omap-counter32k")) {
+			struct property *prop;
+
+			prop = kzalloc(sizeof(*prop), GFP_KERNEL);
+			if (!prop)
+				return NULL;
+			prop->name = "status";
+			prop->value = "disabled";
+			prop->length = strlen(prop->value);
+			of_add_property(np, prop);
+		}
 		return np;
 	}
 
