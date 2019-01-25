Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FADC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 21:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2961218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 21:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbfAYVzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 16:55:37 -0500
Received: from gateway21.websitewelcome.com ([192.185.45.38]:20961 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726179AbfAYVzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 16:55:36 -0500
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id D3F5A400C4BCC
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 15:55:35 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id n9RngMNtcdnCen9RngP1pT; Fri, 25 Jan 2019 15:55:35 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=45382 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gn9Rm-003FgV-Uw; Fri, 25 Jan 2019 15:55:35 -0600
Date:   Fri, 25 Jan 2019 15:55:33 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] drm/amd/powerplay: Fix missing break in switch
Message-ID: <20190125215533.GA4878@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1gn9Rm-003FgV-Uw
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.130.205]:45382
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 22
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing break statement in order to prevent the code from falling
through to the default case.

The resoning for this is that pclk_vol_table is an automatic variable.
So, it makes no sense to update it just before falling through to the
default case and return -EINVAL.

This bug was found thanks to the ongoing efforts to enabling
-Wimplicit-fallthrough.

Fixes: cd70f3d6e3fa ("drm/amd/powerplay: PP/DAL interface changes for dynamic clock switch")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
index f95c5f50eb0f..5273de3c5b98 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
@@ -1033,6 +1033,7 @@ static int smu10_get_clock_by_type_with_latency(struct pp_hwmgr *hwmgr,
 		break;
 	case amd_pp_dpp_clock:
 		pclk_vol_table = pinfo->vdd_dep_on_dppclk;
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.20.1

