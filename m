Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95342C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D946208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQQwk/Ih"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D946208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732585AbeKTDDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:03:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:35456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731835AbeKTDC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:02:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FCBE20989;
        Mon, 19 Nov 2018 16:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645530;
        bh=cdscZSLh9d43Vwj9Xe0SPohKsWQdMckvjGwRytDr1nA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XQQwk/IhvWHgkvmBQii3plON/Km+j8aCF+uDP/zFHZZN4pObD8pBRXbO1CWZS7IYn
         6YIhtJdrp9KLZRQeZRFvUrLeTEgtDWKTJePOw2+dT77GZP+DJhjDObKV1B75ebjBN3
         7djh/z+VTha1bGkbuVgP0twA0t0tcAbRfj4Fmn50=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: [PATCH 4.19 198/205] drm/i915: Dont oops during modeset shutdown after lpe audio deinit
Date:   Mon, 19 Nov 2018 17:28:25 +0100
Message-Id: <20181119162642.506771617@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

commit 6a8915d0f8cf323e1beb792a33095cf652db4056 upstream.

We deinit the lpe audio device before we call
drm_atomic_helper_shutdown(), which means the platform device
may already be gone when it comes time to shut down the crtc.
As we don't know when the last reference to the platform
device gets dropped by the audio driver we can't assume that
the device and its data are still around when turning off the
crtc. Mark the platform device as gone as soon as we do the
audio deinit.

Cc: stable@vger.kernel.org
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20181105194604.6994-1-ville.syrjala@linux.intel.com
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
(cherry picked from commit f45a7977d1140c11f334e01a9f77177ed68e3bfa)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/intel_lpe_audio.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/i915/intel_lpe_audio.c
+++ b/drivers/gpu/drm/i915/intel_lpe_audio.c
@@ -297,8 +297,10 @@ void intel_lpe_audio_teardown(struct drm
 	lpe_audio_platdev_destroy(dev_priv);
 
 	irq_free_desc(dev_priv->lpe_audio.irq);
-}
 
+	dev_priv->lpe_audio.irq = -1;
+	dev_priv->lpe_audio.platdev = NULL;
+}
 
 /**
  * intel_lpe_audio_notify() - notify lpe audio event


