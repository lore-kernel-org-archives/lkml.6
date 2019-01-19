Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E42C61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 08:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F4F72086A
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 08:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsNBrR6I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbfASIki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 03:40:38 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36477 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727622AbfASIki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 03:40:38 -0500
Received: by mail-lj1-f196.google.com with SMTP id g11-v6so13589186ljk.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jan 2019 00:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=/as/bWvIFK2ziDeqCSqmE1WrROB+enst0eH92KNvUJo=;
        b=ZsNBrR6ITU5XVowXZN6C7PWvjbj9gOb8btvlK+pNYnjCTXh+FzsQlG8Bu0sHXf7rw6
         tI6kalV6BWuBcJ4PC2ZPyfh6aPedUDej9qv3SaxyxKPks+soRovSZBNaC5+3djtx6hw5
         TlEF0zI5D0Rv6DuxonAX77qlNZyw10OYzFSpUjoaV/6dQ9+ZJJNHBtwUsLQ9tmF6cDiy
         lDfUq9e9VrT1aq/kdhghHIFrn3Cck61gNAmKy+cr721+dKkWlAdGUqbXMzazlBEdcc8G
         8fy08Ja9XVHdvNggfWT0il158fTW21kHVCmklqvTKFus1329aKyoGD0kX4EFiIQISB02
         cEFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=/as/bWvIFK2ziDeqCSqmE1WrROB+enst0eH92KNvUJo=;
        b=r4fuXA1ziipkzSgNxu7NIbUo0Eqw9DFiR9HglEYAnuAoxzszq0/QpVaRLb94hbA1BJ
         BswVxcVEXJhxslK/m0fFv61bK9wL0nqZlNkZ2U9EPVe6wR5WGJX2ae1ZM3E3cAj8QBM8
         icPS/Xxcrt0aMCB1d6oxy8YYSE1IBkvOMYpHNgoAWp8ooD34act9m6rPzADbsJrqL99h
         p90piIdEDHSDHGK4FzA65YHKlUGIjSnoQ4PkL0yEcp5WUclvunzjMY1JxM8594qEuxL8
         tXfvRA6vtv/kdWrxYhO+0ZX0fHiA1habUEbxpRHubDOKGsU89zQ0UsjpoFLB4SpL+vy6
         y5Ng==
X-Gm-Message-State: AJcUukd4WD7r+KNhO9N6vVsbCGIhjH0cW3j7Aean8GpYv3wbAdRebfZG
        0VpaQLRfoqT1wFpgPCEALiY=
X-Google-Smtp-Source: ALg8bN6N0sf4mG6DcmIAyaykE6uh7WCYONrVvZ0n2Y5Dv4Ads2nYbKhlVGjjgDvwD3Te/97p9NuBJQ==
X-Received: by 2002:a2e:4a19:: with SMTP id x25-v6mr13647404lja.19.1547887235569;
        Sat, 19 Jan 2019 00:40:35 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id p23sm1187109lfh.47.2019.01.19.00.40.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 00:40:34 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Chen Feng <puck.chen@hisilicon.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Vincent Abriou <vincent.abriou@st.com>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Yannick Fertre <yannick.fertre@st.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/6] drm: minimize drmP.h dependencies
Date:   Sat, 19 Jan 2019 09:40:08 +0100
Message-Id: <20190119084014.5355-1-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updated patchset, with merged patches removed.
Addressed Laurents feedback (sorted include files)

> From the original mail:

	- drmP.h is now stripped down to include files
	  and forward declarations.
	- All header files in include/drm/ no longer include drmP.h.

The series was made on top of drm-misc-next.
Build tested using arm and x86

The patches are trivial but touches a lot of files,
so a lot of people on cc: for the individual patches.

This series will conflict with work going on in i915,
and Daniel has a plan how to apply this.

        Sam

v5:
- Rebased on top of drm-misc-next and dropped patches already merged
- Sorted list of include files where they are touched (Laurent)
- Collected ack's, reviewed by's

v4:
- Rebased on top of drm-misc-next and dropped patches already merged
- Include build test of kirin (Daniel)
- Plug drm_util.h into drm-internals.rst (Daniel)
- Fix kernel-doc syntax in drm_util.h (Daniel)
- Split removal of drmP.h from drm_modeset_helper.h
  in smaller patches, to ease the merge process

v3:
- Added Acks/Reviewed annotations (thanks!)
- Add forward of drm_gem_object to drm_framebuffer.h (Noralf)
- Drop "drm: move DRM_IF_VERSION to drm_internal.h" as it is applied to drm-misc
- Drop "drm: make drm_file.h self contained" as Jan made a similar patch that was appleid to drm-misc
- Rebased on top of drm-misc-next

v2:
- DRM_SWITCH_POWER as enum (Daniel Vetter)
- Prefer forward decalration over includes (Laurent Pinchart)
- Updated drm_device to use kerneldoc style (Daniel Vetter)
- Improved commit messages (David Lechner)
- Split up patch when removing drmP.h from drm_gem_cma_helper.h
- rebased on top of drm-misc-next
- dropped patch already applied
- added reviewed-by from Laurent Pinchart (Laurent Pinchart)
- add drm_framebuffer.h patch
- add kernel-doc comments to drm_util.h
- moved EXPORT_SYMBOL_FOR_TESTS_ONLY to drm_util.h
- added note to drmP.h not to add new stuff and not to use in new files

Sam Ravnborg (6):
      drm/stm: prepare for drmP.h removal from drm_modeset_helper.h
      drm/hisilicon/kirin: prepare for drmP.h removal from drm_modeset_helper.h
      drm/arcpgu: prepare for drmP.h removal from drm_modeset_helper.h
      drm/bridge: cdns: prepare for drmP.h removal from drm_modeset_helper.h
      drmi/rcar-du: prepare for drmP.h removal from drm_modeset_helper.h
      drm: remove drmP.h from drm_modeset_helper.h

 drivers/gpu/drm/arc/arcpgu_sim.c             |  3 ++-
 drivers/gpu/drm/bridge/cdns-dsi.c            |  2 ++
 drivers/gpu/drm/drm_damage_helper.c          |  1 +
 drivers/gpu/drm/drm_modeset_helper.c         |  2 ++
 drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c | 11 ++++++++---
 drivers/gpu/drm/rcar-du/rcar_lvds.c          |  1 +
 drivers/gpu/drm/stm/drv.c                    |  6 +++++-
 drivers/gpu/drm/stm/ltdc.c                   |  9 ++++++++-
 include/drm/drm_modeset_helper.h             |  6 +++++-
 9 files changed, 34 insertions(+), 7 deletions(-)
