Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A5FC07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8629620854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:45:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8629620854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730179AbeIMSzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:55:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60716 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729967AbeIMSzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:55:01 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 21619D10;
        Thu, 13 Sep 2018 13:45:27 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 067/115] ASoC: rt5677: Fix initialization of rt5677_of_match.data
Date:   Thu, 13 Sep 2018 15:31:27 +0200
Message-Id: <20180913131827.810439351@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131823.327472833@linuxfoundation.org>
References: <20180913131823.327472833@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthias Kaehlcke <mka@chromium.org>

[ Upstream commit f861e3e28a3016a2064d9f600eaa92a530b732b4 ]

The driver expects to find the device id in rt5677_of_match.data, however
it is currently assigned to rt5677_of_match.type. Fix this.

The problem was found with the help of clang:
  sound/soc/codecs/rt5677.c:5010:36: warning: expression which evaluates to
  zero treated as a null pointer constant of type 'const void *'
  [-Wnon-literal-null-conversion]
    { .compatible = "realtek,rt5677", RT5677 },
                                      ^~~~~~

Fixes: ddc9e69b9dc2 ("ASoC: rt5677: Hide platform data in the module sources")
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Guenter Roeck <groeck@chromium.org>
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/codecs/rt5677.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -5017,7 +5017,7 @@ static const struct i2c_device_id rt5677
 MODULE_DEVICE_TABLE(i2c, rt5677_i2c_id);
 
 static const struct of_device_id rt5677_of_match[] = {
-	{ .compatible = "realtek,rt5677", RT5677 },
+	{ .compatible = "realtek,rt5677", .data = (const void *)RT5677 },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, rt5677_of_match);


