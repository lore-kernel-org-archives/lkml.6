Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1023CC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 11:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76C54216F7
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 11:09:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76C54216F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=smarthome-wolf.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932457AbeFYLJY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 07:09:24 -0400
Received: from dd39320.kasserver.com ([85.13.155.146]:57858 "EHLO
        dd39320.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932089AbeFYLJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 07:09:23 -0400
Received: from dd39320.kasserver.com (dd0802.kasserver.com [85.13.143.1])
        by dd39320.kasserver.com (Postfix) with ESMTPSA id 6AB3C2CE013C;
        Mon, 25 Jun 2018 13:09:21 +0200 (CEST)
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SenderIP: 108.171.129.168
User-Agent: ALL-INKL Webmail 2.11
In-Reply-To: <20180624163138.30976-1-Valentin.Vidic@CARNet.hr>
References: <20180624094245.23741-1-Valentin.Vidic@CARNet.hr><20180624163138.30976-1-Valentin.Vidic@CARNet.hr>
Subject: Re: [PATCH v3] staging: pi433: replace simple switch statements
From:   marcus.wolf@smarthome-wolf.de
To:     gregkh@linuxfoundation.org, Valentin.Vidic@CARNet.hr
Cc:     simon@nikanor.nu, linux@Wolf-Entwicklungen.de, luca@acul.me,
        marcin.s.ciupak@gmail.com, michael.panzlaff@fau.de,
        robsonde@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, hle@owl.eu.com,
        dan.carpenter@oracle.com, joe@perches.com, Valentin.Vidic@CARNet.hr
Message-Id: <20180625110921.6AB3C2CE013C@dd39320.kasserver.com>
Date:   Mon, 25 Jun 2018 13:09:21 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Marcus Wolf <Marcus.Wolf@Wolf-Entwicklungen.de>

Thank you Valentin, very nice patch :-)

Valentin Vidic schrieb am 24.06.2018 18:31:

Use const array to map switch cases to resulting values.

Signed-off-by: Valentin Vidic <Valentin.Vidic@CARNet.hr>
---
v2: use correct type for const arrays
v3: add missing static keyword for af_map

 drivers/staging/pi433/rf69.c | 233 ++++++++++++++---------------------
 1 file changed, 93 insertions(+), 140 deletions(-)

diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
index 90280e9b006d..341d6901a801 100644
--- a/drivers/staging/pi433/rf69.c
+++ b/drivers/staging/pi433/rf69.c
@@ -111,27 +111,22 @@ static inline int rf69_read_mod_write(struct spi_device
*spi, u8 reg,
 
 int rf69_set_mode(struct spi_device *spi, enum mode mode)
 {
-	switch (mode) {
-	case transmit:
-		return rf69_read_mod_write(spi, REG_OPMODE, MASK_OPMODE_MODE,
-					   OPMODE_MODE_TRANSMIT);
-	case receive:
-		return rf69_read_mod_write(spi, REG_OPMODE, MASK_OPMODE_MODE,
-					   OPMODE_MODE_RECEIVE);
-	case synthesizer:
-		return rf69_read_mod_write(spi, REG_OPMODE, MASK_OPMODE_MODE,
-					   OPMODE_MODE_SYNTHESIZER);
-	case standby:
-		return rf69_read_mod_write(spi, REG_OPMODE, MASK_OPMODE_MODE,
-					   OPMODE_MODE_STANDBY);
-	case mode_sleep:
-		return rf69_read_mod_write(spi, REG_OPMODE, MASK_OPMODE_MODE,
-					   OPMODE_MODE_SLEEP);
-	default:
+	static const u8 mode_map[] = {
+		[transmit] = OPMODE_MODE_TRANSMIT,
+		[receive] = OPMODE_MODE_RECEIVE,
+		[synthesizer] = OPMODE_MODE_SYNTHESIZER,
+		[standby] = OPMODE_MODE_STANDBY,
+		[mode_sleep] = OPMODE_MODE_SLEEP,
+	};
+
+	if (unlikely(mode >= ARRAY_SIZE(mode_map))) {
 		dev_dbg(&spi->dev, "set: illegal input param");
 		return -EINVAL;
 	}
 
+	return rf69_read_mod_write(spi, REG_OPMODE, MASK_OPMODE_MODE,
+				   mode_map[mode]);
+
 	// we are using packet mode, so this check is not really needed
 	// but waiting for mode ready is necessary when going from sleep because the
 	FIFO may not be immediately available from previous mode
 	//while (_mode == RF69_MODE_SLEEP && (READ_REG(REG_IRQFLAGS1) &
 	RF_IRQFLAGS1_MODEREADY) == 0x00); // Wait for ModeReady
@@ -145,19 +140,19 @@ int rf69_set_data_mode(struct spi_device *spi, u8
data_mode)
 
 int rf69_set_modulation(struct spi_device *spi, enum modulation modulation)
 {
-	switch (modulation) {
-	case OOK:
-		return rf69_read_mod_write(spi, REG_DATAMODUL,
-					   MASK_DATAMODUL_MODULATION_TYPE,
-					   DATAMODUL_MODULATION_TYPE_OOK);
-	case FSK:
-		return rf69_read_mod_write(spi, REG_DATAMODUL,
-					   MASK_DATAMODUL_MODULATION_TYPE,
-					   DATAMODUL_MODULATION_TYPE_FSK);
-	default:
+	static const u8 modulation_map[] = {
+		[OOK] = DATAMODUL_MODULATION_TYPE_OOK,
+		[FSK] = DATAMODUL_MODULATION_TYPE_FSK,
+	};
+
+	if (unlikely(modulation >= ARRAY_SIZE(modulation_map))) {
 		dev_dbg(&spi->dev, "set: illegal input param");
 		return -EINVAL;
 	}
+
+	return rf69_read_mod_write(spi, REG_DATAMODUL,
+				   MASK_DATAMODUL_MODULATION_TYPE,
+				   modulation_map[modulation]);
 }
 
 static enum modulation rf69_get_modulation(struct spi_device *spi)
@@ -373,43 +368,30 @@ int rf69_set_output_power_level(struct spi_device *spi, u8
power_level)
 
 int rf69_set_pa_ramp(struct spi_device *spi, enum pa_ramp pa_ramp)
 {
-	switch (pa_ramp) {
-	case ramp3400:
-		return rf69_write_reg(spi, REG_PARAMP, PARAMP_3400);
-	case ramp2000:
-		return rf69_write_reg(spi, REG_PARAMP, PARAMP_2000);
-	case ramp1000:
-		return rf69_write_reg(spi, REG_PARAMP, PARAMP_1000);
-	case ramp500:
-		return rf69_write_reg(spi, REG_PARAMP, PARAMP_500);
-	case ramp250:
-		return rf69_write_reg(spi, REG_PARAMP, PARAMP_250);
-	case ramp125:
-		return rf69_write_reg(spi, REG_PARAMP, PARAMP_125);
-	case ramp100:
-		return rf69_write_reg(spi, REG_PARAMP, PARAMP_100);
-	case ramp62:
-		return rf69_write_reg(spi, REG_PARAMP, PARAMP_62);
-	case ramp50:
-		return rf69_write_reg(spi, REG_PARAMP, PARAMP_50);
-	case ramp40:
-		return rf69_write_reg(spi, REG_PARAMP, PARAMP_40);
-	case ramp31:
-		return rf69_write_reg(spi, REG_PARAMP, PARAMP_31);
-	case ramp25:
-		return rf69_write_reg(spi, REG_PARAMP, PARAMP_25);
-	case ramp20:
-		return rf69_write_reg(spi, REG_PARAMP, PARAMP_20);
-	case ramp15:
-		return rf69_write_reg(spi, REG_PARAMP, PARAMP_15);
-	case ramp12:
-		return rf69_write_reg(spi, REG_PARAMP, PARAMP_12);
-	case ramp10:
-		return rf69_write_reg(spi, REG_PARAMP, PARAMP_10);
-	default:
+	static const u8 pa_ramp_map[] = {
+		[ramp3400] = PARAMP_3400,
+		[ramp2000] = PARAMP_2000,
+		[ramp1000] = PARAMP_1000,
+		[ramp500] = PARAMP_500,
+		[ramp250] = PARAMP_250,
+		[ramp125] = PARAMP_125,
+		[ramp100] = PARAMP_100,
+		[ramp62] = PARAMP_62,
+		[ramp50] = PARAMP_50,
+		[ramp40] = PARAMP_40,
+		[ramp31] = PARAMP_31,
+		[ramp25] = PARAMP_25,
+		[ramp20] = PARAMP_20,
+		[ramp15] = PARAMP_15,
+		[ramp10] = PARAMP_10,
+	};
+
+	if (unlikely(pa_ramp >= ARRAY_SIZE(pa_ramp_map))) {
 		dev_dbg(&spi->dev, "set: illegal input param");
 		return -EINVAL;
 	}
+
+	return rf69_write_reg(spi, REG_PARAMP, pa_ramp_map[pa_ramp]);
 }
 
 int rf69_set_antenna_impedance(struct spi_device *spi,
@@ -428,32 +410,23 @@ int rf69_set_antenna_impedance(struct spi_device *spi,
 
 int rf69_set_lna_gain(struct spi_device *spi, enum lna_gain lna_gain)
 {
-	switch (lna_gain) {
-	case automatic:
-		return rf69_read_mod_write(spi, REG_LNA, MASK_LNA_GAIN,
-					   LNA_GAIN_AUTO);
-	case max:
-		return rf69_read_mod_write(spi, REG_LNA, MASK_LNA_GAIN,
-					   LNA_GAIN_MAX);
-	case max_minus_6:
-		return rf69_read_mod_write(spi, REG_LNA, MASK_LNA_GAIN,
-					   LNA_GAIN_MAX_MINUS_6);
-	case max_minus_12:
-		return rf69_read_mod_write(spi, REG_LNA, MASK_LNA_GAIN,
-					   LNA_GAIN_MAX_MINUS_12);
-	case max_minus_24:
-		return rf69_read_mod_write(spi, REG_LNA, MASK_LNA_GAIN,
-					   LNA_GAIN_MAX_MINUS_24);
-	case max_minus_36:
-		return rf69_read_mod_write(spi, REG_LNA, MASK_LNA_GAIN,
-					   LNA_GAIN_MAX_MINUS_36);
-	case max_minus_48:
-		return rf69_read_mod_write(spi, REG_LNA, MASK_LNA_GAIN,
-					   LNA_GAIN_MAX_MINUS_48);
-	default:
+	static const u8 lna_gain_map[] = {
+		[automatic] = LNA_GAIN_AUTO,
+		[max] = LNA_GAIN_MAX,
+		[max_minus_6] = LNA_GAIN_MAX_MINUS_6,
+		[max_minus_12] = LNA_GAIN_MAX_MINUS_12,
+		[max_minus_24] = LNA_GAIN_MAX_MINUS_24,
+		[max_minus_36] = LNA_GAIN_MAX_MINUS_36,
+		[max_minus_48] = LNA_GAIN_MAX_MINUS_48,
+	};
+
+	if (unlikely(lna_gain >= ARRAY_SIZE(lna_gain_map))) {
 		dev_dbg(&spi->dev, "set: illegal input param");
 		return -EINVAL;
 	}
+
+	return rf69_read_mod_write(spi, REG_LNA, MASK_LNA_GAIN,
+				   lna_gain_map[lna_gain]);
 }
 
 static int rf69_set_bandwidth_intern(struct spi_device *spi, u8 reg,
@@ -516,43 +489,24 @@ int rf69_set_bandwidth_during_afc(struct spi_device *spi,
 int rf69_set_ook_threshold_dec(struct spi_device *spi,
 			       enum threshold_decrement threshold_decrement)
 {
-	switch (threshold_decrement) {
-	case dec_every8th:
-		return rf69_read_mod_write(spi, REG_OOKPEAK,
-					   MASK_OOKPEAK_THRESDEC,
-					   OOKPEAK_THRESHDEC_EVERY_8TH);
-	case dec_every4th:
-		return rf69_read_mod_write(spi, REG_OOKPEAK,
-					   MASK_OOKPEAK_THRESDEC,
-					   OOKPEAK_THRESHDEC_EVERY_4TH);
-	case dec_every2nd:
-		return rf69_read_mod_write(spi, REG_OOKPEAK,
-					   MASK_OOKPEAK_THRESDEC,
-					   OOKPEAK_THRESHDEC_EVERY_2ND);
-	case dec_once:
-		return rf69_read_mod_write(spi, REG_OOKPEAK,
-					   MASK_OOKPEAK_THRESDEC,
-					   OOKPEAK_THRESHDEC_ONCE);
-	case dec_twice:
-		return rf69_read_mod_write(spi, REG_OOKPEAK,
-					   MASK_OOKPEAK_THRESDEC,
-					   OOKPEAK_THRESHDEC_TWICE);
-	case dec_4times:
-		return rf69_read_mod_write(spi, REG_OOKPEAK,
-					   MASK_OOKPEAK_THRESDEC,
-					   OOKPEAK_THRESHDEC_4_TIMES);
-	case dec_8times:
-		return rf69_read_mod_write(spi, REG_OOKPEAK,
-					   MASK_OOKPEAK_THRESDEC,
-					   OOKPEAK_THRESHDEC_8_TIMES);
-	case dec_16times:
-		return rf69_read_mod_write(spi, REG_OOKPEAK,
-					   MASK_OOKPEAK_THRESDEC,
-					   OOKPEAK_THRESHDEC_16_TIMES);
-	default:
+	static const u8 td_map[] = {
+		[dec_every8th] = OOKPEAK_THRESHDEC_EVERY_8TH,
+		[dec_every4th] = OOKPEAK_THRESHDEC_EVERY_4TH,
+		[dec_every2nd] = OOKPEAK_THRESHDEC_EVERY_2ND,
+		[dec_once] = OOKPEAK_THRESHDEC_ONCE,
+		[dec_twice] = OOKPEAK_THRESHDEC_TWICE,
+		[dec_4times] = OOKPEAK_THRESHDEC_4_TIMES,
+		[dec_8times] = OOKPEAK_THRESHDEC_8_TIMES,
+		[dec_16times] = OOKPEAK_THRESHDEC_16_TIMES,
+	};
+
+	if (unlikely(threshold_decrement >= ARRAY_SIZE(td_map))) {
 		dev_dbg(&spi->dev, "set: illegal input param");
 		return -EINVAL;
 	}
+
+	return rf69_read_mod_write(spi, REG_OOKPEAK, MASK_OOKPEAK_THRESDEC,
+				   td_map[threshold_decrement]);
 }
 
 int rf69_set_dio_mapping(struct spi_device *spi, u8 dio_number, u8 value)
@@ -749,23 +703,21 @@ int rf69_disable_crc(struct spi_device *spi)
 int rf69_set_address_filtering(struct spi_device *spi,
 			       enum address_filtering address_filtering)
 {
-	switch (address_filtering) {
-	case filtering_off:
-		return rf69_read_mod_write(spi, REG_PACKETCONFIG1,
-					   MASK_PACKETCONFIG1_ADDRESSFILTERING,
-					   PACKETCONFIG1_ADDRESSFILTERING_OFF);
-	case node_address:
-		return rf69_read_mod_write(spi, REG_PACKETCONFIG1,
-					   MASK_PACKETCONFIG1_ADDRESSFILTERING,
-					   PACKETCONFIG1_ADDRESSFILTERING_NODE);
-	case node_or_broadcast_address:
-		return rf69_read_mod_write(spi, REG_PACKETCONFIG1,
-					   MASK_PACKETCONFIG1_ADDRESSFILTERING,
-					   PACKETCONFIG1_ADDRESSFILTERING_NODEBROADCAST);
-	default:
+	static const u8 af_map[] = {
+		[filtering_off] = PACKETCONFIG1_ADDRESSFILTERING_OFF,
+		[node_address] = PACKETCONFIG1_ADDRESSFILTERING_NODE,
+		[node_or_broadcast_address] =
+			PACKETCONFIG1_ADDRESSFILTERING_NODEBROADCAST,
+	};
+
+	if (unlikely(address_filtering >= ARRAY_SIZE(af_map))) {
 		dev_dbg(&spi->dev, "set: illegal input param");
 		return -EINVAL;
 	}
+
+	return rf69_read_mod_write(spi, REG_PACKETCONFIG1,
+				   MASK_PACKETCONFIG1_ADDRESSFILTERING,
+				   af_map[address_filtering]);
 }
 
 int rf69_set_payload_length(struct spi_device *spi, u8 payload_length)
@@ -824,17 +776,18 @@ int rf69_set_fifo_threshold(struct spi_device *spi, u8
threshold)
 
 int rf69_set_dagc(struct spi_device *spi, enum dagc dagc)
 {
-	switch (dagc) {
-	case normal_mode:
-		return rf69_write_reg(spi, REG_TESTDAGC, DAGC_NORMAL);
-	case improve:
-		return rf69_write_reg(spi, REG_TESTDAGC, DAGC_IMPROVED_LOWBETA0);
-	case improve_for_low_modulation_index:
-		return rf69_write_reg(spi, REG_TESTDAGC, DAGC_IMPROVED_LOWBETA1);
-	default:
+	static const u8 dagc_map[] = {
+		[normal_mode] = DAGC_NORMAL,
+		[improve] = DAGC_IMPROVED_LOWBETA0,
+		[improve_for_low_modulation_index] = DAGC_IMPROVED_LOWBETA1,
+	};
+
+	if (unlikely(dagc >= ARRAY_SIZE(dagc_map))) {
 		dev_dbg(&spi->dev, "set: illegal input param");
 		return -EINVAL;
 	}
+
+	return rf69_write_reg(spi, REG_TESTDAGC, dagc_map[dagc]);
 }
 
 /*-------------------------------------------------------------------------*/
-- 
2.18.0.rc2



