Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25EEC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFC5220890
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="VzywVIu+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFC5220890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754495AbeGIIhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:37:01 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:47095 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753725AbeGIIg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:36:59 -0400
Received: by mail-ed1-f66.google.com with SMTP id r17-v6so13261560edo.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 01:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Vu9RzlEPJntTQyrENRstLjpgmV5d//jzsaPCvZv1jcQ=;
        b=VzywVIu+3sQU2oUWP8ZREb84SMwMlVTkl6yvKxmMs2cbxkMGeG2RtJgum9WgHgmJs5
         Pcs+1uDX1ba8YukPCkLPi8XEjoD5CRp4dw7nAPnuOrGSQSVxC+OwrIldI+KiICePXja0
         qhzOakLMdehotp9WZU7geklIGTjWnZbqjaoUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Vu9RzlEPJntTQyrENRstLjpgmV5d//jzsaPCvZv1jcQ=;
        b=Hb7Qrw3dSjFOjo4N5pWHMWw8HnIbap9ZyHcy/qXFAHlhCkq82cPdZNiQl9eTJvl1kE
         ODTgPjiPD/Otu0MboixYwD2r8EDV6/amsZCk0kA1Irf6F+vAAZ/VpgA+EZNjOax8xtJo
         t+8eyTfTzsOqzo20ujOj2bITxZSdCO15soPlSSoYIs3OLidT1Bwz94Ew5EMs/OINEane
         3/t2z8QxxGvcQP0tX0gtBxcPt2wGYI2++c+a79fYQ3sJO4CPfoV9QibyFUC/Npzd+VyO
         QEerCVeZoQozauzOEDtbrkr/2GC4y9C0/UXxDQOzCOxwFSlbCYA9rTQsllsLKQnlFY3W
         GlSw==
X-Gm-Message-State: AOUpUlFYcvDs5vLVh/hPf245o4my2HGiljizqOy/yZZvKbH7Xgdv41o/
        ZO5+9q5EFb3Iks7FqIBwA6u3KmuO
X-Google-Smtp-Source: AAOMgpf2l+vzXSm3p3DW3YtgR6sMwOacQB+bee96eD1s26xAU5o2rRZMcuK16Qk17hdGHvis++8BKQ==
X-Received: by 2002:a50:d313:: with SMTP id g19-v6mr8089623edh.119.1531125417849;
        Mon, 09 Jul 2018 01:36:57 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:5628:0:496f:7dc5:66d7:a057])
        by smtp.gmail.com with ESMTPSA id 8-v6sm340067edv.77.2018.07.09.01.36.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 01:36:57 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        NeilBrown <neilb@suse.com>, Wei Wang <wvw@google.com>,
        Stefan Agner <stefan@agner.ch>,
        Andrei Vagin <avagin@openvz.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yisheng Xie <ysxie@foxmail.com>
Subject: [PATCH 01/12] kernel.h: Add for_each_if()
Date:   Mon,  9 Jul 2018 10:36:39 +0200
Message-Id: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid compilers complainig about ambigious else blocks when putting
an if condition into a for_each macro one needs to invert the
condition and add a dummy else. We have a nice little convenience
macro for that in drm headers, let's move it out. Subsequent patches
will roll it out to other places.

Motivated by a discussion with Andy and Yisheng, who want to add
another for_each_macro which would benefit from for_each_if() instead
of hand-rolling it.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Gustavo Padovan <gustavo@padovan.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Sean Paul <seanpaul@chromium.org>
Cc: David Airlie <airlied@linux.ie>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: NeilBrown <neilb@suse.com>
Cc: Wei Wang <wvw@google.com>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Andrei Vagin <avagin@openvz.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Yisheng Xie <ysxie@foxmail.com>
---
 include/drm/drmP.h     | 3 ---
 include/linux/kernel.h | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/drm/drmP.h b/include/drm/drmP.h
index f7a19c2a7a80..05350424a4d3 100644
--- a/include/drm/drmP.h
+++ b/include/drm/drmP.h
@@ -110,7 +110,4 @@ static inline bool drm_can_sleep(void)
 	return true;
 }
 
-/* helper for handling conditionals in various for_each macros */
-#define for_each_if(condition) if (!(condition)) {} else
-
 #endif
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 941dc0a5a877..4cb95ab9a5bc 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -71,6 +71,9 @@
  */
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
 
+/* helper for handling conditionals in various for_each macros */
+#define for_each_if(condition) if (!(condition)) {} else
+
 #define u64_to_user_ptr(x) (		\
 {					\
 	typecheck(u64, x);		\
-- 
2.18.0

