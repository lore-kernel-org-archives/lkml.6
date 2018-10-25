Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD1AECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 773C42083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pEAxnrWS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 773C42083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730398AbeJYWwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:52:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:34136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727977AbeJYWwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:52:12 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14B072085B;
        Thu, 25 Oct 2018 14:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477154;
        bh=Js0JCaSlY4m+sfhSWIcLC/5xrKO8CY1U/CJnCcevlTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pEAxnrWSJcIw1KBZvOyphLrOv1fpblULLawTYtcqNqLI+zgR8E5SZHxCkMvW5OgnM
         Jl7Sg1Kz+jka+O6/tzGOX9gcNShsS3gnNlY8NMF9Fb/eHAH7TVxiEGJQm28tIz7nza
         LHm33z+MoVqG6rdQ+QfkakP9Wc4vz1sm52OdvJQk=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 11/98] Revert "drm/i915: Fix mutex->owner inspection race under DEBUG_MUTEXES"
Date:   Thu, 25 Oct 2018 10:17:26 -0400
Message-Id: <20181025141853.214051-11-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Wilson <chris@chris-wilson.co.uk>

[ Upstream commit a50940510e94f5fb65ffd79877a60592d85598a9 ]

The core fix was applied in

commit a63b03e2d2477586440741677ecac45bcf28d7b1
Author: Chris Wilson <chris@chris-wilson.co.uk>
Date:   Tue Jan 6 10:29:35 2015 +0000

    mutex: Always clear owner field upon mutex_unlock()

(note the absence of stable@ tag)

so we can now revert our band-aid commit 226e5ae9e5f910 for -next.

Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/i915_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_gem.c b/drivers/gpu/drm/i915/i915_gem.c
index d88dbedeaa77..d0f0a7943d88 100644
--- a/drivers/gpu/drm/i915/i915_gem.c
+++ b/drivers/gpu/drm/i915/i915_gem.c
@@ -5144,7 +5144,7 @@ static bool mutex_is_locked_by(struct mutex *mutex, struct task_struct *task)
 	if (!mutex_is_locked(mutex))
 		return false;
 
-#if defined(CONFIG_SMP) && !defined(CONFIG_DEBUG_MUTEXES)
+#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_MUTEXES)
 	return mutex->owner == task;
 #else
 	/* Since UP may be pre-empted, we cannot assume that we own the lock */
-- 
2.17.1

