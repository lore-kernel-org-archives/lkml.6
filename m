Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A14C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D921B2084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544545131;
	bh=JCfFih1gqxUaNACFlTxrYKZLLt5CJlEv6lqxsKf7mg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BsKwK3GSLeo9GBTmBsHBp3vvt65zIQypDGW8lHGzrA+9XPG0j8rzy3VJ4VXzB9pl5
	 x5vaYeoALI6ahBPo5o0PshXi3NFuP8yfzjIAyrq6eIHa9OSu9IGRkA4AAukhnYKUGl
	 EWeGdpca8KddcI0K2pX+1kd4+6JejOtGE+L8jS+c=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D921B2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbeLKQSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:18:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:34734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728312AbeLKPqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:46:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1857A2087F;
        Tue, 11 Dec 2018 15:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543178;
        bh=JCfFih1gqxUaNACFlTxrYKZLLt5CJlEv6lqxsKf7mg8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cIe3guQW5raGn2+aXsWdheBjxcIlm4migVqmdm9nAOV/TTJXOywelzwGuVO8Yh5eo
         0aXC2jM1054Zkq/4x0evg6elpTtmq2Ix++93mIz18S1CRVUFkvcVF74dsT7JmCfrnb
         yxee6wV/Mqr7XliOnPo1iBNSmbqIDpz2T0hELMzE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Markus Hofstaetter <markus.hofstaetter@ait.ac.at>,
        Jacek Anaszewski <j.anaszewski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 4.4 42/91] leds: call led_pwm_set() in leds-pwm to enforce default LED_OFF
Date:   Tue, 11 Dec 2018 16:41:01 +0100
Message-Id: <20181211151609.360457680@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151606.026852373@linuxfoundation.org>
References: <20181211151606.026852373@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Markus Hofstaetter <markus.hofstaetter@ait.ac.at>

commit f16703360da7731a057df2ffa902306819c22398 upstream.

Some PWMs are disabled by default or the default pin setting
does not match the LED_OFF state (e.g., active-low leds).
Hence, the driver may end up reporting 0 brightness, but
the leds are actually on using full brightness, because
it never enforces its default configuration.
So enforce it by calling led_pwm_set() after successfully
registering the device.

Tested on a Phytec phyFLEX i.MX6Q board based on kernel
v3.19.5.

Signed-off-by: Markus Hofstaetter <markus.hofstaetter@ait.ac.at>
Tested-by: Markus Hofstaetter <markus.hofstaetter@ait.ac.at>
Signed-off-by: Jacek Anaszewski <j.anaszewski@samsung.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/leds/leds-pwm.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/leds/leds-pwm.c
+++ b/drivers/leds/leds-pwm.c
@@ -132,6 +132,7 @@ static int led_pwm_add(struct device *de
 	ret = led_classdev_register(dev, &led_data->cdev);
 	if (ret == 0) {
 		priv->num_leds++;
+		led_pwm_set(&led_data->cdev, led_data->cdev.brightness);
 	} else {
 		dev_err(dev, "failed to register PWM led for %s: %d\n",
 			led->name, ret);


