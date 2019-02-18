Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22265C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E781C21904
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550497962;
	bh=QuaG1rJwN7BNIg0TWBYl2lrq73KFNyETH7GEQ2e4QWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n0hiKt18V2/pvnF8B3zloGT92JA64bajY4wfJi2nCneD6BTv4G+yc1bsFC+ycBzKn
	 O8r4RgL/ZsbyffMVBeKqdSC6hRPAry8tJj+DaShbkpZr97x+rIZ420uHJ9q1UARaaa
	 hn3I6RTPNLBkO6eY8RMs6crT8IxMMV9+vPxWPVWk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732765AbfBRNwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:52:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:60404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732719AbfBRNwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:52:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEC5E21906;
        Mon, 18 Feb 2019 13:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497950;
        bh=QuaG1rJwN7BNIg0TWBYl2lrq73KFNyETH7GEQ2e4QWk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hOcazwqWmYZWdxYYI1jKMXK+Jy/rzjr1exvnhUZzrehhyb8n4IwcxgAVsObR+3W1x
         dF5uP3qaKSSFdj2arwVuqK6jdXz0RHcc5ivDI8/AcojhssjUR79Wjtdzrbpkc4jm/K
         AMWfZvSxzSazBJEKEWcfhgXagLZk7a829Mxcqd48=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Blume <thomas.blume@suse.com>,
        Takashi Iwai <tiwai@suse.de>,
        Martin Peres <martin.peres@free.fr>,
        Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 45/85] drm/nouveau: Dont disable polling in fallback mode
Date:   Mon, 18 Feb 2019 14:43:11 +0100
Message-Id: <20190218133504.522492913@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133459.758004711@linuxfoundation.org>
References: <20190218133459.758004711@linuxfoundation.org>
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



