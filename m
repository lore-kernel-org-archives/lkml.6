Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+uLuSdcaad6UmArBv1ZLHsSbDEW97ULkUS8MYu1HPhb+f1cUAq7hFBOOYqnzElFg+OO2i/
ARC-Seal: i=1; a=rsa-sha256; t=1523473434; cv=none;
        d=google.com; s=arc-20160816;
        b=L4ncOlcYThJ1OhAUYWoqqB3r3a7UED+NZ72EwaCTVw8R/Hh+jR/RySA4yrRFXlq1k+
         X3c1AiBTxLjMUZvOCY/K94bGZ9qie2ggMjSx+f0fi1v8bnAH5elFog3/WXdVJUAIlPH/
         xa7XFQRlSZIsyY1H+fmDUzug31h8b3gFK6vOfJs9YapZiXvMJlt5wyV2p4lWjgWovY3R
         hcG4LInii6rnhCFO7Ymgk/HLhHjutUSaIwFcJdlp50Wxy655vi2nbGY3/qppMvyAoRHg
         FI7CoTbak7KxKO8vfguxDmX9B2EGFbzgl0eynUK6UvpdDgD5zlZ1O7OAvs9y7HedD8da
         Yx6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=F8dRcSyl2iViwoji/lQ11J76r+DN3REq/Zv8xvT3Dss=;
        b=Sfo4w8txYeHDKEp+amFI7+4EdTtpYm1XKVq46R4zrdBqvJhp7ia4uTxGhc2EiujJl8
         2uLW56PVwm07wK1sUHd0wRAZ4jlor5R46KOvQhNlTT7Ks9Z7XehCZfUe5UVMNqSp3u2u
         hkEbl7ZG1+1Ga+eAkktFwBbX5VkCrMb7eak+SMOzn9/YEr6OHfIUGuyYvJJYFuUvgFus
         Ny1RVrrC+46bhOk78lV4MIkmqtASa3CJ3ujnjb9H+7iMNCiKgz2zpfpQuw9dhBLj1dWp
         SHsEihMRCbt9wC/FQacCm5Ehy3cSLojb9QfXrKSU758q4Q2JECRBLXwAnmMjH0A7k1io
         eIsg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Netanel Belgazal <netanel@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 245/310] net: ena: disable admin msix while working in polling mode
Date: Wed, 11 Apr 2018 20:36:24 +0200
Message-Id: <20180411183633.008586271@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477679927159344?=
X-GMAIL-MSGID: =?utf-8?q?1597477679927159344?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Netanel Belgazal <netanel@amazon.com>


[ Upstream commit a2cc5198dac102775b21787752a2e0afe44ad311 ]

Fixes: 1738cd3ed342 ("Add a driver for Amazon Elastic Network Adapters (ENA)")
Signed-off-by: Netanel Belgazal <netanel@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/amazon/ena/ena_com.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/net/ethernet/amazon/ena/ena_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_com.c
@@ -61,6 +61,8 @@
 
 #define ENA_MMIO_READ_TIMEOUT 0xFFFFFFFF
 
+#define ENA_REGS_ADMIN_INTR_MASK 1
+
 /*****************************************************************************/
 /*****************************************************************************/
 /*****************************************************************************/
@@ -1448,6 +1450,12 @@ void ena_com_admin_destroy(struct ena_co
 
 void ena_com_set_admin_polling_mode(struct ena_com_dev *ena_dev, bool polling)
 {
+	u32 mask_value = 0;
+
+	if (polling)
+		mask_value = ENA_REGS_ADMIN_INTR_MASK;
+
+	writel(mask_value, ena_dev->reg_bar + ENA_REGS_INTR_MASK_OFF);
 	ena_dev->admin_queue.polling = polling;
 }
 
