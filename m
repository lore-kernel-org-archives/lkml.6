Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9A1C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54939208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2KJb0efW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54939208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbeKZTDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 14:03:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:46998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726158AbeKZTDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 14:03:00 -0500
Received: from localhost (unknown [122.178.235.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08B302082F;
        Mon, 26 Nov 2018 08:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543219781;
        bh=FocSMzy+xvjIdUnDhR6bcTICWVY1yOUgVR1zGL5rW+4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2KJb0efWnCKx2ttPDZeiiwSp9hHfvAEuxADBCzHLRwDV2eZJ+jboA4sbw2I3Kzecv
         Y7u6JyQErDG3QISNZKwCCb5JK9l5sXyPA6SKWhoWwciWe2LwuyNw4nn1bibZne3HD7
         6lJRyk+p3QIp0YsVW4WG+ArRaa35cZaR6Mc6wfMg=
Date:   Mon, 26 Nov 2018 13:39:38 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        dma <dmaengine@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the slave-dma tree
Message-ID: <20181126080855.GS3175@vkoul-mobl.Dlink>
References: <20181126165903.33b1d872@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126165903.33b1d872@canb.auug.org.au>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 26-11-18, 16:59, Stephen Rothwell wrote:
> Hi Vinod,
> 
> After merging the slave-dma tree, today's linux-next build (x86_64
> allmodconfig) produced this warning:
> 
> drivers/dma/coh901318.c: In function 'coh901318_config':
> drivers/dma/coh901318.c:1805:16: warning: unused variable 'flags' [-Wunused-variable]
>   unsigned long flags;
>                 ^~~~~
> 
> Introduced by commit
> 
>   627469e4445b ("dmaengine: coh901318: Fix a double-lock bug")

Thanks for the report, I have fixed it up with below:

-- >8 --

From fbbdec195155b4497cb83be37788865f98f31dca Mon Sep 17 00:00:00 2001
From: Vinod Koul <vkoul@kernel.org>
Date: Mon, 26 Nov 2018 13:34:15 +0530
Subject: [PATCH] dmaengine: coh901318: Remove unused variable

Commit 627469e4445b ("dmaengine: coh901318: Fix a double-lock bug") left
flags variable unused, so remove it to fix the warning.

drivers/dma/coh901318.c: In function 'coh901318_config':
drivers/dma/coh901318.c:1805:16: warning: unused variable 'flags' [-Wunused-variable]
  unsigned long flags;
                ^~~~~

Reported-By: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/coh901318.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/coh901318.c b/drivers/dma/coh901318.c
index fd862a478738..b69d66e44052 100644
--- a/drivers/dma/coh901318.c
+++ b/drivers/dma/coh901318.c
@@ -1802,7 +1802,6 @@ static struct dma_chan *coh901318_xlate(struct of_phandle_args *dma_spec,
 static int coh901318_config(struct coh901318_chan *cohc,
 			    struct coh901318_params *param)
 {
-	unsigned long flags;
 	const struct coh901318_params *p;
 	int channel = cohc->id;
 	void __iomem *virtbase = cohc->base->virtbase;
-- 
2.14.5

-- 
~Vinod
