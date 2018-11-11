Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DCAC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5271521508
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSekeb9/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5271521508
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391143AbeKLIXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:23:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:58276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390512AbeKLIXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:23:49 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCC3722353;
        Sun, 11 Nov 2018 22:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975631;
        bh=Q8KcYF0Fo1D1/1pxxNT69goE2EzziNqu0dp6LMzDhZw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HSekeb9/AAB/cvjGK+bu5LJrtIJtX0V2USR62zL9ccD2kvanrVX3/7g9CvxiKDKlt
         lnr0ZbmcAwetrKpmBod7ZUqQHPZsJV/OwBdHz5/Zk7dwY3wxr4taVd7G/aE6H7nvmh
         nTpuLZS+W8LJyjQWOV7tK8Pt1OAuU8NL4zAgK1TE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 048/141] pinctrl: spmi-mpp: Fix pmic_mpp_config_get() to be compliant
Date:   Sun, 11 Nov 2018 14:25:07 -0800
Message-Id: <20181111221634.086507943@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221627.853046496@linuxfoundation.org>
References: <20181111221627.853046496@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit 0d5b476f8f57fcb06c45fe27681ac47254f63fd2 ]

If you look at "pinconf-groups" in debugfs for ssbi-mpp you'll notice
it looks like nonsense.

The problem is fairly well described in commit 1cf86bc21257 ("pinctrl:
qcom: spmi-gpio: Fix pmic_gpio_config_get() to be compliant") and
commit 05e0c828955c ("pinctrl: msm: Fix msm_config_group_get() to be
compliant"), but it was pointed out that ssbi-mpp has the same
problem.  Let's fix it there too.

NOTE: in case it's helpful to someone reading this, the way to tell
whether to do the -EINVAL or not is to look at the PCONFDUMP for a
given attribute.  If the last element (has_arg) is false then you need
to do the -EINVAL trick.

ALSO NOTE: it seems unlikely that the values returned when we try to
get PIN_CONFIG_BIAS_PULL_UP will actually be printed since "has_arg"
is false for that one, but I guess it's still fine to return different
values so I kept doing that.  It seems like another driver (ssbi-gpio)
uses a custom attribute (PM8XXX_QCOM_PULL_UP_STRENGTH) for something
similar so maybe a future change should do that here too.

Fixes: cfb24f6ebd38 ("pinctrl: Qualcomm SPMI PMIC MPP pin controller driver")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pinctrl/qcom/pinctrl-spmi-mpp.c |   19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

--- a/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
@@ -345,13 +345,12 @@ static int pmic_mpp_config_get(struct pi
 
 	switch (param) {
 	case PIN_CONFIG_BIAS_DISABLE:
-		arg = pad->pullup == PMIC_MPP_PULL_UP_OPEN;
+		if (pad->pullup != PMIC_MPP_PULL_UP_OPEN)
+			return -EINVAL;
+		arg = 1;
 		break;
 	case PIN_CONFIG_BIAS_PULL_UP:
 		switch (pad->pullup) {
-		case PMIC_MPP_PULL_UP_OPEN:
-			arg = 0;
-			break;
 		case PMIC_MPP_PULL_UP_0P6KOHM:
 			arg = 600;
 			break;
@@ -366,13 +365,17 @@ static int pmic_mpp_config_get(struct pi
 		}
 		break;
 	case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
-		arg = !pad->is_enabled;
+		if (pad->is_enabled)
+			return -EINVAL;
+		arg = 1;
 		break;
 	case PIN_CONFIG_POWER_SOURCE:
 		arg = pad->power_source;
 		break;
 	case PIN_CONFIG_INPUT_ENABLE:
-		arg = pad->input_enabled;
+		if (!pad->input_enabled)
+			return -EINVAL;
+		arg = 1;
 		break;
 	case PIN_CONFIG_OUTPUT:
 		arg = pad->out_value;
@@ -384,7 +387,9 @@ static int pmic_mpp_config_get(struct pi
 		arg = pad->amux_input;
 		break;
 	case PMIC_MPP_CONF_PAIRED:
-		arg = pad->paired;
+		if (!pad->paired)
+			return -EINVAL;
+		arg = 1;
 		break;
 	case PIN_CONFIG_DRIVE_STRENGTH:
 		arg = pad->drive_strength;


