Return-Path: <tony@atomide.com>
X-Google-Smtp-Source: AIpwx48c0PPGcpgWO2vdva1a9QatE+mDDZt8ChtClpTb0xGzHrT29X5/CdT69PYuPpN2NZV261sD
ARC-Seal: i=1; a=rsa-sha256; t=1524505575; cv=none;
        d=google.com; s=arc-20160816;
        b=nR2c2J1pzp160NJAaxDefEXyqiNZWz/4/LfcE9PRL4+cnO4EoQHFc2HQeDt+PN9arD
         t/1N75bSuasZ4DINSFkpuOpSbze1dhPx/4UAou7mexdHtD+rigBhIiPpW7jtV56ZI9b+
         ErcDP4Y67t8ZMKVQ6faG0CNIpG41DMpQi+I/sPOsJDdboiO6xlw7kPWIOpfkrFzd98mb
         T2WIdVsu93Q9K60U/WCFtEQMc7bRY85UUqvdwaWvjSnBAqbvTyitZwEJ05+kmoCScFwI
         ResF29zwcVaEvT9SqMS0znkXAtrSrTQxH+MvkTscoWTi2MnVGQYy/m7pXt7yTS1RBESb
         naXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=+trjUfyGwgiMdK3onoZFNH0mjuEoKtFTIz55jDVYloc=;
        b=DUjhk2vCudO9oq89FYOAQXp3QDwcan8oMzNWmCqYtnumi+qZJZ8jEp5Me3iOGMnccd
         a6pf/rxAxnRdmNzVp/ztkCZBYij5/s2JP/39QeFDPsJYmSYg2EVdLg+UStFYXrzrLrTb
         1BsesxEnJPv+rFVPcWt0tzywuvHvKO2FMyxfl2GvyhG8vZKOQu4ScTeolsdAyEvir39N
         3sP5B6HjWn9h+t78DMEgp48DNAwxfBGpn8GWnRz27JAHs2bMtQxDUyXGC+p7dyuTTOX0
         rA2/qFg/vPmK9dJ19FGTYSWZJ2l5DXG45ktgHiD/5KdGIzjrjPKJkT+kVfDtLTW/Kged
         W72g==
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
	Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 04/16] ARM: OMAP2+: Only probe SDMA via ti-sysc if configured in dts
Date: Mon, 23 Apr 2018 10:45:37 -0700
Message-Id: <20180423174549.57412-5-tony@atomide.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180423174549.57412-1-tony@atomide.com>
References: <20180423174549.57412-1-tony@atomide.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598559957890276076?=
X-GMAIL-MSGID: =?utf-8?q?1598559957890276076?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We still have some SDMA probing using omap_device_build() for the
arch/arm/plat-omap/dma.c part that the dmaengine driver then uses.

So we still need to ensure that omap_device_build() works even if we
probe and manage the dmaengine driver via ti-sysc. And we don't want
to call dev_pm_domain_set() as otherwise we'd also have omap_device
try to manage the hardware in addition to ti-sysc.

Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_device.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -143,7 +143,7 @@ static int omap_device_build_from_dt(struct platform_device *pdev)
 	struct resource res;
 	const char *oh_name;
 	int oh_cnt, i, ret = 0;
-	bool device_active = false;
+	bool device_active = false, skip_pm_domain = false;
 
 	oh_cnt = of_property_count_strings(node, "ti,hwmods");
 	if (oh_cnt <= 0) {
@@ -151,8 +151,15 @@ static int omap_device_build_from_dt(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	/* SDMA still needs special handling for omap_device_build() */
+	ret = of_property_read_string_index(node, "ti,hwmods", 0, &oh_name);
+	if (!ret && (!strncmp("dma_system", oh_name, 10) ||
+		     !strncmp("dma", oh_name, 3)))
+		skip_pm_domain = true;
+
 	/* Use ti-sysc driver instead of omap_device? */
-	if (!omap_hwmod_parse_module_range(NULL, node, &res))
+	if (!skip_pm_domain &&
+	    !omap_hwmod_parse_module_range(NULL, node, &res))
 		return -ENODEV;
 
 	hwmods = kzalloc(sizeof(struct omap_hwmod *) * oh_cnt, GFP_KERNEL);
@@ -191,11 +198,12 @@ static int omap_device_build_from_dt(struct platform_device *pdev)
 			r->name = dev_name(&pdev->dev);
 	}
 
-	dev_pm_domain_set(&pdev->dev, &omap_device_pm_domain);
-
-	if (device_active) {
-		omap_device_enable(pdev);
-		pm_runtime_set_active(&pdev->dev);
+	if (!skip_pm_domain) {
+		dev_pm_domain_set(&pdev->dev, &omap_device_pm_domain);
+		if (device_active) {
+			omap_device_enable(pdev);
+			pm_runtime_set_active(&pdev->dev);
+		}
 	}
 
 odbfd_exit1:
-- 
2.17.0
