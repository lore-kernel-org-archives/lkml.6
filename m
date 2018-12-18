Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991E9C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 688DD218A4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545151291;
	bh=RTGjUgXmLk3+fJYRp0agh7q+R0Cs/2uN3T/tUCsbrKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=osarwAVJEJ0oXb/9qNeN5TWmbd8LApFOJOHs/dZNFv+Nf9F9zEq5SFiN0+twtprKj
	 nwATcLCLM6fjxMGnLkxId9Ed7v5d9NrYh4Tw0LJf9mYB9Fsu/T/F2Aq0E5ihg8yFQD
	 66oBK5hUKJgS7fzjLAvtuss3Lesqt45H+zpzu1cI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbeLRQla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:41:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:38944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727518AbeLRQl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:41:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4194F218A2;
        Tue, 18 Dec 2018 16:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545151286;
        bh=RTGjUgXmLk3+fJYRp0agh7q+R0Cs/2uN3T/tUCsbrKA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=egKN3NrfVKgPD62WMWD6vRsqOIZD12ll7CJxRaLHIxSIw0jcSU9jd8naC2pGAIgra
         BHH/T2pcg4EHvSCf1mqgZ6TPQa9o+X5JKpP5UUOwYTZWz8r2OScKFkS5WQ1nHvmFps
         us8aYJsEJy7G1gzlt4hyRKFueM99I2Di9OledQ6E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Wilson <chris@chris-wilson.co.uk>,
        Mika Kuoppala <mika.kuoppala@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: [PATCH 4.19 37/44] drm/i915/execlists: Apply a full mb before execution for Braswell
Date:   Tue, 18 Dec 2018 17:39:49 +0100
Message-Id: <20181218163931.750845579@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181218163927.119623235@linuxfoundation.org>
References: <20181218163927.119623235@linuxfoundation.org>
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

commit cf66b8a0ba142fbd1bf10ac8f3ae92d1b0cb7b8f upstream.

Braswell is really picky about having our writes posted to memory before
we execute or else the GPU may see stale values. A wmb() is insufficient
as it only ensures the writes are visible to other cores, we need a full
mb() to ensure the writes are in memory and visible to the GPU.

The most frequent failure in flushing before execution is that we see
stale PTE values and execute the wrong pages.

References: 987abd5c62f9 ("drm/i915/execlists: Force write serialisation into context image vs execution")
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Mika Kuoppala <mika.kuoppala@linux.intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: stable@vger.kernel.org
Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20181206084431.9805-3-chris@chris-wilson.co.uk
(cherry picked from commit 490b8c65b9db45896769e1095e78725775f47b3e)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/intel_lrc.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/i915/intel_lrc.c
+++ b/drivers/gpu/drm/i915/intel_lrc.c
@@ -442,8 +442,13 @@ static u64 execlists_update_context(stru
 	 * may not be visible to the HW prior to the completion of the UC
 	 * register write and that we may begin execution from the context
 	 * before its image is complete leading to invalid PD chasing.
+	 *
+	 * Furthermore, Braswell, at least, wants a full mb to be sure that
+	 * the writes are coherent in memory (visible to the GPU) prior to
+	 * execution, and not just visible to other CPUs (as is the result of
+	 * wmb).
 	 */
-	wmb();
+	mb();
 	return ce->lrc_desc;
 }
 


