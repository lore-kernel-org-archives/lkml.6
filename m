Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43372C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 20:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E048520862
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 20:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ct+kS34N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E048520862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730989AbeGZV0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 17:26:24 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46341 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730402AbeGZV0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 17:26:24 -0400
Received: by mail-pg1-f193.google.com with SMTP id p23-v6so1796629pgv.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 13:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YCd02/vZxpMRlLHq7ybx5SvTkjkTxXqzWT78stp+hMw=;
        b=ct+kS34NZ3WDSxHib4Np79lqIZVBgcbR2PXaSbW+F8rF0UlVvAv8Qc8rBDRgGyLRNc
         adLFHX93ew/4LgbwcLMuxLkBtLOgcjfVZI3WOZ/xDPeYvhuUwxOaUwcJ7YvvWDOohhWZ
         4+Ihqnw8Fy6gEyO/xkHQpaZH3dzIxXyDOOkuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YCd02/vZxpMRlLHq7ybx5SvTkjkTxXqzWT78stp+hMw=;
        b=Zov9j9GNdTGjHlzrsnri9Q1pcyfPwq9VHgB8hKD9sMpVGDUq0PBH5KSupXabU7HBQ/
         2yf0sLz3KqpiMKB/HXfe4m0nqnBXX7ThYNwjsOUdPL7UfgfWF27sIwzB3r0l2PrpbtTk
         hYSScNyFox5FlQxvuRelxQQb0OpaqQe1ao/fU5ceuOKGWqycg8QjQjxFC0aHhbdt7gxN
         BXMilO4X3hSQSQf0+kRyENHsYdjRL0jbVsyEBmZPWmDyvCAGonaa8X7A91NP+a437Cfc
         G7iynwZ++b6/qT2Ws94JU3OLm4mfT/9EuywqE50K4OmEWhrAkaKb2eGAWuek9I9HEfwA
         kNQA==
X-Gm-Message-State: AOUpUlH3UTJkFoXD8BvgHB0os89kep6mZTrQjTbvCIgS3K4/f8LQAeqz
        qKBdiAnhSCpLFWcrKPGQmZOXpQ==
X-Google-Smtp-Source: AAOMgpctpliepydZIdjwcvave/W+iGH40G0PASuXWg7hzHdtylPJp/9mBa/Eee8hhCwtLM+DKB1RyA==
X-Received: by 2002:a62:57dc:: with SMTP id i89-v6mr3518847pfj.65.1532635678848;
        Thu, 26 Jul 2018 13:07:58 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:0:1000:1501:38e4:86fe:ec0c:4007])
        by smtp.gmail.com with ESMTPSA id u11-v6sm5784169pfd.117.2018.07.26.13.07.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 13:07:57 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     balbi@kernel.org, hminas@synopsys.com, gregkh@linuxfoundation.org
Cc:     stefan.wahren@i2se.com, grigor.tovmasyan@synopsys.com,
        Bruno Herrera <bruherrera@gmail.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>, john.stultz@linaro.org,
        Stephen Warren <swarren@wwwdotorg.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Douglas Anderson <dianders@chromium.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [REPOST PATCH 0/4] usb: dwc2: Turn on uframe sched everywhere
Date:   Thu, 26 Jul 2018 13:07:26 -0700
Message-Id: <20180726200730.18290-1-dianders@chromium.org>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While looking at a dwc2 recently, I noticed that some platforms still
have the uframe scheduler off.  As far as I know, nothing good can
come out of having the uframe scheduler off.  Let's turn it on
everywhere.  Assuming this all works out then some time in the future
we can gut all the old code that handles the old non-uframe scheduler
and make everything simpler.

This is a repost of the original "RFT" (request for testing) series I
posted a few weeks ago but without the "RFT" prefix.  Two of the
patches in the series now have "Tested-by:" tags.  Since there should
be nothing platform specific about the uFrame scheduler presumably
this should mean we're good to go?  Specificaly note that in at least
one of the "Tested-by" reports this patch caused a notable
improvement.

In response to the original RFT, some notes about testing this:
- In general, try to have lots of things plugged in.
- Plug many different keyboards / mice in.  See if keys are
  dropped / mouse is jerky.
- Try USB audio (ideally full speed, not high speed).  How is
  the audio?
- If you're brave, try a USB webcam.  How is the video?
  ...maybe try including patches from crbug.com/820961 too.


Douglas Anderson (4):
  usb: dwc2: Turn on uframe_sched on "bcm" platforms
  usb: dwc2: Turn on uframe_sched on "his" platforms
  usb: dwc2: Turn on uframe_sched on "amlogic" platforms
  usb: dwc2: Turn on uframe_sched on "stm32f4x9_fsotg" platforms

 drivers/usb/dwc2/params.c | 4 ----
 1 file changed, 4 deletions(-)

-- 
2.18.0.345.g5c9ce644c3-goog

