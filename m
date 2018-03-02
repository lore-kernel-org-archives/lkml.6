Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt45JV8DqB758bG+MueI6gt28hjDLq2ykFetv8hmGWbdbnwe4vjOybAGW+Qca5XzdKnRkv4
ARC-Seal: i=1; a=rsa-sha256; t=1519981328; cv=none;
        d=google.com; s=arc-20160816;
        b=kifVQ+WtndOMDWSIiB67R9PVUa8b1g3u+obTd2GwQ9KsTChBeH5fx3VDsAaw48fXPe
         23XaOOyaHAF/+0aTpoG5epTP7VGECqLTt848YqWtQ1CpRsSmVy5DhnlW3pk0DDl4Z7BZ
         ax96pOsjb94Vc38BfI5pEvCkEthIgqMMSUFZXH3jKSkD4d/AqMnL2Z6KneACeEWSsr0p
         6ooup5X9vY3P6ZOr+UBYYNqNOp5YwC1MSQ4mnIsS8Ppd7dtNVz2FUodcNa2p9Fn/HNRh
         RsbanoivNa4cl/0JBIj70XbbdVIlA6Z20tlSRtm+nZZ71fli83H/jQU050iM+cTiRaMG
         NdNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=tcfTeCUIqliN9wURORT76o6IQ9Q1LgOpBecaN932tcg=;
        b=Bgfotoxg9RfoFEOV+WatRLVZZlERHpH5EfLDZwzWYr5QFiC0DGIbKXc8QEJ+I3psz/
         3bCckq4qTqyy1In3qrf2WR+U7QuNaDLfdyuOA2w5iIHBcOt2ufBPJEAy2B8O2R1/KJMl
         df4TnzbkMZiF0euppA/7o0yRGldjINCBr8psCiwMIdAjk+TbPFp7H0HA9kXhwZnaKo8g
         jrOClXtvns9LS3yppMvdJ/MFcpkIgcNc/WZBKbk4Aen9fvCYMsi2zD4+MSeOtLngoYe4
         kmBxhHqRD1hcI7S3HoySP/3fcFcc9QAfTAiINrT45Ixs4vkNQfwtorftszQ57qJTGjMp
         DYxw==
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
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 058/115] tg3: Add workaround to restrict 5762 MRRS to 2048
Date: Fri,  2 Mar 2018 09:51:01 +0100
Message-Id: <20180302084506.229367324@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815433008003046?=
X-GMAIL-MSGID: =?utf-8?q?1593815941622120821?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/tg3.c |   10 ++++++++++
 drivers/net/ethernet/broadcom/tg3.h |    4 ++++
 2 files changed, 14 insertions(+)

--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -10052,6 +10052,16 @@ static int tg3_reset_hw(struct tg3 *tp,
 
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
@@ -96,6 +96,7 @@
 #define TG3PCI_SUBDEVICE_ID_DELL_JAGUAR		0x0106
 #define TG3PCI_SUBDEVICE_ID_DELL_MERLOT		0x0109
 #define TG3PCI_SUBDEVICE_ID_DELL_SLIM_MERLOT	0x010a
+#define TG3PCI_SUBDEVICE_ID_DELL_5762		0x07f0
 #define TG3PCI_SUBVENDOR_ID_COMPAQ		PCI_VENDOR_ID_COMPAQ
 #define TG3PCI_SUBDEVICE_ID_COMPAQ_BANSHEE	0x007c
 #define TG3PCI_SUBDEVICE_ID_COMPAQ_BANSHEE_2	0x009a
@@ -281,6 +282,9 @@
 #define TG3PCI_STD_RING_PROD_IDX	0x00000098 /* 64-bit */
 #define TG3PCI_RCV_RET_RING_CON_IDX	0x000000a0 /* 64-bit */
 /* 0xa8 --> 0xb8 unused */
+#define TG3PCI_DEV_STATUS_CTRL		0x000000b4
+#define  MAX_READ_REQ_SIZE_2048		 0x00004000
+#define  MAX_READ_REQ_MASK		 0x00007000
 #define TG3PCI_DUAL_MAC_CTRL		0x000000b8
 #define  DUAL_MAC_CTRL_CH_MASK		 0x00000003
 #define  DUAL_MAC_CTRL_ID		 0x00000004
