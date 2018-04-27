Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpr/XMi+h/z8oELWoICZR57udj4rD6taIhP49/fgAU9fcAowoYH4YXg4+dL2Rmce8AumPKN
ARC-Seal: i=1; a=rsa-sha256; t=1524838023; cv=none;
        d=google.com; s=arc-20160816;
        b=xbG7HMDeg1CIsfQFvYqnBmbxvGTLNemhvNcFA2LmgnZbpni5dx6Ae1n7F6AOBQc/qv
         dpntaa0kCXSObETS+1uZCQgiyk0PUBuPAxS147kLL6MNDRq1EzHdJuEI3WOoxxB6zX/g
         66kYxz9F2itY7VurQQcMBPYlcWALEWKhqaNLgrWAymxeD2TBwsmt088RQOvNvMK3DF5R
         Yh2hVKanpkITK/+zP/09jxtaACqlRCJHu1pXqTosWzWzCDEsVVNkL6aKKR7lzsMcGKIf
         Aca1upiwduMaSqcY6wxsbvUUTdb6qHVYtOgo9aMH2wb5isvqlOrpYWtQs/Sb55lfl6oK
         Mwhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=5aIlWnMvfgjB6Pm61ovgei4dFhliwLn+3L48KDzL0U0=;
        b=lHpat10xkFavr+zR/PiMYC64jrxe8UJdJYVrHAS0HOTgfaY7oWysxUgmtyOMBN3p+Q
         Xp0+7JQ2tfqt5iPn9AFn3h29oMXd413bCHv0QS4yi2ttjwKLQm4gEINBme/jKM8wI7tI
         +MmjBEG1k1gqaHrWe1OcHGBOTUaWDs7KagUxq+XnYBnuqXuKsyAz9p3/NbaQKSnuJ2FB
         JpxNXr2XOYy5wVoa/ZyXrAtneSSzpUCQxWYfHI6rjfrOa1F/hSxeDThsiWy2fZV9CYtt
         //pzCDl1yGvg++MrujGgEFVmRmSqPKKWgBRW3G1emryWPcLZvauxGZ/bqNUezWvZ7PBb
         EZHw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D31321864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 30/80] amd-xgbe: Only use the SFP supported transceiver signals
Date: Fri, 27 Apr 2018 15:58:23 +0200
Message-Id: <20180427135734.517998240@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135732.928644313@linuxfoundation.org>
References: <20180427135732.928644313@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908554692559135?=
X-GMAIL-MSGID: =?utf-8?q?1598908554692559135?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tom Lendacky <thomas.lendacky@amd.com>


[ Upstream commit 117df655f8ed51adb6e6b163812a06ebeae9f453 ]

The SFP eeprom indicates the transceiver signals (Rx LOS, Tx Fault, etc.)
that it supports.  Update the driver to include checking the eeprom data
when deciding whether to use a transceiver signal.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c |   71 +++++++++++++++++++++-------
 1 file changed, 54 insertions(+), 17 deletions(-)

--- a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
@@ -253,6 +253,10 @@ enum xgbe_sfp_speed {
 #define XGBE_SFP_BASE_VENDOR_SN			4
 #define XGBE_SFP_BASE_VENDOR_SN_LEN		16
 
+#define XGBE_SFP_EXTD_OPT1			1
+#define XGBE_SFP_EXTD_OPT1_RX_LOS		BIT(1)
+#define XGBE_SFP_EXTD_OPT1_TX_FAULT		BIT(3)
+
 #define XGBE_SFP_EXTD_DIAG			28
 #define XGBE_SFP_EXTD_DIAG_ADDR_CHANGE		BIT(2)
 
@@ -332,6 +336,7 @@ struct xgbe_phy_data {
 
 	unsigned int sfp_gpio_address;
 	unsigned int sfp_gpio_mask;
+	unsigned int sfp_gpio_inputs;
 	unsigned int sfp_gpio_rx_los;
 	unsigned int sfp_gpio_tx_fault;
 	unsigned int sfp_gpio_mod_absent;
@@ -986,6 +991,49 @@ static void xgbe_phy_sfp_external_phy(st
 	phy_data->sfp_phy_avail = 1;
 }
 
+static bool xgbe_phy_check_sfp_rx_los(struct xgbe_phy_data *phy_data)
+{
+	u8 *sfp_extd = phy_data->sfp_eeprom.extd;
+
+	if (!(sfp_extd[XGBE_SFP_EXTD_OPT1] & XGBE_SFP_EXTD_OPT1_RX_LOS))
+		return false;
+
+	if (phy_data->sfp_gpio_mask & XGBE_GPIO_NO_RX_LOS)
+		return false;
+
+	if (phy_data->sfp_gpio_inputs & (1 << phy_data->sfp_gpio_rx_los))
+		return true;
+
+	return false;
+}
+
+static bool xgbe_phy_check_sfp_tx_fault(struct xgbe_phy_data *phy_data)
+{
+	u8 *sfp_extd = phy_data->sfp_eeprom.extd;
+
+	if (!(sfp_extd[XGBE_SFP_EXTD_OPT1] & XGBE_SFP_EXTD_OPT1_TX_FAULT))
+		return false;
+
+	if (phy_data->sfp_gpio_mask & XGBE_GPIO_NO_TX_FAULT)
+		return false;
+
+	if (phy_data->sfp_gpio_inputs & (1 << phy_data->sfp_gpio_tx_fault))
+		return true;
+
+	return false;
+}
+
+static bool xgbe_phy_check_sfp_mod_absent(struct xgbe_phy_data *phy_data)
+{
+	if (phy_data->sfp_gpio_mask & XGBE_GPIO_NO_MOD_ABSENT)
+		return false;
+
+	if (phy_data->sfp_gpio_inputs & (1 << phy_data->sfp_gpio_mod_absent))
+		return true;
+
+	return false;
+}
+
 static bool xgbe_phy_belfuse_parse_quirks(struct xgbe_prv_data *pdata)
 {
 	struct xgbe_phy_data *phy_data = pdata->phy_data;
@@ -1031,6 +1079,10 @@ static void xgbe_phy_sfp_parse_eeprom(st
 	if (sfp_base[XGBE_SFP_BASE_EXT_ID] != XGBE_SFP_EXT_ID_SFP)
 		return;
 
+	/* Update transceiver signals (eeprom extd/options) */
+	phy_data->sfp_tx_fault = xgbe_phy_check_sfp_tx_fault(phy_data);
+	phy_data->sfp_rx_los = xgbe_phy_check_sfp_rx_los(phy_data);
+
 	if (xgbe_phy_sfp_parse_quirks(pdata))
 		return;
 
@@ -1196,7 +1248,6 @@ put:
 static void xgbe_phy_sfp_signals(struct xgbe_prv_data *pdata)
 {
 	struct xgbe_phy_data *phy_data = pdata->phy_data;
-	unsigned int gpio_input;
 	u8 gpio_reg, gpio_ports[2];
 	int ret;
 
@@ -1211,23 +1262,9 @@ static void xgbe_phy_sfp_signals(struct
 		return;
 	}
 
-	gpio_input = (gpio_ports[1] << 8) | gpio_ports[0];
-
-	if (phy_data->sfp_gpio_mask & XGBE_GPIO_NO_MOD_ABSENT) {
-		/* No GPIO, just assume the module is present for now */
-		phy_data->sfp_mod_absent = 0;
-	} else {
-		if (!(gpio_input & (1 << phy_data->sfp_gpio_mod_absent)))
-			phy_data->sfp_mod_absent = 0;
-	}
-
-	if (!(phy_data->sfp_gpio_mask & XGBE_GPIO_NO_RX_LOS) &&
-	    (gpio_input & (1 << phy_data->sfp_gpio_rx_los)))
-		phy_data->sfp_rx_los = 1;
+	phy_data->sfp_gpio_inputs = (gpio_ports[1] << 8) | gpio_ports[0];
 
-	if (!(phy_data->sfp_gpio_mask & XGBE_GPIO_NO_TX_FAULT) &&
-	    (gpio_input & (1 << phy_data->sfp_gpio_tx_fault)))
-		phy_data->sfp_tx_fault = 1;
+	phy_data->sfp_mod_absent = xgbe_phy_check_sfp_mod_absent(phy_data);
 }
 
 static void xgbe_phy_sfp_mod_absent(struct xgbe_prv_data *pdata)
