Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/PPUoUlrirER2QKGaPD162XBQsx5qB4ffUt/+eFMcCa5kyphdxjLSSXlnikG/zB4GntZdl
ARC-Seal: i=1; a=rsa-sha256; t=1523473316; cv=none;
        d=google.com; s=arc-20160816;
        b=WL7P4LP88heYuiFTUzbSlH3u1lpTe8XrBRt8BAEo+XCYSRiNS8szjRU3eOP54p/gNw
         44dJx5wD2vgNIG3onLt2ig1IErzcJQN5eV8MGaAbPkE8M4z60n8OYx8sJcxaHH++NBZR
         9kQ4/cXomOmBp0ZEkChiOQ+JTfm29bhMntQfFs8mm8KcwE8PAs12QKPamfxteWD62QwC
         5h8hsDDKLdgoctEoNC7dTRk3R1roQ0GMILx/VLpDoT1Y80w3xynqsQtW0bnbKfDPHc5i
         1eCo8cifG0vJSMGzVfhm/V6IDPrMTLGe7dFFOOW0uoQCjZJ7hPpoMiOA1TVCm9xpZn1v
         h6MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ReOhsz0jCiVvqrqbancqAKUZ3llP7mjMB6EO0dpykBM=;
        b=ZvElAhRCaSDaLAo0r3IKjq0GVjP4eKzuhfHh7qySUerw0stkFJRO/ZIASwZv7aHmZp
         eCDNUzG1wrt1KYHc4sOx9iIdUMBAaeqgWhWic4QY4Fszp9X7QcROyNHqSuizCe5NtP2k
         uc8Z+FbHdKT4e1RnuYe0GhdHDbujZH0Cm1pNJFohqEQwHPdm6mASNhVkLwnnbpU7gK6T
         rXKWLhP0RFmRMDYdwb9kgoqla+UIXuD5r4sFH7OIq11myIplQ/QPUFmL5C3Ak7p862DU
         jDkJhdAlqNOS9uy9En3a50ioQpZXbLToTyx0qdEx8nkkKuTfVsYL4KQYbU2QEwWr2WPI
         aUuA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Anilkumar Kolli <akolli@qti.qualcomm.com>,
	Kalle Valo <kvalo@qca.qualcomm.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 176/310] ath10k: add BMI parameters to fix calibration from DT/pre-cal
Date: Wed, 11 Apr 2018 20:35:15 +0200
Message-Id: <20180411183630.197106721@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477556622499698?=
X-GMAIL-MSGID: =?utf-8?q?1597477556622499698?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anilkumar Kolli <akolli@qti.qualcomm.com>


[ Upstream commit a9f5f287fa1d47d61dfa8b60f94831174b2ea4d0 ]

QCA99X0, QCA9888, QCA9984 supports calibration data in
either OTP or DT/pre-cal file. Current ath10k supports
Calibration data from OTP only.

If caldata is loaded from DT/pre-cal file, fetching board id
and applying calibration parameters like tx power gets failed.

error log:
[   15.733663] ath10k_pci 0000:01:00.0: failed to fetch board file: -2
[   15.741474] ath10k_pci 0000:01:00.0: could not probe fw (-2)

This patch adds calibration data support from DT/pre-cal
file.  Below parameters are used to get board id and
applying calibration parameters from cal data.

		EEPROM[OTP]	FLASH[DT/pre-cal file]
Cal param	0x700		0x10000
Board id	0x10		0x8000

Tested on QCA9888 with pre-cal file.

Signed-off-by: Anilkumar Kolli <akolli@qti.qualcomm.com>
Signed-off-by: Kalle Valo <kvalo@qca.qualcomm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/ath/ath10k/bmi.h  |    2 ++
 drivers/net/wireless/ath/ath10k/core.c |   16 +++++++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

--- a/drivers/net/wireless/ath/ath10k/bmi.h
+++ b/drivers/net/wireless/ath/ath10k/bmi.h
@@ -83,6 +83,8 @@ enum bmi_cmd_id {
 #define BMI_NVRAM_SEG_NAME_SZ 16
 
 #define BMI_PARAM_GET_EEPROM_BOARD_ID 0x10
+#define BMI_PARAM_GET_FLASH_BOARD_ID 0x8000
+#define BMI_PARAM_FLASH_SECTION_ALL 0x10000
 
 #define ATH10K_BMI_BOARD_ID_FROM_OTP_MASK   0x7c00
 #define ATH10K_BMI_BOARD_ID_FROM_OTP_LSB    10
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -652,7 +652,7 @@ static int ath10k_core_get_board_id_from
 {
 	u32 result, address;
 	u8 board_id, chip_id;
-	int ret;
+	int ret, bmi_board_id_param;
 
 	address = ar->hw_params.patch_load_addr;
 
@@ -676,8 +676,13 @@ static int ath10k_core_get_board_id_from
 		return ret;
 	}
 
-	ret = ath10k_bmi_execute(ar, address, BMI_PARAM_GET_EEPROM_BOARD_ID,
-				 &result);
+	if (ar->cal_mode == ATH10K_PRE_CAL_MODE_DT ||
+	    ar->cal_mode == ATH10K_PRE_CAL_MODE_FILE)
+		bmi_board_id_param = BMI_PARAM_GET_FLASH_BOARD_ID;
+	else
+		bmi_board_id_param = BMI_PARAM_GET_EEPROM_BOARD_ID;
+
+	ret = ath10k_bmi_execute(ar, address, bmi_board_id_param, &result);
 	if (ret) {
 		ath10k_err(ar, "could not execute otp for board id check: %d\n",
 			   ret);
@@ -739,6 +744,11 @@ static int ath10k_download_and_run_otp(s
 		return ret;
 	}
 
+	/* As of now pre-cal is valid for 10_4 variants */
+	if (ar->cal_mode == ATH10K_PRE_CAL_MODE_DT ||
+	    ar->cal_mode == ATH10K_PRE_CAL_MODE_FILE)
+		bmi_otp_exe_param = BMI_PARAM_FLASH_SECTION_ALL;
+
 	ret = ath10k_bmi_execute(ar, address, bmi_otp_exe_param, &result);
 	if (ret) {
 		ath10k_err(ar, "could not execute otp (%d)\n", ret);
