Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323B1C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAFB2208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SLLNyPgX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAFB2208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732424AbeKTKx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 05:53:26 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41369 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbeKTKxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 05:53:25 -0500
Received: by mail-pl1-f193.google.com with SMTP id u6so72908plm.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 16:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=za3ZZmNH7kHbx9dY/SRvZvZLX/+3fY71z53dJZPzB3U=;
        b=SLLNyPgXAIYJjcdurDXlgKoLYYwIhKx3iK/E1I3CteFVRUpxZ+EWo43D/Bbux3I0gl
         wCqbTGQEsdvq5bg4zU8SdIf/4eN3ixKnVxDhrLsuWezt85Iw1f+pSJDYAnfXkuGPDORW
         xXti3kiT4zwrpjOkzc9qQJx9gIUebfFv052SI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=za3ZZmNH7kHbx9dY/SRvZvZLX/+3fY71z53dJZPzB3U=;
        b=DJeH1s9U8alv1LuSBoonFf10alT+zb1d0l4+6rcTI2cgOdjdUUztnJz4unUgCPTCYr
         GuVhGssqL9epXG+8IeVYipS45TSG16P4nU8e3OYzV/D8jXjBF8H+23R+UJLOVl9vvpAo
         RtdaPjY5+lWSnCwKc68iQnOuwyQuqHr+lstlAFHHY/uFeEUC2JZ6/9NGsscdR6XzNbEx
         w5oQmDXD0mYGJ7CA/V0GmoucBDHKiXWYk/1Mx2NDwRIxOuP7MQWaQJ5raxx5gbQTVU6L
         mcHk4WJBm+gCRZRu84BXhcFdbDoQwGn7VyWfI31eChb6QIN121D5t01jhC5x3waD7Joy
         sdrQ==
X-Gm-Message-State: AA+aEWZ0x/kOXwSWO11ODhWklqrgRkyUzu5ra+ql5sQ0om3/zFWIlsax
        YNZ6z0JxEz0zhN/pmyBY3HCZfQ==
X-Google-Smtp-Source: AFSGD/XR/mmm7/eSZ+FE3Te+mPfT5Fk9zMCvJd5seVY+ghjeAm8S6fpVJK0fzVensyAtFQvrf+q0mQ==
X-Received: by 2002:a17:902:3281:: with SMTP id z1mr1794200plb.296.1542673627966;
        Mon, 19 Nov 2018 16:27:07 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id z83-v6sm55240218pfi.4.2018.11.19.16.27.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 16:27:07 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>, evgreen@chromium.org,
        swboyd@chromium.org, Dmitry Osipenko <digetx@gmail.com>,
        ryandcase@chromium.org, David Collins <collinsd@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] regulator: core: Don't assume always_on when is_enabled returns err
Date:   Mon, 19 Nov 2018 16:26:49 -0800
Message-Id: <20181120002654.1891-2-dianders@chromium.org>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
In-Reply-To: <20181120002654.1891-1-dianders@chromium.org>
References: <20181120002654.1891-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At boot sometimes regulators (like qcom-rpmh-regulator) will return
-EINVAL if we don't know the enable state of the regulator.  We
shouldn't take this to mean that the regulator is an always-on
regulator, but that was what was happening since "-EINVAL" is non-zero
and a few places in the code were not properly checking for errors.

Let's resolve this.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/regulator/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index ff5ca185bb8f..0052bbc8c531 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1622,7 +1622,7 @@ static struct regulator *create_regulator(struct regulator_dev *rdev,
 	 * enable/disable calls.
 	 */
 	if (!regulator_ops_is_valid(rdev, REGULATOR_CHANGE_STATUS) &&
-	    _regulator_is_enabled(rdev))
+	    _regulator_is_enabled(rdev) > 0)
 		regulator->always_on = true;
 
 	regulator_unlock(rdev);
@@ -1811,7 +1811,7 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 	}
 
 	/* Cascade always-on state to supply */
-	if (_regulator_is_enabled(rdev)) {
+	if (_regulator_is_enabled(rdev) > 0) {
 		ret = regulator_enable(rdev->supply);
 		if (ret < 0) {
 			_regulator_put(rdev->supply);
-- 
2.19.1.1215.g8438c0b245-goog

