Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3FCC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5574A20864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZW+ZJV3I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5574A20864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933258AbeFRIAj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:00:39 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:45699 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932612AbeFRIAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:00:37 -0400
Received: by mail-pg0-f65.google.com with SMTP id z1-v6so7134549pgv.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 01:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=cN81UpZytDgGH1q7pVFxwT3Z8JMPLUn5wf+Benx79dg=;
        b=ZW+ZJV3I3tWC2br+YWwJXIU+EE0Lr3fT7hBW0xXFTQ0c11VpNAHZ6jR1I0tunCKpUk
         /6tzZOmVeyLyYWfsUZ2pMw+S7qUri+ECSOoxRI/2nLTdADJX6b84Fq6n3q0HCxjLqzTR
         QrejNcKXcUTSuLKM9eOl8FKmJD/0DM/ZZZ5E8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cN81UpZytDgGH1q7pVFxwT3Z8JMPLUn5wf+Benx79dg=;
        b=PfUUDCXweRanCjFHg7JIVf8MhLx/St21CeAYWYhNyHyidDNfzpcxH+w1t63/mbgi3L
         3qyR92juEpAlK4xy5FAecPcojAql5VS/KPsZ6cpCpvJvfeWr/A+5/CM3kCV+qWKqsL0V
         g6IgvfDF8w5NXpERzt2x67/dF+dtnP5XbAzDb94lbCYEGKBW7MM7iAkIMNBc81Mca7nz
         MvuLVXH5oYV6y/AdzniI8gf2pZFeg1RebTyczwIdNVodBVYyymA6YgeohekvfnCWMG+Q
         zUyyV7R/CwlLWcN5kTFfpi5WnDCjGHlX0nh/FUx055M5el9PVwVIcjaMlxVsSalyGq35
         4pAg==
X-Gm-Message-State: APt69E0YxB9Lr4oszfDlHxFi2a/S/ujHw/A3iSmQN8RYozuXfMOxwtFn
        CAWd/vWXOxoqWrxgoVhbwmNDwQ==
X-Google-Smtp-Source: ADUXVKI8IL/GoWFjZXrtBeO2I4hdRe5O0l0SKjp6BPsjUW2arL1PXVn+bHLnChVGvEdZ4/FUzXTWAg==
X-Received: by 2002:a65:660a:: with SMTP id w10-v6mr9877522pgv.366.1529308836729;
        Mon, 18 Jun 2018 01:00:36 -0700 (PDT)
Received: from keiichiw1.tok.corp.google.com ([2401:fa00:4:4:968c:de0d:27a3:4bef])
        by smtp.gmail.com with ESMTPSA id d9-v6sm23543236pfg.183.2018.06.18.01.00.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 01:00:35 -0700 (PDT)
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
        Smitha T Murthy <smitha.t@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tom Saeger <tom.saeger@oracle.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v4 0/3] Add controls for VP8/VP9 profile
Date:   Mon, 18 Jun 2018 16:58:51 +0900
Message-Id: <20180618075854.12881-1-keiichiw@chromium.org>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the 4th revision of the patch set that adds controls for VP8/VP9
profiles. Please see v3 cover letter for more details.
<https://lkml.org/lkml/2018/6/14/132>

In this version, I changed the contents that pointed out by Stanimir and Hans.

Changelog
----------

Version 4 changes:
- Remove unnecessary changes in venus drivers.
- Remove unnecessary blank lines in documentations.
- Fix typo and grammar mistakes.

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

 .../media/uapi/v4l/extended-controls.rst      | 48 +++++++++++++++++--
 .../platform/mtk-vcodec/mtk_vcodec_dec.c      |  5 ++
 .../media/platform/qcom/venus/vdec_ctrls.c    | 10 ++--
 drivers/media/platform/qcom/venus/venc.c      |  4 +-
 .../media/platform/qcom/venus/venc_ctrls.c    | 10 ++--
 drivers/media/platform/s5p-mfc/s5p_mfc_enc.c  | 15 +++---
 drivers/media/v4l2-core/v4l2-ctrls.c          | 23 ++++++++-
 include/uapi/linux/v4l2-controls.h            | 18 ++++++-
 8 files changed, 110 insertions(+), 23 deletions(-)

--
2.18.0.rc1.244.gcf134e6275-goog
