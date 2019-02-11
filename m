Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40C0C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95F71222AA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549894932;
	bh=oHtb8RQjyGHeXqg4WDiOfECALbbC1hqoUBGnPZso5c0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GnZHvlVlOgfvYcNnU/Fm+Bgkbi8yPQdmkzgTRz5fs4PzqSkyi1Zi863rf5RxKCdIK
	 xa/+NtRrl3sQ0L4WCcbhsNTWDKIEkO4m/TQUOxplf+5YDQB68vu3kkvxUwwZ7zv+Oi
	 sedpAe8+iXy5CCKBN3qzFQ5KcvJBppZfoT2XDnbQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbfBKOWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:22:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:55058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728677AbfBKOWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:22:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E1FC20844;
        Mon, 11 Feb 2019 14:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549894929;
        bh=oHtb8RQjyGHeXqg4WDiOfECALbbC1hqoUBGnPZso5c0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zOp4PRMSwgPIZC7LTryAhLA9wyf+h5oVQ4LJCtnUN+ta81f4MjfZqRI43eqIaPL4v
         8foZZ9y/onlW2XzJPi3O4lOdTzGgGDknDe5F2PRoqtxqakc0SkBTAI/X5kh7QuYiza
         YSlBzXVv6tzPQMgPVQWGJyZgalrSq6nyStINQr2Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ioana Ciornei <ioana.ciornei@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 034/352] dpaa2-ptp: defer probe when portal allocation failed
Date:   Mon, 11 Feb 2019 15:14:21 +0100
Message-Id: <20190211141848.511147253@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 5500598abbfb5b46201b9768bd9ea873a5eeaece ]

The fsl_mc_portal_allocate can fail when the requested MC portals are
not yet probed by the fsl_mc_allocator. In this situation, the driver
should defer the probe.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c
index 84b942b1eccc..9b150db3b510 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c
@@ -140,7 +140,10 @@ static int dpaa2_ptp_probe(struct fsl_mc_device *mc_dev)
 
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



