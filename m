Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCE1C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A5CF20866
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwYYRblN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732371AbeLTMfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 07:35:05 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37194 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730044AbeLTMfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 07:35:02 -0500
Received: by mail-pl1-f195.google.com with SMTP id b5so833813plr.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 04:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=RFf5xlrJowjAcNcgVo7EfifGoS9m+N50AmRD0sRVj5Q=;
        b=DwYYRblNLvQosDfYN3xJkjOyQ2F/NvWU47gkgRoDVOteFx/9K40skpWyNrE7VjeA1o
         jQ5Bmjx0MUReMTfNMLApwetxig/VAejrCUYi+nDwyWeD4zrhzGp/VVPUXsocq3jB9jtg
         rT0J1nqsIc/oQqimwHHi+Jn6NV4ejAVDNcrnMXowEk3QpxNObJf/GZ6wLHW6FknxtTOo
         Fu5sMqYa/xik3Gk7TXYoFL8fL1Riv6DA+2SZYUEPBAMEInlIQh8a5nYXunGiQPiFr633
         sHR9eT9CuCbVxEtkq40wO+rDAeogoYTyq3xIIYgyNCtNDGFf7fri0IViPk35nAUT0wsb
         PLWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=RFf5xlrJowjAcNcgVo7EfifGoS9m+N50AmRD0sRVj5Q=;
        b=UT61B61MqOHCU1ul2hwYuyg1ztxkMtSLW/TKf/cDvR4qxOrVzDY3kKaMxCI3lZmOFN
         czLKqIfNAsQRZ1NCxtNqmJ3bxDBwkIG05F9hmDLoDgwuO9czd/RdrKYlYJlBYYTYbaZ2
         18iAbmy0ComHyvXixNSTWjuMpMFw/j4Gg71nN/YbapAdogsFGuzZEePdZPfhD0BoKLo6
         cnucoAyFZPpXKgdO+Bhdz4BihPDd/qqm3PdqnmCH1cDuy7hdhSBEcb0INWsJymqYiIQK
         f3gBoToiV7SXQ1P9qgjtV7s+VktCpQs9vrBC7m7TZT286mJAb2BPu30Kj97P7h2rltmI
         OA3w==
X-Gm-Message-State: AA+aEWaG0yvCpIaHH1y3YrS40UhbIBDIfHGgbtqpUJ8i4iOdx3ETCUbM
        ZzE717hoQ219765uJ+Afb6c=
X-Google-Smtp-Source: AFSGD/WPbOWnolRdq+8iw//VERDiXF7iJ/tgrvpnxPkrs69lyeOEJVR5MvYF7hArj1QhleakHx0eWA==
X-Received: by 2002:a17:902:848d:: with SMTP id c13mr24103814plo.257.1545309301697;
        Thu, 20 Dec 2018 04:35:01 -0800 (PST)
Received: from hp-pavilion-15-notebook-pc-brajeswar ([2409:4061:61f:c77a:7447:88ff:6435:ef2b])
        by smtp.gmail.com with ESMTPSA id p7sm41570484pfj.72.2018.12.20.04.34.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 04:35:01 -0800 (PST)
Date:   Thu, 20 Dec 2018 18:04:55 +0530
From:   Brajeswar Ghosh <brajeswar.linux@gmail.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, airlied@linux.ie, Tony.Cheng@amd.com,
        Bhawanpreet.Lakha@amd.com, Dmytro.Laktyushkin@amd.com,
        charlene.liu@amd.com
Cc:     jrdr.linux@gmail.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        sabyasachi.linux@gmail.com
Subject: [PATCH] drm/amd/display/i2c_hw_engine_dce110: Remove duplicate header
Message-ID: <20181220123455.GA24952@hp-pavilion-15-notebook-pc-brajeswar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove reg_helper.h which is included more than once

Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
---
 .../gpu/drm/amd/display/dc/i2caux/dce110/i2c_hw_engine_dce110.c  | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/i2caux/dce110/i2c_hw_engine_dce110.c b/drivers/gpu/drm/amd/display/dc/i2caux/dce110/i2c_hw_engine_dce110.c
index 9cbe1a7a6bcb..137350142fb2 100644
--- a/drivers/gpu/drm/amd/display/dc/i2caux/dce110/i2c_hw_engine_dce110.c
+++ b/drivers/gpu/drm/amd/display/dc/i2caux/dce110/i2c_hw_engine_dce110.c
@@ -97,7 +97,6 @@ enum dc_i2c_arbitration {
 #define FN(reg_name, field_name) \
 	hw_engine->i2c_shift->field_name, hw_engine->i2c_mask->field_name
 
-#include "reg_helper.h"
 
 static void disable_i2c_hw_engine(
 	struct i2c_hw_engine_dce110 *hw_engine)
-- 
2.17.1

