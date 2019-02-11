Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28590C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED3A4214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896063;
	bh=BCtdXOL9hqYQhvk0FzH8JxEVulc92xq/NUu+7gqz7m4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x+eWOM1nhD4qrLd7nj2Y5oK0Xj+jd7/0jyj9j2kKkhqhTALg/tOy6U3rjENx6VLjA
	 zqZLNetVtRoqs5g4IfUFw7k+zeYNX8aMNJciHofQHT/9r2QXo3UwHNjqyq2go567IC
	 UMuDBt5AyKRfsevgVzI/xsGCt2f8F2y1mCoVV1N4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732160AbfBKOlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:41:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:52032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731756AbfBKOk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:40:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D6DE20700;
        Mon, 11 Feb 2019 14:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896056;
        bh=BCtdXOL9hqYQhvk0FzH8JxEVulc92xq/NUu+7gqz7m4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QAFxUKWEanynV2/hAGWo3iZ78ydS3/Iqk+6uBy+Fz11UHiulvk425l/zJFM7cOMhS
         fX4l9YpI/6vrsLa8+27IQHrTaG1keI1ZNeR7HSzbmYrAYCXrWlW1V0/yvPM/FUCw9A
         Ctqs5+XM25ISDIannOzF/xvW+CWMbV0GMPVHfJAo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ioana Ciornei <ioana.ciornei@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 029/313] dpaa2-ptp: defer probe when portal allocation failed
Date:   Mon, 11 Feb 2019 15:15:09 +0100
Message-Id: <20190211141855.364128805@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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



