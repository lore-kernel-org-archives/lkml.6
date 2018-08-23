Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC93DC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B322C20A8B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:18:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B322C20A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729936AbeHWLrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:47:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46362 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727760AbeHWLrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:47:21 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5745CC74;
        Thu, 23 Aug 2018 08:18:52 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Maciej Purski <m.purski@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 011/217] drm/bridge/sii8620: fix potential buffer overflow
Date:   Thu, 23 Aug 2018 09:52:04 +0200
Message-Id: <20180823075506.043095283@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823075505.090246914@linuxfoundation.org>
References: <20180823075505.090246914@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maciej Purski <m.purski@samsung.com>

[ Upstream commit 9378cecb1ce5d618b8aff4d65113ddcf72fc1011 ]

Buffer overflow error should not occur, as mode_fixup() callback
filters pixel clock value and it should never exceed 600000. However,
current implementation is not obviously safe and relies on
implementation of mode_fixup().

Make 'i' variable never reach unsafe value in order to avoid buffer
overflow error.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: bf1722ca ("drm/bridge/sii8620: rewrite hdmi start sequence")
Signed-off-by: Maciej Purski <m.purski@samsung.com>
Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Link: https://patchwork.freedesktop.org/patch/msgid/1511341718-6974-1-git-send-email-m.purski@samsung.com
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/bridge/sil-sii8620.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/bridge/sil-sii8620.c
+++ b/drivers/gpu/drm/bridge/sil-sii8620.c
@@ -1196,7 +1196,7 @@ static void sii8620_start_hdmi(struct si
 		int clk = ctx->pixel_clock * (ctx->use_packed_pixel ? 2 : 3);
 		int i;
 
-		for (i = 0; i < ARRAY_SIZE(clk_spec); ++i)
+		for (i = 0; i < ARRAY_SIZE(clk_spec) - 1; ++i)
 			if (clk < clk_spec[i].max_clk)
 				break;
 


