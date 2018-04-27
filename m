Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoBs9X/68kvnc+aB2od/FJJ0i9OEiPY4Af4Z8+omUN8nNqcsaXkJ5N/Tx+IkOYrT+0S3q+o
ARC-Seal: i=1; a=rsa-sha256; t=1524837876; cv=none;
        d=google.com; s=arc-20160816;
        b=lnGFZq/4L5fQ/mKDKMQDb5bAu1nJKw+fEQCtp5EtbW5jxfyfjUSBb86kA9Yvjp2LZZ
         vcLnd9gjB2YN6p090gYzgObWSkkF+8sMRAURHIk8inQR6KNHCZt4gtWxGbUmph2flaMR
         u3X+rSKHrAE1lwGggT2CN1WlWjtIdg0WIBAarlPjXe6anmWU1majbMrO3QhoLgFtPR9d
         yLJXzZBTw7cVhkdql2xQ1vujLghwU0vQpZ3J008ie47DOa3bjcU2wrbSZK5LmUXYPM40
         Z6GmgdcOKac86LbXWVnekfAVZ2ObvnpAQXpsPxZRNbefTIEVyq1KhvpoTjF0AJXKB9Zn
         iJXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=xsUX7GprwjK1XEaAf4Ju7uYUmeS8tvhpz53kquaymwk=;
        b=XUWkYU02ZwTRLzcgudMftL5QDiVbgHLh+ZF1+59ZxGEtnqRFZjZ+iuZOSjYJUAHZOl
         vkeDTWXu2MPYb4rha9cPD0wLF0Co+jsg5VYvQs/R3RfHadBRX3AdJOHxtECAVFEgrD/A
         MNcxQJiTUMiJqdmggQH4sB+O89+l09CohZx/GKYmsdSrkLjpIdzs9VSdvrwZCuevvFTS
         jiGio+SsPGiYtTG+b7tP3Sm51lLhNc3EWDDamq28widW9rgGQSDpYMOx6qnOxHWcnKhh
         44bE/k4escD6t1pZi6EO3+eBkkwjsDmoZ4eT2ey10bEJjjylFXWGA4bWiXIHKp1DQUFn
         RGpw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E02772189D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Felix Fietkau <nbd@nbd.name>,
	Kalle Valo <kvalo@qca.qualcomm.com>,
	Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 4.9 16/74] ath9k_hw: check if the chip failed to wake up
Date: Fri, 27 Apr 2018 15:58:06 +0200
Message-Id: <20180427135710.573193299@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
References: <20180427135709.899303463@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908165445884565?=
X-GMAIL-MSGID: =?utf-8?q?1598908401671310660?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1603,6 +1603,10 @@ bool ath9k_hw_check_alive(struct ath_hw
 	int count = 50;
 	u32 reg, last_val;
 
+	/* Check if chip failed to wake up */
+	if (REG_READ(ah, AR_CFG) == 0xdeadbeef)
+		return false;
+
 	if (AR_SREV_9300(ah))
 		return !ath9k_hw_detect_mac_hang(ah);
 
