Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtqdxLwKXU3PALUnRtAYTEL2OoyDMYTBtBAVvDsW9a25ZZBVnEvueDdMiIwjvagC8+KEdWj
ARC-Seal: i=1; a=rsa-sha256; t=1521483666; cv=none;
        d=google.com; s=arc-20160816;
        b=S3gSOPBK6tYh3HxI/piJ234Ee5Em6020dZcgaa1d5M7045RsiHmYEtBg6SPDu0gs1o
         DtzVvX4TkWpCOPnemspAK08RnbPIz9nJLx4M8YD1TnHDmFvmi12MGegUJH9kZhs6+Ft8
         bTb8zePC8VKE84aUPNP7wwJWSv3/R185YXRxJdJVe2+BbAJlqnEjeZ2dI4swSK5IFLzY
         A/odZckNRx0vizbaBoze9aFVdDE0Fq/nGPUBoO0lVTJkyqbB1+uxjrPtEZ22DwJgEMO1
         YYYYDsky5X8E4/YN7wGD5F7HAKlaXC5huSteGfTAXfr4uR1JT3PuWBni/0bSsXe20pcl
         qS/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=2OaC4KVkZchYwDzrumpGgf+28qg4gP2LmPwWW1z/HcU=;
        b=LrU2q4zrMzdTCbQ6cBFvZW271Fan2phZ0leu4MlidQGa6L2nDtl2o5Wk4wEI0I+cm/
         1WZAApA0Uy7b3zibhsm6dQSs3+d7IZUNYhYPhFXKtuIAPsZiuxQ9n+2d9SyALEeFfeuw
         5POoXnbUaOFepg557hpyjuk2TmistI0KluVzGc4EGaLyvL8zCofp7BLNxn/T8p+Pyj7W
         uMmX44i0tknoF1LauqPmLrt2rKzLHF1nHR7pvgdBPHw3h52CQmO2m6VCbux4XUjfN7mo
         GqaDnz8GdMooi2CWBwtzBut85Aip7uKESDFGsX5tyM3wBaWfTXE3d8IA+YsgVjQ2VNmF
         KG2g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mahesh Bandewar <maheshb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 073/241] bonding: make speed, duplex setting consistent with link state
Date: Mon, 19 Mar 2018 19:05:38 +0100
Message-Id: <20180319180754.226710212@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391257271759845?=
X-GMAIL-MSGID: =?utf-8?q?1595391257271759845?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mahesh Bandewar <maheshb@google.com>


[ Upstream commit c4adfc822bf5d8e97660b6114b5a8892530ce8cb ]

bond_update_speed_duplex() retrieves speed and duplex settings. There
is a possibility of failure in retrieving these values but caller has
to assume it's always successful. This leads to having inconsistent
slave link settings. If these (speed, duplex) values cannot be
retrieved, then keeping the link UP causes problems.

The updated bond_update_speed_duplex() returns 0 on success if it
retrieves sane values for speed and duplex. On failure it returns 1
and marks the link down.

Signed-off-by: Mahesh Bandewar <maheshb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/bonding/bond_main.c |   24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -371,9 +371,10 @@ down:
 /* Get link speed and duplex from the slave's base driver
  * using ethtool. If for some reason the call fails or the
  * values are invalid, set speed and duplex to -1,
- * and return.
+ * and return. Return 1 if speed or duplex settings are
+ * UNKNOWN; 0 otherwise.
  */
-static void bond_update_speed_duplex(struct slave *slave)
+static int bond_update_speed_duplex(struct slave *slave)
 {
 	struct net_device *slave_dev = slave->dev;
 	struct ethtool_link_ksettings ecmd;
@@ -383,24 +384,27 @@ static void bond_update_speed_duplex(str
 	slave->duplex = DUPLEX_UNKNOWN;
 
 	res = __ethtool_get_link_ksettings(slave_dev, &ecmd);
-	if (res < 0)
-		return;
-
-	if (ecmd.base.speed == 0 || ecmd.base.speed == ((__u32)-1))
-		return;
-
+	if (res < 0) {
+		slave->link = BOND_LINK_DOWN;
+		return 1;
+	}
+	if (ecmd.base.speed == 0 || ecmd.base.speed == ((__u32)-1)) {
+		slave->link = BOND_LINK_DOWN;
+		return 1;
+	}
 	switch (ecmd.base.duplex) {
 	case DUPLEX_FULL:
 	case DUPLEX_HALF:
 		break;
 	default:
-		return;
+		slave->link = BOND_LINK_DOWN;
+		return 1;
 	}
 
 	slave->speed = ecmd.base.speed;
 	slave->duplex = ecmd.base.duplex;
 
-	return;
+	return 0;
 }
 
 const char *bond_slave_link_status(s8 link)
