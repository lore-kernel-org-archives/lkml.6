Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57594C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F89D21104
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1Dy+u607"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F89D21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732617AbeKTDDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:03:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:35608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731637AbeKTDDH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:03:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50D1F20989;
        Mon, 19 Nov 2018 16:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645537;
        bh=VLSvI9axjnG4Qqm578tuiJBopkzlfnPoULtevo3Ds2Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1Dy+u607Qvs9IhwMJUA9STOJUnSHhcO7GEa223j5iJHwRT26AbU/zV2thjbJzKDbu
         E+iMMSYCbPPNvCFL6qPYbhllEBCbXQbSVvXghPxVfEfc7Xm4zz8TEeLk81QBu58HBY
         W5QZCPjM2BAFoJiFX9eNmdI45fwCg7D2orh6I5Sk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Wilson <chris@chris-wilson.co.uk>,
        Mika Kuoppala <mika.kuoppala@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: [PATCH 4.19 201/205] drm/i915/execlists: Force write serialisation into context image vs execution
Date:   Mon, 19 Nov 2018 17:28:28 +0100
Message-Id: <20181119162642.716435677@linuxfoundation.org>
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

From: Chris Wilson <chris@chris-wilson.co.uk>

commit 0a823e8fd4fd67726697854578f3584ee3a49b1d upstream.

Ensure that the writes into the context image are completed prior to the
register mmio to trigger execution. Although previously we were assured
by the SDM that all writes are flushed before an uncached memory
transaction (our mmio write to submit the context to HW for execution),
we have empirical evidence to believe that this is not actually the
case.

Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=108656
References: https://bugs.freedesktop.org/show_bug.cgi?id=108315
References: https://bugs.freedesktop.org/show_bug.cgi?id=106887
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Mika Kuoppala <mika.kuoppala@linux.intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Acked-by: Mika Kuoppala <mika.kuoppala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20181108081740.25615-1-chris@chris-wilson.co.uk
Cc: stable@vger.kernel.org
(cherry picked from commit 987abd5c62f92ee4970b45aa077f47949974e615)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/intel_lrc.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/i915/intel_lrc.c
+++ b/drivers/gpu/drm/i915/intel_lrc.c
@@ -424,7 +424,8 @@ static u64 execlists_update_context(stru
 
 	reg_state[CTX_RING_TAIL+1] = intel_ring_set_tail(rq->ring, rq->tail);
 
-	/* True 32b PPGTT with dynamic page allocation: update PDP
+	/*
+	 * True 32b PPGTT with dynamic page allocation: update PDP
 	 * registers and point the unallocated PDPs to scratch page.
 	 * PML4 is allocated during ppgtt init, so this is not needed
 	 * in 48-bit mode.
@@ -432,6 +433,17 @@ static u64 execlists_update_context(stru
 	if (ppgtt && !i915_vm_is_48bit(&ppgtt->vm))
 		execlists_update_context_pdps(ppgtt, reg_state);
 
+	/*
+	 * Make sure the context image is complete before we submit it to HW.
+	 *
+	 * Ostensibly, writes (including the WCB) should be flushed prior to
+	 * an uncached write such as our mmio register access, the empirical
+	 * evidence (esp. on Braswell) suggests that the WC write into memory
+	 * may not be visible to the HW prior to the completion of the UC
+	 * register write and that we may begin execution from the context
+	 * before its image is complete leading to invalid PD chasing.
+	 */
+	wmb();
 	return ce->lrc_desc;
 }
 


