Return-Path: <gustavo@embeddedor.com>
X-Google-Smtp-Source: AB8JxZrrb5dfeMX+ZXJy3+Uc3UFbws2wVYILYZOqyo1OucjZLufrr++oKbGq4SH4BKFDzvaHbJR+
ARC-Seal: i=1; a=rsa-sha256; t=1526692424; cv=none;
        d=google.com; s=arc-20160816;
        b=lLGyhBGOB0OQg5nw6fEzTLQqJlxRrLQ9T9ZUY6GNtJEG0tbVMk3PNhQtmorNTUye/K
         QY7L29wLXeoQjef4/5PvzkvJberYLxOBabP4teZi3xIZuuBFG8QbSsAgiPog/x6jlnyP
         GpTmKRNzHppX3IBA4rooJ/0nKbLagcXJ7LeaNqcu4+5bLvs/L5nfRGkPxIrV6P1Wcdoz
         PuNHoNKT/R0b52FXvX28xDu+cOa9oZNCb58pQBBVvdA2MnCRO5y3siCUSLJQ+YWbj1q5
         8Avt0w3k2HMZEVEbKvy+b9wEeHujeFz3fcttatOqGEpgYzo4+9YnHPAruv3Hk2ty5cHh
         jSrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=E/7g7F7Ohbb25kUjdEVKb8HsivEL3/Nqbnpsq/G3BXE=;
        b=BmL3Tt4jTdXqWMNgeUODn2CQqMI0k4hVpK9o9mg92E9JvUTrz/xomFinLhLBhUAc4x
         ntQUXD+59lcf9G1YDCr9AovskyuuMYSCRQEb4ALVqOkt38yg01DgeOrorPlK465YZe1o
         n2HHVO8DPp+07ONIeYM7PpQc0wpn9mzZzUvpyAaH7VFKRyzgEl0u8CVnUGvUTaJ0eWbT
         06jBw/L+24zIrd8z1VwAvKDMDLQDOzmGGOd3pCp1Gtlz6x4/X7lu3wiMjcxkjldL3wYN
         HzegGKAKZuGuSNCWgTeJmXaSoTY4Ze1UERp31Wym5ZaZk0S2Qbljq56ztvWIoBlKG59u
         TKYw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of gustavo@embeddedor.com designates 192.185.145.1 as permitted sender) smtp.mailfrom=gustavo@embeddedor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of gustavo@embeddedor.com designates 192.185.145.1 as permitted sender) smtp.mailfrom=gustavo@embeddedor.com
X-Authority-Reason: nr=8
Date: Fri, 18 May 2018 20:13:42 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Valentina Manea <valentina.manea.m@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH v3] usbip: vhci_sysfs: fix potential Spectre v1
Message-ID: <20180519011342.GA13962@embeddedgus>
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
X-Exim-ID: 1fJqRL-004N6K-La
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedgus) [187.172.56.86]:58738
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600661041859915107?=
X-GMAIL-MSGID: =?utf-8?q?1600853035470472362?=
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
Acked-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
---
Changes in v3:
 - Pass the addresses of pdev_nr and rhport into valid_port and
   valid_args.

Changes in v2:
 - Place the barriers into valid_port.

 drivers/usb/usbip/vhci_sysfs.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/usbip/vhci_sysfs.c b/drivers/usb/usbip/vhci_sysfs.c
index 4880838..be37aec 100644
--- a/drivers/usb/usbip/vhci_sysfs.c
+++ b/drivers/usb/usbip/vhci_sysfs.c
@@ -10,6 +10,9 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
+/* Hardening for Spectre-v1 */
+#include <linux/nospec.h>
+
 #include "usbip_common.h"
 #include "vhci.h"
 
@@ -205,16 +208,20 @@ static int vhci_port_disconnect(struct vhci_hcd *vhci_hcd, __u32 rhport)
 	return 0;
 }
 
-static int valid_port(__u32 pdev_nr, __u32 rhport)
+static int valid_port(__u32 *pdev_nr, __u32 *rhport)
 {
-	if (pdev_nr >= vhci_num_controllers) {
-		pr_err("pdev %u\n", pdev_nr);
+	if (*pdev_nr >= vhci_num_controllers) {
+		pr_err("pdev %u\n", *pdev_nr);
 		return 0;
 	}
-	if (rhport >= VHCI_HC_PORTS) {
-		pr_err("rhport %u\n", rhport);
+	*pdev_nr = array_index_nospec(*pdev_nr, vhci_num_controllers);
+
+	if (*rhport >= VHCI_HC_PORTS) {
+		pr_err("rhport %u\n", *rhport);
 		return 0;
 	}
+	*rhport = array_index_nospec(*rhport, VHCI_HC_PORTS);
+
 	return 1;
 }
 
@@ -232,7 +239,7 @@ static ssize_t detach_store(struct device *dev, struct device_attribute *attr,
 	pdev_nr = port_to_pdev_nr(port);
 	rhport = port_to_rhport(port);
 
-	if (!valid_port(pdev_nr, rhport))
+	if (!valid_port(&pdev_nr, &rhport))
 		return -EINVAL;
 
 	hcd = platform_get_drvdata(vhcis[pdev_nr].pdev);
@@ -258,7 +265,8 @@ static ssize_t detach_store(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_WO(detach);
 
-static int valid_args(__u32 pdev_nr, __u32 rhport, enum usb_device_speed speed)
+static int valid_args(__u32 *pdev_nr, __u32 *rhport,
+		      enum usb_device_speed speed)
 {
 	if (!valid_port(pdev_nr, rhport)) {
 		return 0;
@@ -322,7 +330,7 @@ static ssize_t attach_store(struct device *dev, struct device_attribute *attr,
 			     sockfd, devid, speed);
 
 	/* check received parameters */
-	if (!valid_args(pdev_nr, rhport, speed))
+	if (!valid_args(&pdev_nr, &rhport, speed))
 		return -EINVAL;
 
 	hcd = platform_get_drvdata(vhcis[pdev_nr].pdev);
-- 
2.7.4
