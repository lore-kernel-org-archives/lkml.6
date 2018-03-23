Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuLcomA9hum4oBuzmKA4NN1XIVRGMAz3y0Sm1n52cIMseby2eB9RQXMgUgI79Aca94sTKAM
ARC-Seal: i=1; a=rsa-sha256; t=1521800143; cv=none;
        d=google.com; s=arc-20160816;
        b=UEZxRcGeeoQ6FdZDOSZCkJnzMI/jO5WqA4j/igPMDNKZ+nFC9SoiIVb6IUpOP3s8KP
         Vftu+4awq5UtfxKXoZfws3EUzrjzSQ+KiCyK09BSvRVhpfgF0txmpMqHTNFuDm/CbU38
         AJtpeTaOc4zF+0vtKasUE/nThfP0SyaVL7hflF7V2NGB2DiidU64Ijpn0qt5vJhDbWOC
         j2MpXCsbaIiW+RbHnBi57tOTzHZ92cCfLnR++RpKdsLdRIpcvAjmnu6xENNMCl8dvofy
         F2yPvONGV1ETCILo+XT3UVhCYEp4DOIp1azv7XDbLefNnKcGdxq75YfnkDLimisof3Au
         pLvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=B3nkgjvL8lA3FKuXXucA2ByfzfePS4iovAUr2BLFoT4=;
        b=ob0VD0k78hPl6NqfEGJUUbppbkgoQruOIgvEMGpZjfrK85b1E/wUhscN+5eHb+pv8C
         CikQAsJff7gvBpONapXyC9YoCi3rr5U0Ewhuv/z+X5WxZFjWUgoFJhM05lxC6QMfl/HT
         96XfajExpsz5OJa5tzwrEiSWfHkyr94sfPzPd7TRE3LKycx2UyUgFDtFZ33Z+GQhNPko
         /kGx8TYXXQe+oAjYI75uxU95mhJjitTUTXdOFYEoD06AoOo5SzX0YOHt9zIts5lPrkwL
         BfeaGfPykcAQRQsoqZSt6dwJLXLmacetq8MU1EqyecSmYx1B8KV2ZrHiSMsb9KaVxUvb
         Y9yA==
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
Subject: [PATCH 4.4 51/97] mfd: palmas: Reset the POWERHOLD mux during power off
Date: Fri, 23 Mar 2018 10:54:38 +0100
Message-Id: <20180323094200.471499547@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722610937627144?=
X-GMAIL-MSGID: =?utf-8?q?1595723107267568860?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
