Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73803C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42ED021917
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545405718;
	bh=6hNfz3J/JXnzP0MOdgv9k3hkqS8MnbxlsEvS+ba3FuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=voX31Zi7PnRScXUhdg8+PHJ++iKYG8z+OLM4RFTPpIkGxreK29Mg1ci0y8gDpMS6A
	 L9A748JDizkCgVs582MVW+SZsSLjFl35VazkFCiUL1lPOajhq+V/G8aZXOvVsP0OXt
	 v523MYkPRXhUjVzHtCGA+CF36S2ifBtBqBa3Gfi0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404249AbeLUPV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 10:21:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:57378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404204AbeLUPVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 10:21:46 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A2EA21929;
        Fri, 21 Dec 2018 15:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545405706;
        bh=6hNfz3J/JXnzP0MOdgv9k3hkqS8MnbxlsEvS+ba3FuY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=0DqI4pkL3+38bN1xiGByqmfTEDzA8iIRME48tcAnO5q82ble12QvzyJ2xVl57/r4M
         ueGCUD652xuvsd/+5uVZ4F5+tpC4IP3h459kdw8+xV4q55vqGnar4zKWLG8ffEs8VV
         IgeXgUDjJsSm7gXH3wz+BdH63mpOvf+8RZuirSco=
From:   Tom Zanussi <zanussi@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     rostedt@goodmis.org, tglx@linutronix.de, C.Emde@osadl.org,
        jkacur@redhat.com, bigeasy@linutronix.de,
        daniel.wagner@siemens.com, julia@ni.com
Subject: [PATCH RT 8/9] drm/i915: disable tracing on -RT
Date:   Fri, 21 Dec 2018 09:21:20 -0600
Message-Id: <bc045daf7dcb077b845955b25a8f2d1b6eaceac0.1545347029.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1545347029.git.tom.zanussi@linux.intel.com>
References: <cover.1545347029.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1545347029.git.tom.zanussi@linux.intel.com>
References: <cover.1545347029.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3.18.129-rt111 rt-stable review patch.  If anyone has any objections,
please let me know.

------------------
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[Upstream commit 05cebb309b156646e61b898e92acc8e46c47ba75]

Luca Abeni reported this:
| BUG: scheduling while atomic: kworker/u8:2/15203/0x00000003
| CPU: 1 PID: 15203 Comm: kworker/u8:2 Not tainted 4.19.1-rt3 #10
| Call Trace:
|  rt_spin_lock+0x3f/0x50
|  gen6_read32+0x45/0x1d0 [i915]
|  g4x_get_vblank_counter+0x36/0x40 [i915]
|  trace_event_raw_event_i915_pipe_update_start+0x7d/0xf0 [i915]

The tracing events use trace_i915_pipe_update_start() among other events
use functions acquire spin locks. A few trace points use
intel_get_crtc_scanline(), others use ->get_vblank_counter() wich also
might acquire a sleeping lock.

Based on this I don't see any other way than disable trace points on RT.

Cc: stable-rt@vger.kernel.org
Reported-by: Luca Abeni <lucabe72@gmail.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 drivers/gpu/drm/i915/i915_trace.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/i915/i915_trace.h b/drivers/gpu/drm/i915/i915_trace.h
index f5aa0067755a..3b37567b76c8 100644
--- a/drivers/gpu/drm/i915/i915_trace.h
+++ b/drivers/gpu/drm/i915/i915_trace.h
@@ -1,6 +1,10 @@
 #if !defined(_I915_TRACE_H_) || defined(TRACE_HEADER_MULTI_READ)
 #define _I915_TRACE_H_
 
+#ifdef CONFIG_PREEMPT_RT_BASE
+#define NOTRACE
+#endif
+
 #include <linux/stringify.h>
 #include <linux/types.h>
 #include <linux/tracepoint.h>
-- 
2.14.1

