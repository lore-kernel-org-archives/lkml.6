Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D55ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 21:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46A6D20661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 21:52:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46A6D20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shmanahar.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731774AbeGTWm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 18:42:26 -0400
Received: from avasout06.plus.net ([212.159.14.18]:48150 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731402AbeGTWmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 18:42:25 -0400
Received: from hairyalien ([80.229.148.18])
        by smtp with SMTP
        id gdJtfIgPjWLW2gdJvf5XG8; Fri, 20 Jul 2018 22:52:16 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=fJUXI6Se c=1 sm=1 tr=0
 a=o7Djd4SkmPXITDn8qH+ssQ==:117 a=o7Djd4SkmPXITDn8qH+ssQ==:17
 a=R9QF1RCXAYgA:10 a=V0UhwjhiAAAA:8 a=i_WjPEPfpYfp5gNgJU8A:9
 a=6G8YB_76TE7o_SSv:21 a=CHZDZPwrg5D3xYBf:21 a=_UVLBGXn8Au_dgoMdIS7:22
Received: by hairyalien (sSMTP sendmail emulation); Fri, 20 Jul 2018 22:52:13 +0100
From:   Nick Dyer <nick@shmanahar.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Chris Healy <cphealy@gmail.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Nick Dyer <nick.dyer@itdev.co.uk>
Subject: [PATCH v1 10/10] Input: atmel_mxt_ts - move completion to after config crc is updated
Date:   Fri, 20 Jul 2018 22:51:22 +0100
Message-Id: <20180720215122.23558-10-nick@shmanahar.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180720215122.23558-1-nick@shmanahar.org>
References: <20180720215122.23558-1-nick@shmanahar.org>
X-CMAE-Envelope: MS4wfJcR/YNZbKArKmLhk1ylzNmMZAZAScM+C94n5lAqK1bNe72Pj6Iz3btxpPyEo+Pgt10c+WdhppQ2++0g9mP8EFJc14BH/mT5Xvy+ZkZljqk4Rc9nzn1k
 r3W0qU8th2gY+OoR9KpjSRmmJZxf/9qrbjzZMlql3wP3MeD61RWMI5G7rluLy5axie3LKodzf+fEfg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Dyer <nick.dyer@itdev.co.uk>

Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index c31af790ef84..9f296a66c94e 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -728,13 +728,13 @@ static void mxt_proc_t6_messages(struct mxt_data *data, u8 *msg)
 	u8 status = msg[1];
 	u32 crc = msg[2] | (msg[3] << 8) | (msg[4] << 16);
 
-	complete(&data->crc_completion);
-
 	if (crc != data->config_crc) {
 		data->config_crc = crc;
 		dev_dbg(dev, "T6 Config Checksum: 0x%06X\n", crc);
 	}
 
+	complete(&data->crc_completion);
+
 	/* Detect reset */
 	if (status & MXT_T6_STATUS_RESET)
 		complete(&data->reset_completion);
-- 
2.17.1

