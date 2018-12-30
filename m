Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0A6C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 17:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFCAE20861
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 17:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f15RlIuA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbeL3RtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 12:49:04 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40994 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbeL3RtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 12:49:03 -0500
Received: by mail-lf1-f66.google.com with SMTP id c16so17315900lfj.8
        for <linux-kernel@vger.kernel.org>; Sun, 30 Dec 2018 09:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=mEZJNWJtdpmKjd3zb3L4gpeSqO2og5SgBJuK13KPepA=;
        b=f15RlIuA8VH9tmq7XcdYkFvNkbfsARRGBtfOQIY1nYjIHse4pkXTYtW8SOPwsspt5H
         4ygy+Jauk85zNE0pVHRQIZHjsYNjuVW9KU0v0pqDMHZwjIQKIX9yoCWCKSRn1an7QK7c
         XL8BXc9S0VznVTz5u4VNUBb5Iz+FKbvMmXA3y3Cc8qj3Pyw5VxPFWLUcJOXxv6iK/GcF
         H6K66Jw/hjO5rLhzXDerAv2lem7Jfav140CuDj97O3w06OmGzWarfUkfBmHt4e89DPAV
         1iRBNMcUAdTanrp/fxtWMmiGPVz3Ob2WHr1bzp/eNCSrYt0hnxuix2xMtfYqE1SymM0g
         rnuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=mEZJNWJtdpmKjd3zb3L4gpeSqO2og5SgBJuK13KPepA=;
        b=ufjgAlxi4GMqALSjdp6Tfp7lgF4tKZV0ZZAeDRVSdGC+CU5BvWRzLgOYFE7f+zl4L0
         Kyvh9+CImGqhdrCYHq8qC/A0rIl6t+dMVPgV8E6Y/iwTF3dmxY08EIwDv70PeTvwOYSj
         mWhsOcNGYxCDjhnP0JeRPcNPnpXoI5D28NL7zTxSC9hXViXuruKNZ+Ux06amfC4yp6Gu
         uJAA6+cIDUNMIllsRLQ07al60E3iNCzLwsHI7N5pwsN4rnqUk88Cmit6rnBA16s3A7h7
         0hwmSEVIsxwoYlM0Xt0JSKfUjhJRnC03v+pBTOGTOLSzJWEb+HlUi6tcmDL2xPOCmelo
         5T/w==
X-Gm-Message-State: AA+aEWbjZsf+mt5hZEB22xbXXmfu3g+d7WMeFkexWqjo33kXLmSav76Y
        qyqTUfcL4lop+9AawaZhkVg=
X-Google-Smtp-Source: AFSGD/WC6+7GSYgxWUrnRxqZJePt404jwH9l1prUSteZrbZxz21/ghqqv8mTC7v/R6y3zxdpmwOIoA==
X-Received: by 2002:a19:9653:: with SMTP id y80mr17381485lfd.66.1546192142004;
        Sun, 30 Dec 2018 09:49:02 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id q11sm8853170lfc.92.2018.12.30.09.49.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Dec 2018 09:49:01 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        David Lechner <david@lechnology.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH v2 05/14] drm: make drm_file.h self contained
Date:   Sun, 30 Dec 2018 18:48:29 +0100
Message-Id: <20181230174838.32330-6-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_file.h embed struct idr, so this file need to know
the full type definition.

With this change users of drm_file.h are no longer forced
to include idr.h - a file they usually get from drmP.h

This makes it simpler to remove drmP.h includes

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Sean Paul <sean@poorly.run>
Cc: David Airlie <airlied@linux.ie>
---
 include/drm/drm_file.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
index 84ac79219e4c..bbdb74c3d7ff 100644
--- a/include/drm/drm_file.h
+++ b/include/drm/drm_file.h
@@ -30,6 +30,7 @@
 #ifndef _DRM_FILE_H_
 #define _DRM_FILE_H_
 
+#include <linux/idr.h>
 #include <linux/types.h>
 #include <linux/completion.h>
 
-- 
2.12.0

