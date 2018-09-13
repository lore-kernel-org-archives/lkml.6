Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6656C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 972C320854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:53:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 972C320854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731170AbeIMTD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:03:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33750 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728810AbeIMTD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:03:27 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1F00DD19;
        Thu, 13 Sep 2018 13:53:50 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 057/197] pwm: meson: Fix mux clock names
Date:   Thu, 13 Sep 2018 15:30:06 +0200
Message-Id: <20180913131843.804736565@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jerome Brunet <jbrunet@baylibre.com>

[ Upstream commit b96e9eb62841c519ba1db32d036628be3cdef91f ]

Current clock name looks like this:
/soc/bus@ffd00000/pwm@1b000#mux0

This is bad because CCF uses the clock to create a directory in clk debugfs.
With such name, the directory creation (silently) fails and the debugfs
entry end up being created at the debugfs root.

With this change, the clock name will now be:
ffd1b000.pwm#mux0

This matches the clock naming scheme used in the ethernet and mmc driver.
It also fixes the problem with debugfs.

Fixes: 36af66a79056 ("pwm: Convert to using %pOF instead of full_name")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pwm/pwm-meson.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -458,7 +458,6 @@ static int meson_pwm_init_channels(struc
 				   struct meson_pwm_channel *channels)
 {
 	struct device *dev = meson->chip.dev;
-	struct device_node *np = dev->of_node;
 	struct clk_init_data init;
 	unsigned int i;
 	char name[255];
@@ -467,7 +466,7 @@ static int meson_pwm_init_channels(struc
 	for (i = 0; i < meson->chip.npwm; i++) {
 		struct meson_pwm_channel *channel = &channels[i];
 
-		snprintf(name, sizeof(name), "%pOF#mux%u", np, i);
+		snprintf(name, sizeof(name), "%s#mux%u", dev_name(dev), i);
 
 		init.name = name;
 		init.ops = &clk_mux_ops;


