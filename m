Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49HSydK5fSRlyTeFmM0i+T5JoyfPcD/zh2yKnHcD577nOCkMs+fwTLpgp7gckhO5hDiO4Gq
ARC-Seal: i=1; a=rsa-sha256; t=1522168617; cv=none;
        d=google.com; s=arc-20160816;
        b=x3wRXlupUkuD6EPJUpSUMDOIjBcVvz4z27XMf54BH2xrx1QTmDU2wtgQwiixrUxdZN
         iifGk6/QUxhkF/AcfHpXWNADnRG5eeiQor4ybz1bl3bw+/+9g1sLma9RcjG7uImIhJyL
         0yK7xG1cTAQ/WtOUAILlsJCQMSDii8W55HlDRxTLif+HYfM4LFwt5MUP+TBm3NrLQcDs
         KHrlG979tqim03nI6sn8qBlksF+CQqW6DpFEhFgHYfe0W2a+VHO6QAaDa7gJaP++A7rg
         9XXUZL2OoN+/AsLTWkDwaRgdsNRrDrqnspSn0dXT0Gy8d2Tnt94oYQ7wEs1P2gDq5gob
         Iztg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=UJoiIGg2wpmVY3KnLM5QsGpYsP2O6p5bqHvRvoMDamU=;
        b=xJpm7q88NdNuTgQKk3FD+DWS79WILSyVQe6bM4Z+ctagLVtuOIcYiqoFcnjJF7XDj8
         3pXtaSw/F/AxtU6y3Ob9bOfBnSFzVeQDT3unSZsdaQlN2pQSKPhaPlWHwdrYN3f05UvH
         bAyoJRlxeBaby13/Kb2yhvLIpX+hw5GBtX29Qc968Bs2opa/6BEN4pOA252IXzSUIzZ8
         vOTq/N33YiUcS1xZwqT2loRqwuKvDO+4aqi2PDIiCebhoa9eO+nD1dhqFex1+tzmpDB5
         c+GPfXaGfyEQX7s0v9ILq6gk72EQeopeEUWlvQvjpr8bj8jehaDjG+yC8bZiRq4R6Gt5
         H5WQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Marek Vasut <marex@denx.de>,
	Heiko Schocher <hs@denx.de>,
	Markus Marb <markus@marb.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4.14 073/101] can: ifi: Check core revision upon probe
Date: Tue, 27 Mar 2018 18:27:45 +0200
Message-Id: <20180327162754.587267139@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109251430732676?=
X-GMAIL-MSGID: =?utf-8?q?1596109480725007497?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Vasut <marex@denx.de>

commit 591d65d5b15496af8d05e252bc1da611c66c0b79 upstream.

Older versions of the core are not compatible with the driver due
to various intrusive fixes of the core. Read out the VER register,
check the core revision bitfield and verify if the core in use is
new enough (rev 2.1 or newer) to work correctly with this driver.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Heiko Schocher <hs@denx.de>
Cc: Markus Marb <markus@marb.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/can/ifi_canfd/ifi_canfd.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/drivers/net/can/ifi_canfd/ifi_canfd.c
+++ b/drivers/net/can/ifi_canfd/ifi_canfd.c
@@ -144,6 +144,8 @@
 #define IFI_CANFD_SYSCLOCK			0x50
 
 #define IFI_CANFD_VER				0x54
+#define IFI_CANFD_VER_REV_MASK			0xff
+#define IFI_CANFD_VER_REV_MIN_SUPPORTED		0x15
 
 #define IFI_CANFD_IP_ID				0x58
 #define IFI_CANFD_IP_ID_VALUE			0xD073CAFD
@@ -943,7 +945,7 @@ static int ifi_canfd_plat_probe(struct p
 	struct resource *res;
 	void __iomem *addr;
 	int irq, ret;
-	u32 id;
+	u32 id, rev;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	addr = devm_ioremap_resource(dev, res);
@@ -957,6 +959,13 @@ static int ifi_canfd_plat_probe(struct p
 		return -EINVAL;
 	}
 
+	rev = readl(addr + IFI_CANFD_VER) & IFI_CANFD_VER_REV_MASK;
+	if (rev < IFI_CANFD_VER_REV_MIN_SUPPORTED) {
+		dev_err(dev, "This block is too old (rev %i), minimum supported is rev %i\n",
+			rev, IFI_CANFD_VER_REV_MIN_SUPPORTED);
+		return -EINVAL;
+	}
+
 	ndev = alloc_candev(sizeof(*priv), 1);
 	if (!ndev)
 		return -ENOMEM;
