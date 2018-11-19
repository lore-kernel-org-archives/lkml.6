Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C2FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 618A5208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wDkm+jDS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 618A5208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732561AbeKTDCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:02:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:35342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731835AbeKTDCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:02:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 724F620831;
        Mon, 19 Nov 2018 16:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645525;
        bh=ir29uXV09u5Le8WcRpcdB1HxoQeAW2fReO25BlXHUGY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wDkm+jDSsgtBYZ2x9YqXXvNpU1bOsbh25tsfpzsCwyz5RvbjEdcOyzsvXCf/wOozZ
         w70Xn7RYAjA6KlUYVljxErh75Dvx+l5LfOue5LoWYAHUXAtrHTKZ8s6SPN9GqZysPW
         1BE+kup5htfOErIUqWJbRan80D5Ka22fZu1siHdQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matt Roper <matthew.d.roper@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: [PATCH 4.19 196/205] drm/i915: Fix ilk+ watermarks when disabling pipes
Date:   Mon, 19 Nov 2018 17:28:23 +0100
Message-Id: <20181119162642.361701597@linuxfoundation.org>
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

commit df5e31c204b34e8d9e5ec33f5b28e960c4f25e14 upstream.

We're no longer programming any watermarks when we're disabling
a pipe. That means ilk_wm_merge() & co. will keep considering
the any pipe that is getting disabled as still enabled. Thus we
either get no LP1+ watermakrs (ilk-ivb), or we get suboptimal
ones (hsw-bdw).

This seems to have been broken by commit b6b178a77210 ("drm/i915:
Calculate ironlake intermediate watermarks correctly, v2."). Before
that we apparently had some difference between the intermediate
and optimal watermarks and so we would program the optiomal ones.
Now intermediate and optimal are identical for disabled pipes
and so we don't program either.

Fix this by programming the intermediate watermarks even for
disabled pipes. We were already doing that for skl+. We'll
leave out gmch platforms for now since those do the merging
in a different manner and should work as is. We'll want to
unify this eventually, but play it safe for now and just put
in a FIXME.

Cc: stable@vger.kernel.org
Cc: Matt Roper <matthew.d.roper@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Fixes: b6b178a77210 ("drm/i915: Calculate ironlake intermediate watermarks correctly, v2.")
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20181025130536.29024-1-ville.syrjala@linux.intel.com
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com> #irc
(cherry picked from commit a748faea3bfd7fd1d1485bc1c426c7d460cc6503)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/intel_display.c |   17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

--- a/drivers/gpu/drm/i915/intel_display.c
+++ b/drivers/gpu/drm/i915/intel_display.c
@@ -12639,17 +12639,12 @@ static void intel_atomic_commit_tail(str
 			intel_check_cpu_fifo_underruns(dev_priv);
 			intel_check_pch_fifo_underruns(dev_priv);
 
-			if (!new_crtc_state->active) {
-				/*
-				 * Make sure we don't call initial_watermarks
-				 * for ILK-style watermark updates.
-				 *
-				 * No clue what this is supposed to achieve.
-				 */
-				if (INTEL_GEN(dev_priv) >= 9)
-					dev_priv->display.initial_watermarks(intel_state,
-									     to_intel_crtc_state(new_crtc_state));
-			}
+			/* FIXME unify this for all platforms */
+			if (!new_crtc_state->active &&
+			    !HAS_GMCH_DISPLAY(dev_priv) &&
+			    dev_priv->display.initial_watermarks)
+				dev_priv->display.initial_watermarks(intel_state,
+								     to_intel_crtc_state(new_crtc_state));
 		}
 	}
 


