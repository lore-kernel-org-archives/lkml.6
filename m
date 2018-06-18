Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFB2C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4729520836
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="f0iXjn5R";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="f0iXjn5R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4729520836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935562AbeFRRmL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 13:42:11 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59838 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934957AbeFRRmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 13:42:09 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E74E86071B; Mon, 18 Jun 2018 17:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529343728;
        bh=42K5hmfQhLdTMx03WgK4MIq3rsmSPfZx+0/Fj7znTzs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f0iXjn5RoBvH69HkqFoVNvVJIa9JSV9oGsPWDBX+K4B0TQ3K0rA6GNg+oiOhu683l
         exMx5qAZm9W/1ftcICXDRlTFx9iuAfJM5OFdKtREGhruAbPHX1xhz2tMNXKDrFxPb1
         sIcIGXozexvR0kfIFHji59LhnKQMq3lr/4ORFG4Q=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EBBC5607EB;
        Mon, 18 Jun 2018 17:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529343728;
        bh=42K5hmfQhLdTMx03WgK4MIq3rsmSPfZx+0/Fj7znTzs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f0iXjn5RoBvH69HkqFoVNvVJIa9JSV9oGsPWDBX+K4B0TQ3K0rA6GNg+oiOhu683l
         exMx5qAZm9W/1ftcICXDRlTFx9iuAfJM5OFdKtREGhruAbPHX1xhz2tMNXKDrFxPb1
         sIcIGXozexvR0kfIFHji59LhnKQMq3lr/4ORFG4Q=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EBBC5607EB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Mon, 18 Jun 2018 11:42:07 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     andy.gross@linaro.org, tdas@codeaurora.org,
        collinsd@codeaurora.org, sboyd@kernel.org, broonie@kernel.org,
        rplsssn@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, David Brown <david.brown@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: qcom: rpmh-rsc: Check cmd_db_ready() to help
 children
Message-ID: <20180618174207.GF21724@codeaurora.org>
References: <20180618172230.241960-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180618172230.241960-1-dianders@chromium.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18 2018 at 11:23 -0600, Douglas Anderson wrote:
>Children of RPMh will need access to cmd_db.  Rather than having each
>child have code to check if cmd_db is ready let's add the check to
>RPMh.
>
>Suggested-by: Stephen Boyd <sboyd@kernel.org>
>Signed-off-by: Douglas Anderson <dianders@chromium.org>
Acked-by: Lina Iyer <ilina@codeaurora.org>
>---
>This code is based upon v11 of Lina and Raju's RPMh series.
>
>With this we'll be able to remove this boilerplate code from
>clk-rpmh.c and qcom-rpmh-regulator.c.  Neither of these files has
>landed upstream yet but patches are pretty far along.
>
> drivers/soc/qcom/rpmh-rsc.c | 13 +++++++++++++
> 1 file changed, 13 insertions(+)
>
>diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
>index 144a058407c0..ad85523bdd3b 100644
>--- a/drivers/soc/qcom/rpmh-rsc.c
>+++ b/drivers/soc/qcom/rpmh-rsc.c
>@@ -18,6 +18,7 @@
> #include <linux/slab.h>
> #include <linux/spinlock.h>
>
>+#include <soc/qcom/cmd-db.h>
> #include <soc/qcom/tcs.h>
> #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>
>@@ -621,6 +622,18 @@ static int rpmh_rsc_probe(struct platform_device *pdev)
> 	struct rsc_drv *drv;
> 	int ret, irq;
>
>+	/*
>+	 * Even though RPMh doesn't directly use cmd-db, all of its children
>+	 * do.  To avoid adding this check to our children we'll do it now.
nit: Double space before To
>+	 */
>+	ret = cmd_db_ready();
>+	if (ret) {
>+		if (ret != -EPROBE_DEFER)
>+			dev_err(&pdev->dev, "Command DB not available (%d)\n",
>+									ret);
>+		return ret;
>+	}
>+
> 	drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_KERNEL);
> 	if (!drv)
> 		return -ENOMEM;
>--
>2.18.0.rc1.244.gcf134e6275-goog
>
