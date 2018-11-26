Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D732CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A2122089F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UzgAiu55"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A2122089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbeKZVrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:47:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:55522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbeKZVrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:47:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 061152089F;
        Mon, 26 Nov 2018 10:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543229617;
        bh=m1s73G31edMIFazGiDq57CD4TsXp9vbXB1EPPm4nw0s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UzgAiu55hdt5ne0Ip3cL2ayrkZ8omAMQOTkVMoGOIfAFxeceYFAHJMzfbvMEz9nek
         CpGAe8ow7z5pEKKiF4o4ryxeSYM/Ivo63Zq/Wc+HY78Bc2+RIEs+dPV1aUDxDuouDr
         FnUfLI73Gp7Ot7uFZ8Cy5qUIieJF3zC6XNHJJPN4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 12/24] Revert "Revert "drm/i915: Fix mutex->owner inspection race under DEBUG_MUTEXES""
Date:   Mon, 26 Nov 2018 11:51:06 +0100
Message-Id: <20181126105031.609623957@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105029.790599475@linuxfoundation.org>
References: <20181126105029.790599475@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

This reverts commit bc07ee33284ac6e6872d5efad1b321ec0b7b46a4. Which is
upstream commit a50940510e94f5fb65ffd79877a60592d85598a9.

This revert relies on upstream commit a63b03e2d24 ("mutex: Always clear
owner field upon mutex_unlock()") being in the tree, but that commit
should not be backported.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/i915_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_gem.c b/drivers/gpu/drm/i915/i915_gem.c
index d0f0a7943d88..d88dbedeaa77 100644
--- a/drivers/gpu/drm/i915/i915_gem.c
+++ b/drivers/gpu/drm/i915/i915_gem.c
@@ -5144,7 +5144,7 @@ static bool mutex_is_locked_by(struct mutex *mutex, struct task_struct *task)
 	if (!mutex_is_locked(mutex))
 		return false;
 
-#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_MUTEXES)
+#if defined(CONFIG_SMP) && !defined(CONFIG_DEBUG_MUTEXES)
 	return mutex->owner == task;
 #else
 	/* Since UP may be pre-empted, we cannot assume that we own the lock */
-- 
2.17.1



