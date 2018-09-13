Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F97C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA9ED20854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:05:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA9ED20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732202AbeIMTPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:15:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35540 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbeIMTPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:15:23 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 78CF2D39;
        Thu, 13 Sep 2018 14:05:43 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Shashank Sharma <shashank.sharma@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?UTF-8?q?Fredrik=20Sch=C3=B6n?= <fredrik.schon@gmail.com>
Subject: [PATCH 4.18 154/197] drm/i915: Increase LSPCON timeout
Date:   Thu, 13 Sep 2018 15:31:43 +0200
Message-Id: <20180913131847.710817359@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
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

From: Fredrik Schön <fredrikschon@gmail.com>

commit 299c2a904b1e8d5096d4813df6371357d97a6cd1 upstream.

100 ms is not enough time for the LSPCON adapter on Intel NUC devices to
settle. This causes dropped display modes at boot or screen reconfiguration.
Empirical testing can reproduce the error up to a timeout of 190 ms. Basic
boot and stress testing at 200 ms has not (yet) failed.

Increase timeout to 400 ms to get some margin of error.

Changes from v1:
The initial suggestion of 1000 ms was lowered due to concerns about delaying
valid timeout cases.
Update patch metadata.

Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=107503
Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1570392
Fixes: 357c0ae9198a ("drm/i915/lspcon: Wait for expected LSPCON mode to settle")
Cc: Shashank Sharma <shashank.sharma@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: <stable@vger.kernel.org> # v4.11+
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Reviewed-by: Shashank Sharma <shashank.sharma@intel.com>
Signed-off-by: Fredrik Schön <fredrik.schon@gmail.com>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180817200728.8154-1-fredrik.schon@gmail.com
(cherry picked from commit 59f1c8ab30d6f9042562949f42cbd3f3cf69de94)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/intel_lspcon.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/i915/intel_lspcon.c
+++ b/drivers/gpu/drm/i915/intel_lspcon.c
@@ -74,7 +74,7 @@ static enum drm_lspcon_mode lspcon_wait_
 	DRM_DEBUG_KMS("Waiting for LSPCON mode %s to settle\n",
 		      lspcon_mode_name(mode));
 
-	wait_for((current_mode = lspcon_get_current_mode(lspcon)) == mode, 100);
+	wait_for((current_mode = lspcon_get_current_mode(lspcon)) == mode, 400);
 	if (current_mode != mode)
 		DRM_ERROR("LSPCON mode hasn't settled\n");
 


