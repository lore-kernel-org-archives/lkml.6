Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6B3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD65A21841
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217621;
	bh=cGVaHaFpVlp46Bl4yfgmOul59RwIyk7iLGES9QFouCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zAWA9XuGIIEaP3+M1jWO8JpeBSpkhoM82vSDYUG9+sDCLmFZEQ/xGC03rycWn00Wa
	 PmEyMk+WCUgeBzTw43bw9/1HF6HfiiKaoCOpLrNZU5e8Z9sn7RsRUc/Xn+fNdeDpUy
	 J8uWihb5+EPPetlWeycZyBfgEpyRWbAzfkqwiNwo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391201AbfAKOkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:40:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:32892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403872AbfAKOkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:40:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C19621841;
        Fri, 11 Jan 2019 14:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217617;
        bh=cGVaHaFpVlp46Bl4yfgmOul59RwIyk7iLGES9QFouCY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mvHOaJi3mrvCL1zM+5Ur8YVWfF9+JJdmTrJfPYlRGb8wYnI8VCXOBQ58JxuJTXrPg
         S3oLUIN+QSiMBoyGSOY9uRHjqQxO8a30fcuF3Go1zbkOOz/kbmzP5Lu2s4Fy/frxH+
         sNEEIPI2YB7ePGe6dHyUW/kGwmcbd05Y6nM4+SvY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Benjamin Drung <bdrung@debian.org>
Subject: [PATCH 4.19 127/148] leds: pwm: silently error out on EPROBE_DEFER
Date:   Fri, 11 Jan 2019 15:15:05 +0100
Message-Id: <20190111131119.361732998@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jerome Brunet <jbrunet@baylibre.com>

commit 9aec30371fb095a0c9415f3f0146ae269c3713d8 upstream.

When probing, if we fail to get the pwm due to probe deferal, we shouldn't
print an error message. Just be silent in this case.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Benjamin Drung <bdrung@debian.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/leds/leds-pwm.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/leds/leds-pwm.c
+++ b/drivers/leds/leds-pwm.c
@@ -100,8 +100,9 @@ static int led_pwm_add(struct device *de
 		led_data->pwm = devm_pwm_get(dev, led->name);
 	if (IS_ERR(led_data->pwm)) {
 		ret = PTR_ERR(led_data->pwm);
-		dev_err(dev, "unable to request PWM for %s: %d\n",
-			led->name, ret);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "unable to request PWM for %s: %d\n",
+				led->name, ret);
 		return ret;
 	}
 


