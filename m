Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3875C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 17:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B69DF20866
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 17:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDLF9raS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbeL3RtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 12:49:12 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:47068 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbeL3RtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 12:49:08 -0500
Received: by mail-lj1-f195.google.com with SMTP id v15-v6so22341942ljh.13
        for <linux-kernel@vger.kernel.org>; Sun, 30 Dec 2018 09:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=VdeDdyogVLBFon8h3UNQyuscXKoXRi/BGyhqSDbu6NQ=;
        b=LDLF9raSqbTX6F7UKwWXJf7fRCUA52lWFWi8LsTlxD5WO+/AUf1/M5YCKYSjRq9Z3j
         Mh1I0wHGSuscLL+FcBBgUphtUzQEVlf2vCzHarY4g/613DZdUfLfVNGOC6jWZSGJWYZ6
         WzL+p3JWpgONNDKQVXvTVlaMZxO4zsUbPuJJA5tg3P9k3gkf1oEGQkzzj8y14QoGl6EE
         hFdq71jGwP9AnDu1UHC1oO3+KVLmO9zA42G4FYFCGX12FIm5WZW26TJ2WSI3uxnSD/la
         QMufJhoKO2H1kLSkNRSV+LKb74wG2EjKztAuFVYrs4t4oudYASr8Vvo3jsiwmIOLqWqk
         f1lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=VdeDdyogVLBFon8h3UNQyuscXKoXRi/BGyhqSDbu6NQ=;
        b=bk8PCmEHY99wxMAeykgmQL8EB85+tnRP8it34PPuUWQDRPkfodWqbEvJ/RogR52PqG
         zLisncKL8J77o4pko8A9Qdv7JLvLvTqF1zAO412ssGr8mqhlN5PfCnt4xcL2aZO/VCpi
         E53ldsIxX66E7g1KoNobDnrlGxlOdz1hIJoL9DEBzWjEaonSbmaHEG1L9MbAoKzAONnd
         3jamZJ5l2hbebbb0Wm+H0pwzPOiF3mzmALLhyzPyaT35JN2Z4Hynx33qvmI95A5YczVq
         +fBvADsn77/iQa4kZ61IGA5DBqyBAnpo45399vKpD0vpogBzd/uZG8IoBer2/Iey7Uyo
         /8sg==
X-Gm-Message-State: AJcUukcijHOMliJglupJEnxCfLJX9599BQ6Milg8smbF06pYoSvECBtx
        caBm3g+gxrDn6OOYxtXZg1I=
X-Google-Smtp-Source: AFSGD/XhE0kc0512ygaZL4jXWUfi+7RUrWwLXm5dqnxXPqU5rwX3fiOAloe9JcXuVqvfRK5uofRx8g==
X-Received: by 2002:a2e:4299:: with SMTP id h25-v6mr19129988ljf.5.1546192146234;
        Sun, 30 Dec 2018 09:49:06 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id q11sm8853170lfc.92.2018.12.30.09.49.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Dec 2018 09:49:05 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        David Lechner <david@lechnology.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v2 09/14] drm: remove include of drmP.h from drm_encoder_slave.h
Date:   Sun, 30 Dec 2018 18:48:33 +0100
Message-Id: <20181230174838.32330-10-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No further changes required.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
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

