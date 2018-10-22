Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862A8C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 14:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B5A620645
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 14:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hZybMC2L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B5A620645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbeJVXIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 19:08:04 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42021 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbeJVXIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 19:08:04 -0400
Received: by mail-pl1-f194.google.com with SMTP id c8-v6so19165364plo.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 07:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+1KZXHHhqgavw6jNVFM3//RcnjVG71f4baEma6XtfFs=;
        b=hZybMC2LMgJucbEzD0FSUvnym7PMzsVnvjzB+1Q9B+lafUFxNV2t09ZdG0g8MqN5LD
         4vbPBY60EQa80BLnwD6cjqMSmX6SVfnHe6Kqb4xKutFDiCRMi2LS6AqUpkdrdqxOjCaL
         B90OQoNFLvMJOLtmi3ClN/uN1kV8GmiM+37is=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+1KZXHHhqgavw6jNVFM3//RcnjVG71f4baEma6XtfFs=;
        b=Ev1uTNlICK/ybIil0d7cVuqllcadb2/6Ta7qnjak5Ab1ogPiIkxpuI9fn8eIIUW2ll
         K8kBZlIpw51taw2b12TLBQA98Y2jaM9TMO45VfNUMVnFLqO0G/0djlSUH2CocWmx2WrL
         GJkXPtHFCgW/bDUAEE5J3Qgt3SV2FvtYWVBQNvgF4HDLf9O0nxWSChvEaqwl0gF52p0M
         +JkUZKuS5teNwA2MwhETpN9AM2vt3l/UmxhMpKyypeCMHcp1iddv7hrgtzWeOS/DweM6
         3MNeSh6DIg3XNI2OBPXxdtUJEZDWcTVYEsYwgYBZeuix4YhcDTumhnu6CCjLqLryOE9l
         nHKQ==
X-Gm-Message-State: ABuFfohVc/VoYOfDKAXvmlsSqQQ47419BXBTePogJM3PaBcQVoEQnxud
        pJzPLa8X7k+WRmLFRrzBIAEtlw==
X-Google-Smtp-Source: ACcGV632jqkTDMZt4EF5PYWHIc/821qp3JU8sLVc3VLvwZxVR/bWl7bco929OsctcHJPuH2VFO8npg==
X-Received: by 2002:a17:902:1c3:: with SMTP id b61-v6mr32102828plb.65.1540219752537;
        Mon, 22 Oct 2018 07:49:12 -0700 (PDT)
Received: from tfiga.tok.corp.google.com ([2401:fa00:4:4:5b21:5966:1198:d1e9])
        by smtp.gmail.com with ESMTPSA id s80-v6sm42245429pfa.114.2018.10.22.07.49.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 07:49:11 -0700 (PDT)
From:   Tomasz Figa <tfiga@chromium.org>
To:     linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        =?UTF-8?q?Pawe=C5=82=20O=C5=9Bciak?= <posciak@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Kamil Debski <kamil@wypas.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jeongtae Park <jtp.park@samsung.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Todor Tomov <todor.tomov@linaro.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dave.stevenson@raspberrypi.org,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Maxime Jourdan <maxi.jourdan@wanadoo.fr>,
        Tomasz Figa <tfiga@chromium.org>
Subject: [PATCH v2 0/2] Document memory-to-memory video codec interfaces
Date:   Mon, 22 Oct 2018 23:48:58 +0900
Message-Id: <20181022144901.113852-1-tfiga@chromium.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's been a while, but here is the v2 of the stateful mem2mem codec
interfaces documentation. Sorry for taking so long time to respin.

This series attempts to add the documentation of what was discussed
during Media Workshops at LinuxCon Europe 2012 in Barcelona and then
later Embedded Linux Conference Europe 2014 in Düsseldorf and then
eventually written down by Pawel Osciak and tweaked a bit by Chrome OS
video team (but mostly in a cosmetic way or making the document more
precise), during the several years of Chrome OS using the APIs in
production.

Note that most, if not all, of the API is already implemented in
existing mainline drivers, such as s5p-mfc or mtk-vcodec. Intention of
this series is just to formalize what we already have.

Thanks everyone for the huge amount of useful comments for the RFC and
v1. Much of the credits should go to Pawel Osciak too, for writing most
of the original text of the initial RFC.

Changes since v1:
(https://lore.kernel.org/patchwork/project/lkml/list/?series=360520)
Decoder:
 - Removed a note about querying all combinations of OUTPUT and CAPTURE
   frame sizes, since it would conflict with scaling/composiion support
   to be added later.
 - Removed the source change event after setting non-zero width and
   height on OUTPUT queue, since the change happens as a direct result
   of a client action.
 - Moved all the setup steps for CAPTURE queue out of Initialization
   and Dynamic resolution change into a common sequence called Capture
   setup, since they were mostly duplicate of each other.
 - Described steps to allocate buffers for higher resolution than the
   stream to prepare for future resolution changes.
 - Described a way to skip the initial header parsing and speculatively
   configure the CAPTURE queue (for gstreamer/ffmpeg compatibility).
 - Reordered CAPTURE setup steps so that all the driver queries are done
   first and only then a reconfiguration may be attempted or skipped.
 - Described VIDIOC_CREATE_BUFS as another way of allocating buffers.
 - Made the decoder signal the source change event as soon as the change
   is detected, to reduce pipeline stalls in case of buffers already
   good to continue decoding.
 - Stressed out the fact that a source change may happen even without a
   change in the coded resolution.
 - Described querying pixel aspect ratio using VIDIOC_CROPCAP.
 - Extended documentation of VIDIOC_DECODER_CMD and VIDIOC_G/S/TRY_FMT
   to more precisely describe the behavior of mem2mem decoders.
 - Clarified that 0 width and height are allowed for OUTPUT side of
   mem2mem decoders in the documentation of the v4l2_pix_fmt struct.

Encoder:
 - Removed width and height from CAPTURE (coded) format, since the coded
   resolution of the stream is an internal detail of the encoded stream.
 - Made the VIDIOC_S_FMT on OUTPUT mandatory, since the default format
   normally does not make sense (even if technically valid).
 - Changed the V4L2_SEL_TGT_CROP_BOUNDS and V4L2_SEL_TGT_CROP_DEFAULT
   selection targets to be equal to the full source frame to simplify
   internal handling in drivers for simple hardware.
 - Changed the V4L2_SEL_TGT_COMPOSE_DEFAULT selection target to be equal
   to |crop width|x|crop height|@(0,0) to simplify internal handling in
   drivers for simple hardware.
 - Removed V4L2_SEL_TGT_COMPOSE_PADDED, since the encoder does not write
   to the raw buffers.
 - Extended documentation of VIDIOC_ENCODER_CMD to more precisely
   describe the behavior of mem2mem encoders.
 - Clarified that 0 width and height are allowed for CAPTURE side of
   mem2mem encoders in the documentation of the v4l2_pix_fmt struct.

General:
 - Clarified that the Drain sequence valid only if both queues are
   streaming and stopping any of the queues would abort it, since there
   is nothing to drain, if OUTPUT is stopped and there is no way to
   signal the completion if CAPTURE is stopped.
 - Clarified that VIDIOC_STREAMON on any of the queues would resume the
   codec from stopped state, to be consistent with the documentation of
   VIDIOC_ENCODER/DECODER_CMD.
 - Documented the relation between timestamps of OUTPUT and CAPTURE
   buffers and how special cases of non-1:1 relation are handled.
 - Added missing sizeimage to bitstream format operations and removed
   the mistaken mentions from descriptions of respective REQBUFS calls.
 - Removed the Pause sections, since there is no notion of pause for
   mem2mem devices.
 - Added state machine diagrams.
 - Merged both glossaries into one in the decoder document and a
   reference to it in the encoder document.
 - Added missing terms to the glossary.
 - Added "Stateful" to the interface names.
 - Reworded the text to be more userspace-centric.
 - A number of other readability improvements suggested in review comments.

For changes since RFC see the v1:
https://lore.kernel.org/patchwork/project/lkml/list/?series=360520

Tomasz Figa (2):
  media: docs-rst: Document memory-to-memory video decoder interface
  media: docs-rst: Document memory-to-memory video encoder interface

 Documentation/media/uapi/v4l/dev-decoder.rst  | 1082 +++++++++++++++++
 Documentation/media/uapi/v4l/dev-encoder.rst  |  579 +++++++++
 Documentation/media/uapi/v4l/devices.rst      |    2 +
 Documentation/media/uapi/v4l/pixfmt-v4l2.rst  |   10 +
 Documentation/media/uapi/v4l/v4l2.rst         |   12 +-
 .../media/uapi/v4l/vidioc-decoder-cmd.rst     |   40 +-
 .../media/uapi/v4l/vidioc-encoder-cmd.rst     |   38 +-
 Documentation/media/uapi/v4l/vidioc-g-fmt.rst |   14 +
 8 files changed, 1747 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/media/uapi/v4l/dev-decoder.rst
 create mode 100644 Documentation/media/uapi/v4l/dev-encoder.rst

-- 
2.19.1.568.g152ad8e336-goog

