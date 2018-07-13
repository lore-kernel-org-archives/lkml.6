Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBDAECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 12:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3507720871
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 12:56:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3507720871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729797AbeGMNLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 09:11:15 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48599 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729617AbeGMNLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 09:11:15 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1fdxck-0004cR-5Q; Fri, 13 Jul 2018 14:56:38 +0200
Received: from mfe by dude.hi.pengutronix.de with local (Exim 4.91)
        (envelope-from <mfe@pengutronix.de>)
        id 1fdxch-0003c1-Av; Fri, 13 Jul 2018 14:56:35 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     lgirdwood@gmail.com, broonie@kernel.org
Cc:     m.purski@samsung.com, p.paillet@st.com,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] regulator: core: fix _regulator_do_disable return value
Date:   Fri, 13 Jul 2018 14:56:24 +0200
Message-Id: <20180713125624.13783-1-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.18.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently _regulator_do_disable returns 0 if either the ena_pin nor the
ops.disbale() isn't present. This assumes that the call was successful
but it wasn't because disbaling isn't supported at all.

The last case of the if-chain should return -EINVAL, because disabling
isn't supported by the driver as it is done already by
_regulator_do_enable.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/regulator/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index bb1324f93143..69b4e096b632 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2311,6 +2311,8 @@ static int _regulator_do_disable(struct regulator_dev *rdev)
 		ret = rdev->desc->ops->disable(rdev);
 		if (ret != 0)
 			return ret;
+	} else {
+		return -EINVAL;
 	}
 
 	/* cares about last_off_jiffy only if off_on_delay is required by
-- 
2.18.0

