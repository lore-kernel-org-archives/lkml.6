Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725A0C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33769208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/y7zq8f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33769208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732744AbeKTDDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:03:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:36230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731810AbeKTDDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:03:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53F9C208E3;
        Mon, 19 Nov 2018 16:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645563;
        bh=OrPfj55GmKZIIWp0iPBhtB7B/dJBAYr/eLYG8fU/A9g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N/y7zq8fZzTOSm3rMz4VWlmC3HxV3QzM7I1KdT2cujb0lYNovHI/H1fPZlRl6JNE0
         faYpKthOACbM6CEtXyW+nzYbUDDfNAxqaYc0yQa1Nf0uotIcR3trIcAkdKKU5fIpwY
         5Fht6482RBQVBTZrx7TUnf6toNYIfVzozC4sb17k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
        Jan-Marek Glogowski <glogow@fbihome.de>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: [PATCH 4.19 191/205] drm/i915/dp: Restrict link retrain workaround to external monitors
Date:   Mon, 19 Nov 2018 17:28:18 +0100
Message-Id: <20181119162642.003859535@linuxfoundation.org>
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

From: Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>

commit f9776280c29e77a18cbc7ebb6d48f7885e494990 upstream.

Commit '3cf71bc9904d ("drm/i915: Re-apply "Perform link quality check,
unconditionally during long pulse"")' applies a work around for sinks
that don't signal link loss. The work around does not need to have to be
that broad as the issue was seen with only one particular monitor; limit
this only for external displays as eDP features like PSR turn off the link
and the driver ends up retraining the link seeeing that link is not
synchronized.

Cc: Lyude Paul <lyude@redhat.com>
Cc: Jan-Marek Glogowski <glogow@fbihome.de>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
References: 3cf71bc9904d ("drm/i915: Re-apply "Perform link quality check, unconditionally during long pulse"")
Signed-off-by: Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180927205735.16651-2-dhinakaran.pandiyan@intel.com
(cherry picked from commit f24f6eb95807bca0dbd8dc5b2f3a4099000f4472)
Fixes: 399334708b4f ("drm/i915: Re-apply "Perform link quality check, unconditionally during long pulse"")
Cc: stable@vger.kernel.org
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/intel_dp.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

--- a/drivers/gpu/drm/i915/intel_dp.c
+++ b/drivers/gpu/drm/i915/intel_dp.c
@@ -4739,12 +4739,13 @@ intel_dp_long_pulse(struct intel_connect
 		 */
 		status = connector_status_disconnected;
 		goto out;
-	} else {
-		/*
-		 * Some external monitors do not signal loss of link
-		 * synchronization with an IRQ_HPD, so force a link status
-		 * check.
-		 */
+	}
+
+	/*
+	 * Some external monitors do not signal loss of link synchronization
+	 * with an IRQ_HPD, so force a link status check.
+	 */
+	if (!intel_dp_is_edp(intel_dp)) {
 		struct intel_encoder *encoder = &dp_to_dig_port(intel_dp)->base;
 
 		intel_dp_retrain_link(encoder, ctx);


