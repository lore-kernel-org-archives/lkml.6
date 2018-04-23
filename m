Return-Path: <tony@atomide.com>
X-Google-Smtp-Source: AIpwx4+IbeN0RStdL7sbtx5U60BD0vxlJ1RHjAwTqHedJp0JqgK3IXKo/2/lvXYZXu+1GgpDBi0N
ARC-Seal: i=1; a=rsa-sha256; t=1524505584; cv=none;
        d=google.com; s=arc-20160816;
        b=JDivTzNMpSRJ52W+s81jkhRBvYcGkTqNypmpBEBkeDDUV9nQv9Cw6wAaZDifG0CAOw
         YjpEVXuwPcO/e+s0PB+BCNhbpIxF968p8jrgAcr4OXSxSJgKNmzdW3N8kmYtIDkG/XHn
         EcOVs5UnXRKLKw2Q/aFwduMMNMLJ75yeX86b2axEAP5gi2jZhewtrzv3G07FP5tzhY4Q
         yEzn8cjl7pWLf/efrus4DwU30b0NDt06cwPIYHjfBd1YRZndq2KVr7j1SlupW+hwKIAM
         FF8wrZQO98OWj2VlC9YE+L5/DekWh2xWL3c7l+leHT1Zej9tO3ZsQklk9tWhSRZmPoKC
         QZqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=JdfOHL2Mv5M5bdKHdbRPCtHXxjxvElv8TSDlGubBhCo=;
        b=y87jA0h3bveHFjpG2VC9+3nL7dtDtf33GOxaKCRoYBaybJz1CAe379W4z0eEH/gVUV
         N761xXkzKepiGqinwPSWxB2m2FuisInvn3kcsg+tSgLRczstn0j0Sv0ZLetogPKlFJzu
         MP6i639izZ1oFVAvu4irSwrtbvT2GYMbkJCXrBKPRuK2SxHb5tvuYMDbnY0Lu6cLBJ9A
         Kr+JKLm6vbcOmOUiOBxLx/BpnjOyuN1bTOFW74r25hu5qQ71tdj59k1EFbfNSet6CUDc
         k74YSZDOkwPIxsPRAU8ANhtSz1X2tH0kO3NVcbAenGlR6skotC0Qbdn5+FmovxRJLsWz
         1+ow==
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
Subject: [PATCH 08/16] bus: ti-sysc: Make child clock alias handling more generic
Date: Mon, 23 Apr 2018 10:45:41 -0700
Message-Id: <20180423174549.57412-9-tony@atomide.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180423174549.57412-1-tony@atomide.com>
References: <20180423174549.57412-1-tony@atomide.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598559968266071599?=
X-GMAIL-MSGID: =?utf-8?q?1598559968266071599?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In order to prepare supporting clkctrl optional clocks, we need to
make the current child clock handling more generic so we can use the
clock role names for the optional clocks in the following patch.

Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -811,29 +811,38 @@ static int sysc_init_syss_mask(struct sysc *ddata)
 }
 
 /*
- * Many child device drivers need to have fck available to get the clock
- * rate for device internal configuration.
+ * Many child device drivers need to have fck and opt clocks available
+ * to get the clock rate for device internal configuration etc.
  */
-static int sysc_child_add_fck(struct sysc *ddata,
-			      struct device *child)
+static int sysc_child_add_named_clock(struct sysc *ddata,
+				      struct device *child,
+				      const char *name)
 {
-	struct clk *fck;
+	struct clk *clk;
 	struct clk_lookup *l;
-	const char *name = clock_names[SYSC_FCK];
+	int error = 0;
 
-	if (IS_ERR_OR_NULL(ddata->clocks[SYSC_FCK]))
+	if (!name)
 		return 0;
 
-	fck = clk_get(child, name);
-	if (!IS_ERR(fck)) {
-		clk_put(fck);
+	clk = clk_get(child, name);
+	if (!IS_ERR(clk)) {
+		clk_put(clk);
 
 		return -EEXIST;
 	}
 
-	l = clkdev_create(ddata->clocks[SYSC_FCK], name, dev_name(child));
+	clk = clk_get(ddata->dev, name);
+	if (IS_ERR(clk))
+		return -ENODEV;
+
+	l = clkdev_create(clk, name, dev_name(child));
+	if (!l)
+		error = -ENOMEM;
 
-	return l ? 0 : -ENODEV;
+	clk_put(clk);
+
+	return error;
 }
 
 static struct device_type sysc_device_type = {
@@ -983,7 +992,8 @@ static int sysc_notifier_call(struct notifier_block *nb,
 
 	switch (event) {
 	case BUS_NOTIFY_ADD_DEVICE:
-		error = sysc_child_add_fck(ddata, dev);
+		error = sysc_child_add_named_clock(ddata, dev,
+						   clock_names[SYSC_FCK]);
 		if (error && error != -EEXIST)
 			dev_warn(ddata->dev, "could not add %s fck: %i\n",
 				 dev_name(dev), error);
-- 
2.17.0
