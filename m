Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2CAC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8874206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GjiRVhFZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8874206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388970AbeKTDLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:11:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:46850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728537AbeKTDLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:11:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D1D5214C4;
        Mon, 19 Nov 2018 16:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646015;
        bh=95NOTCYuSZoTRWZUh3Hv/JJzmtHtCfkdklKPG/kBKa0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GjiRVhFZGgmPGvEiTiKRg+e9i+1RJn0E+vL5KwP6pOLziQTPFWz06EIlnfVCAGDES
         b4C2o4OZyyVtRxeYN6WGcybQwpWDnMjILnOecfWk06GidxLEVxIx/Htqpuu5GH4tUe
         KbbmndWGh4iUycy6PFOHc9Eeri1xXYQrGyo5hypE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Jan-Marek Glogowski <glogow@fbihome.de>,
        Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: [PATCH 4.18 160/171] drm/i915/dp: Fix link retraining comment in intel_dp_long_pulse()
Date:   Mon, 19 Nov 2018 17:29:16 +0100
Message-Id: <20181119162640.551479378@linuxfoundation.org>
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

From: Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>

commit 49af5d95b9b3c21a84ad115a9db9acbc036d849a upstream.

Comment claims link needs to be retrained because the connected sink raised
a long pulse to indicate link loss. If the sink did so,
intel_dp_hotplug() would have handled link retraining. Looking at the
logs in Bugzilla referenced in commit '3cf71bc9904d ("drm/i915: Re-apply
Perform link quality check, unconditionally during long pulse"")', the
issue is that the sink does not trigger an interrupt. What we want is
->detect() from user space to check link status and retrain. Ville's
review for the original patch also indicates the same root cause. So,
rewrite the comment.

v2: Patch split and rewrote comment.

Cc: Lyude Paul <lyude@redhat.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Jan-Marek Glogowski <glogow@fbihome.de>
References: 3cf71bc9904d ("drm/i915: Re-apply "Perform link quality check, unconditionally during long pulse"")
Signed-off-by: Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180927205735.16651-1-dhinakaran.pandiyan@intel.com
(cherry picked from commit 9ebd8202393dde9d3678c9ec162c1aa63ba17eac)
Fixes: 399334708b4f ("drm/i915: Re-apply "Perform link quality check, unconditionally during long pulse"")
Cc: stable@vger.kernel.org
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/intel_dp.c |   13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

--- a/drivers/gpu/drm/i915/intel_dp.c
+++ b/drivers/gpu/drm/i915/intel_dp.c
@@ -4874,16 +4874,9 @@ intel_dp_long_pulse(struct intel_connect
 		goto out;
 	} else {
 		/*
-		 * If display is now connected check links status,
-		 * there has been known issues of link loss triggering
-		 * long pulse.
-		 *
-		 * Some sinks (eg. ASUS PB287Q) seem to perform some
-		 * weird HPD ping pong during modesets. So we can apparently
-		 * end up with HPD going low during a modeset, and then
-		 * going back up soon after. And once that happens we must
-		 * retrain the link to get a picture. That's in case no
-		 * userspace component reacted to intermittent HPD dip.
+		 * Some external monitors do not signal loss of link
+		 * synchronization with an IRQ_HPD, so force a link status
+		 * check.
 		 */
 		struct intel_encoder *encoder = &dp_to_dig_port(intel_dp)->base;
 


