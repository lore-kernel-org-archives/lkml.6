Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEA7C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B40C2176F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277645;
	bh=klpiIBjUiNueEpp5wc/y/zCBHgRlYWCMM/jcfOfm020=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aH6K7B32o1HoihP7r1K4JOFFWpYFWSbUnmhlUb9BO4d/VU3CQ4fXKX00N31xatG8I
	 roDxTf0uwhcx/HVl5cv8QTf8z6pR0EsXsWLuWUg7t7g/lM8xWcp2REMTLVna60NKLY
	 i1k/vMfLfBybeJ5bwqut0eGCirPVSMkBaaoYQ90g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732877AbfBDKyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:54:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:51734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732833AbfBDKyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:54:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 107972082F;
        Mon,  4 Feb 2019 10:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277639;
        bh=klpiIBjUiNueEpp5wc/y/zCBHgRlYWCMM/jcfOfm020=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vUOLRjUxxNQuE7yU6nvmy1Wugf6jiz5Cgeabo44f83b/EOcRIdJ1n4KsUuRI8PGke
         UF/vUyen4nVcNlEoNXuipuEy2T0PPFIjuu4MBbKNO6W5T0yLwDcIJCcjKL6HK/uXq+
         NsbjFHYnBL4Yc8REI4Nhgr22UckLfwPP5B+5iwPk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 4.20 50/80] gpiolib: fix line event timestamps for nested irqs
Date:   Mon,  4 Feb 2019 11:37:10 +0100
Message-Id: <20190204103627.193016120@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103620.287366543@linuxfoundation.org>
References: <20190204103620.287366543@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

commit 1033be58992f818dc564196ded2bcc3f360bc297 upstream.

Nested interrupts run inside the calling thread's context and the top
half handler is never called which means that we never read the
timestamp.

This issue came up when trying to read line events from a gpiochip
using regmap_irq_chip for interrupts.

Fix it by reading the timestamp from the irq thread function if it's
still 0 by the time the second handler is called.

Fixes: d58f2bf261fd ("gpio: Timestamp events in hardirq handler")
Cc: stable@vger.kernel.org
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpio/gpiolib.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -828,7 +828,14 @@ static irqreturn_t lineevent_irq_thread(
 	/* Do not leak kernel stack to userspace */
 	memset(&ge, 0, sizeof(ge));
 
-	ge.timestamp = le->timestamp;
+	/*
+	 * We may be running from a nested threaded interrupt in which case
+	 * we didn't get the timestamp from lineevent_irq_handler().
+	 */
+	if (!le->timestamp)
+		ge.timestamp = ktime_get_real_ns();
+	else
+		ge.timestamp = le->timestamp;
 
 	if (le->eflags & GPIOEVENT_REQUEST_RISING_EDGE
 	    && le->eflags & GPIOEVENT_REQUEST_FALLING_EDGE) {


