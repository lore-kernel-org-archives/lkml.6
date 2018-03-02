Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtVGzwT6MiaB+mEA+/2Gs06Nwfr7Pe4Wncd13kRRY5Saw5PKS5nQkDJjtIqaQszZGK292Lc
ARC-Seal: i=1; a=rsa-sha256; t=1519981020; cv=none;
        d=google.com; s=arc-20160816;
        b=EBu2dg/8zEMClwu/azPGFNDmBDUbdal5UZmoSfS/j1TgeiMHrYJ0rJfWgQXRd4/rvp
         orOhCGXlsu3E6wRtfxlOnXn5h+VxnTzDFvGykcPxEB52LlzmV3RkC94SFDhWXyTeLSaR
         F2s88WRqcE++d7i2ZW1acdEnXZoh0+fDZzm5EQsMG987AOU7DXdmcF5zih4LNnC9o8ot
         +dXH2qFnpV6hYfoh7MP+q+rpqAZkMGQ485NTzqlasIT5+m8ZgYu7qS9TYHThx4K7N2+9
         BtBbndTpi1YQuNaDJ7jD9/gNKsg11l092hzeMIUd4M08DTo+I66EHNijmRENaK3XpWQx
         9uTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Bhvb0OYB0moPUXaYSduaHKfWNeeoxVOtuzQPeeaCRT0=;
        b=JINAbxqZDwUIjnxzjdmtaAcGVNGgQMOyd7wgdqD+dKN9mG9PdouBu4bEEsSdB2cTf3
         2SMdzsh8I9kPtF1lCk9oxlcm4tCdwClyBpRM1SD+Z0xin+r+sA68Z6vyXt+xFLf6F1Xc
         DONPYMubuOQrcM/A9YuvFtHhmfX/VwLfYSiqzdPblSLNxj8KeF2PuaZeKsSwazzZmMeY
         n8rqW07l9gA1CK6EcOK2fYVbJ8BPhjcII3wdkC2kdygDi7/Nj5sh61mboaqxE9UWbKwf
         Ypk8mbYVzqV8va9XT9Leb6kj+nZe/Nl02X5r3Am6UAn42LtFDD/my6OVgIIhHB9h8p5D
         UNvg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Siva Reddy Kallam <siva.kallam@broadcom.com>,
	Michael Chan <michael.chan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 27/56] tg3: Add workaround to restrict 5762 MRRS to 2048
Date: Fri,  2 Mar 2018 09:51:13 +0100
Message-Id: <20180302084450.957168665@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084449.568562222@linuxfoundation.org>
References: <20180302084449.568562222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815433008003046?=
X-GMAIL-MSGID: =?utf-8?q?1593815619128842560?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Siva Reddy Kallam <siva.kallam@broadcom.com>


[ Upstream commit 4419bb1cedcda0272e1dc410345c5a1d1da0e367 ]

One of AMD based server with 5762 hangs with jumbo frame traffic.
This AMD platform has southbridge limitation which is restricting MRRS
to 4000. As a work around, driver to restricts the MRRS to 2048 for
this particular 5762 NX1 card.

Signed-off-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/tg3.c |   10 ++++++++++
 drivers/net/ethernet/broadcom/tg3.h |    4 ++++
 2 files changed, 14 insertions(+)

--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -10049,6 +10049,16 @@ static int tg3_reset_hw(struct tg3 *tp,
 
 	tw32(GRC_MODE, tp->grc_mode | val);
 
+	/* On one of the AMD platform, MRRS is restricted to 4000 because of
+	 * south bridge limitation. As a workaround, Driver is setting MRRS
+	 * to 2048 instead of default 4096.
+	 */
+	if (tp->pdev->subsystem_vendor == PCI_VENDOR_ID_DELL &&
+	    tp->pdev->subsystem_device == TG3PCI_SUBDEVICE_ID_DELL_5762) {
+		val = tr32(TG3PCI_DEV_STATUS_CTRL) & ~MAX_READ_REQ_MASK;
+		tw32(TG3PCI_DEV_STATUS_CTRL, val | MAX_READ_REQ_SIZE_2048);
+	}
+
 	/* Setup the timer prescalar register.  Clock is always 66Mhz. */
 	val = tr32(GRC_MISC_CFG);
 	val &= ~0xff;
--- a/drivers/net/ethernet/broadcom/tg3.h
+++ b/drivers/net/ethernet/broadcom/tg3.h
@@ -95,6 +95,7 @@
 #define TG3PCI_SUBDEVICE_ID_DELL_JAGUAR		0x0106
 #define TG3PCI_SUBDEVICE_ID_DELL_MERLOT		0x0109
 #define TG3PCI_SUBDEVICE_ID_DELL_SLIM_MERLOT	0x010a
+#define TG3PCI_SUBDEVICE_ID_DELL_5762		0x07f0
 #define TG3PCI_SUBVENDOR_ID_COMPAQ		PCI_VENDOR_ID_COMPAQ
 #define TG3PCI_SUBDEVICE_ID_COMPAQ_BANSHEE	0x007c
 #define TG3PCI_SUBDEVICE_ID_COMPAQ_BANSHEE_2	0x009a
@@ -280,6 +281,9 @@
 #define TG3PCI_STD_RING_PROD_IDX	0x00000098 /* 64-bit */
 #define TG3PCI_RCV_RET_RING_CON_IDX	0x000000a0 /* 64-bit */
 /* 0xa8 --> 0xb8 unused */
+#define TG3PCI_DEV_STATUS_CTRL		0x000000b4
+#define  MAX_READ_REQ_SIZE_2048		 0x00004000
+#define  MAX_READ_REQ_MASK		 0x00007000
 #define TG3PCI_DUAL_MAC_CTRL		0x000000b8
 #define  DUAL_MAC_CTRL_CH_MASK		 0x00000003
 #define  DUAL_MAC_CTRL_ID		 0x00000004
