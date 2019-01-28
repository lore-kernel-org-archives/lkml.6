Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99869C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ECB020855
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548696365;
	bh=tVhLaO8AFrXoV9RBbMbzy2X+9ZWeSUKzmb+unBx5Ulw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tlnWNQcyBhS9ixFqm9FRE1H+o7kaD7m2yf8afl/4vtEHO0Jcsr4ss8ga1ET1UXrcx
	 tACJVOpuyUdj/K2f/wPdUAQJxLjFvcmdw4UOx+RgCILb3rrMV1qXUZVRoYqwHvUBm3
	 64hmo1pcJTsXoJo5m1dS6EOtEBza0sxKExhPbARw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730873AbfA1QAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:00:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:46152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730512AbfA1QAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:00:51 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E35221919;
        Mon, 28 Jan 2019 16:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691251;
        bh=tVhLaO8AFrXoV9RBbMbzy2X+9ZWeSUKzmb+unBx5Ulw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=anKW3tmRdGDiwjwdSc9N8NwS5QRYjsOhmcLSacjsQazXHFZejtGnliV09T4h+ehtN
         04DRtVxBhv24PpIlhe6IswWzB41+NE12X3nXBwi5aOY3epEy4P8zMB2LrzPu0CqQlb
         blfQ+UCYwEDemZVcepaJojH+C/J8Q3YdnrugN0no=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ioana Ciornei <ioana.ciornei@nxp.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, devel@driverdev.osuosl.org
Subject: [PATCH AUTOSEL 4.19 032/258] dpaa2-ptp: defer probe when portal allocation failed
Date:   Mon, 28 Jan 2019 10:55:38 -0500
Message-Id: <20190128155924.51521-32-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ioana Ciornei <ioana.ciornei@nxp.com>

[ Upstream commit 5500598abbfb5b46201b9768bd9ea873a5eeaece ]

The fsl_mc_portal_allocate can fail when the requested MC portals are
not yet probed by the fsl_mc_allocator. In this situation, the driver
should defer the probe.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/fsl-dpaa2/rtc/rtc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/fsl-dpaa2/rtc/rtc.c b/drivers/staging/fsl-dpaa2/rtc/rtc.c
index 0d52cb85441f..318a33c2f7a7 100644
--- a/drivers/staging/fsl-dpaa2/rtc/rtc.c
+++ b/drivers/staging/fsl-dpaa2/rtc/rtc.c
@@ -142,7 +142,10 @@ static int rtc_probe(struct fsl_mc_device *mc_dev)
 
 	err = fsl_mc_portal_allocate(mc_dev, 0, &mc_dev->mc_io);
 	if (err) {
-		dev_err(dev, "fsl_mc_portal_allocate err %d\n", err);
+		if (err == -ENXIO)
+			err = -EPROBE_DEFER;
+		else
+			dev_err(dev, "fsl_mc_portal_allocate err %d\n", err);
 		goto err_exit;
 	}
 
-- 
2.19.1

