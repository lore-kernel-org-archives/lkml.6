Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7A4C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 03:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DE562087B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 03:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="06tPqe9/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DE562087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbeH2HDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 03:03:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:35002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726857AbeH2HDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 03:03:18 -0400
Received: from localhost (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CF8620850;
        Wed, 29 Aug 2018 03:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535512119;
        bh=r8J7arHwsn2U8MMIt4qVF+0eQess58UBuTNvx0OtASo=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=06tPqe9/yPjXu03g2XUE46PHGm6ZV5EWzt8SApUN+1tUBZOcTOf8mm7OYIN79pop1
         3WTTOqyYkSNJRACQUM26qtWvGWhrqoTq01dYpNZGkBpPf8JgKpXWYtBI6uNgP31wte
         8qBjbzSzLZdEEKqZwgIBPZw4Nis6MHbfgtwF59kU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     "A.s. Dong" <aisheng.dong@nxp.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <AM0PR04MB4211368561A415B255782CBE803D0@AM0PR04MB4211.eurprd04.prod.outlook.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "thor.thayer@linux.intel.com" <thor.thayer@linux.intel.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
References: <1527244643-10736-1-git-send-email-aisheng.dong@nxp.com>
 <AM0PR04MB421114F8AFAE56B6D7C2D1E480770@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <AM0PR04MB4211368561A415B255782CBE803D0@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <153551211897.129321.14630649454821319736@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: RE: [PATCH V3 0/4] clk: new APIs to handle all available clocks
Date:   Tue, 28 Aug 2018 20:08:38 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting A.s. Dong (2018-08-16 19:33:52)
> Hi Stephen,
> =

> Do you want me to resend this series for review?
> It seems have been pending for quite a long time.
> =

> Thor just pinged me for its status as he wants to use it.
> =


I was waiting for someone to try them out or review them. Good that it
happened!

I've taken a look at the patches and I'm slightly annoyed with the API
that passes in a double pointer to clk_bulk_data and returns a count of
the number of clks found. I guess it's ok though. It's really just this
line:

	devres->clks =3D *clks;

which makes my brain all confused and go think about what's being
assigned and if it's a struct copy or not.

Maybe this on top would make it easier to take? I'll think about it
tonight.

---8<---
diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
index 6d3ca5ec5de8..12c87457eca1 100644
--- a/drivers/clk/clk-devres.c
+++ b/drivers/clk/clk-devres.c
@@ -81,9 +81,9 @@ int __must_check devm_clk_bulk_get_all(struct device *dev,
 	if (!devres)
 		return -ENOMEM;
 =

-	ret =3D clk_bulk_get_all(dev, clks);
+	ret =3D clk_bulk_get_all(dev, &devres->clks);
 	if (ret > 0) {
-		devres->clks =3D *clks;
+		*clks =3D devres->clks;
 		devres->num_clks =3D ret;
 		devres_add(dev, devres);
 	} else {
