Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A82BC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6060520855
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690878;
	bh=dJGZDB/wYLl0Lb7u+ZJeEaLCkp4CkQ4EbPD1t9rdbv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R0JQKKMRmhA7nCY+e/boBt/nkG5Z5xDWSKLWvZN2crwfAJaqJlahZMO/PhWa54MVw
	 nRr190U9iCz+YMSZr+hJU8GhH8mVxxJ3SNMUvP4EQvHvq+3L+KHPcqUot7xP7ZQum2
	 LkY76TUKx+A+la59eMEm3QffU4cge7SR7mVSE+UY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729722AbfA1Pyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:54:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:40674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729294AbfA1Pye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:54:34 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9C1220855;
        Mon, 28 Jan 2019 15:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690873;
        bh=dJGZDB/wYLl0Lb7u+ZJeEaLCkp4CkQ4EbPD1t9rdbv0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cEOOYZvVWNjQ8b578xXgQ2WoZ/Qyt/Ty7pMCBvJB6uI5fkoXM/f/DREadKyC7e8Up
         RL5TMlUg9Yr+o2R/XS5PumSVO3juoHmzl2gqjSgbzg2Znoc1kG6I+AqgoV0FjA12Dh
         eF8tpkVuggRxd+whqJfizhPfD+3Qpjia60iqeB/M=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dale Zhao <dale.zhao@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.20 219/304] drm/amd/display: Wait edp HPD to high in detect_sink
Date:   Mon, 28 Jan 2019 10:42:16 -0500
Message-Id: <20190128154341.47195-219-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dale Zhao <dale.zhao@amd.com>

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

