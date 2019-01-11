Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2936C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB28A2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217651;
	bh=2i4lM4e8z2H+yJ85029ZyjEEqHyXu/7apTdMFflQOrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YdlqasqgnMoQwLw88tRayw95C/Csxb90at/9x6h5LKMw0vSD+pRZbqRMe/xnRTzeJ
	 aFnGGfnxMMv7SkZ6/dm+Q9OHaTLrRDqWhmVY+mpM7+2/SFni+DYFptojbAw83aePKQ
	 QSgZ/suFhzJKsuSF1t4mgaBxH5/KbBczKrFlcIAc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391260AbfAKOku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:40:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:33410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403907AbfAKOkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:40:46 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47CE82133F;
        Fri, 11 Jan 2019 14:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217645;
        bh=2i4lM4e8z2H+yJ85029ZyjEEqHyXu/7apTdMFflQOrg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NcyBxNoE1d5eQFv+anyjQSa7+6RAel9S2yAzpaC4UtX4YOMqAG2PamfMa0HkwV7yZ
         C0ZF5lFPo1qc29Ph6lVSvfTJTV/CegBE0EBQW0mPvESYiSX47C+ZTYeIQfyGKAwLKP
         T+9Dns/vf2FbMqNN5PUjHZ/QdtPCQqTVW51ERP00=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        stable@kernel.org
Subject: [PATCH 4.19 137/148] video: fbdev: pxafb: Fix "WARNING: invalid free of devm_ allocated data"
Date:   Fri, 11 Jan 2019 15:15:15 +0100
Message-Id: <20190111131119.761064331@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
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

From: YueHaibing <yuehaibing@huawei.com>

commit 2607391882fca37463187e7f2a9c76dec286947e upstream.

'info->modes' got allocated with devm_kcalloc in of_get_pxafb_display.

This gives this error message:
  ./drivers/video/fbdev/pxafb.c:2238:2-7: WARNING: invalid free of devm_ allocated data

Fixes: c8f96304ec8b4 ("video: fbdev: pxafb: switch to devm_* API")
Cc: stable@kernel.org [v4.19+]
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Daniel Mack <daniel@zonque.org>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/video/fbdev/pxafb.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/video/fbdev/pxafb.c
+++ b/drivers/video/fbdev/pxafb.c
@@ -2234,10 +2234,8 @@ static struct pxafb_mach_info *of_pxafb_
 	if (!info)
 		return ERR_PTR(-ENOMEM);
 	ret = of_get_pxafb_mode_info(dev, info);
-	if (ret) {
-		kfree(info->modes);
+	if (ret)
 		return ERR_PTR(ret);
-	}
 
 	/*
 	 * On purpose, neither lccrX registers nor video memory size can be


