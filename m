Return-Path: <gustavo@embeddedor.com>
X-Google-Smtp-Source: AB8JxZqQUT5IyRoSkIZ0yMTFMfIJBdzhTv+uKqiYu+O2toAwiituSMeu+1GMlcYfjrtKZq/vZkld
ARC-Seal: i=1; a=rsa-sha256; t=1526588190; cv=none;
        d=google.com; s=arc-20160816;
        b=yDvzewUASEVz2KI3yAHK1UiFel3XLdjLNLqN6cZ5ppk2QvmrA6ncpmKQPsPq94zbQ6
         4agH/7v7g6xvA60+mtdtGgV5icPhlzfe3SztMrE0j/tVmfHRxzlqSh/r3/MAWmQ+hMmB
         BOzmpbgvcIegaPX9NbHFimCbgIG4u3JKqoIptEgJ5HE48RgHD2dXqWpVTK5pIu4fp5VC
         RLkzr9j2YhIGVYRjmc7ektYFWZRED6nyCgdiDQaDl7n/s2Evmxv82a3nZObVqup/xz9o
         v+RfaYUUOThN6zSk5jbZEAFHFZkujo+JCdBTdrbr+mKqew+aFY17klaA6dLMZBN8E545
         e3sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=iGxrz26UH2sknN+MHX+8+T+TEKegGmdFzWACNE2TbJQ=;
        b=ny+WQLYd6Oq+VnbehbclBuEUT1U76u1uZ9eW2s3GaCwnYGuCrxuhQsVufuNfY8o4sg
         CEYRIfItoVmsHmqcXQ18osWS1HdbsqKvs6EQBHTYm9gC0Of4HgX9lPenZ/ZOqsGdnm3/
         DCN47cOHXHQK7HgCTSO77kBuh87rvNq+J/S5yDYU6jnX7SaJbEL9dOSrciJ66lRr/O6B
         f4mxmxLAj0VYeACtPqQe3LToWcRlWbyLrjMSBh2aLYsJk0CuwgFmByHTpvaaojS6BjVn
         CXcFA64nIOBF9wWd5JPHBclFSLuWZBCCEBWYNgc03eTCoGdIrvn/JsBy4JAvM7retAQL
         /cYQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of gustavo@embeddedor.com designates 192.185.58.11 as permitted sender) smtp.mailfrom=gustavo@embeddedor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of gustavo@embeddedor.com designates 192.185.58.11 as permitted sender) smtp.mailfrom=gustavo@embeddedor.com
X-Authority-Reason: nr=8
Date: Thu, 17 May 2018 15:16:28 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Valentina Manea <valentina.manea.m@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH v2] usbip: vhci_sysfs: fix potential Spectre v1
Message-ID: <20180517201628.GA6090@embeddedor.com>
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
X-Source-IP: 201.172.20.167
X-Source-L: No
X-Exim-ID: 1fJPK9-0011mL-8i
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: cablelink20-167.telefonia.intercable.net (embeddedor) [201.172.20.167]:57166
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600661041859915107?=
X-GMAIL-MSGID: =?utf-8?q?1600743737752816906?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

pdev_nr and rhport can be controlled by user-space, hence leading to
a potential exploitation of the Spectre variant 1 vulnerability.

This issue was detected with the help of Smatch:
drivers/usb/usbip/vhci_sysfs.c:238 detach_store() warn: potential spectre issue 'vhcis'
drivers/usb/usbip/vhci_sysfs.c:328 attach_store() warn: potential spectre issue 'vhcis'
drivers/usb/usbip/vhci_sysfs.c:338 attach_store() warn: potential spectre issue 'vhci->vhci_hcd_ss->vdev'
drivers/usb/usbip/vhci_sysfs.c:340 attach_store() warn: potential spectre issue 'vhci->vhci_hcd_hs->vdev'

Fix this by sanitizing pdev_nr and rhport before using them to index
vhcis and vhci->vhci_hcd_ss->vdev respectively.

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
Changes in v2:
 - Place the barriers into valid_port.

 drivers/usb/usbip/vhci_sysfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/usbip/vhci_sysfs.c b/drivers/usb/usbip/vhci_sysfs.c
index 4880838..69db0c9 100644
--- a/drivers/usb/usbip/vhci_sysfs.c
+++ b/drivers/usb/usbip/vhci_sysfs.c
@@ -10,6 +10,8 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
+#include <linux/nospec.h>
+
 #include "usbip_common.h"
 #include "vhci.h"
 
@@ -211,10 +213,14 @@ static int valid_port(__u32 pdev_nr, __u32 rhport)
 		pr_err("pdev %u\n", pdev_nr);
 		return 0;
 	}
+	pdev_nr = array_index_nospec(pdev_nr, vhci_num_controllers);
+
 	if (rhport >= VHCI_HC_PORTS) {
 		pr_err("rhport %u\n", rhport);
 		return 0;
 	}
+	rhport = array_index_nospec(rhport, VHCI_HC_PORTS);
+
 	return 1;
 }
 
-- 
2.7.4
