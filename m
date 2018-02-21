Return-Path: <arend.vanspriel@broadcom.com>
X-Google-Smtp-Source: AH8x225DHC4yPJSWiSHUkH7hUf+cmO7ggVJNEBkU1McrZkJDZYSoBQyJ8w5VbGtXPAAl419BTfXU
ARC-Seal: i=1; a=rsa-sha256; t=1519210242; cv=none;
        d=google.com; s=arc-20160816;
        b=HvUfXsTRvZQQv7J3HVisXfr7oL2jTJeDDp25bNQS6Y2fNO2YrZj5tALSkIn60bkBS9
         t07tQLK5LouyzBMHxgFFzQ5iDL/9ToK/RK0MsSpPiZRLnwGBwKaUabmBOowYYl64bH9Y
         VlWyAVTMRL3qO3vcODsz5CVvc87QMNeDbcUxGRaTaSbTexWm+T/DpYtZVRRcPJco5Z8I
         7xA8DU0hC0wSh76fnP78WrVDD9EzyYs8B5PMlTy+/hSnqo0EQKUZMfmDnSurFIujgOnW
         ebeVwb+G+znWeRuVdz2XfFXNPmIetJ+oJJnAdU8G/CQmlN7satGD40B42TXxAqdaJf3j
         3U1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=6kVdI4Uxjn5eoVLsc654fr9tVIKQmmSJ9cLL6CQePKs=;
        b=OUN8nxXubSluW6il6FiKgmr8/jf5UcWK6t8l60vtlhJ38UA3NvOcoCdVecR1lQH2RT
         eDqHzu942qBJ9hA1mUa1w9ZQKRZFokP/rKvN1Ojqh6ahXWJZbSRmO5Fk0nrgtetBzDyK
         UV/H6ntJTIgaVIjKbJFfDzzAAcuKBFd+qqxPkrhtwcJ1stvgYT4BB8oHiNEBovefLw8y
         B86d2dYfGi1z+BSosn4YeyctjEYbiLa/J+uLWtoP1VEFVKy+Ylhgvtpbj+lNvY/OeUw6
         iPrDd0w+06SwqLKeSlr8Nu7kXmfvfsvXSCk37HgMQT96kbJjmYrkSCfVvPhFpJvy+dJG
         S4UA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of arend.vanspriel@broadcom.com designates 192.19.229.170 as permitted sender) smtp.mailfrom=arend.vanspriel@broadcom.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=broadcom.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of arend.vanspriel@broadcom.com designates 192.19.229.170 as permitted sender) smtp.mailfrom=arend.vanspriel@broadcom.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=broadcom.com
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Kalle Valo <kvalo@codeaurora.org>,
	Marcel Holtmann <marcel@holtmann.org>
Cc: linux-wireless@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH 1/3] brcmfmac: add support for sysfs initiated coredump
Date: Wed, 21 Feb 2018 11:50:18 +0100
Message-Id: <1519210220-22437-2-git-send-email-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519210220-22437-1-git-send-email-arend.vanspriel@broadcom.com>
References: <1519210220-22437-1-git-send-email-arend.vanspriel@broadcom.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593007399359542327?=
X-GMAIL-MSGID: =?utf-8?q?1593007399359542327?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The driver already supports device coredump initiated by firmware
event. Since commit 3c47d19ff4dc ("drivers: base: add coredump driver
ops") it is also possible to initiate it from user-space through
sysfs. This patch adds support for SDIO and PCIe devices.

Reviewed-by: Hante Meuleman <hante.meuleman@broadcom.com>
Reviewed-by: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
Reviewed-by: Franky Lin <franky.lin@broadcom.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c | 1 +
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h    | 2 ++
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c   | 7 +++++++
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c   | 1 +
 4 files changed, 11 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index 0b68240..3220b69 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -1164,6 +1164,7 @@ static int brcmf_ops_sdio_resume(struct device *dev)
 #ifdef CONFIG_PM_SLEEP
 		.pm = &brcmf_sdio_pm_ops,
 #endif	/* CONFIG_PM_SLEEP */
+		.coredump = brcmf_dev_coredump,
 	},
 };
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
index 0b76a61..77d1f34 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
@@ -249,6 +249,8 @@ int brcmf_bus_get_fwname(struct brcmf_bus *bus, uint chip, uint chiprev,
 void brcmf_detach(struct device *dev);
 /* Indication from bus module that dongle should be reset */
 void brcmf_dev_reset(struct device *dev);
+/* Request from bus module to initiate a coredump */
+int brcmf_dev_coredump(struct device *dev);
 
 /* Configure the "global" bus state used by upper layers */
 void brcmf_bus_change_state(struct brcmf_bus *bus, enum brcmf_bus_state state);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
index 930e423..d06ffe0 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
@@ -1110,6 +1110,13 @@ void brcmf_dev_reset(struct device *dev)
 		brcmf_fil_cmd_int_set(drvr->iflist[0], BRCMF_C_TERMINATED, 1);
 }
 
+int brcmf_dev_coredump(struct device *dev)
+{
+	struct brcmf_bus *bus_if = dev_get_drvdata(dev);
+
+	return brcmf_debug_create_memdump(bus_if, NULL, 0);
+}
+
 void brcmf_detach(struct device *dev)
 {
 	s32 i;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index 8752707..502dd7b 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -2005,6 +2005,7 @@ static int brcmf_pcie_pm_leave_D3(struct device *dev)
 #ifdef CONFIG_PM
 	.driver.pm = &brcmf_pciedrvr_pm,
 #endif
+	.driver.coredump = brcmf_dev_coredump,
 };
 
 
-- 
1.9.1
