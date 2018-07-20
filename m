Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD903ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 21:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C0C620661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 21:51:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C0C620661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shmanahar.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbeGTWmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 18:42:03 -0400
Received: from avasout05.plus.net ([84.93.230.250]:41581 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728312AbeGTWmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 18:42:03 -0400
Received: from hairyalien ([80.229.148.18])
        by smtp with SMTP
        id gdJVf5Nmf05ijgdJWfGBtH; Fri, 20 Jul 2018 22:51:53 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=QJJGuDDL c=1 sm=1 tr=0
 a=o7Djd4SkmPXITDn8qH+ssQ==:117 a=o7Djd4SkmPXITDn8qH+ssQ==:17
 a=R9QF1RCXAYgA:10 a=V0UhwjhiAAAA:8 a=cm27Pg_UAAAA:8 a=oTaP97jFD5tAdmTDqxEA:9
 a=tiEEu-LGr7uwsMrZ:21 a=GSASkbulp0fwIRpx:21 a=_UVLBGXn8Au_dgoMdIS7:22
 a=xmb-EsYY8bH0VWELuYED:22
Received: by hairyalien (sSMTP sendmail emulation); Fri, 20 Jul 2018 22:51:49 +0100
From:   Nick Dyer <nick@shmanahar.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Chris Healy <cphealy@gmail.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Nick Dyer <nick.dyer@itdev.co.uk>
Subject: [PATCH v1 01/10] Input: atmel_mxt_ts - only use first T9 instance
Date:   Fri, 20 Jul 2018 22:51:13 +0100
Message-Id: <20180720215122.23558-1-nick@shmanahar.org>
X-Mailer: git-send-email 2.17.1
X-CMAE-Envelope: MS4wfGzjmYnaK7QAMwTlAdxXsOESMwsI11F/U5kC5w5tFmgX8FVle++vxCZoLkRG494tpkY6vBJosqyoNafcExBDsyYH5MzwqtYhgds0w82eLcRLyaNeEprz
 f/LUu3J+7e+N4kNgBntN80FkzYt4rgmA4dc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Dyer <nick.dyer@itdev.co.uk>

The driver only registers one input device, which uses the screen
parameters from the first T9 instance. The first T63 instance also uses
those parameters.

It is incorrect to send input reports from the second instances of these
objects if they are enabled: the input scaling will be wrong and the
positions will be mashed together.

This also causes problems on Android if the number of slots exceeds 32.

In the future, this could be handled by looking for enabled touch object
instances and creating an input device for each one.

Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
Acked-by: Benson Leung <bleung@chromium.org>
Acked-by: Yufeng Shen <miletus@chromium.org>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 54fe190fd4bc..48c5ccab00a0 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -1658,10 +1658,11 @@ static int mxt_parse_object_table(struct mxt_data *data,
 			break;
 		case MXT_TOUCH_MULTI_T9:
 			data->multitouch = MXT_TOUCH_MULTI_T9;
+			/* Only handle messages from first T9 instance */
 			data->T9_reportid_min = min_id;
-			data->T9_reportid_max = max_id;
-			data->num_touchids = object->num_report_ids
-						* mxt_obj_instances(object);
+			data->T9_reportid_max = min_id +
+						object->num_report_ids - 1;
+			data->num_touchids = object->num_report_ids;
 			break;
 		case MXT_SPT_MESSAGECOUNT_T44:
 			data->T44_address = object->start_address;
-- 
2.17.1

