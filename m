Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC28EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4BCE2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="muI5MjiU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4BCE2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730309AbeKTCzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:55:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:52736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730034AbeKTCzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:55:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E60D2086A;
        Mon, 19 Nov 2018 16:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645065;
        bh=nEgLqOU8AvyweRa9jgdR45mukFhEbzwbt5m/NOPLl68=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=muI5MjiUCMoo6/xvpEUzknBEiXbmeSuM/yjyc2pJBttNDjxLjvdss93EwboCCTeaN
         i834K7JFIEfDNJpNuzF8UfMojgUHVnmewcigFknuDP9vcS8h3vxDMVNxA0ES9iPwPv
         OvMYhmtW1QReWrD52ghhhJ5cU00dT3lHbEwZrWKA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Su Sung Chung <Su.Chung@amd.com>,
        Aric Cyr <Aric.Cyr@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 005/205] drm/amd/display: fix bug of accessing invalid memory
Date:   Mon, 19 Nov 2018 17:25:12 +0100
Message-Id: <20181119162617.904108535@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Su Sung Chung <Su.Chung@amd.com>

[ Upstream commit 43c3ff27a47d83d153c4adc088243ba594582bf5 ]

[Why]
A loop inside of build_evenly_distributed_points function that traverse through
the array of points become an infinite loop when m_GammaUpdates does not
get assigned to any value.

[How]
In DMColor, clear m_gammaIsValid bit just before writting all Zeromem for
m_GammaUpdates, to prevent calling build_evenly_distributed_points
before m_GammaUpdates gets assigned to some value.

Signed-off-by: Su Sung Chung <Su.Chung@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/modules/color/color_gamma.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
+++ b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
@@ -1069,10 +1069,14 @@ static void build_evenly_distributed_poi
 	struct dividers dividers)
 {
 	struct gamma_pixel *p = points;
-	struct gamma_pixel *p_last = p + numberof_points - 1;
+	struct gamma_pixel *p_last;
 
 	uint32_t i = 0;
 
+	// This function should not gets called with 0 as a parameter
+	ASSERT(numberof_points > 0);
+	p_last = p + numberof_points - 1;
+
 	do {
 		struct fixed31_32 value = dc_fixpt_from_fraction(i,
 			numberof_points - 1);
@@ -1083,7 +1087,7 @@ static void build_evenly_distributed_poi
 
 		++p;
 		++i;
-	} while (i != numberof_points);
+	} while (i < numberof_points);
 
 	p->r = dc_fixpt_div(p_last->r, dividers.divider1);
 	p->g = dc_fixpt_div(p_last->g, dividers.divider1);


