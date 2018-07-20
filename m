Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D922ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 21:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D474E20661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 21:52:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D474E20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shmanahar.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731599AbeGTWmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 18:42:21 -0400
Received: from avasout06.plus.net ([212.159.14.18]:48149 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731402AbeGTWmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 18:42:20 -0400
Received: from hairyalien ([80.229.148.18])
        by smtp with SMTP
        id gdJpfIgPLWLW2gdJqf5XFo; Fri, 20 Jul 2018 22:52:11 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=fJUXI6Se c=1 sm=1 tr=0
 a=o7Djd4SkmPXITDn8qH+ssQ==:117 a=o7Djd4SkmPXITDn8qH+ssQ==:17
 a=R9QF1RCXAYgA:10 a=V0UhwjhiAAAA:8 a=rmrmLN10yKof2KZZh_oA:9
 a=VYi_7EKfSEZBtkSb:21 a=l9GQmagX8nqmyVhH:21 a=CdTG0GUg6pYA:10
 a=_UVLBGXn8Au_dgoMdIS7:22
Received: by hairyalien (sSMTP sendmail emulation); Fri, 20 Jul 2018 22:52:09 +0100
From:   Nick Dyer <nick@shmanahar.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Chris Healy <cphealy@gmail.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Nick Dyer <nick.dyer@itdev.co.uk>
Subject: [PATCH v1 08/10] Input: atmel_mxt_ts - don't report zero pressure from T9
Date:   Fri, 20 Jul 2018 22:51:20 +0100
Message-Id: <20180720215122.23558-8-nick@shmanahar.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180720215122.23558-1-nick@shmanahar.org>
References: <20180720215122.23558-1-nick@shmanahar.org>
X-CMAE-Envelope: MS4wfArrwff6rAY9vEW9ljHyUw0vkg1GYPgkyC+IWKsXwulvzX35UJiDasqGRKodHmOH+y0z2SuFI3UZP91BY3yftEu0M4pMdd9Zt4+VLUhNg62gW/0RZtlk
 0cGk7ryay5J0UJWBh6wy2QSDsz4BJUnOaxWa8wEzfYDgUiVIV43GFcBt
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Dyer <nick.dyer@itdev.co.uk>

If T9.CTRL DISAMP is set, then pressure is reported as zero. This means
some app layers (eg tslib) will ignore the contact.

Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 2d1fddafb7f9..d7023d261458 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -843,6 +843,10 @@ static void mxt_proc_t9_message(struct mxt_data *data, u8 *message)
 			mxt_input_sync(data);
 		}
 
+		/* if active, pressure must be non-zero */
+		if (!amplitude)
+			amplitude = MXT_PRESSURE_DEFAULT;
+
 		/* Touch active */
 		input_mt_report_slot_state(input_dev, MT_TOOL_FINGER, 1);
 		input_report_abs(input_dev, ABS_MT_POSITION_X, x);
-- 
2.17.1

