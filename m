Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9733BC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 010432087D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cc66YBAf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 010432087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbeJEBtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 21:49:10 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35182 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728324AbeJEBtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 21:49:09 -0400
Received: by mail-wm1-f65.google.com with SMTP id e187-v6so2564363wmf.0;
        Thu, 04 Oct 2018 11:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BwIrt/QiZthUXo9qim2CsYJxYbNHfbi5cRl8NpsI+xE=;
        b=Cc66YBAfVN42IrVHUONRAd+/GlSOM5cI3pE6ejedc+kaiqzi4Yml8r0V1JUKbkNjG8
         Ke8e1zXROvNaHorGJksQ8WXatAUWiMpvHVjKDZ1PIq3tRZ3khhCW4rs2dTlr18Q/uwsV
         Dw0Ps1JKmptc2mNgkQuG2BbKuMndbD2fO1cDwoKOKYsDIKT4UG4uLBjBRQgi8keQgSa1
         n5jhoCTWkjDHYzp6a+UDKKKOth9CTJR1C31wtwTsdW/EVp42tUQo9dtaPoh5GT9mOsxl
         fa89UZrDzIU7I4dhIJ5a3ezxx3FTCVl+0F3ntE1FOsr7EvzujiGwoH6JN28NK7OGTBNH
         lldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BwIrt/QiZthUXo9qim2CsYJxYbNHfbi5cRl8NpsI+xE=;
        b=KQzJjWGEDtLqc42+hKAa5j0YZbx2BH10Nir4lLWBkgo8j5Qah4To0pM6jyl5Zq1h9o
         ObxA1HorlohKzTRuT0GYV2w6DxS6PXgHqK5sVNglQl2SSKUli5Xa7xndDTWv3amrN6zA
         G7cQCgJiBMpClFnpKyt6D7a64uGjN+RE7XJk3XmyBcQi1ilrlg5drdp5iQtvrVdDYVOP
         KSWy3L9gt6bHVQw+2mjAL2weK4g02BUnLI1bCO0JickrblORVf9Xr2uwV/9HaO7F/VBe
         yUOCekloegbZK2lVYR3CIzLSCpCegE1bZgcn2QML9zjJVnJcnXgTSqZpOPpuUVaA3oRv
         J+Lw==
X-Gm-Message-State: ABuFfojkp8+n3ncy1EMuchQg446F1VmDRJDlQ7EaWxNHU9t5i07NURcE
        LjBKtHdNFYVnD6WcnPoJZzotg17t
X-Google-Smtp-Source: ACcGV62l3qtxLK2FthTZ1BPaR+yafdZoSDL+2ApVRn3rWh2bLWXZ8cNow6G8/k/HzNQTZGGmtwS/Vg==
X-Received: by 2002:a1c:1e8e:: with SMTP id e136-v6mr5648336wme.100.1538679274138;
        Thu, 04 Oct 2018 11:54:34 -0700 (PDT)
Received: from mappy.world.mentorg.com (nat-wv.mentorg.com. [192.94.38.34])
        by smtp.gmail.com with ESMTPSA id h78-v6sm8706877wmd.4.2018.10.04.11.54.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 11:54:33 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 08/11] media: imx: vdic: rely on VDIC for correct field order
Date:   Thu,  4 Oct 2018 11:53:58 -0700
Message-Id: <20181004185401.15751-9-slongerbeam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181004185401.15751-1-slongerbeam@gmail.com>
References: <20181004185401.15751-1-slongerbeam@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

prepare_vdi_in_buffers() was setting up the dma pointers as if the
VDIC is always programmed to receive the fields in bottom-top order,
i.e. as if ipu_vdi_set_field_order() only programs BT order in the VDIC.
But that's not true, ipu_vdi_set_field_order() is working correctly.

So fix prepare_vdi_in_buffers() to give the VDIC the fields in whatever
order they were received by the video source, and rely on the VDIC to
sort out which is top and which is bottom.

Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
---
 drivers/staging/media/imx/imx-media-vdic.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/media/imx/imx-media-vdic.c b/drivers/staging/media/imx/imx-media-vdic.c
index 482250d47e7c..4a890714193e 100644
--- a/drivers/staging/media/imx/imx-media-vdic.c
+++ b/drivers/staging/media/imx/imx-media-vdic.c
@@ -219,26 +219,18 @@ static void __maybe_unused prepare_vdi_in_buffers(struct vdic_priv *priv,
 
 	switch (priv->fieldtype) {
 	case V4L2_FIELD_SEQ_TB:
-		prev_phys = vb2_dma_contig_plane_dma_addr(prev_vb, 0);
-		curr_phys = vb2_dma_contig_plane_dma_addr(curr_vb, 0) + fs;
-		next_phys = vb2_dma_contig_plane_dma_addr(curr_vb, 0);
-		break;
 	case V4L2_FIELD_SEQ_BT:
 		prev_phys = vb2_dma_contig_plane_dma_addr(prev_vb, 0) + fs;
 		curr_phys = vb2_dma_contig_plane_dma_addr(curr_vb, 0);
 		next_phys = vb2_dma_contig_plane_dma_addr(curr_vb, 0) + fs;
 		break;
+	case V4L2_FIELD_INTERLACED_TB:
 	case V4L2_FIELD_INTERLACED_BT:
+	case V4L2_FIELD_INTERLACED:
 		prev_phys = vb2_dma_contig_plane_dma_addr(prev_vb, 0) + is;
 		curr_phys = vb2_dma_contig_plane_dma_addr(curr_vb, 0);
 		next_phys = vb2_dma_contig_plane_dma_addr(curr_vb, 0) + is;
 		break;
-	default:
-		/* assume V4L2_FIELD_INTERLACED_TB */
-		prev_phys = vb2_dma_contig_plane_dma_addr(prev_vb, 0);
-		curr_phys = vb2_dma_contig_plane_dma_addr(curr_vb, 0) + is;
-		next_phys = vb2_dma_contig_plane_dma_addr(curr_vb, 0);
-		break;
 	}
 
 	ipu_cpmem_set_buffer(priv->vdi_in_ch_p, 0, prev_phys);
-- 
2.17.1

