Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA296ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6951D20B80
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jndouleD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6951D20B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbeGPOAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 10:00:37 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]:46562 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727203AbeGPOAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 10:00:37 -0400
Received: by mail-lj1-f176.google.com with SMTP id 203-v6so18932323ljj.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 06:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=dtTHErLXXYUHpBrEpItQDU1aGr1jDekHRSZh96OPQ0M=;
        b=jndouleDYOUJ3an9D4XL+w6ijuv1n4QPWqdSbzKXFV78JUfZ2cMvVGpu6HyLSV/1ge
         mCUGiENSCXgcXuFiEWNQsCctqIpLKolo/C3OTW7vsB7Q7ZE8IyxJxqcCBlsixpjkbg+k
         UAAcEfQPf0SIK4gq6dJgur1jYE9/GhNqJ2j5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dtTHErLXXYUHpBrEpItQDU1aGr1jDekHRSZh96OPQ0M=;
        b=JBvsmiOFCo9d43n7e56Ka2BAISLpTnWP+4eHmUh64TVoWdQT4e+E3waNlgbkE763Sv
         0Fh5n8U66jxNuZommmQWOWr9fv+fkOcQDtKAbQIg9VH4+A/tQNlGLgZhm2rm9Boo72ou
         GEqul97BHDssJlpUVtp5VJBq9bv0H7zlRJUgdykAWT4/S0tLdJfGYTBiD90VrN1hKGqr
         o7Bp+TwI/xKXWZvz/xQCjLRxLXmOy9D7h37SwYB1K/PtBp9KPPEMQeH3XFm+z0KCl/Ec
         ol8f1aCKo6hrlzmjg0r164dUMT/8SITyStiT8tGh5vQQy2NyfMqLcIAjpylusfIv9Krt
         iYvw==
X-Gm-Message-State: AOUpUlFd2NWCh2Szff/n8eNEulFiW4mHve986qjlmWBtQl0sJVKkVeXd
        gRkPSwm5R0yDojRW4h+NgO7YUw==
X-Google-Smtp-Source: AAOMgpdjRuZ6Fo0bqcv+6dDDnBIR6XV2pe6UPZLj5//AnWSgd+jV/s69GdwtKhAVUT6MzKiqz7RRJA==
X-Received: by 2002:a2e:9bc9:: with SMTP id w9-v6mr9827917ljj.33.1531747988065;
        Mon, 16 Jul 2018 06:33:08 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id a14-v6sm3820390ljb.49.2018.07.16.06.33.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 06:33:07 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     broonie@kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, johan@kernel.org,
        Niklas Cassel <niklas.cassel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] regulator: qcom_spmi: fix Bad of_node_put() splat
Date:   Mon, 16 Jul 2018 15:32:50 +0200
Message-Id: <20180716133255.1506-1-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix Bad of_node_put() splat, and some minor checkpatch issues.


Changes since v1:
-Use of_get_child_by_name() instead of of_find_node_by_name().

Niklas Cassel (4):
  regulator: qcom_spmi: Fix warning Bad of_node_put()
  regulator: qcom_spmi: Use correct regmap when checking for error
  regulator: qcom_spmi: Do not initialise static to NULL
  regulator: qcom_spmi: Indent with tabs instead of spaces

 drivers/regulator/qcom_spmi-regulator.c | 38 +++++++++++++++----------
 1 file changed, 23 insertions(+), 15 deletions(-)

-- 
2.17.1

