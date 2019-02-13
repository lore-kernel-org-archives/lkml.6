Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4056C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EAC6222D1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083586;
	bh=w5dyh7n/2LdziC4L5Svno/nejRTHTCAoPYqkvLX/80g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fLCh9Hpysqc5pphA1t7xDsJEh18rgi9INhLWc3mMA31Xp5TJueAF4IO+Ps6elBVVn
	 pocLwyUXjkscbCCPIXrrXNO6fh50lZ4ypj2stzSURF7RPC4b2wbq9q/WFfSDnQJih6
	 OCwhioeLlKI0Y18c6mfn6uhO0vMccqcUNYQamgUg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403942AbfBMSqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:46:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:44920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406427AbfBMSqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:46:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FEAA20835;
        Wed, 13 Feb 2019 18:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083579;
        bh=w5dyh7n/2LdziC4L5Svno/nejRTHTCAoPYqkvLX/80g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eT4c6tV/Jk5Z1HwZ9+1g3bEvd1JGH548tZN2lkY5Wn/ojkZh/mtIaD37R+jwoPAK3
         wLvp8JVdnlTA7jMtaNaD39oj41vu9PdJ8b23KiSVmBlHfXY6Y8ii/FE0dib0dkySXU
         0I8V3EUa4jt3SfuDJ2Tg9hid0YuxIicoEi04CmAo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.20 39/50] drm/amd/powerplay: Fix missing break in switch
Date:   Wed, 13 Feb 2019 19:38:44 +0100
Message-Id: <20190213183658.776366374@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183655.747168774@linuxfoundation.org>
References: <20190213183655.747168774@linuxfoundation.org>
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
@@ -1005,6 +1005,7 @@ static int smu10_get_clock_by_type_with_
 		break;
 	case amd_pp_dpp_clock:
 		pclk_vol_table = pinfo->vdd_dep_on_dppclk;
+		break;
 	default:
 		return -EINVAL;
 	}


