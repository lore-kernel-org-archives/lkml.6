Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FE0C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0FB42063F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217700;
	bh=5npUuVqQ1atJkEmarVl/THBxhwvwTnkBq9ASwl2pzmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=prW0oorkKCidVddSrHmc3ifLR8wM3hsNOM4NFSK2LSoYKPr5JF/DPL9ZwIeaQJ4cS
	 Qs+tfAAKakgPSlazoWzmflv8Q5Gfnj4h9zP4dnnKARZl+wn8nUdlD6Pa5DpVwhzTKL
	 uxrsUZfM+LPYv0OE90OfdmCKG1f3O6hJLVRexNdk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391314AbfAKOlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:41:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:34280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391296AbfAKOle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:41:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CA4F2063F;
        Fri, 11 Jan 2019 14:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217693;
        bh=5npUuVqQ1atJkEmarVl/THBxhwvwTnkBq9ASwl2pzmA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y+pca8H8AFgb0/taHJuXOORdpH6sbBteX9VOyjgzO5iWywUIV/+GpCBUxlYw4Wwxt
         VPLScb5O4SpGoAEowATfURFZXGxFGNBPFlRe7Kop9IRvUsO68WSaBUJmvXxcwVHHE8
         y4kXENkwLNp7pa9DPh+6FwsLkmwX5nz+0xKCwvwk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.19 148/148] drm/amd/display: Fix unintialized max_bpc state values
Date:   Fri, 11 Jan 2019 15:15:26 +0100
Message-Id: <20190111131120.240666057@linuxfoundation.org>
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

commit 49f1c44b581b08e3289127ffe58bd208c3166701 upstream.

[Why]
If the "max bpc" isn't explicitly set in the atomic state then it
have a value of 0. This has the correct behavior of limiting a panel
to 8bpc in the case where the panel supports 8bpc. In the case of eDP
panels this isn't a true assumption - there are panels that can only
do 6bpc.

Banding occurs for these displays.

[How]
Initialize the max_bpc when the connector resets to 8bpc. Also carry
over the value when the state is duplicated.

Bugzilla: https://bugs.freedesktop.org/108825
Fixes: 307638884f72 ("drm/amd/display: Support amdgpu "max bpc" connector property")

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2894,6 +2894,7 @@ void amdgpu_dm_connector_funcs_reset(str
 		state->underscan_enable = false;
 		state->underscan_hborder = 0;
 		state->underscan_vborder = 0;
+		state->max_bpc = 8;
 
 		__drm_atomic_helper_connector_reset(connector, &state->base);
 	}
@@ -2911,6 +2912,7 @@ amdgpu_dm_connector_atomic_duplicate_sta
 	if (new_state) {
 		__drm_atomic_helper_connector_duplicate_state(connector,
 							      &new_state->base);
+		new_state->max_bpc = state->max_bpc;
 		return &new_state->base;
 	}
 


