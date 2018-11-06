Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCD1C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 05:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA2C82089F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 05:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="P5pOzBEP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA2C82089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387441AbeKFOZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 09:25:34 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44711 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729794AbeKFOZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 09:25:34 -0500
Received: by mail-pf1-f194.google.com with SMTP id j13-v6so5515328pff.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 21:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=VKu6Lyuuq1HCg2vjK0SKqBKedEZKBAaQkFejaBLFPf0=;
        b=P5pOzBEPVvT+v94DFEU22LAsgxhHRTt6Ea6meOS+GbP+YI+0kE5s7mOwEVDwpyE7GE
         xN8AUVPCtu0UPYvze/fOUyRJ8UmOOoHj2pvwkgho1DdT03DyfSEbj8aXIt9cpvE48ju9
         mG0ZWl+bbahRA3mvPwY8FbjEg1MpxHMbhmdKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=VKu6Lyuuq1HCg2vjK0SKqBKedEZKBAaQkFejaBLFPf0=;
        b=CLLGsDMe5OCExtzUP/C7ldcGmpi7c/RSisecPsf8ePZmVncCbmdv4pu9YjGfSYUy1F
         YON802WKSRvE04i3JQfsodnNTK15LfcWaqYMENCHauObDn0zKZX66IAQomYIQYYPGufc
         5N1KsMUNN3UmAVQVzyDrMnxkjdf6TPja1/zMwbXFV3YfqzSz6OjnbKTjjPiT0LJPXEJ5
         wNiczXju1pn5/rN3cNv5Pg1ZWdWQv+k4Xhi4aqU5qHJiW6mR+l8R0XUJgT67GWs3NHRd
         3AlOKfZU1Zw1K9Xk2BFsqhZYMYEYabe5/kneuWlpeThv4uL7qYgElV9uh5l3q3R5hrbv
         b6Jw==
X-Gm-Message-State: AGRZ1gJVzIZA4T7UQLSEmnJbONy65fyBumEPavNlSqszzLpfEfx+eajZ
        5PY5EQuJivdgkZ6kuDO5Hx8c2w==
X-Google-Smtp-Source: AJdET5e3MgGqFde5O0+CD/ST5M95yfejt8EPaczM6rLk2T3feF/XQXr1rjzQDcTnC48CURkzU9uhPA==
X-Received: by 2002:a63:d655:: with SMTP id d21mr13363464pgj.280.1541480531978;
        Mon, 05 Nov 2018 21:02:11 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id o7-v6sm55735416pfb.23.2018.11.05.21.02.09
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Nov 2018 21:02:11 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org, eric.long@unisoc.com
Cc:     broonie@kernel.org, baolin.wang@linaro.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 4/7] dmaengine: sprd: Set cur_desc as NULL when free or terminate one dma channel
Date:   Tue,  6 Nov 2018 13:01:34 +0800
Message-Id: <4b13aba73775582aa570212a1dccc6c511031de6.1541480353.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1541480353.git.baolin.wang@linaro.org>
References: <cover.1541480353.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1541480353.git.baolin.wang@linaro.org>
References: <cover.1541480353.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Long <eric.long@spreadtrum.com>

It will be failed to start one new transfer if the channel started one
none interrupt transfer before, since we will only set the schan->cur_desc
as NULL depending on the transfer interrupt now. Thus we should set
schan->cur_desc as NULL when free or terminate one dma channel to
avoid this issue.

Signed-off-by: Eric Long <eric.long@spreadtrum.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/dma/sprd-dma.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index e6a74dc..1b39661 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -439,6 +439,7 @@ static void sprd_dma_stop(struct sprd_dma_chn *schan)
 	sprd_dma_stop_and_disable(schan);
 	sprd_dma_unset_uid(schan);
 	sprd_dma_clear_int(schan);
+	schan->cur_desc = NULL;
 }
 
 static bool sprd_dma_check_trans_done(struct sprd_dma_desc *sdesc,
-- 
1.7.9.5

