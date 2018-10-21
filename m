Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9938ECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A5302083C
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:01:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A5302083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbeJVEQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 00:16:30 -0400
Received: from sauhun.de ([88.99.104.3]:45972 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728699AbeJVEQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 00:16:28 -0400
Received: from localhost (unknown [90.200.225.72])
        by pokefinder.org (Postfix) with ESMTPSA id 04CD62E35DD;
        Sun, 21 Oct 2018 22:01:00 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-serial@vger.kernel.org
Subject: [PATCH 0/1] tty: simplify getting .driver_data
Date:   Sun, 21 Oct 2018 22:00:58 +0200
Message-Id: <20181021200059.2294-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I got tired of fixing this in Renesas drivers manually, so I took the big
hammer. Remove this cumbersome code pattern which got copy-pasted too much
already:

-	struct platform_device *pdev = to_platform_device(dev);
-	struct ep93xx_keypad *keypad = platform_get_drvdata(pdev);
+	struct ep93xx_keypad *keypad = dev_get_drvdata(dev);

A branch, tested by buildbot, can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git coccinelle/get_drvdata

I have been asked if it couldn't be done for dev_set_drvdata as well. I checked
it and did not find one occasion where it could be simplified like this. Not
much of a surprise because driver_data is usually set in probe() functions
which access struct platform_device in many other ways.

I am open for other comments, suggestions, too, of course.

Here is the cocci-script I created:

@@
struct device* d;
identifier pdev;
expression *ptr;
@@
(
-	struct platform_device *pdev = to_platform_device(d);
|
-	struct platform_device *pdev;
	...
-	pdev = to_platform_device(d);
)
	<... when != pdev
-	&pdev->dev
+	d
	...>

	ptr =
-	platform_get_drvdata(pdev)
+	dev_get_drvdata(d)

	<... when != pdev
-	&pdev->dev
+	d
	...>

Kind regards,

   Wolfram


Wolfram Sang (1):
  tty: serial: qcom_geni_serial: simplify getting .driver_data

 drivers/tty/serial/qcom_geni_serial.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

-- 
2.19.0

