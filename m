Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF39DC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97D5A21473
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJ8A9dVl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97D5A21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbeJEBtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 21:49:19 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39809 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbeJEBtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 21:49:18 -0400
Received: by mail-wr1-f65.google.com with SMTP id 61-v6so10298561wrb.6;
        Thu, 04 Oct 2018 11:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cG9VS7jnh6YQ8GOt+2fU35PjyyKZwM8EKuhYPfMi6LY=;
        b=YJ8A9dVl2Pf7ZQhEM5lVSh6UJiaC66gRKNmpLabLMD6PvTjtImNATNQ5zo2ygIPjKS
         qOq+giNRozNr5Qn0c8h6doCf8ePRKeCatAGMktR96DYnC17mC4pcBd2U3Z0ep3xsMJqV
         zG+jEBTCvanf7plKPDTckKBPcZ8i0BmM2DBNmMoXy2xNYkPUM/rcpwkA82nFbUqZpkfZ
         +8UtPWqypnjPIMUzwJsDXNCOxm2u2hOX+5OwJw9Xn47oMDPY81DsMITDQdgioqf2m4rT
         YnV5d+Yq8lXbrKqFUiG6hknYSOPynKBmtJuYWCDhjj2j7P9Po0pAwuQ73v/qeLXTP+wF
         Sjeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cG9VS7jnh6YQ8GOt+2fU35PjyyKZwM8EKuhYPfMi6LY=;
        b=cMzU8HQrDe/U8K+90TaT8wCoa7m2qV65PNLD1LzehOCwlJYPbE6jda2HEvY4ryhves
         MrvFDlVmVdTRT1T0oli96nIX/Pt4zi0J3kVOcNCRW+h6pEWxaxnT+snnuWk49NhXQu4c
         MHG/jAHwS01S/6kYcLT4L/UgahAxTN2f8pgAC9iMJbcd+LVMc2j3wOgF6fkTLz2d5JoZ
         /ywSF6FxDSbggVnIYvxewqXUTIHDowy8dATPzYnVISgpDDLVbqYGZb5yUDYq8q/56HaQ
         3umRmqbSt4AhsuP3zYxO+Y207praxZ8KV5kW4HnPvERKTYN0WQQlhIeWxlVMl876rTzu
         1KBQ==
X-Gm-Message-State: ABuFfojnjfGcG1p7LzYl23D4YimQ9lkAbU/4bpMdnaO3iXhfnMQHOKYY
        Qm5fKeZzKG5mG7IbmgqNDilljlZx
X-Google-Smtp-Source: ACcGV61NkLcRrZCoEWv9j+o+kjmfW6n0nYszu++b5Zd0i2RAqD8bnXewDsZFQAvR6t0VoohEq0xamg==
X-Received: by 2002:a5d:69c2:: with SMTP id s2-v6mr5792339wrw.232.1538679282225;
        Thu, 04 Oct 2018 11:54:42 -0700 (PDT)
Received: from mappy.world.mentorg.com (nat-wv.mentorg.com. [192.94.38.34])
        by smtp.gmail.com with ESMTPSA id h78-v6sm8706877wmd.4.2018.10.04.11.54.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 11:54:41 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 11/11] media: imx.rst: Update doc to reflect fixes to interlaced capture
Date:   Thu,  4 Oct 2018 11:54:01 -0700
Message-Id: <20181004185401.15751-12-slongerbeam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181004185401.15751-1-slongerbeam@gmail.com>
References: <20181004185401.15751-1-slongerbeam@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also add an example pipeline for unconverted capture with interweave
on SabreAuto.

Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
---
Changes since v3:
- none.
Changes since v2:
- expand on idmac interweave behavior in CSI subdev.
- switch second SabreAuto pipeline example to PAL to give
  both NTSC and PAL examples.
- Cleanup some language in various places.
---
 Documentation/media/v4l-drivers/imx.rst | 93 ++++++++++++++++---------
 1 file changed, 60 insertions(+), 33 deletions(-)

diff --git a/Documentation/media/v4l-drivers/imx.rst b/Documentation/media/v4l-drivers/imx.rst
index 65d3d15eb159..1f6279d418ed 100644
--- a/Documentation/media/v4l-drivers/imx.rst
+++ b/Documentation/media/v4l-drivers/imx.rst
@@ -22,8 +22,8 @@ memory. Various dedicated DMA channels exist for both video capture and
 display paths. During transfer, the IDMAC is also capable of vertical
 image flip, 8x8 block transfer (see IRT description), pixel component
 re-ordering (for example UYVY to YUYV) within the same colorspace, and
-even packed <--> planar conversion. It can also perform a simple
-de-interlacing by interleaving even and odd lines during transfer
+packed <--> planar conversion. The IDMAC can also perform a simple
+de-interlacing by interweaving even and odd lines during transfer
 (without motion compensation which requires the VDIC).
 
 The CSI is the backend capture unit that interfaces directly with
@@ -173,15 +173,19 @@ via the SMFC and an IDMAC channel, bypassing IC pre-processing. This
 source pad is routed to a capture device node, with a node name of the
 format "ipuX_csiY capture".
 
-Note that since the IDMAC source pad makes use of an IDMAC channel, it
-can do pixel reordering within the same colorspace. For example, the
+Note that since the IDMAC source pad makes use of an IDMAC channel, the
+CSI can do pixel reordering within the same colorspace. For example, the
 sink pad can take UYVY2X8, but the IDMAC source pad can output YUYV2X8.
 If the sink pad is receiving YUV, the output at the capture device can
 also be converted to a planar YUV format such as YUV420.
 
-It will also perform simple de-interlace without motion compensation,
-which is activated if the sink pad's field type is an interlaced type,
-and the IDMAC source pad field type is set to none.
+The CSI will also perform simple interweave without motion compensation,
+which is activated if the source pad's field type is sequential top-bottom
+or bottom-top or alternate, and the capture interface field type is set
+to interlaced (t-b, b-t, or unqualified interlaced). The capture interface
+will enforce the same field order if the source pad field type is seq-bt
+or seq-tb. However if the source pad's field type is alternate, any
+interlaced type at the capture interface will be accepted.
 
 This subdev can generate the following event when enabling the second
 IDMAC source pad:
@@ -323,14 +327,14 @@ ipuX_vdic
 
 The VDIC carries out motion compensated de-interlacing, with three
 motion compensation modes: low, medium, and high motion. The mode is
-specified with the menu control V4L2_CID_DEINTERLACING_MODE. It has
-two sink pads and a single source pad.
+specified with the menu control V4L2_CID_DEINTERLACING_MODE. The VDIC
+has two sink pads and a single source pad.
 
 The direct sink pad receives from an ipuX_csiY direct pad. With this
 link the VDIC can only operate in high motion mode.
 
 When the IDMAC sink pad is activated, it receives from an output
-or mem2mem device node. With this pipeline, it can also operate
+or mem2mem device node. With this pipeline, the VDIC can also operate
 in low and medium modes, because these modes require receiving
 frames from memory buffers. Note that an output or mem2mem device
 is not implemented yet, so this sink pad currently has no links.
@@ -343,8 +347,8 @@ ipuX_ic_prp
 This is the IC pre-processing entity. It acts as a router, routing
 data from its sink pad to one or both of its source pads.
 
-It has a single sink pad. The sink pad can receive from the ipuX_csiY
-direct pad, or from ipuX_vdic.
+This entity has a single sink pad. The sink pad can receive from the
+ipuX_csiY direct pad, or from ipuX_vdic.
 
 This entity has two source pads. One source pad routes to the
 pre-process encode task entity (ipuX_ic_prpenc), the other to the
@@ -367,8 +371,8 @@ color-space conversion, resizing (downscaling and upscaling),
 horizontal and vertical flip, and 90/270 degree rotation. Flip
 and rotation are provided via standard V4L2 controls.
 
-Like the ipuX_csiY IDMAC source, it can also perform simple de-interlace
-without motion compensation, and pixel reordering.
+Like the ipuX_csiY IDMAC source, this entity can also perform simple
+de-interlace without motion compensation, and pixel reordering.
 
 ipuX_ic_prpvf
 -------------
@@ -378,18 +382,18 @@ pad from ipuX_ic_prp, and a single source pad. The source pad is routed
 to a capture device node, with a node name of the format
 "ipuX_ic_prpvf capture".
 
-It is identical in operation to ipuX_ic_prpenc, with the same resizing
-and CSC operations and flip/rotation controls. It will receive and
-process de-interlaced frames from the ipuX_vdic if ipuX_ic_prp is
+This entity is identical in operation to ipuX_ic_prpenc, with the same
+resizing and CSC operations and flip/rotation controls. It will receive
+and process de-interlaced frames from the ipuX_vdic if ipuX_ic_prp is
 receiving from ipuX_vdic.
 
-Like the ipuX_csiY IDMAC source, it can perform simple de-interlace
-without motion compensation. However, note that if the ipuX_vdic is
-included in the pipeline (ipuX_ic_prp is receiving from ipuX_vdic),
-it's not possible to use simple de-interlace in ipuX_ic_prpvf, since
-the ipuX_vdic has already carried out de-interlacing (with motion
-compensation) and therefore the field type output from ipuX_ic_prp can
-only be none.
+Like the ipuX_csiY IDMAC source, this entity can perform simple
+interweaving without motion compensation. However, note that if the
+ipuX_vdic is included in the pipeline (ipuX_ic_prp is receiving from
+ipuX_vdic), it's not possible to use interweave in ipuX_ic_prpvf,
+since the ipuX_vdic has already carried out de-interlacing (with
+motion compensation) and therefore the field type output from
+ipuX_vdic can only be none (progressive).
 
 Capture Pipelines
 -----------------
@@ -514,10 +518,33 @@ On the SabreAuto, an on-board ADV7180 SD decoder is connected to the
 parallel bus input on the internal video mux to IPU1 CSI0.
 
 The following example configures a pipeline to capture from the ADV7180
-video decoder, assuming NTSC 720x480 input signals, with Motion
-Compensated de-interlacing. Pad field types assume the adv7180 outputs
-"interlaced". $outputfmt can be any format supported by the ipu1_ic_prpvf
-entity at its output pad:
+video decoder, assuming NTSC 720x480 input signals, using simple
+interweave (unconverted and without motion compensation). The adv7180
+must output sequential or alternating fields (field type 'seq-bt' for
+NTSC, or 'alternate'):
+
+.. code-block:: none
+
+   # Setup links
+   media-ctl -l "'adv7180 3-0021':0 -> 'ipu1_csi0_mux':1[1]"
+   media-ctl -l "'ipu1_csi0_mux':2 -> 'ipu1_csi0':0[1]"
+   media-ctl -l "'ipu1_csi0':2 -> 'ipu1_csi0 capture':0[1]"
+   # Configure pads
+   media-ctl -V "'adv7180 3-0021':0 [fmt:UYVY2X8/720x480 field:seq-bt]"
+   media-ctl -V "'ipu1_csi0_mux':2 [fmt:UYVY2X8/720x480]"
+   media-ctl -V "'ipu1_csi0':2 [fmt:AYUV32/720x480]"
+   # Configure "ipu1_csi0 capture" interface (assumed at /dev/video4)
+   v4l2-ctl -d4 --set-fmt-video=field=interlaced_bt
+
+Streaming can then begin on /dev/video4. The v4l2-ctl tool can also be
+used to select any supported YUV pixelformat on /dev/video4.
+
+This example configures a pipeline to capture from the ADV7180
+video decoder, assuming PAL 720x576 input signals, with Motion
+Compensated de-interlacing. The adv7180 must output sequential or
+alternating fields (field type 'seq-tb' for PAL, or 'alternate').
+$outputfmt can be any format supported by the ipu1_ic_prpvf entity
+at its output pad:
 
 .. code-block:: none
 
@@ -529,11 +556,11 @@ entity at its output pad:
    media-ctl -l "'ipu1_ic_prp':2 -> 'ipu1_ic_prpvf':0[1]"
    media-ctl -l "'ipu1_ic_prpvf':1 -> 'ipu1_ic_prpvf capture':0[1]"
    # Configure pads
-   media-ctl -V "'adv7180 3-0021':0 [fmt:UYVY2X8/720x480]"
-   media-ctl -V "'ipu1_csi0_mux':2 [fmt:UYVY2X8/720x480 field:interlaced]"
-   media-ctl -V "'ipu1_csi0':1 [fmt:AYUV32/720x480 field:interlaced]"
-   media-ctl -V "'ipu1_vdic':2 [fmt:AYUV32/720x480 field:none]"
-   media-ctl -V "'ipu1_ic_prp':2 [fmt:AYUV32/720x480 field:none]"
+   media-ctl -V "'adv7180 3-0021':0 [fmt:UYVY2X8/720x576 field:seq-tb]"
+   media-ctl -V "'ipu1_csi0_mux':2 [fmt:UYVY2X8/720x576]"
+   media-ctl -V "'ipu1_csi0':1 [fmt:AYUV32/720x576]"
+   media-ctl -V "'ipu1_vdic':2 [fmt:AYUV32/720x576 field:none]"
+   media-ctl -V "'ipu1_ic_prp':2 [fmt:AYUV32/720x576 field:none]"
    media-ctl -V "'ipu1_ic_prpvf':1 [fmt:$outputfmt field:none]"
 
 Streaming can then begin on the capture device node at
-- 
2.17.1

