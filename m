Return-Path: <gustavo@embeddedor.com>
X-Google-Smtp-Source: AB8JxZpn7PquQwCTnHxpPyRjOufSKACRTd9UCyMmkrLKlV/ZUidwvWV5RLVnCUzRxvhXtV+FA62S
ARC-Seal: i=1; a=rsa-sha256; t=1526509325; cv=none;
        d=google.com; s=arc-20160816;
        b=h06SZPYlxFXOa4cLAyHbUIBi7Y5ms0YFnT0bJ20SJ5PK0Xj9yPUlBy6BU5TEG3SiwQ
         ARPtllvA2/0ptGXq4eXHIm+uZin6NmzS+Kg83yZQg2mwK6dNoj31UiUeEU29OwqnSLtM
         21RB+7QQg9XCflG+cV5iz5ak0JfmZ6xT+JkcolarQ62WZ52h6PWwemWmwzdvz+7bN1pb
         mr4sQsVIPQdgo97D1Q0AI65LtkegM9adp9urQvMN+ifn6E9pfIUdcUDyPzIM+Lift6ji
         doFlyrvt1DGY//DP9mCJq9ARXkTcocwB266bYNgXOFNmhTj9dMN+Zw65sN8S71e57YK3
         JKVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=dGVyWIsurq/MYBdqSBQOcww5+DZRaDUbCz5UURzeeus=;
        b=Ho/skuhEI5ak6MfgKAPDTNStvh+u/hXp3Fp/Qq97rxfEtQIMDZ1cOGjPxPCbRezj+k
         /Fsr4742FWQnMWCEf6wh3PCby+rk4OYI4F8oLJmBQ/MpQ8DenDd0VAwgfbmd38sUnqyb
         ew4fFd2Pu76XVaDMnmYE3ra5U7QcV3dsKx2E6PFdLPxumwiI0gP9/nXJk4MFZkNQXnDf
         xtSb8CAUKMRGjoCj7zfC7glPCLNa/m8Y0FQWNaSpoaOZSoPDUlcr6CfPvxsxeqBHmQub
         cxQkTKukVD6LtpSZbNRfNTqe29XqL/K9cspdUOh7hngPyzDfWUWoJU7fsAyAOfmrCtB3
         qS+Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of gustavo@embeddedor.com designates 192.185.149.105 as permitted sender) smtp.mailfrom=gustavo@embeddedor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of gustavo@embeddedor.com designates 192.185.149.105 as permitted sender) smtp.mailfrom=gustavo@embeddedor.com
X-Authority-Reason: nr=8
Date: Wed, 16 May 2018 17:22:00 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Valentina Manea <valentina.manea.m@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] usbip: vhci_sysfs: fix potential Spectre v1
Message-ID: <20180516222200.GA14733@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - linuxfoundation.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.172.56.86
X-Source-L: No
X-Exim-ID: 1fJ4o5-00112M-4u
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.172.56.86]:50382
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600661041859915107?=
X-GMAIL-MSGID: =?utf-8?q?1600661041859915107?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

pdev_nr and rhport can be controlled by user-space, hence leading to
a potential exploitation of the Spectre variant 1 vulnerability.

This issue was detected with the help of Smatch:
drivers/usb/usbip/vhci_sysfs.c:238 detach_store() warn: potential
spectre issue 'vhcis'
drivers/usb/usbip/vhci_sysfs.c:328 attach_store() warn: potential
spectre issue 'vhcis'
drivers/usb/usbip/vhci_sysfs.c:338 attach_store() warn: potential
spectre issue 'vhci->vhci_hcd_ss->vdev'
drivers/usb/usbip/vhci_sysfs.c:340 attach_store() warn: potential
spectre issue 'vhci->vhci_hcd_hs->vdev'

Fix this by sanitizing pdev_nr and rhport before using them to index
vhcis and vhci->vhci_hcd_ss->vdev respectively.

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/usb/usbip/vhci_sysfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/usbip/vhci_sysfs.c b/drivers/usb/usbip/vhci_sysfs.c
index 4880838..9045888 100644
--- a/drivers/usb/usbip/vhci_sysfs.c
+++ b/drivers/usb/usbip/vhci_sysfs.c
@@ -10,6 +10,8 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
+#include <linux/nospec.h>
+
 #include "usbip_common.h"
 #include "vhci.h"
 
@@ -235,6 +237,8 @@ static ssize_t detach_store(struct device *dev, struct device_attribute *attr,
 	if (!valid_port(pdev_nr, rhport))
 		return -EINVAL;
 
+	pdev_nr = array_index_nospec(pdev_nr, vhci_num_controllers);
+	rhport = array_index_nospec(rhport, VHCI_HC_PORTS);
 	hcd = platform_get_drvdata(vhcis[pdev_nr].pdev);
 	if (hcd == NULL) {
 		dev_err(dev, "port is not ready %u\n", port);
@@ -325,6 +329,8 @@ static ssize_t attach_store(struct device *dev, struct device_attribute *attr,
 	if (!valid_args(pdev_nr, rhport, speed))
 		return -EINVAL;
 
+	pdev_nr = array_index_nospec(pdev_nr, vhci_num_controllers);
+	rhport = array_index_nospec(rhport, VHCI_HC_PORTS);
 	hcd = platform_get_drvdata(vhcis[pdev_nr].pdev);
 	if (hcd == NULL) {
 		dev_err(dev, "port %d is not ready\n", port);
-- 
2.7.4
