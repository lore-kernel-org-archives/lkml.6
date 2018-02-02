Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224pdgNhCPjr2Cu6RQAnhD35pB0uBuxZN7t+wUPGf3PRjk/x00BL6BQLYLgFROor6BhFH0ys
ARC-Seal: i=1; a=rsa-sha256; t=1517591482; cv=none;
        d=google.com; s=arc-20160816;
        b=KESidNZQY0vn/+lb8Zlj+zIT7Sca1bx7i6vmQSWFZrNgdMHtF/jndj8mZkV8GoGXPp
         3khkkBhDN/1ZVqqK9/EHD/PrKt2xrGhJK7ykTztrsAsOKRGnwVO5o9bQTUnIwe+oPeoP
         DygR+5oy5QyOmykmFAwWHdIsCv662UyIfz3XfUQQ04fudyhf4i5zfgT6hEqtEDZ6zsHM
         tzazJqxv9WS9UYHgcS0DIhtN9Zwc2uQ0q+pPi50slNdneT4OFOV/Lff9ssZXYcmVDg/b
         f1yuLl9GrgOvqm4vDatWP0zFQdJ9z5GxT2x9StaQjR9qb3bFQ1idYh/Lt/ufjhkQokw6
         16Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=8nQgz4lLW+fWQ1cPkWllXvvx0he6r5FU2VG0nICTvEM=;
        b=p/CK6ztG48JU6XtzIztfOUlSCkQBsyov4spJdQh6APdEBuoV0AtPSSsLoHJwe4eE9X
         vc/Jqmr+JdSG+HLU61iKGALNp1fyBjWTebM59Lx9EGouPXkMEtRtQzPMl4AnO7S3k9bX
         2zLjN8JFA8lRtLObKFk361RYKGND4IbC7LCBT6UE+/YnHDvgWwmEFcEKT1sx7IGqAkOX
         l0+/gpBHqQqcIqv9VGRp4C8FtrWJzuFSD/9h+/UcaTQHKoVMceU0K5vSupIdsITG8BI3
         zdak1vMPvI12vy/RYh5CaLhHJEq3yrPqyd7+cJNVfmYja67t95tmBCMBpV8GZHEzLAvF
         9cSg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Yan Markman <ymarkman@marvell.com>,
	Antoine Tenart <antoine.tenart@free-electrons.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 094/156] net: phy: marvell10g: fix the PHY id mask
Date: Fri,  2 Feb 2018 17:57:55 +0100
Message-Id: <20180202140844.492751137@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591310006210895065?=
X-GMAIL-MSGID: =?utf-8?q?1591310006210895065?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Antoine Tenart <antoine.tenart@free-electrons.com>


[ Upstream commit 952b6b3b07877419386e719ff20917170e1ce684 ]

The Marvell 10G PHY driver supports different hardware revisions, which
have their bits 3..0 differing. To get the correct revision number these
bits should be ignored. This patch fixes this by using the already
defined MARVELL_PHY_ID_MASK (0xfffffff0) instead of the custom
0xffffffff mask.

Fixes: 20b2af32ff3f ("net: phy: add Marvell Alaska X 88X3310 10Gigabit PHY support")
Suggested-by: Yan Markman <ymarkman@marvell.com>
Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/marvell10g.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/net/phy/marvell10g.c
+++ b/drivers/net/phy/marvell10g.c
@@ -16,6 +16,7 @@
  * link takes priority and the other port is completely locked out.
  */
 #include <linux/phy.h>
+#include <linux/marvell_phy.h>
 
 enum {
 	MV_PCS_BASE_T		= 0x0000,
@@ -338,7 +339,7 @@ static int mv3310_read_status(struct phy
 static struct phy_driver mv3310_drivers[] = {
 	{
 		.phy_id		= 0x002b09aa,
-		.phy_id_mask	= 0xffffffff,
+		.phy_id_mask	= MARVELL_PHY_ID_MASK,
 		.name		= "mv88x3310",
 		.features	= SUPPORTED_10baseT_Full |
 				  SUPPORTED_100baseT_Full |
@@ -360,7 +361,7 @@ static struct phy_driver mv3310_drivers[
 module_phy_driver(mv3310_drivers);
 
 static struct mdio_device_id __maybe_unused mv3310_tbl[] = {
-	{ 0x002b09aa, 0xffffffff },
+	{ 0x002b09aa, MARVELL_PHY_ID_MASK },
 	{ },
 };
 MODULE_DEVICE_TABLE(mdio, mv3310_tbl);
