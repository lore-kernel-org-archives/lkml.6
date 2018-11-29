Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342C3C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8FB52146D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xrh95Vsq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8FB52146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388579AbeK3BfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:35:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:37230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728961AbeK3BfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:35:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA1272145D;
        Thu, 29 Nov 2018 14:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501791;
        bh=w+vtz/i15iEYsrNv+t3JYQjq7dDNcKcVoW8wE8nOC3s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xrh95VsqDj1gUlU8Nt+e/BhpAdVYxXyTw/4QwpEs2pGL5Slo5OJXlp/QhYh7zcGKU
         N3R2I6ELgrtxm8Obw5qAEjsxVVKtf3t3dKz153fKNq99oRkuBKIUYiqxxpukLkkyuH
         EIjOJVs1hR3mzEXb20VSFOnUxFY5I7+VYJchIxtE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH 4.19 042/110] drm/vc4: Set ->legacy_cursor_update to false when doing non-async updates
Date:   Thu, 29 Nov 2018 15:12:13 +0100
Message-Id: <20181129135922.963599466@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129135921.231283053@linuxfoundation.org>
References: <20181129135921.231283053@linuxfoundation.org>
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

From: Boris Brezillon <boris.brezillon@bootlin.com>

commit fcc86cb45d38ca2f24bcea9c29c7f4742041caed upstream.

drm_atomic_helper_setup_commit() auto-completes commit->flip_done when
state->legacy_cursor_update is true, but we know for sure that we want
a sync update when we call drm_atomic_helper_setup_commit() from
vc4_atomic_commit().

Explicitly set state->legacy_cursor_update to false to prevent this
auto-completion.

Fixes: 184d3cf4f738 ("drm/vc4: Use wait_for_flip_done() instead of wait_for_vblanks()")
Cc: <stable@vger.kernel.org>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Reviewed-by: Eric Anholt <eric@anholt.net>
Link: https://patchwork.freedesktop.org/patch/msgid/20181115105852.9844-2-boris.brezillon@bootlin.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/vc4/vc4_kms.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/gpu/drm/vc4/vc4_kms.c
+++ b/drivers/gpu/drm/vc4/vc4_kms.c
@@ -216,6 +216,12 @@ static int vc4_atomic_commit(struct drm_
 		return 0;
 	}
 
+	/* We know for sure we don't want an async update here. Set
+	 * state->legacy_cursor_update to false to prevent
+	 * drm_atomic_helper_setup_commit() from auto-completing
+	 * commit->flip_done.
+	 */
+	state->legacy_cursor_update = false;
 	ret = drm_atomic_helper_setup_commit(state, nonblock);
 	if (ret)
 		return ret;


