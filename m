Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA675C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A613820870
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="onEQQNUS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A613820870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730116AbeKTCyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:54:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:52000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730070AbeKTCyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:54:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CD4320831;
        Mon, 19 Nov 2018 16:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645034;
        bh=58sBviAd0iLp4+DNdHd7IOwjQx49qPw4VPYDxzTUGjI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=onEQQNUSAkTTtpkQLKN2oeB16QBpHng7PZihhXQJyYYJZasjDVn/86nfldxRkUOoF
         ttgFPUNv9PHsc9UIQeohPCzIJHEvI2dlodMmRU0NGNDlBLYJY2GmnbkEu31SNdQjs1
         H//9B3UoNL0TAaNKcoQV7IzCS+VZm5Vt2SZfvnXg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Kees Cook <keescook@chromium.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 011/205] drm/nouveau/secboot/acr: fix memory leak
Date:   Mon, 19 Nov 2018 17:25:18 +0100
Message-Id: <20181119162619.142193127@linuxfoundation.org>
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

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>

[ Upstream commit 74a07c0a59fa372b069d879971ba4d9e341979cf ]

In case memory resources for *bl_desc* were allocated, release
them before return.

Addresses-Coverity-ID: 1472021 ("Resource leak")
Fixes: 0d466901552a ("drm/nouveau/secboot/acr: Remove VLA usage")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c
@@ -801,6 +801,7 @@ acr_r352_load(struct nvkm_acr *_acr, str
 		bl = acr->hsbl_unload_blob;
 	} else {
 		nvkm_error(_acr->subdev, "invalid secure boot blob!\n");
+		kfree(bl_desc);
 		return -EINVAL;
 	}
 


