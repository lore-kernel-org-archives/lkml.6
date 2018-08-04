Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6850EC4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CBB2217C7
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:05:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CBB2217C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732904AbeHDLFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 07:05:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48736 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728340AbeHDLFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 07:05:19 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B8ED589C;
        Sat,  4 Aug 2018 09:05:20 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Bourque, Francis" <francis.bourque@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Anthony de Boer <adb@adb.ca>
Subject: [PATCH 4.9 16/32] pinctrl: intel: Read back TX buffer state
Date:   Sat,  4 Aug 2018 11:01:06 +0200
Message-Id: <20180804082650.774350159@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180804082649.908295462@linuxfoundation.org>
References: <20180804082649.908295462@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Thu, 24 Aug 2017 11:19:33 +0300
Subject: [PATCH 4.9 16/32] pinctrl: intel: Read back TX buffer state

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

commit d68b42e30bbacd24354d644f430d088435b15e83 upstream.

In the same way as it's done in pinctrl-cherryview.c we would provide
a readback TX buffer state.

Fixes: 17fab473693 ("pinctrl: intel: Set pin direction properly")
Reported-by: "Bourque, Francis" <francis.bourque@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Tested-by: "Bourque, Francis" <francis.bourque@intel.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Cc: Anthony de Boer <adb@adb.ca>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pinctrl/intel/pinctrl-intel.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -604,12 +604,17 @@ static int intel_gpio_get(struct gpio_ch
 {
 	struct intel_pinctrl *pctrl = gpiochip_get_data(chip);
 	void __iomem *reg;
+	u32 padcfg0;
 
 	reg = intel_get_padcfg(pctrl, offset, PADCFG0);
 	if (!reg)
 		return -EINVAL;
 
-	return !!(readl(reg) & PADCFG0_GPIORXSTATE);
+	padcfg0 = readl(reg);
+	if (!(padcfg0 & PADCFG0_GPIOTXDIS))
+		return !!(padcfg0 & PADCFG0_GPIOTXSTATE);
+
+	return !!(padcfg0 & PADCFG0_GPIORXSTATE);
 }
 
 static void intel_gpio_set(struct gpio_chip *chip, unsigned offset, int value)


