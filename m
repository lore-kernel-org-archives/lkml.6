Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABDAC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCCEE2073D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549278007;
	bh=CFZBMG+UMSpSZ7og1sgnVHrbmoTGb2VEDx2BhAyRM4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=doDN1jf2I/hlHRJne9n9Q2QcfjQHvojoKJ5zcQpq/FBjhX1d72xotDOywJY46rq4p
	 OOQbSAKXskjR0xtiuWUIVA2NgElTLGgmTqIKkSfCGzip9TbGdN5vYTK1/ngkBOcTSQ
	 cu5RKM1g3jxd8b1T2fCuwO8dKY71ltr5iFFZX7w8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732746AbfBDLAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 06:00:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:47304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731610AbfBDKt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:49:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B86F2070C;
        Mon,  4 Feb 2019 10:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277368;
        bh=CFZBMG+UMSpSZ7og1sgnVHrbmoTGb2VEDx2BhAyRM4k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RUrBNc+KaVcew+Jvmi+dTgImh1MTug3Z6gFJEdzZMffLfaJ/7kj5H2hk8mtifuzCX
         Wf6Ij+4TOLEnsEqjmzOuWaxWtJiI+xMHr+j/jbwNqgDbSDjXNLk3jHZLV8G2b6MvDX
         Fbnt60DNShP5iAIx4+dh+i1xdLQnc1qlLSFmcf0c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 4.19 46/74] gpiolib: fix line event timestamps for nested irqs
Date:   Mon,  4 Feb 2019 11:36:59 +0100
Message-Id: <20190204103625.524388736@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103619.714714157@linuxfoundation.org>
References: <20190204103619.714714157@linuxfoundation.org>
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
 drivers/gpio/gpiolib.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -817,7 +817,15 @@ static irqreturn_t lineevent_irq_thread(
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
+
 	level = gpiod_get_value_cansleep(le->desc);
 
 	if (le->eflags & GPIOEVENT_REQUEST_RISING_EDGE


