Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967136AbeEYQGp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 12:06:45 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:48803 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966464AbeEYQGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 12:06:42 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Manu Gautam <mgautam@codeaurora.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: dwc3: qcom: mark PM functions as __maybe_unused
Date: Fri, 25 May 2018 18:06:20 +0200
Message-Id: <20180525160632.66726-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:dWCl/jVjfXoDioTJ0zVZ8uKRUMIFoh5Uw4m9c02wt4Pe7bPGLd8
 3oUNsF2GavlwjiDl5sFyPrLdIgVuKDqB8yeFgVucrIpQQdI2M0C8/Dw+1O4lLoqVL54vd90
 Dvbs2JZ1E5T4qPY6bbgPLf+q7Jo3ggnNZ2FG2UBdnqx9MHI8u36xyKWOnDkam6BsLBh7rp9
 JiN5zm5cKzyxM+YSJcr6w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9lKe1XE0r9U=:dwhuR7Hmyt5P5VQfrqSGat
 5RH9+JCQOlOZZYcQcRtiSJv2fh1wiOsGtNfG5sKsw3zSKE8MdRaArha4teLvhMPL7SX1XBqma
 cb2LXAgFOpwPn3LX6CeCxUhfaxIaj+4+WtQsiYd4ikz5dG4FM6z+Ta2YyCwTJk5H5o90W+Y0B
 O0tG9yw8Vp6G0V1JQJzNG9cqysyrFwGuyBLy78DEbi2mvlQAlWIq/Tj0tRMzm9c+y1v5h0wAm
 VGY5nFDhjuJiLOsE+lKLUaVMLUCpULTwouDltAYSp+ggqWFZxGJ4r9n7uKWIoqmcwIGSt9NhA
 z9ByvUwBu2IFUoAzV1JGtEO8XMnKc3Zq/eQj3i5NN9NfsG7ot4MX/cyZIJ2HnAxtzxRMJ2/Hc
 /3UEzXmU73qVvZMNyk2qPZdZEo+ERreUych7hFHZe6l06/Z0UJ5QbjqL9deSPHDbVX2dky5PA
 H/+M6JsYEIcHeQrWyb1/ZlnDWSEIEPoK8fUnCBV5dfgYHoI4EEp/wZhsHIPwSeNRz5mFD51ap
 49vlMzR+HyngaqhdRuA7YhUENoENbL8fXu/X8D3Els95hJ+/nBmz28jiGzrUaWS0dYhUeNfvY
 /mFoccSelZAsl6y8iEcuo9NIHzWqFJ20UYLHHicZNMiZ3dCElgtxm30enE06MSOVM2YU0a8k5
 qL1yrdjhXEskg5YruKEuQ5DGldfO8AwnwXq/MQib6nUq3HSoenwlTIucsjNrJFUBVj5s=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The #ifdef guards around these are wrong, resulting in warnings
in certain configurations:

drivers/usb/dwc3/dwc3-qcom.c:244:12: error: 'dwc3_qcom_resume' defined but not used [-Werror=unused-function]
 static int dwc3_qcom_resume(struct dwc3_qcom *qcom)
            ^~~~~~~~~~~~~~~~
drivers/usb/dwc3/dwc3-qcom.c:223:12: error: 'dwc3_qcom_suspend' defined but not used [-Werror=unused-function]
 static int dwc3_qcom_suspend(struct dwc3_qcom *qcom)

This replaces the guards with __maybe_unused annotations to shut up
the warnings and give better compile time coverage.

Fixes: a4333c3a6ba9 ("usb: dwc3: Add Qualcomm DWC3 glue driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/dwc3/dwc3-qcom.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 8abb6f31389d..d7a4728b48d5 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -548,8 +548,7 @@ static int dwc3_qcom_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int dwc3_qcom_pm_suspend(struct device *dev)
+static int __maybe_unused dwc3_qcom_pm_suspend(struct device *dev)
 {
 	struct dwc3_qcom *qcom = dev_get_drvdata(dev);
 	int ret = 0;
@@ -561,7 +560,7 @@ static int dwc3_qcom_pm_suspend(struct device *dev)
 	return ret;
 }
 
-static int dwc3_qcom_pm_resume(struct device *dev)
+static int __maybe_unused dwc3_qcom_pm_resume(struct device *dev)
 {
 	struct dwc3_qcom *qcom = dev_get_drvdata(dev);
 	int ret;
@@ -572,23 +571,20 @@ static int dwc3_qcom_pm_resume(struct device *dev)
 
 	return ret;
 }
-#endif
 
-#ifdef CONFIG_PM
-static int dwc3_qcom_runtime_suspend(struct device *dev)
+static int __maybe_unused dwc3_qcom_runtime_suspend(struct device *dev)
 {
 	struct dwc3_qcom *qcom = dev_get_drvdata(dev);
 
 	return dwc3_qcom_suspend(qcom);
 }
 
-static int dwc3_qcom_runtime_resume(struct device *dev)
+static int __maybe_unused dwc3_qcom_runtime_resume(struct device *dev)
 {
 	struct dwc3_qcom *qcom = dev_get_drvdata(dev);
 
 	return dwc3_qcom_resume(qcom);
 }
-#endif
 
 static const struct dev_pm_ops dwc3_qcom_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(dwc3_qcom_pm_suspend, dwc3_qcom_pm_resume)
-- 
2.9.0
