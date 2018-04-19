Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AIpwx49Pqe84ZKWCRUFLQYtpRcIMU487wa8itKf5sybqIom+jIttlv2VF5P7Wav55t3Sz4RGxlmz
ARC-Seal: i=1; a=rsa-sha256; t=1524135873; cv=none;
        d=google.com; s=arc-20160816;
        b=N3Desb+prggTJOkN4sAUF41Ho4OiQpTVoz6qbaHzkgBJTDE/4To1kzL+IpcFgxzHGY
         gj5jFzBc/lnOmow1dd6qZq3uZiEwf8jRaKYdzgJKtt5F/YZCewZfTXID1dc6PfUUb8Em
         9tJ2YLJkG2oZHVmOyVJLh9FliWxksroQucTxNlmLTbTOAERAqWjFr+8KxHTaAxOIjq+q
         iyCWtjxf2TySbJViQQ0YFoNPQSHJv/zGujKLErRDoBD+hN7E5DS2TSkC8wzuQuCNz7EZ
         bQitCTZwn/KkN1aeWzdL5B2kykBufNPsp6IRhL6okoELKwvIkh5bLWldnmzoBGqJb/88
         +yTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=8yyz1CKJFUbWwpZeex/M/jNOe6F+aRwY8alOpmJMigY=;
        b=QYaDlx1DOwbhVpyNd1d90qH6ZOg5q0Bg94uoR1qkQb6ZXUJsQAyY9ea4+dRG9uFvz2
         6pOhSXHdPhOueUs6R1chWtjFteQ/uyf0beR1kcw67Q0NjDEppgeOZ5U1ZTfQPiwzQWLY
         iz7HWayGsHaDfDXd+9/4CLWVlIuzghiuboqASOXqv/28O635Jm8Rzw22hq3JGIwPmlie
         r/PIPQCjqgwpTAueKpmokMCdszYbW5NHAjxHs6dxg8kX98s7ApXUw6GuHCMZ4YiQD8H/
         GKTpBnw9hu7h15RzXv8CwYZzMvAoD1pED6BSJVSmq/8uAMP4FJFOq1hIrZNKA+EnGY01
         XiRQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=TRkbeQA3;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.78 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=TRkbeQA3;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.78 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com w3JB42ur024223
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
Subject: [PATCH v2 1/2] usb: dwc3: use local copy of resource to fix-up register offset
Date: Thu, 19 Apr 2018 20:03:37 +0900
Message-Id: <1524135818-14825-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524135818-14825-1-git-send-email-yamada.masahiro@socionext.com>
References: <1524135818-14825-1-git-send-email-yamada.masahiro@socionext.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598172297284188306?=
X-GMAIL-MSGID: =?utf-8?q?1598172297284188306?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

It is not a good idea to directly modify the resource of a platform
device.  Modify its local copy, and pass it to devm_ioremap_resource()
so that we do not need to restore it in the failure path and the remove
hook.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
---

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
