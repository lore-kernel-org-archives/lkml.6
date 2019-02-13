Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5D4C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF18620811
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083431;
	bh=ysfh84W7HfNG4G/5WhZhVv15nBZJ6dJSn+iUX9r9feY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=onpdQlJofUHlj4GNvZDxKcU43BbNW5Qw/YOR7eh0fCcYbmL9Ex8RKwxBtC5u4L5h7
	 aTuETCfWLa8CJLPjZKnjmKyPy5EYBe100jo+Fo4dJj6dmjaXb92tKCXUzy50Cd6ULt
	 ivyVzQgOoGT3tmwlCJrl4r508THF4vmJ1lvw95DI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405993AbfBMSnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:43:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:42350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405968AbfBMSnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:43:46 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81DED222D5;
        Wed, 13 Feb 2019 18:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083426;
        bh=ysfh84W7HfNG4G/5WhZhVv15nBZJ6dJSn+iUX9r9feY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wL11oX5MsOFVgl2NIJTp6UCJ+CTsg6eq4nuUcHXYzLQzjxFuwdinvD0OIELVESJYR
         N+H0INxij17bfIrnqGfoXzkgqDapWx9aBTX2P0gx0R67sWh8G/rjp4kkNMtRD9Fh29
         PiJTXFv6XbwC8kK0Naav9gq+hU4LHkBr4DIWeOvw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.19 32/44] drm/amd/powerplay: Fix missing break in switch
Date:   Wed, 13 Feb 2019 19:38:33 +0100
Message-Id: <20190213183654.494134460@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183651.648060257@linuxfoundation.org>
References: <20190213183651.648060257@linuxfoundation.org>
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

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

commit 2f10d823739680d2477ce34437e8a08a53117f40 upstream.

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
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
@@ -984,6 +984,7 @@ static int smu10_get_clock_by_type_with_
 		break;
 	case amd_pp_dpp_clock:
 		pclk_vol_table = pinfo->vdd_dep_on_dppclk;
+		break;
 	default:
 		return -EINVAL;
 	}


