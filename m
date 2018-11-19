Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222B3C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E140820870
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8dtCzPK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E140820870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730604AbeKTC4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:56:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:54114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729979AbeKTC4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:56:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E27B82086A;
        Mon, 19 Nov 2018 16:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645119;
        bh=lD+UJknVb8BuBli2x5yOXeTSBQ7c981777BM81llzso=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s8dtCzPK/Jsd+mWSJX7KBzErS47DFabF99FWIRhuhIeq/G+6pT+l3W8Koe/W+jHSS
         lZMfOMiUdbbXrhA2qppUauFymJTQE9idIXq4w86AnhFkmyAFj0xIGe2PMLQ+HZhn66
         RE3xWgVY6+xUS4eFEKA9lv5t2ND05otBQUNoz9rw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Huang Rui <ray.huang@amd.com>,
        Bas Nieuwenhuizen <basni@chromium.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 043/205] drm/amdgpu: fix integer overflow test in amdgpu_bo_list_create()
Date:   Mon, 19 Nov 2018 17:25:50 +0100
Message-Id: <20181119162625.106303938@linuxfoundation.org>
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

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit ff30e9e8509cb877dc7cbc776b36c70f5bdd290f ]

We accidentally left out the size of the amdgpu_bo_list struct.  It
could lead to memory corruption on 32 bit systems.  You'd have to
pick the absolute maximum and set "num_entries == 59652323" then size
would wrap to 16 bytes.

Fixes: 920990cb080a ("drm/amdgpu: allocate the bo_list array after the list")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Bas Nieuwenhuizen <basni@chromium.org>
Signed-off-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
@@ -67,7 +67,8 @@ int amdgpu_bo_list_create(struct amdgpu_
 	unsigned i;
 	int r;
 
-	if (num_entries > SIZE_MAX / sizeof(struct amdgpu_bo_list_entry))
+	if (num_entries > (SIZE_MAX - sizeof(struct amdgpu_bo_list))
+				/ sizeof(struct amdgpu_bo_list_entry))
 		return -EINVAL;
 
 	size = sizeof(struct amdgpu_bo_list);


