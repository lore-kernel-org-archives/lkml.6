Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B23FC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FAAA20852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:33:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FAAA20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933157AbeFRPdy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:33:54 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:39505 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753570AbeFRPdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:33:53 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue003 [212.227.15.129]) with ESMTPA (Nemesis) id
 0LnX10-1g8wbp2nKI-00hhoK; Mon, 18 Jun 2018 17:33:35 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] firewire: use 64-bit time_t based interfaces
Date:   Mon, 18 Jun 2018 17:33:26 +0200
Message-Id: <20180618153334.1963539-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:F2BG6/qS0Xhk/JqdSuWgaTWQaPAebwM/o92SgAJLn9V7E9crRxz
 NkDOQhI4CPGfB6eBPUJBlFK7ar8OHjTMuOgw3/lB39d4P5qddeuHqGCNpT+RSvUqa4hXnCz
 7xZhnYml+U0eesR9qPaV1z1EiB5J1i2FB52ImYa7v/RejXJvfIFGaWj5UnO9jB7qUPz58nh
 1V5hjm08gDDjTSBaHWlmA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KET7D8SOg5M=:eGq2tTNX7Ujr9yrflJhaHf
 Tpb6vjALwrgcc8xFm4XYWjzjVn90qoUHxEoAj7LArZ9xK0Jr/LnIN7H7roNAnhedxnRDr+JcU
 Ewp+jwAjxyXbEZ4XOA7yRkktrJcAGRcHE9zdyLUjZoMQsBMT0ooqKPvm/M896bS1471pyBNhe
 niox0bEwbmMM9V9ifKSUs6yKB7F/E+SqoTk0QpoZka5NhSD5tBopPFTpinfVY1gmDb8HjcmFL
 mMVNpih2HYeVF3Tzp5dJGaF/wteRsuk/V4D0WiaZWYe35XDD3MRwHzYmjdLPDPHyCjVT4rGVJ
 cJ0NtHMictDt4yTQV4W6vzT3eYb5EK7LF7kWwpHs9rpc43RmMqQ6SURqEDFIVLpGylZcnAujQ
 x65tqojwEzjHeD7xWfTHlzOuhWgh26CDkM3JZ4TofONT8WZaXaHSFgyRDP5AC04ACEb80po99
 FiaNCwx2efxtJvd9MQ//X8ykGrhy4De1AOU3CCjHO1sBemT4xEoJvCk+XnucHALa7hUJ4O2Fy
 lYEHRj1CIRuQUFqWusSOe7zWthBHCUZwux+brGK2pvtVTaory+Flk5bd11WGGAI+ZpjQk0uuO
 qFc50M8flWh5rfTa0TbhP+FY8hkB/BE0/YV1SDyUH/UPiLwgKJ86sCIC5EPy6yjG3pkupOFkY
 FmVhx0Odf5UgZZ/FFc+zuFH78OQ1568dFqcbuaIkY9hjOTuzLmRSO7ILP0EPPUn6RNn4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

32-bit CLOCK_REALTIME timestamps overflow in year 2038, so all such interfaces
are deprecated now. For the FW_CDEV_IOC_GET_CYCLE_TIMER2 ioctl, we already
support 64-bit timestamps, but the implementation still uses timespec.

This changes the code to use timespec64 instead with the appropriate
accessor functions.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/firewire/core-cdev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
index f0587273940e..d8e185582642 100644
--- a/drivers/firewire/core-cdev.c
+++ b/drivers/firewire/core-cdev.c
@@ -1205,7 +1205,7 @@ static int ioctl_get_cycle_timer2(struct client *client, union ioctl_arg *arg)
 {
 	struct fw_cdev_get_cycle_timer2 *a = &arg->get_cycle_timer2;
 	struct fw_card *card = client->device->card;
-	struct timespec ts = {0, 0};
+	struct timespec64 ts = {0, 0};
 	u32 cycle_time;
 	int ret = 0;
 
@@ -1214,9 +1214,9 @@ static int ioctl_get_cycle_timer2(struct client *client, union ioctl_arg *arg)
 	cycle_time = card->driver->read_csr(card, CSR_CYCLE_TIME);
 
 	switch (a->clk_id) {
-	case CLOCK_REALTIME:      getnstimeofday(&ts);	break;
-	case CLOCK_MONOTONIC:     ktime_get_ts(&ts);	break;
-	case CLOCK_MONOTONIC_RAW: getrawmonotonic(&ts);	break;
+	case CLOCK_REALTIME:      ktime_get_real_ts64(&ts);	break;
+	case CLOCK_MONOTONIC:     ktime_get_ts64(&ts);		break;
+	case CLOCK_MONOTONIC_RAW: ktime_get_raw_ts64(&ts);	break;
 	default:
 		ret = -EINVAL;
 	}
-- 
2.9.0

