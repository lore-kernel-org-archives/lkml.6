Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D834EC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C2742083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="vjv+Y2M/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C2742083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730881AbeGZOxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 10:53:08 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:56442 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730106AbeGZOxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 10:53:06 -0400
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 88D7B5C1E35;
        Thu, 26 Jul 2018 15:36:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1532612170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:content-type:content-transfer-encoding:
         in-reply-to:references; bh=30oDltP7/vKP6oTX6UwpMIgFDD8ejlNRnvq8I2WNAKI=;
        b=vjv+Y2M/6JzgEySlGJPPi9KsCvfjeOq5la9quok8SYx9IMlTlcnLtpz6BhH9/krXWawyPO
        RAP/PgViOPqPLx5iDSm+XCQKAzdcUClvOhQtZzHE1x7+YHodxcRJ5izLNIv57RrVNuFvDd
        8KnP3bbUIElBzxxx9ZVGz6+XcmY3EZI=
From:   Stefan Agner <stefan@agner.ch>
To:     thierry.reding@gmail.com, airlied@linux.ie
Cc:     jonathanh@nvidia.com, dri-devel@lists.freedesktop.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH] drm/tegra: return with probe defer if GPIO subsystem is not ready
Date:   Thu, 26 Jul 2018 15:36:06 +0200
Message-Id: <20180726133606.14587-1-stefan@agner.ch>
X-Mailer: git-send-email 2.18.0
X-Spamd-Result: default: False [-2.10 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[7];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         MID_CONTAINS_FROM(1.00)[];
         ASN(0.00)[asn:6830, ipnet:46.140.0.0/17, country:AT];
         RCVD_TLS_ALL(0.00)[];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the GPIO subsystem is not ready make sure to return -EPROBE_DEFER
instead of silently continuing without HPD.

Reported-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/gpu/drm/tegra/output.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tegra/output.c b/drivers/gpu/drm/tegra/output.c
index ffe34bd0bb9d..4bcefe455afd 100644
--- a/drivers/gpu/drm/tegra/output.c
+++ b/drivers/gpu/drm/tegra/output.c
@@ -133,7 +133,9 @@ int tegra_output_probe(struct tegra_output *output)
 	output->hpd_gpio = of_get_named_gpio_flags(output->of_node,
 						   "nvidia,hpd-gpio", 0,
 						   &output->hpd_gpio_flags);
-	if (gpio_is_valid(output->hpd_gpio)) {
+	if (output->hpd_gpio == -EPROBE_DEFER) {
+		return -EPROBE_DEFER;
+	} else if (gpio_is_valid(output->hpd_gpio)) {
 		unsigned long flags;
 
 		err = gpio_request_one(output->hpd_gpio, GPIOF_DIR_IN,
-- 
2.18.0

