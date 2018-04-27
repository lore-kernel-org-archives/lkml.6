Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoRzu7OSbLkunHDbPZ3X18Ep3J9qryz6QN6szTfKn0AyEsJJ5gWXvUd71c9cLmEOp2ua6vI
ARC-Seal: i=1; a=rsa-sha256; t=1524837651; cv=none;
        d=google.com; s=arc-20160816;
        b=JPq6OuoLGlSP8eb3U1UuQ8fmTny+zj5IyVcNUDpXi9+f3gd3YyWZdMlrBtJV8Gi3xL
         7liCt8p/0mL2EPFA5EXFJMW5xL+xP2YM9do3Pa6xHnEa9L+dl872bV0yTAcYUYzthtLw
         //92C3AjtpznpZyKaeWSDY9hd1M9cSSEcY1oWyGfjOGIfdllXRtuuSVA3rj6kCbPX78Q
         bcCicYcZwz0vOxRKYNixkHfGmJY9e4Bs5RwcTlUWH5zng9Vo0L6YBigRESZifounze7C
         7ee6cpP27Pwf1SdHBYsTcD2kW3gyOglgmXkHT+sSyHZJ6jPlnuf0ywnqn0JSNxb8Wml1
         zROA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=JdfeojLoDOnKUDIoL0pYBOcf7stL8y5y7uJ8Q5iysQE=;
        b=n3WzcgK/6wdWH8IkfGpWPpI1LsMcxAFQRz3dmOeEg7bMMQZpOQHPS4yXuggHNc1WdY
         Q3PaeiefMMALzyapQ23KzS/9bZr8GYr1NQcAyj4C5k4tUZBXnEhqSEXy+nQ0EyoRf9Kp
         bw8Y9lS5QwdPWRxbpFVj7q2WFQEOKBrkKwj8gjzaTj3S3SiEdhwMGxQPgv4Ia7boF/jF
         0m0SoDweaERrl9FYqEZetwuI4ejwPtHRut235TvZCeCS3x9GYKEhKBN/2suN4ctnDPFo
         gJOLaTjKwMFVi3vqKzuZrB2fjv5i7l3mKLP4s/yoQGAHOdqnKqeX7fvZ++U2rCrorPcq
         OS+w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 864E421890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Felix Fietkau <nbd@nbd.name>,
	Kalle Valo <kvalo@qca.qualcomm.com>,
	Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 4.4 07/50] ath9k_hw: check if the chip failed to wake up
Date: Fri, 27 Apr 2018 15:58:09 +0200
Message-Id: <20180427135656.069466594@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135655.623669681@linuxfoundation.org>
References: <20180427135655.623669681@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908165445884565?=
X-GMAIL-MSGID: =?utf-8?q?1598908165445884565?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Fietkau <nbd@nbd.name>

commit a34d0a0da1abae46a5f6ebd06fb0ec484ca099d9 upstream.

In an RFC patch, Sven Eckelmann and Simon Wunderlich reported:

"QCA 802.11n chips (especially AR9330/AR9340) sometimes end up in a
state in which a read of AR_CFG always returns 0xdeadbeef.
This should not happen when when the power_mode of the device is
ATH9K_PM_AWAKE."

Include the check for the default register state in the existing MAC
hang check.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Kalle Valo <kvalo@qca.qualcomm.com>
Cc: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/ath/ath9k/hw.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/net/wireless/ath/ath9k/hw.c
+++ b/drivers/net/wireless/ath/ath9k/hw.c
@@ -1595,6 +1595,10 @@ bool ath9k_hw_check_alive(struct ath_hw
 	int count = 50;
 	u32 reg, last_val;
 
+	/* Check if chip failed to wake up */
+	if (REG_READ(ah, AR_CFG) == 0xdeadbeef)
+		return false;
+
 	if (AR_SREV_9300(ah))
 		return !ath9k_hw_detect_mac_hang(ah);
 
