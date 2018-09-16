Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC8AECE561
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 23:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 875EB214AB
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 23:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WwCh3U3L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 875EB214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbeIQFKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 01:10:38 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:42245 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbeIQFKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 01:10:38 -0400
Received: by mail-io1-f68.google.com with SMTP id n18-v6so10035740ioa.9
        for <linux-kernel@vger.kernel.org>; Sun, 16 Sep 2018 16:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=QmWCxZVD75+DiVDbUSg7usGzB9VZQhy8o0+4TV31j2Q=;
        b=WwCh3U3LQbWxF26jNYmBZ6ZAVpWb29sBrSVkKN7dIXCbpVNFlSViJQAqoPfOkeLt1n
         AAENCFexi57H7zHpgYPRPfjkvo8n3cmuH+73/QVSfqW1+EUWOqnAtCy4Hz8vJDnRi40U
         5FpWVCp9NOt/CJL4IeRMxvhPjQYPgXpMSCG4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QmWCxZVD75+DiVDbUSg7usGzB9VZQhy8o0+4TV31j2Q=;
        b=WyhWbqcLFiPy/4e643qBku26oWngKXC88xWjFMuh/iM5Asi326esQ54uNxXzxEvaYj
         Civ1WCBan10JPvcQ0pQT8bLcauNGl8mHm3sreqhVFjlUXBPXRxZB3kTTMfsaVEiTPIe3
         F8jN9SX1h+tNVFrnJS/WRLEKyeQ9RolYbqOqoZiVuEWn769AKdVGXQp87KKQ/67K6dc3
         NqfgsdncREpNs9kvOntA1bKxgmoXyYmJhU3FhqMxBkDfT4s8C2+qy399OzwV1D7g8gAz
         xSEQLZFj1pR4KlHYFlmDPrr3LarcbX6rRMIQvCFRfTjfc+XdwSPcjtUJdxpRVMznkAu9
         YSIg==
X-Gm-Message-State: APzg51BFeVV5UXLpypDDoe2ELj9X2yK1h8W0meEowCsMegpfdA9qw6eH
        U05c4Hd4Ao/uiWsYXDkaWVHV6g==
X-Google-Smtp-Source: ANB0VdZVZjKKhOoejcphrCJVB2Q4QJptC0SESQ9GLjVEhZPzg2NbCt0obR3UHMY3wFIfvN+UZreFlg==
X-Received: by 2002:a6b:8bc5:: with SMTP id n188-v6mr17978516iod.184.1537141557057;
        Sun, 16 Sep 2018 16:45:57 -0700 (PDT)
Received: from localhost.localdomain ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id a11-v6sm4495177ioc.63.2018.09.16.16.45.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Sep 2018 16:45:56 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        vkoul@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/7] slimbus: fix module loading
Date:   Sun, 16 Sep 2018 16:45:39 -0700
Message-Id: <20180916234546.29661-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.9.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Hi Greg,

Here are some of the fixes for issues found while testing module loading
on DB820c debian setup.

First 3 core fixes are to do with generating uevents, calling status callback in
probe sequence if the device is up and one fix is able to match device id from
device tree compatible strings.
Second 4 ngd patches fixes few issues firstly with registration, secondly checking
the validity of logical address assigned by remote. Lastly there are few typo fixes.


Thanks,
Srini


Srinivas Kandagatla (7):
  slimbus: core: add support to uevent
  slimbus: core: update device status in probe
  slimbus: core: match device tree based devices correctly
  slimbus: ngd: validate logical address assigned by remote
  silmbus: ngd: register controller after power up.
  slimbus: ngd: return proper error code instead of zero
  slimbus: ngd: register ngd driver only once.

 drivers/slimbus/core.c          | 37 +++++++++++++++++++++++++++++++++++--
 drivers/slimbus/qcom-ngd-ctrl.c | 28 +++++++++++++++++-----------
 2 files changed, 52 insertions(+), 13 deletions(-)

-- 
2.9.3

