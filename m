Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534EFECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F97120834
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fEAbbkjR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F97120834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730974AbeGQUox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 16:44:53 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:42089 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730362AbeGQUox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 16:44:53 -0400
Received: by mail-pl0-f65.google.com with SMTP id f4-v6so928399plb.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 13:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=iFlZqAusiuiptPYJ+n9BZOWxMu3viScTErMsKjpysc0=;
        b=fEAbbkjRlVSifUuWZQyUvCVOLkBAOuCc85YBlRLRQwswqJdYl6AM1xIGAaCSq3TwGT
         XFBXNiG7+p5IJLFvS3r9aekU+uh+5wzGAQFWee364eD2nN/fqK4+9ynxLTIv55vzT1RQ
         aQhNFF9JT4rwl7geB3Kc4QRmUmy3UybLib7/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iFlZqAusiuiptPYJ+n9BZOWxMu3viScTErMsKjpysc0=;
        b=FfPH3MLwhj7IZWfzKFwhdDXWYCZv3Bkpg+WzUEIL61flENZaphW5u+eTQpQtNbs8b1
         Z10JujJxXiGgBFVRNfc+FjH94CT72IGFQo5K7T3J2HiZ/H7vlY+3IaP4yZdR6390NeZv
         kqCtzcITfHE55z/NmqDuAmQGQxG0tMOPlB/73dbipwnnu877Fmf7mD/F0rHymBp/owuf
         zTTLmcaw+uhrkvrAxYM0rWlGUxn/whd3ewOCfEQkdXhWUsgRfKr2Z+kY5LzawOviUkqj
         kpx1ZdTZqIa+ZFaS+hZtsatlQ73eJQWNd5haL/VIW9fTP6kZ8rCyKoEY9ohcc9fhZIr6
         DvQA==
X-Gm-Message-State: AOUpUlFmlu4tLeP0awDMy1/kqyKFWg4353xA/ciKtraoo7grWLD46EQN
        7s6zvBWc1J0NAl7ktVeXAxIZhg==
X-Google-Smtp-Source: AAOMgpeA9pVCbKvSdEsWcZOAz8fa8ki2BgdpaaVQSfaDXyTNA7HDKc5C7ycLU8r4MHji0w6ikpslqQ==
X-Received: by 2002:a17:902:a5:: with SMTP id a34-v6mr3052317pla.60.1531858239019;
        Tue, 17 Jul 2018 13:10:39 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:0:1000:1501:38e4:86fe:ec0c:4007])
        by smtp.gmail.com with ESMTPSA id d26-v6sm4532746pfl.159.2018.07.17.13.10.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 13:10:38 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Cc:     dmitry.torokhov@gmail.com,
        Douglas Anderson <dianders@chromium.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] usb: dwc2: host: do not delay retries after successful transfer
Date:   Tue, 17 Jul 2018 13:10:10 -0700
Message-Id: <20180717201010.175491-1-dianders@chromium.org>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

When handling split transactions we should not be delaying retrying
SSPLIT/CSPLIT after we successfully communicate with the device, so
let's reset dtd->num_naks counter when handling XFERCOMPL.

Fixes: 38d2b5fb75c1 ("usb: dwc2: host: Don't retry NAKed transactions right away")
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Move clearing num_naks to the start to avoid use after free

 drivers/usb/dwc2/hcd_intr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/dwc2/hcd_intr.c b/drivers/usb/dwc2/hcd_intr.c
index 8ce10caf3e19..4e1953b2955e 100644
--- a/drivers/usb/dwc2/hcd_intr.c
+++ b/drivers/usb/dwc2/hcd_intr.c
@@ -994,6 +994,8 @@ static void dwc2_hc_xfercomp_intr(struct dwc2_hsotg *hsotg,
 	int pipe_type;
 	int urb_xfer_done;
 
+	qtd->num_naks = 0;
+
 	if (dbg_hc(chan))
 		dev_vdbg(hsotg->dev,
 			 "--Host Channel %d Interrupt: Transfer Complete--\n",
-- 
2.18.0.203.gfac676dfb9-goog

