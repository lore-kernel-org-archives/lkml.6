Return-Path: <tony@atomide.com>
X-Google-Smtp-Source: AIpwx49z7lN1mfma426AoFvm69XP1Tt50macM91Zdl8R1jNu8FlEVh3M/VwIiXocmHVHEq+TkbDQ
ARC-Seal: i=1; a=rsa-sha256; t=1524505582; cv=none;
        d=google.com; s=arc-20160816;
        b=iMmmMFvStA/OGVuJCK18QQGwRbBx7FRLZv61x3KuanGXxDJDi6cS7el+40qjT00hwi
         JeOgIaxf/kNSCYz/4qs3UuDUc0IMcYRlRRh6eRB8r3Y6xt38fJdESQP67QAQCqzNpJd1
         0EvlUthy9FG+DhmXMeQDnLSPA79vbyv/Yh7u3eToPr6ke96j+B2sz1REfmApOG8y7Qwr
         EJ0ASDCVqf2YD/hhdNDrjq00HyBbbDBequIAtiJmINK9SzV+S6/J+RR9uVGlbTaxe4gC
         RVrWTQb6V6Bmu5f2TkPhaELmzlIB1nsHd7i6gs1JGSIkalZc5XCwmY9sVbCIQMwrRdtX
         bfUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=6RSuAlP33gFzLz3JuUrmJHi8q22DfficiEsTzEchhcw=;
        b=ICoegK4jYlNPjTi93ZN40lQuiJ0iZK1UGSjR+NY6tnHhmsxQLv55nieH2IGWik6+JC
         KlqOEArRNGc2pknFrnZZCYXqNSHA6Li/yJfXgOo9gIYRHETv0ZEAJ3AEdSMHyj7yOtsM
         pfp9kwWmQAPLp6udGdnoMNetx/Tk1YsOJwzeiMzT250XGwGc27oSZtkwLQBo7p02nwwY
         O2VOzBwgNWPp/06EcjVgV62I8nMOQ2Xy/3xIMphi1NLZjNJr17qp4/98M5un1MT36H0Q
         IhCm8Beo4ISpcrwF4evlL0BIAS7ebzVAlSHar2GwbnF25+H/AjWWHKbfxDtdcmzsbxfM
         uGBg==
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
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 07/16] bus: ti-sysc: Handle simple-bus for nested children
Date: Mon, 23 Apr 2018 10:45:40 -0700
Message-Id: <20180423174549.57412-8-tony@atomide.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180423174549.57412-1-tony@atomide.com>
References: <20180423174549.57412-1-tony@atomide.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598559965692454618?=
X-GMAIL-MSGID: =?utf-8?q?1598559965692454618?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Otherwise child devices that some interconnect target module devices
have won't probe using simple-bus.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -1314,6 +1314,11 @@ static void ti_sysc_idle(struct work_struct *work)
 		pm_runtime_put_sync(ddata->dev);
 }
 
+static const struct of_device_id sysc_match_table[] = {
+	{ .compatible = "simple-bus", },
+	{ /* sentinel */ },
+};
+
 static int sysc_probe(struct platform_device *pdev)
 {
 	struct ti_sysc_platform_data *pdata = dev_get_platdata(&pdev->dev);
@@ -1375,8 +1380,8 @@ static int sysc_probe(struct platform_device *pdev)
 	sysc_show_registers(ddata);
 
 	ddata->dev->type = &sysc_device_type;
-	error = of_platform_populate(ddata->dev->of_node,
-				     NULL, pdata ? pdata->auxdata : NULL,
+	error = of_platform_populate(ddata->dev->of_node, sysc_match_table,
+				     pdata ? pdata->auxdata : NULL,
 				     ddata->dev);
 	if (error)
 		goto err;
-- 
2.17.0
