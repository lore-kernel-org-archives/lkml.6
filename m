Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31975C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0064420811
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298953;
	bh=IzAOZSxeSOyHM5GeQBuEmiO3601NTm3LmpBUMWbv6eU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BzsUk3Orb3n43Mibsnetf6hMLwQ04sHYvs6aRSp6fOboaNGd4vBRRsDGISQV0WEI1
	 DDmFqbeTurfC38edU/lK7tEilNf6/J2KZrgWX/1yRp7B5s1pM5OsXFMkulkl21QAVP
	 rzwNYqz6MszXOTqQc1fVx7oBnlmq8P1+Qp4ppU3M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732095AbeLTJmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:42:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:53630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731556AbeLTJX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:23:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C7F92177B;
        Thu, 20 Dec 2018 09:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297806;
        bh=IzAOZSxeSOyHM5GeQBuEmiO3601NTm3LmpBUMWbv6eU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ma4oRRQh1Nhh1KVCzWOvIyA1vt08Gd25kjA1VDMh0eZCJQBxmv7mH9EF5gIPFgw2R
         e6ZAxx0qDpkuBbdb0KJmx+Gh4gb5cZyZCnN7KJTITm6pojmDSjnLELtX8b39F0oX4r
         L2Xq1p54HymkdTM8gxE0QbF0S4GNmD+w0b0ac1/o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Wilson <chris@chris-wilson.co.uk>,
        Mika Kuoppala <mika.kuoppala@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: [PATCH 4.9 16/61] drm/i915/execlists: Apply a full mb before execution for Braswell
Date:   Thu, 20 Dec 2018 10:18:16 +0100
Message-Id: <20181220085844.383286101@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085843.743900603@linuxfoundation.org>
References: <20181220085843.743900603@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -386,8 +386,13 @@ static u64 execlists_update_context(stru
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
 


