Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54FFC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABFD6214C4
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bh19Y1+s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABFD6214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388887AbeKTDKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:10:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:46258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388851AbeKTDKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:10:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97376214DE;
        Mon, 19 Nov 2018 16:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645989;
        bh=FxqydID5+Np5Z9t/1lGsJaZuLVdtGtW5rYAKEHic1+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bh19Y1+sumNMijP6pr9gW7dFnNcJPibzhn2XI7uwWZk/p+ah62b6W3WEhZk3P4ALv
         7rpq1a5/8CGXWAYjo6nk1Ymtlfk7BYDYFYUAr2FJVGn7IwtJmN9IL3JrLVl64r2OiQ
         0PcbLMWKMOM7nDg5UD3dz/7wihGYsyZxB00290YM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: [PATCH 4.18 166/171] drm/i915: Dont oops during modeset shutdown after lpe audio deinit
Date:   Mon, 19 Nov 2018 17:29:22 +0100
Message-Id: <20181119162641.009421055@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162618.909354448@linuxfoundation.org>
References: <20181119162618.909354448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

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


