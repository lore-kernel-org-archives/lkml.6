Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731FFC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 419E62064C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtbhfj1P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731944AbfAHT5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:57:13 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34862 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730533AbfAHT37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:29:59 -0500
Received: by mail-lj1-f193.google.com with SMTP id x85-v6so4432931ljb.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 11:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S7GQPxs0t3y9zlAXIHUyGYnhNOIZDGXN8RuqBsuueiw=;
        b=gtbhfj1P+JUlcfFdiUm2EguvL9J1JXer27daDEgPwyvAqrEvEKD7+ePByL2hqCoc20
         RGv000r7LaBfasfADgAyN7zAlLUXc+w69boEP4vte5S32gxr/ouqTmtA6IaBv2Sa+lkf
         MsUXz226zESLxgjmPUhhLbJV8r+dGBARP2uSRkGlvSdVjnpf5ZcfiBKyXBxltFGnCIBE
         +0geREvUEMyLFK8miMke7xvLBMdp9rWwCeEP/9vQxPn1t9ZDuBmGWS4D/oikgVd68ItU
         EPr2dBViP5UTXRLRCGpqEII1kCjt/PXC5l8JR+QIKymSVlQLpicEnKxGQoP5+N2WVzSw
         cXIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=S7GQPxs0t3y9zlAXIHUyGYnhNOIZDGXN8RuqBsuueiw=;
        b=lklgNZ6/4+oUpQHjqYzXKtc1sk9d7dwmM9Mw88FF84j7HRmv3F2N9ZMdAAwYtMu3Rf
         rjfcW3OP48dPqdppIRz2iuE5Hjs4cWPNCCfD8tpDuYGvGIgv8WSmRwHgs/bniimAErul
         Qwd4CfM3OrN4TS+MPBPRUTMlDqj5oN9I7jPGWJMsgS88C9Kl3wzxDGT67ylpRgjBZ2gr
         einqhYIZJD2XCmh/vyqAUoMAhWq6bI6zGBJsciHup+rI31fQNq4y/I4iaHCzgon03fkP
         yutvpLMzHehJXiqgix8DiSiMt5iec3rk6wwzkfhKxwt29ptKfVdHn2lNXMEbVqQwFlPr
         zRrA==
X-Gm-Message-State: AJcUukcOpZG9ifY7gTSHd/krMjboSC7YZoBqb0i4pix65x1t4buOWbgH
        bmRNeuAiWapa15IJdgJCaZ8=
X-Google-Smtp-Source: ALg8bN45yISxVeVGV0Q2ry4GyZgf9iC+eVMVl8DRMCSNume8GHSW54RwDAkchGpZpjG5SXGdKnU4ww==
X-Received: by 2002:a2e:974a:: with SMTP id f10-v6mr1992077ljj.61.1546975798138;
        Tue, 08 Jan 2019 11:29:58 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id q128-v6sm9122246ljq.14.2019.01.08.11.29.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 11:29:57 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        David Lechner <david@lechnology.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v3 07/12] drm: remove include of drmP.h from drm_encoder_slave.h
Date:   Tue,  8 Jan 2019 20:29:34 +0100
Message-Id: <20190108192939.15255-8-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190108192939.15255-1-sam@ravnborg.org>
References: <20190108192939.15255-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No further changes required.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Acked-by: Noralf Trønnes <noralf@tronnes.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Sean Paul <sean@poorly.run>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
 include/drm/drm_encoder_slave.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/drm/drm_encoder_slave.h b/include/drm/drm_encoder_slave.h
index 1107b4b1c599..a09864f6d684 100644
--- a/include/drm/drm_encoder_slave.h
+++ b/include/drm/drm_encoder_slave.h
@@ -27,7 +27,6 @@
 #ifndef __DRM_ENCODER_SLAVE_H__
 #define __DRM_ENCODER_SLAVE_H__
 
-#include <drm/drmP.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_encoder.h>
 
-- 
2.12.0

