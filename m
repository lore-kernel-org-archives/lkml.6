Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuMm3FIQwcB1JXSWcqaWsB8mA/WOkNuxAAKDINedSOb0gvUMR6dVDuKXWT5WdUBXZWwyV6Y
ARC-Seal: i=1; a=rsa-sha256; t=1521800365; cv=none;
        d=google.com; s=arc-20160816;
        b=Icdmy+HviZKxunOzIZSvyy1rnp56dvVWziyDVhBuHjOZaDzDgYYITuQw3HDx2n0lrP
         tiXiyfT5smttl2Gv37s4SIeef/ERUdYnY5riwxoMWQLoN/3KrGeAKOjwsGgT0r+ihXSw
         tn9IZhPtlW5RCgJENzafusDbUW+1FLXxH+rwRC3BQZWt2GQTfdC0qw76b0lbp+21O26X
         gI1o4Q8ixoFWJ4VLudcRPmk+Lrq6Pj5zwpitBq+BVJ/B1kKMsriX1yg0/9wFMLclzybj
         GTmmB+uT0p0Pf6YPJ81/foerip35/yfYM1/vh9rqF0g1M5JWO8rfNbTwYGvHB/F0M7lG
         +78A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LsvDORS6MHRsu1p6MDDZwXks+EnudRY6CQV3M7Y5VNs=;
        b=ngPEVqEEQQWkFgbragneOpqznMxKgJUwPye9cvEYPW99cvoo2A9TneKtTbJVvTTOOg
         Qi8oA8XuBvNgvjHK/9VheuySyXVy0IvC7AxF450tN9pt/3E486T1g6kykrqzLZLWtSyN
         SHuLNtYG/wxvsMcvuP/VGZngKwbDUqoy9OV0M/5CQvg1lPY2s24f7CtpYThqFhOCK/qd
         WCwUkc6HpjJsUQNJEkkC9+bm/hHPL3Y/qH1rGjQTq60XTZHwyM+O08d6mWa8/7IkTUQe
         3mR1GdgE7iPrEnh5sb/08kK7iXI/c335jEt9SNOBh1hR/lKOCIWJ8Ujd8NM+3AIM+yj9
         qwkA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Keerthy <j-keerthy@ti.com>,
	Lee Jones <lee.jones@linaro.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 27/47] mfd: palmas: Reset the POWERHOLD mux during power off
Date: Fri, 23 Mar 2018 10:55:18 +0100
Message-Id: <20180323094249.284468754@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094248.117679641@linuxfoundation.org>
References: <20180323094248.117679641@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722610937627144?=
X-GMAIL-MSGID: =?utf-8?q?1595723340486228060?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Keerthy <j-keerthy@ti.com>


[ Upstream commit 85fdaf8eb9bbec1f0f8a52fd5d85659d60738816 ]

POWERHOLD signal has higher priority  over the DEV_ON bit.
So power off will not happen if the POWERHOLD is held high.
Hence reset the MUX to GPIO_7 mode to release the POWERHOLD
and the DEV_ON bit to take effect to power off the PMIC.

PMIC Power off happens in dire situations like thermal shutdown
so irrespective of the POWERHOLD setting go ahead and turn off
the powerhold.  Currently poweroff is broken on boards that have
powerhold enabled. This fixes poweroff on those boards.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mfd/palmas.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/drivers/mfd/palmas.c
+++ b/drivers/mfd/palmas.c
@@ -430,6 +430,20 @@ static void palmas_power_off(void)
 {
 	unsigned int addr;
 	int ret, slave;
+	struct device_node *np = palmas_dev->dev->of_node;
+
+	if (of_property_read_bool(np, "ti,palmas-override-powerhold")) {
+		addr = PALMAS_BASE_TO_REG(PALMAS_PU_PD_OD_BASE,
+					  PALMAS_PRIMARY_SECONDARY_PAD2);
+		slave = PALMAS_BASE_TO_SLAVE(PALMAS_PU_PD_OD_BASE);
+
+		ret = regmap_update_bits(palmas_dev->regmap[slave], addr,
+				PALMAS_PRIMARY_SECONDARY_PAD2_GPIO_7_MASK, 0);
+		if (ret)
+			dev_err(palmas_dev->dev,
+				"Unable to write PRIMARY_SECONDARY_PAD2 %d\n",
+				ret);
+	}
 
 	if (!palmas_dev)
 		return;
