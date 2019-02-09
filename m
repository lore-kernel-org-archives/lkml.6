Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03954C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBDAC21934
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549738165;
	bh=Qd1fahdPosSnEjFOXf+YPh97rzaC+Gmq1JYOnuqchKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c9/J7I9scKrO7d2PIUfvxEFiRq8yySZcszyWby4Ys+lTLvstzQs5R8WnWabC0tX/C
	 RwQnp7jIPRsiG7IdBFVMIsxzKg6qBy0F6LiFCU8O4pIQr5nY7ec0VS6ugyOKgj0M7E
	 URlujYKtTNTqG2s6XW9jG5lP2bdpoxX9/6cmbIU8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbfBIStY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:49:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:34874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728092AbfBIStW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 13:49:22 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41AA121934;
        Sat,  9 Feb 2019 18:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549738162;
        bh=Qd1fahdPosSnEjFOXf+YPh97rzaC+Gmq1JYOnuqchKk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W8qH1JKQY9qN/EKMaFswT94nmcOkC+L4zp3wNvxLQRzWC7m2uYkbxwn+DiFijK6J3
         rZ9oYOnJDWVxyNp0K8O08+N7sYZB6af+Wtk7Px3hrdEhdHCkzfiIitMD1L4KEXB78h
         juKfxZqpYzcMIvSTisw7hK77CAfmf91EINnTgPug=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Takashi Iwai <tiwai@suse.de>, Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 25/28] drm/nouveau: Don't disable polling in fallback mode
Date:   Sat,  9 Feb 2019 13:48:33 -0500
Message-Id: <20190209184840.126418-25-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190209184840.126418-1-sashal@kernel.org>
References: <20190209184840.126418-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

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
index 3695cde669f8..07914e36939e 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/base.c
@@ -132,11 +132,12 @@ nvkm_therm_update(struct nvkm_therm *therm, int mode)
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

