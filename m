Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AB8JxZq4s87nUY0auMFXkrdagILPGCCBTvUWu5Up5so3CG4LXK6WdqQjARsbbwySYsLCnE2oC/OY
ARC-Seal: i=1; a=rsa-sha256; t=1526438636; cv=none;
        d=google.com; s=arc-20160816;
        b=VbsX0xKUMHaGlHse1Q1XK2exB3h5zXCNiSUagNjMHmIvbTZgSEAv8tmK2c7AsbhCkD
         jGUBmvBkMV69KX44aAi0Juc+YzN3K2HXRU26U5q7QOmASOqqSx6M3N+mHeqwwMRuG3PK
         pMkPBF2gVCBe28eAcrORUi7Q/+TS5kdSLx8/zXWdrJgs7qLNLZlngvQ5P/CxqlVqeF0v
         aDUvFMwHrBIm+b9v9v65qUSq0NwbWGW0RefKZTJjwaSzCS3o0YAIQzf+anNtO+oqZlqs
         cCpZ8iuAUoP24Oc0/ZKsqXQ7jX0j4kQdOZ4eugvAaWhCsxrLGt516RiqzzFiht89tUN5
         sT4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=4hOeQg3zWqUzuMpDP+lr7T+Mni6J3N6xTYz/n3qRN0U=;
        b=DMjE9tAF3rNBpcwTzxf74g1JVJMK2aRKyA/+Scy43RMK7sWb0okzV/C2IyFv0XsPmk
         rTB+j/PRSyvlRzsGHAXH78OoH1nfVlXD92lhvNncYG57WNcl++C8IuhgLjcpII8h8IQA
         IAkY/Gb9LOEj6BqrrlJ0yCFvRtGFwK5v8fzFnlsDw+R3SULknXi5CsmBoZG+OeAt7BS6
         f3Jm2D+xI/ZCS8fVTWS8eGhaZr4Xpx9bUQWzJS0geg09WZt88jIYOgI5h/XSuVmDVEeG
         WEQqFDjJaWN1MN/MkIyTrxXGemcpQXoTCpTwvl4o/6/22nR5dGpyA/ZYsJZU0BguFwag
         2W2g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=BHjkQDNB;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.76 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=BHjkQDNB;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.76 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w4G2h6cA023234
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-usb@vger.kernel.org, Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: Rob Herring <robh@kernel.org>, Roger Quadros <rogerq@ti.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] usb: dwc3: use local copy of resource to fix-up register offset
Date: Wed, 16 May 2018 11:41:06 +0900
Message-Id: <1526438467-12470-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526438467-12470-1-git-send-email-yamada.masahiro@socionext.com>
References: <1526438467-12470-1-git-send-email-yamada.masahiro@socionext.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600586919229674762?=
X-GMAIL-MSGID: =?utf-8?q?1600586919229674762?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

It is not a good idea to directly modify the resource of a platform
device.  Modify its local copy, and pass it to devm_ioremap_resource()
so that we do not need to restore it in the failure path and the remove
hook.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
---

Changes in v3: None
Changes in v2: None

 drivers/usb/dwc3/core.c | 32 ++++++++------------------------
 1 file changed, 8 insertions(+), 24 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index a15648d..8e66edd 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1245,7 +1245,7 @@ static void dwc3_check_params(struct dwc3 *dwc)
 static int dwc3_probe(struct platform_device *pdev)
 {
 	struct device		*dev = &pdev->dev;
-	struct resource		*res;
+	struct resource		*res, dwc_res;
 	struct dwc3		*dwc;
 
 	int			ret;
@@ -1270,20 +1270,19 @@ static int dwc3_probe(struct platform_device *pdev)
 	dwc->xhci_resources[0].flags = res->flags;
 	dwc->xhci_resources[0].name = res->name;
 
-	res->start += DWC3_GLOBALS_REGS_START;
-
 	/*
 	 * Request memory region but exclude xHCI regs,
 	 * since it will be requested by the xhci-plat driver.
 	 */
-	regs = devm_ioremap_resource(dev, res);
-	if (IS_ERR(regs)) {
-		ret = PTR_ERR(regs);
-		goto err0;
-	}
+	dwc_res = *res;
+	dwc_res.start += DWC3_GLOBALS_REGS_START;
+
+	regs = devm_ioremap_resource(dev, &dwc_res);
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
 
 	dwc->regs	= regs;
-	dwc->regs_size	= resource_size(res);
+	dwc->regs_size	= resource_size(&dwc_res);
 
 	dwc3_get_properties(dwc);
 
@@ -1350,29 +1349,14 @@ static int dwc3_probe(struct platform_device *pdev)
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
-err0:
-	/*
-	 * restore res->start back to its original value so that, in case the
-	 * probe is deferred, we don't end up getting error in request the
-	 * memory region the next time probe is called.
-	 */
-	res->start -= DWC3_GLOBALS_REGS_START;
-
 	return ret;
 }
 
 static int dwc3_remove(struct platform_device *pdev)
 {
 	struct dwc3	*dwc = platform_get_drvdata(pdev);
-	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
 	pm_runtime_get_sync(&pdev->dev);
-	/*
-	 * restore res->start back to its original value so that, in case the
-	 * probe is deferred, we don't end up getting error in request the
-	 * memory region the next time probe is called.
-	 */
-	res->start -= DWC3_GLOBALS_REGS_START;
 
 	dwc3_debugfs_exit(dwc);
 	dwc3_core_exit_mode(dwc);
-- 
2.7.4
