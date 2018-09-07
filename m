Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D12BC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F177020645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:18:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F177020645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbeIHCBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:01:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45046 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728641AbeIHCBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:01:37 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4093ADC4;
        Fri,  7 Sep 2018 21:18:49 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Rivshin <drivshin@allworx.com>,
        Pavel Machek <pavel@ucw.cz>,
        Ladislav Michl <ladis@linux-mips.org>,
        Andreas Kemnade <andreas@kemnade.info>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 4.18 105/145] pwm: omap-dmtimer: Return -EPROBE_DEFER if no dmtimer platform data
Date:   Fri,  7 Sep 2018 23:09:31 +0200
Message-Id: <20180907210912.414776227@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210903.617721278@linuxfoundation.org>
References: <20180907210903.617721278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Rivshin <DRivshin@allworx.com>

commit 43725feb593127b16318b871e3a9bf89a96d66cb upstream.

If a pwm-omap-dmtimer is probed before the dmtimer it uses, the platform
data won't be set yet.

Fixes: ac30751df953 ("ARM: OMAP: pdata-quirks: Remove unused timer pdata")
Cc: <stable@vger.kernel.org> # 4.17+
Signed-off-by: David Rivshin <drivshin@allworx.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
Tested-by: Pavel Machek <pavel@ucw.cz>
Acked-by: Ladislav Michl <ladis@linux-mips.org>
Tested-by: Andreas Kemnade <andreas@kemnade.info>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pwm/pwm-omap-dmtimer.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -264,8 +264,9 @@ static int pwm_omap_dmtimer_probe(struct
 
 	timer_pdata = dev_get_platdata(&timer_pdev->dev);
 	if (!timer_pdata) {
-		dev_err(&pdev->dev, "dmtimer pdata structure NULL\n");
-		ret = -EINVAL;
+		dev_dbg(&pdev->dev,
+			 "dmtimer pdata structure NULL, deferring probe\n");
+		ret = -EPROBE_DEFER;
 		goto put;
 	}
 


