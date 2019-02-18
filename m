Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BDEC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3514521902
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498150;
	bh=zHEuF4UFVMwql6tn85kg5q2dk2edSpZww5rG+X7Duts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PlmwcAAgQ45JnDiuZc08umH+y8RVaAb9amw6E+uVK2HLKE7wORMZm7etIR6A5IZ3B
	 A7YBFAdfW1HSDDjElZIGT9kdM2/5pii7PV+JsusmkOivWKt1l23lPX6omfzHCZ2t/J
	 qWJhXoE6/vK1KjsSaof7sbmi7SPfGQK7xNSSBaVk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387603AbfBRNzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:55:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:35794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387587AbfBRNzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:55:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FE9821900;
        Mon, 18 Feb 2019 13:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498142;
        bh=zHEuF4UFVMwql6tn85kg5q2dk2edSpZww5rG+X7Duts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nRs9uJO3F1KgVA5gCRHW5qvhhjpg9K2eUpsCbxVrTXHhTMy8ZNMjYRIeUBk0Bw1e9
         548pNG1UQBpFvy1tU3oZX739gTsZ3nGO2+rdRqcRIaKK98CGjt0NmBdhOyCDJKJzl0
         DSdkv5aofCtetqDBnZsOka+yHUpo9sfWQGUIlyeQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Blume <thomas.blume@suse.com>,
        Takashi Iwai <tiwai@suse.de>,
        Martin Peres <martin.peres@free.fr>,
        Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 37/62] drm/nouveau: Dont disable polling in fallback mode
Date:   Mon, 18 Feb 2019 14:43:43 +0100
Message-Id: <20190218133509.097587380@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133505.801423074@linuxfoundation.org>
References: <20190218133505.801423074@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 118780066e30c34de3d9349710b51780bfa0ba83 ]

When a fan is controlled via linear fallback without cstate, we
shouldn't stop polling.  Otherwise it won't be adjusted again and
keeps running at an initial crazy pace.

Fixes: 800efb4c2857 ("drm/nouveau/drm/therm/fan: add a fallback if no fan control is specified in the vbios")
Bugzilla: https://bugzilla.suse.com/show_bug.cgi?id=1103356
Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=107447
Reported-by: Thomas Blume <thomas.blume@suse.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Reviewed-by: Martin Peres <martin.peres@free.fr>
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/base.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/base.c
index 952a7cb0a59a..692d4d96766a 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/base.c
@@ -131,11 +131,12 @@ nvkm_therm_update(struct nvkm_therm *therm, int mode)
 			duty = nvkm_therm_update_linear(therm);
 			break;
 		case NVBIOS_THERM_FAN_OTHER:
-			if (therm->cstate)
+			if (therm->cstate) {
 				duty = therm->cstate;
-			else
+				poll = false;
+			} else {
 				duty = nvkm_therm_update_linear_fallback(therm);
-			poll = false;
+			}
 			break;
 		}
 		immd = false;
-- 
2.19.1



