Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B47C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8CD4217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129286;
	bh=q84XV1KNIl+JfbRSnfzlFsiJToHkmPiCP+CNSBD7tHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DH3CdgAk1a1FyoNqcE+h5hyjCime6rdqMJNt0p7L58f3bZUYBx4pzPipmPhpcvldj
	 wtG5bOFn0Lg3f/MfyLivl4+Jtp/Pms5v8mt8xRZECvSDY1LivHhVhNJN3s0V5FBbTa
	 YCUOtgBdFytwiEt4SrwNXu6EXPIlkP68/UVO/l+M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbfBYVOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:14:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:45572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729256AbfBYVOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:14:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFCDB2147C;
        Mon, 25 Feb 2019 21:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129281;
        bh=q84XV1KNIl+JfbRSnfzlFsiJToHkmPiCP+CNSBD7tHk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V6aPZtWrTVYU9JiSMEk44vT6t2RD4S3uwQ4X7K8z34iKtEX8yhlE19S8IDSt21xVr
         7PGkMNOBLxU9UM14JsFAgEkxhN8qNMLmb3p95hV8wtOcm4fgoGGLUWGkQsgWNprpde
         VCKkj5PAAhnTHmZS1Btbsth2QawPHxXg30lieKA0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Torokhov <dtor@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Grant Grundler <grundler@chromium.org>,
        Greg Hackmann <ghackmann@google.com>,
        Michael Davidson <md@google.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.9 43/63] clocksource: Use GENMASK_ULL in definition of CLOCKSOURCE_MASK
Date:   Mon, 25 Feb 2019 22:11:43 +0100
Message-Id: <20190225195039.105592733@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195035.713274200@linuxfoundation.org>
References: <20190225195035.713274200@linuxfoundation.org>
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

From: Matthias Kaehlcke <mka@chromium.org>

commit 0773cea37470f8e080c510fe720fc356cf35df3a upstream

Besides reusing existing code this removes the special case handling
for 64-bit masks, which causes clang to raise a shift count overflow
warning due to https://bugs.llvm.org//show_bug.cgi?id=10030.

Suggested-by: Dmitry Torokhov <dtor@chromium.org>
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Cc: Grant Grundler <grundler@chromium.org>
Cc: Greg Hackmann <ghackmann@google.com>
Cc: Michael Davidson <md@google.com>
Cc: John Stultz <john.stultz@linaro.org>
Link: http://lkml.kernel.org/r/20170418233037.70990-1-mka@chromium.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
[nc: cycle_t wasn't eliminated until commit a5a1d1c2914b ("clocksource:
     Use a plain u64 instead of cycle_t") in v4.10]
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/clocksource.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -117,7 +117,7 @@ struct clocksource {
 #define CLOCK_SOURCE_RESELECT			0x100
 
 /* simplify initialization of mask field */
-#define CLOCKSOURCE_MASK(bits) (cycle_t)((bits) < 64 ? ((1ULL<<(bits))-1) : -1)
+#define CLOCKSOURCE_MASK(bits) GENMASK_ULL((bits) - 1, 0)
 
 static inline u32 clocksource_freq2mult(u32 freq, u32 shift_constant, u64 from)
 {


