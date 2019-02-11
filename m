Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE258C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADC9720838
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895453;
	bh=6Ib8dn4kizR60ukJmLKNmIoa+NccnR0LjKE6hV9REX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PE8Az84kfBPofPQ5SEKpzTrKBdGUva9vY41mRyRLLsOfNJSQ5P0h6Al1c0g034E9f
	 vJTvYgf57Wyil3nyjwgZomN4pwx/l6QaQvaxQx++FXFj9wU2JVazJt/djfI4/1xMl3
	 VycY51UncWZCCZLJ6zDT3xT6RHsoFDF2m3tKqlD4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730190AbfBKOaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:30:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:37312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729724AbfBKOat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:30:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E85620675;
        Mon, 11 Feb 2019 14:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895449;
        bh=6Ib8dn4kizR60ukJmLKNmIoa+NccnR0LjKE6hV9REX0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a0dMho71oxrPdsAc/HSCsw/EXf4km/+AxLMNRuEhdiiyiQ/HCR9bQj8k/dfmulFND
         PQRfr5nkLEoBN9aWAJfliNyFt2P17/w+9vI4pNWWAxcPnjzKuUVaZdZJrWZkR0RpUF
         3aL7CrfUl6s1e8vUEY82xtOyjeutvcV7e9q+YHbY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dale Zhao <dale.zhao@amd.com>,
        Eric Yang <eric.yang2@amd.com>, Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 207/352] drm/amd/display: Wait edp HPD to high in detect_sink
Date:   Mon, 11 Feb 2019 15:17:14 +0100
Message-Id: <20190211141900.331113890@linuxfoundation.org>
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

[ Upstream commit 0a6414e75d231ee1bb7ffb2f5eb246b682a884cd ]

[Why]
In 99% user case, edp will be post by vbios.
In 1% / current case: Lenovo don't light up edp panel in vbios
post stage, vbios won't be lit up. Thus in dal when we init DCN
10 hw, we power up edp, then we start detect_sink, but internal
time is too short, when we detect it, HPD is still low, so we don't
detect the edp, and edp shows black.

[How]
When we init hw, we wait edp HPD to high after power up edp.

Signed-off-by: Dale Zhao <dale.zhao@amd.com>
Reviewed-by: Eric Yang <eric.yang2@amd.com>
Acked-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index ef1b350a45e0..8b69913b6943 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -208,6 +208,9 @@ bool dc_link_detect_sink(struct dc_link *link, enum dc_connection_type *type)
 		return true;
 	}
 
+	if (link->connector_signal == SIGNAL_TYPE_EDP)
+		link->dc->hwss.edp_wait_for_hpd_ready(link, true);
+
 	/* todo: may need to lock gpio access */
 	hpd_pin = get_hpd_gpio(link->ctx->dc_bios, link->link_id, link->ctx->gpio_service);
 	if (hpd_pin == NULL)
-- 
2.19.1



