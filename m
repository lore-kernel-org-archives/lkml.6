Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7A0C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 363F620855
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543892;
	bh=+0HtX0GbHQWb0WWSotDtcHQirDYVF19UcoJtafFoTZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FjLTf6BZutO70FaG9oiGjx8QFRaQKHnZqkaM8OjRr/CiIjkd18uiThlVlhIA29Yd2
	 1tk5qop4JLJsuNLV9BF7+HLuN5mz/CnHSo6Ey/KQrtUw27DUwmR0Oml8fNPHS8l3F0
	 ZKS6QVsdVYLWvMDbFkWLqW6UisE5FZhVIV47YP88=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 363F620855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730978AbeLKP6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:58:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:47272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730960AbeLKP6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:58:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61EB9205C9;
        Tue, 11 Dec 2018 15:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543886;
        bh=+0HtX0GbHQWb0WWSotDtcHQirDYVF19UcoJtafFoTZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A7h7DM0LPUYoIrBwc96q4Q8OBMIYMWdzaMZVOySth3fCHlxImWvQsiae65G6zUr83
         gQCxSZGGXT1DeKPYgzN6wA83RZaONTdT04JafvZF80d42H7erT+lKKQDkJiLMbu5j8
         ByDgc22hgHJWYSITFVyk30SNuZjD+ufuDXkW6Cb8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Wilson <chris@chris-wilson.co.uk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Ville Syrjala <ville.syrjala@linux.intel.com>
Subject: [PATCH 4.19 102/118] drm/i915: Downgrade Gen9 Plane WM latency error
Date:   Tue, 11 Dec 2018 16:42:01 +0100
Message-Id: <20181211151648.388522822@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chris Wilson <chris@chris-wilson.co.uk>

commit 86c1c87d0e6241cbe35bd52badfc84b154e1b959 upstream.

According to intel_read_wm_latency() it is perfectly legal for one WM
and all subsequent levels to be 0 (and the deeper powersaving states
disabled), so don't shout *ERROR*, over and over again.

Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Ville Syrjala <ville.syrjala@linux.intel.com>
Acked-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180726161527.10516-1-chris@chris-wilson.co.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/intel_pm.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/i915/intel_pm.c
+++ b/drivers/gpu/drm/i915/intel_pm.c
@@ -2951,8 +2951,8 @@ static void intel_print_wm_latency(struc
 		unsigned int latency = wm[level];
 
 		if (latency == 0) {
-			DRM_ERROR("%s WM%d latency not provided\n",
-				  name, level);
+			DRM_DEBUG_KMS("%s WM%d latency not provided\n",
+				      name, level);
 			continue;
 		}
 


