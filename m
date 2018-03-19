Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELszxi6Y21H28nKKF6BLIi2T4dZEEK3/rbTdf78ECFUt7+eQoqY0z7S4Hwx8aag+enbKsn8D
ARC-Seal: i=1; a=rsa-sha256; t=1521483568; cv=none;
        d=google.com; s=arc-20160816;
        b=H4MGdhvGgJD8d+bjX4GbJxOJrJrW9ujdmYV4CcPX2QfSo5on2kPLMtnUIBOzbkSdoA
         JEleU0MC6EURG7fp3FYREkxtLSwep1BW+jhL6eJaJWIxVOD8IlA5ZTxceEFD7UiSjkpW
         87/NWrrq2hJx7kJgDd/yCnGJFjEEp62qIKrYPMCSC3R3y4dsMm0wSypEKkBWssukESzD
         /DrSbhn+teblk36pmNrF+yJNI6FEg0F+2G65mJFro0QhXSuJWiG400O10RFtlXZmy0kP
         L9/XL5Naye3CHHctW6Nk3X1kah+I2JWSDlCKJzgqsyy3GhxRzCZ/us9ZJXIH2GC/50me
         Y8Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=zngn5PEDMBwMFwV8lN5+l9qVqM994fmJ8WahoXuh8Mg=;
        b=shlygvHwxVvzpHWeNgtwwL7DNre+XrhFcBjDDTUeYSn2v+T1+d/wlvnmCGCgBKhtsu
         tuuV1qmZ4tU+whXLGAz4v5zFWNLl8gfTCrnlTK6op95GB/HjBkZJWgDFNHSuw0Nnofco
         hQDsrHSEJxRNMJvp4CRUNeNCLwbI6uc0V64wr2YZU0WR11sfJ0eERqKBTui/KgZIDx9R
         N6iSnK5X6CVBZ++RQzhxFYF50WvUSsA39ggzFB6uQ8qc/Fxg9W1SoCAiR8Ag6C5HkiyP
         UmI1AvVm+o6y03m7hwhkqolcvGkRrqXuo3+WqMfPKT5p3iA6mopr18SBJJ6b9RbVjFFD
         BQ/A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Steve Lin <steven.lin1@broadcom.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jon Mason <jon.mason@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 037/241] net: ethernet: bgmac: Allow MAC address to be specified in DTB
Date: Mon, 19 Mar 2018 19:05:02 +0100
Message-Id: <20180319180752.730334921@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391153940551541?=
X-GMAIL-MSGID: =?utf-8?q?1595391153940551541?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steve Lin <steven.lin1@broadcom.com>


[ Upstream commit 2f771399a3a2c371c140ff33544a583c6fbc5fd9 ]

Allows the BCMA version of the bgmac driver to obtain MAC address
from the device tree.  If no MAC address is specified there, then
the previous behavior (obtaining MAC address from SPROM) is
used.

Signed-off-by: Steve Lin <steven.lin1@broadcom.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Acked-by: Jon Mason <jon.mason@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bgmac-bcma.c |   39 +++++++++++++++++------------
 1 file changed, 23 insertions(+), 16 deletions(-)

--- a/drivers/net/ethernet/broadcom/bgmac-bcma.c
+++ b/drivers/net/ethernet/broadcom/bgmac-bcma.c
@@ -11,6 +11,7 @@
 #include <linux/bcma/bcma.h>
 #include <linux/brcmphy.h>
 #include <linux/etherdevice.h>
+#include <linux/of_net.h>
 #include "bgmac.h"
 
 static inline bool bgmac_is_bcm4707_family(struct bcma_device *core)
@@ -96,7 +97,7 @@ static int bgmac_probe(struct bcma_devic
 	struct ssb_sprom *sprom = &core->bus->sprom;
 	struct mii_bus *mii_bus;
 	struct bgmac *bgmac;
-	u8 *mac;
+	const u8 *mac = NULL;
 	int err;
 
 	bgmac = kzalloc(sizeof(*bgmac), GFP_KERNEL);
@@ -110,21 +111,27 @@ static int bgmac_probe(struct bcma_devic
 
 	bcma_set_drvdata(core, bgmac);
 
-	switch (core->core_unit) {
-	case 0:
-		mac = sprom->et0mac;
-		break;
-	case 1:
-		mac = sprom->et1mac;
-		break;
-	case 2:
-		mac = sprom->et2mac;
-		break;
-	default:
-		dev_err(bgmac->dev, "Unsupported core_unit %d\n",
-			core->core_unit);
-		err = -ENOTSUPP;
-		goto err;
+	if (bgmac->dev->of_node)
+		mac = of_get_mac_address(bgmac->dev->of_node);
+
+	/* If no MAC address assigned via device tree, check SPROM */
+	if (!mac) {
+		switch (core->core_unit) {
+		case 0:
+			mac = sprom->et0mac;
+			break;
+		case 1:
+			mac = sprom->et1mac;
+			break;
+		case 2:
+			mac = sprom->et2mac;
+			break;
+		default:
+			dev_err(bgmac->dev, "Unsupported core_unit %d\n",
+				core->core_unit);
+			err = -ENOTSUPP;
+			goto err;
+		}
 	}
 
 	ether_addr_copy(bgmac->mac_addr, mac);
