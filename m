Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64FEC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9600B20827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpeO0p42"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731217AbfAHT4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:56:17 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42055 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730581AbfAHTaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:30:05 -0500
Received: by mail-lf1-f67.google.com with SMTP id l10so3793894lfh.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 11:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PgnDm5oGLcKsts3ng+aHutxRGjDqns3ivdbxYi2VjQ4=;
        b=gpeO0p42c9i/JyM2HL+AaT4lpqoFWJxKSU9RAmk1SQevGGu5tVbm1UtXR9aTEqBuB2
         bxHqGTKf9JY5OrwLLzEodsSBpe+jIFvjVhMY0PjtSgg8VAXayWTdTtu9lyGgn5iDbdkT
         uwz4/oqtJa47eCw3yywjul9CWwb0mGZohBh2XF92QfCwAs+fW85js8jfyQPFa9TY4MCS
         fjkiauWeuDEb5suzCAX9/lx+5o8SE9ojgZFz3IX2rjslFQIwQwq46rJfp4Wy24/Veuwm
         gIdQMZ7lCE/UWAu0Bazfnefe4zxXg+PrJovELq5/1zGto1M0Jl+UPvgqA9LD7Dz4JCkG
         blgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=PgnDm5oGLcKsts3ng+aHutxRGjDqns3ivdbxYi2VjQ4=;
        b=Pwggafq0xUgGcfwDLwKOxFLH7GSvYtlENEPyC3w2eEjSHUMkuLIgxNLPRxeaFiIODP
         Py6+ua7R/2yHTznNIRFjIv51evtu2fu/3OvtGgeh2Qo8LS638095aZBEL020mIwiE2U/
         shjpWSTyC41mO8i5XTUI1Jxo+tnBYwIa/n8mJanNlrBrny1yCZ0Q5tbnHvQXlj/ktf0z
         agzkNIodJOaNXWPKhz1Tt6BCrrklnrVB6XKap0HDZKmajyUZr69n75YfNbLw2vWnDN3S
         crNuW6u5zsSnT8gt3e2HfT4skB1fOz+w+fr+sjfw/9sC6eLMTffO5DtufnBncJi5tVMz
         Tg5w==
X-Gm-Message-State: AJcUukc4rgPSwM767LDqjMWv7Xk270iOGt5RdNKBN8JvlQ3vHIG1IlXY
        5YyjNCgXtuJwmecKAvS2akk=
X-Google-Smtp-Source: ALg8bN7KThAK/MAfIdpJMBb54cqwTEcjSIpZPt7GoGVaBDXg7/mRqgdGj1VYG/hWi3o43Nzl7n8W1g==
X-Received: by 2002:a19:4402:: with SMTP id r2mr1702980lfa.111.1546975803431;
        Tue, 08 Jan 2019 11:30:03 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id q128-v6sm9122246ljq.14.2019.01.08.11.30.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 11:30:03 -0800 (PST)
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
Subject: [PATCH v3 12/12] drm: remove drmP.h from drm_gem_cma_helper.h
Date:   Tue,  8 Jan 2019 20:29:39 +0100
Message-Id: <20190108192939.15255-13-sam@ravnborg.org>
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

With all dependencies fixed we can now remove
drmP.h from drm_gem_cma_helper.h.
It is replaced by the include files required,
or forward declarations as appropritate.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Acked-by: Noralf Trønnes <noralf@tronnes.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Sean Paul <sean@poorly.run>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
 include/drm/drm_gem_cma_helper.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/drm/drm_gem_cma_helper.h b/include/drm/drm_gem_cma_helper.h
index 07c504940ba1..947ac95eb24a 100644
--- a/include/drm/drm_gem_cma_helper.h
+++ b/include/drm/drm_gem_cma_helper.h
@@ -2,9 +2,12 @@
 #ifndef __DRM_GEM_CMA_HELPER_H__
 #define __DRM_GEM_CMA_HELPER_H__
 
-#include <drm/drmP.h>
+#include <drm/drm_file.h>
+#include <drm/drm_ioctl.h>
 #include <drm/drm_gem.h>
 
+struct drm_mode_create_dumb;
+
 /**
  * struct drm_gem_cma_object - GEM object backed by CMA memory allocations
  * @base: base GEM object
-- 
2.12.0

