Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/xzUAXstRCLtgrnSykhfbn60mntncti+wvKmdW+LpQPrX1bqmOfuuPO8/YWITquK4wobow
ARC-Seal: i=1; a=rsa-sha256; t=1522168825; cv=none;
        d=google.com; s=arc-20160816;
        b=LZ1R3YDuVFPOyVPufHncCiOhN7B8gpcymU8m2YbyqqIqpWHICjcP21vzxmq+c2rn/K
         2CfmM/3IcOrdGQvAW6bPe5J3HM0VM+V270HuFRwqhqeIUct+0aKtZCqDoW+5W91DhyEN
         OV1tb+kdBSrHXfPRF0cLS7h00EFsYuvKoUhLOiGtlG0Dm20Z7S7l7nrIF3iy/UJdWFKa
         VJx+O+fR5nMXMOqikrB8P6MHae5CryfHYgAhVB1Qou62oxWP/iWKbAI1aDJbRNMDFCxh
         OB6aAo7+YDrkXe3EWxijBMz/Us7KEFNBzZE3fOwJUvcDBQMRmC1aWyEHmB1WZlN7lujl
         jiiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jmzQDgfr8yZuR3/IVajZhxUa8t99K7MzheVrfHI2K9s=;
        b=NFBlMofH3TauJ5N2n1f4prn6SATZPmObGQ7VSV71zj0V6JGMtoNFyUnE8Lg7auz0Dy
         p82Tf8udeM/6Dmy6mbkVYWuDLUqvtdDZAjOf8BtqI470ypIShY9mwsYbrOnYfaVKmO2c
         9nxWEfKjCsX+uob/UOFwV8CSzjw/wLzgN8r1FsECuMkds4f+QDXIN8Axg7jIA3XQHjPS
         TZHhywoMSIlqxpGMQErg06H7VEXQIZ07YOO0jq6wer2pgpwUrHhLNqsViaRZVwk/f6xe
         iaQIvoc+PkbBTqRN/ktcGPB5CviVaQsPUqJ6Z3A6FoKo+8JcMCqocm7UeQyTJPImPOUb
         d6uQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hans Verkuil <hans.verkuil@cisco.com>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 4.15 046/105] media: tegra-cec: reset rx_buf_cnt when start bit detected
Date: Tue, 27 Mar 2018 18:27:26 +0200
Message-Id: <20180327162800.115680053@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109698598114628?=
X-GMAIL-MSGID: =?utf-8?q?1596109698598114628?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Verkuil <hverkuil@xs4all.nl>

commit e113d65ae417ae6d9be229649b81d404c47ade79 upstream.

If a start bit is detected, then reset the receive buffer counter to 0.

This ensures that no stale data is in the buffer if a message is
broken off midstream due to e.g. a Low Drive condition and then
retransmitted.

The only Rx interrupts we need to listen to are RX_REGISTER_FULL (i.e.
a valid byte was received) and RX_START_BIT_DETECTED (i.e. a new
message starts and we need to reset the counter).

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Cc: <stable@vger.kernel.org>      # for v4.15 and up
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/platform/tegra-cec/tegra_cec.c |   17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

--- a/drivers/media/platform/tegra-cec/tegra_cec.c
+++ b/drivers/media/platform/tegra-cec/tegra_cec.c
@@ -172,16 +172,13 @@ static irqreturn_t tegra_cec_irq_handler
 		}
 	}
 
-	if (status & (TEGRA_CEC_INT_STAT_RX_REGISTER_OVERRUN |
-		      TEGRA_CEC_INT_STAT_RX_BUS_ANOMALY_DETECTED |
-		      TEGRA_CEC_INT_STAT_RX_START_BIT_DETECTED |
-		      TEGRA_CEC_INT_STAT_RX_BUS_ERROR_DETECTED)) {
+	if (status & TEGRA_CEC_INT_STAT_RX_START_BIT_DETECTED) {
 		cec_write(cec, TEGRA_CEC_INT_STAT,
-			  (TEGRA_CEC_INT_STAT_RX_REGISTER_OVERRUN |
-			   TEGRA_CEC_INT_STAT_RX_BUS_ANOMALY_DETECTED |
-			   TEGRA_CEC_INT_STAT_RX_START_BIT_DETECTED |
-			   TEGRA_CEC_INT_STAT_RX_BUS_ERROR_DETECTED));
-	} else if (status & TEGRA_CEC_INT_STAT_RX_REGISTER_FULL) {
+			  TEGRA_CEC_INT_STAT_RX_START_BIT_DETECTED);
+		cec->rx_done = false;
+		cec->rx_buf_cnt = 0;
+	}
+	if (status & TEGRA_CEC_INT_STAT_RX_REGISTER_FULL) {
 		u32 v;
 
 		cec_write(cec, TEGRA_CEC_INT_STAT,
@@ -255,7 +252,7 @@ static int tegra_cec_adap_enable(struct
 		  TEGRA_CEC_INT_MASK_TX_BUS_ANOMALY_DETECTED |
 		  TEGRA_CEC_INT_MASK_TX_FRAME_TRANSMITTED |
 		  TEGRA_CEC_INT_MASK_RX_REGISTER_FULL |
-		  TEGRA_CEC_INT_MASK_RX_REGISTER_OVERRUN);
+		  TEGRA_CEC_INT_MASK_RX_START_BIT_DETECTED);
 
 	cec_write(cec, TEGRA_CEC_HW_CONTROL, TEGRA_CEC_HWCTRL_TX_RX_MODE);
 	return 0;
