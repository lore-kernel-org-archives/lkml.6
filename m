Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9662EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E57320851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llbUvU/j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbfAQUky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 15:40:54 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36694 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727674AbfAQUkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 15:40:53 -0500
Received: by mail-wm1-f68.google.com with SMTP id p6so2479580wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 12:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L/grezJULwv9Knxf1C+1plOEJ1PG9MZ5huJPitH+iAs=;
        b=llbUvU/jb0mub03XQ98PrTNdSh5KWnY/dFGsdffu9gPobCETinKYAkSdELfqF2sCdz
         LsOTrbVKkQHXUi5RKn8E6doy/A7m0+tdK7DT19bqKOzIAEOtol8oz0P3o9cCmpCi/TiL
         XT0FT7pHcpnsYawnGIUPsQ/j0xrDN5ZnAK4ARuKrJyS4zjsZAbxA5+p4vVMBPwdoQgB+
         TYICQARZ0aOa2RFdu08xmCo93X0hXH/tj/oq6IbdWEj9CiDFSHQTf53Bn3U3haVKula4
         SyoMcY76rPIBdQEz1ixTjRspULfIvVv6LqLjvIe9vWaQyOUAf4xZwkD+xdT076qkhWZm
         CMvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=L/grezJULwv9Knxf1C+1plOEJ1PG9MZ5huJPitH+iAs=;
        b=siuxwRakvJesnhqVEJ/x6yDm12GqI1i/iQS3nnkJqerMyFA6PYLiFf022Mlf9xdhpM
         GEvixE6ouJnanPRYk5bZbtduSgKDPhmqWUXqq/InMQ2eWFbhw1mqJEEYNy+g9EG/2xuN
         PNyRapXxdUtC95jyzp7fWp1zuIZuLQ92/fjvzf/oXf9Qrb2JQewBEl4UlbnN5xUhStIV
         bYs1tjN9pQLtQuhBwcd45K85jSPl7jb8y6xknhOJ4EP357UJDRPPzrmGi8+0ZLDbHTT0
         qoSM2c8+PgnnP5CkTCKRkXca1bgNtM0Zy5H16nx0AS8Ev+UvJxObkjUGdPx1SjpDrOXH
         3G+w==
X-Gm-Message-State: AJcUukdBkTm93NiBIVCEtcEx/F6XR9cQnGpf7wA7nNpSmwn2uWlcQrAy
        IAY2K7drIZlq2YZKqh7d3SExEt1S
X-Google-Smtp-Source: ALg8bN6cz6sa2sEvhl5gFhTeM48lO7SXAXKbqjRh4/be8CMEI0EnMr/7qOI6+7n61g8Go6HC90TMrw==
X-Received: by 2002:a7b:c0c5:: with SMTP id s5mr13691610wmh.40.1547757651485;
        Thu, 17 Jan 2019 12:40:51 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id y1sm47183040wme.1.2019.01.17.12.40.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 12:40:50 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 7C6D3114257D; Thu, 17 Jan 2019 21:40:49 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     Mathieu Malaterre <malat@debian.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm: radeon: add a missing break in evergreen_cs_handle_reg
Date:   Thu, 17 Jan 2019 21:40:47 +0100
Message-Id: <20190117204047.1262-1-malat@debian.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190114202652.15204-1-malat@debian.org>
References: <20190114202652.15204-1-malat@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit dd220a00e8bd ("drm/radeon/kms: add support for streamout v7")
case statements were added without a terminating break statement. This
commit adds the missing break. This was discovered during a compilation
with W=1.

This commit removes the following warning:

  drivers/gpu/drm/radeon/evergreen_cs.c:1301:11: warning: this statement may fall through [-Wimplicit-fallthrough=]

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Fixes: dd220a00e8bd ("drm/radeon/kms: add support for streamout v7")
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
v2: Add missing break statement, instead of marking it as fall through

 drivers/gpu/drm/radeon/evergreen_cs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/radeon/evergreen_cs.c b/drivers/gpu/drm/radeon/evergreen_cs.c
index f471537c852f..1e14c6921454 100644
--- a/drivers/gpu/drm/radeon/evergreen_cs.c
+++ b/drivers/gpu/drm/radeon/evergreen_cs.c
@@ -1299,6 +1299,7 @@ static int evergreen_cs_handle_reg(struct radeon_cs_parser *p, u32 reg, u32 idx)
 			return -EINVAL;
 		}
 		ib[idx] += (u32)((reloc->gpu_offset >> 8) & 0xffffffff);
+		break;
 	case CB_TARGET_MASK:
 		track->cb_target_mask = radeon_get_ib_value(p, idx);
 		track->cb_dirty = true;
-- 
2.19.2

