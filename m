Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5D1D0C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12BE6208D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oO65Xoba"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12BE6208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754714AbeFNHrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 03:47:18 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:37893 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754631AbeFNHrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 03:47:16 -0400
Received: by mail-pl0-f66.google.com with SMTP id b14-v6so3059755pls.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 00:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=hB8N7caivf5dNhcJxRLEqcbX9WI+8+J/asiSED2KGQA=;
        b=oO65Xoba0bM9QR2PpELD0f5gIhUTEtWYIoxSAiF19cFZpwTnIqRMTNe6LuXO6uL4Oj
         rcYMd3VAijIrgrEea3pDG4rnzvY6XJsmmzGLhPdtXIj8JoRN+uKbS7VGj7+4h/wkgQAR
         H9ElPikYN58vlmtKxeWCuaUh8ffmQeW8lgj+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hB8N7caivf5dNhcJxRLEqcbX9WI+8+J/asiSED2KGQA=;
        b=kh+qv+ibrciZs9kWdCCqoB9yYXNxhG1NCi+RjoB8qDCwmZj9rMC34CBFdJOGAOtIwG
         fxjd5nBanmmoH0FnmUz8TcPAEis07vG7k+J5helVcBVqXpE5BSAbeA+D4gTseq+B9haK
         561UKMNAMaVSsIzDuZpbEotvP8ABdJroEiTjNsIKe6iWfq2TcPHtfwprSBxFcsmiVr6t
         CQh40bWNqz7jjJ9O9Zy4JisT/N7++diz6YcN4YAU6Q92PLAwlNDSuuQv+X2oQqPs2ZGI
         aIpFEzKh7IGQII39njT/LDW/4N6g1I1JrLnna68+A/cleK5EwI8q7ysIxAW+zGHJrx6c
         zUnA==
X-Gm-Message-State: APt69E01My9cJEfecEYjzX/lMMtB90h3Cu3ER8o74c2ZAFplKPo2AJtn
        TJomJjPDr9OvND8CtRw4DELWffNFajU=
X-Google-Smtp-Source: ADUXVKJoT3L0y2E0LRIb295uRFcq1bvH2PIcJmMMv/zuDq9JejVBz/e5ILtLKFKiL+bt3P0ZwuAjQA==
X-Received: by 2002:a17:902:b604:: with SMTP id b4-v6mr1809946pls.18.1528962435550;
        Thu, 14 Jun 2018 00:47:15 -0700 (PDT)
Received: from keiichiw1.tok.corp.google.com ([2401:fa00:4:4:968c:de0d:27a3:4bef])
        by smtp.gmail.com with ESMTPSA id y11-v6sm6522788pfn.92.2018.06.14.00.47.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 00:47:14 -0700 (PDT)
From:   Keiichi Watanabe <keiichiw@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kamil Debski <kamil@wypas.org>,
        Jeongtae Park <jtp.park@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Keiichi Watanabe <keiichiw@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Smitha T Murthy <smitha.t@samsung.com>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        s.nawrocki@samsung.com
Subject: [PATCH v3 0/3] Add controls for VP8/VP9 profile
Date:   Thu, 14 Jun 2018 16:46:49 +0900
Message-Id: <20180614074652.162796-1-keiichiw@chromium.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series add new menu controls V4L2_CID_MPEG_VIDEO_VP8_PROFILE and
V4L2_CID_MPEG_VIDEO_VP9_PROFILE for VP8/VP9 profiles. These controls can be used
to select a desired profile for VP8/VP9 encoders. In addition, they are also
used to query for supported profiles by an encoder or a decoder.

Patch 1 adds a control V4L2_CID_MPEG_VIDEO_VP8_PROFILE for VP8 profile. Though
V4L2_CID_MPEG_VIDEO_VPX_PROFILE is originally used for VP8 profile, this control
is not good by the following reasons:
(i) Despite the name contains 'VPX', it cannot be used for VP9 because supported
profiles differ between VP8 and VP9.
(ii) Unlike other controls for profiles (e.g. H264), this is not a menu control
but an integer control, which cannot be used to query for supported profiles.

Thus, V4L2_CID_MPEG_VIDEO_VPX_PROFILE is deprecated and become an alias of
V4L2_CID_MPEG_VIDEO_VP8_PROFILE. In addition, Patch 1 fixes the use of
V4L2_CID_MPEG_VIDEO_VPX_PROFILE in existing venus/s5p_mfc drivers.

Patch 2 adds a control V4L2_CID_MPEG_VIDEO_VP9_PROFILE for VP9 profile.

By patch 3, this control is supported in MediaTek decoder's driver, which
supports VP9 profile 0.

Version 3 changes:
- Add V4L2_CID_MPEG_VIDEO_VP8_PROFILE in v4l2-controls.
- Make V4L2_CID_MPEG_VIDEO_VPX_PROFILE to be an alias of
  V4L2_CID_MPEG_VIDEO_VP8_PROFILE.
- Fix the use of V4L2_CID_MPEG_VIDEO_VPX_PROFILE in venus/s5p_mfc drivers.
- Small fix in mtk_vcodec_dec.

Version 2 changes:
- Support V4L2_CID_MPEG_VIDEO_VP9_PROFILE in MediaTek decoder's driver.

Version 1 changes:
- Add V4L2_CID_MPEG_VIDEO_VP9_PROFILE in v4l2-controls.

Keiichi Watanabe (3):
  media: v4l2-ctrl: Change control for VP8 profile to menu control
  media: v4l2-ctrl: Add control for VP9 profile
  media: mtk-vcodec: Support VP9 profile in decoder

 .../media/uapi/v4l/extended-controls.rst      | 52 +++++++++++++++++--
 .../platform/mtk-vcodec/mtk_vcodec_dec.c      |  5 ++
 drivers/media/platform/qcom/venus/core.h      |  2 +-
 .../media/platform/qcom/venus/hfi_helper.h    | 12 ++---
 .../media/platform/qcom/venus/vdec_ctrls.c    | 10 ++--
 drivers/media/platform/qcom/venus/venc.c      | 14 ++---
 .../media/platform/qcom/venus/venc_ctrls.c    | 12 +++--
 drivers/media/platform/s5p-mfc/s5p_mfc_enc.c  | 15 +++---
 drivers/media/v4l2-core/v4l2-ctrls.c          | 23 +++++++-
 include/uapi/linux/v4l2-controls.h            | 18 ++++++-
 10 files changed, 127 insertions(+), 36 deletions(-)

--
2.18.0.rc1.242.g61856ae69a-goog
