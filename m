Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5903C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 20:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6906C20659
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 20:28:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6906C20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kleine-koenig.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbeJOEKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 00:10:23 -0400
Received: from antares.kleine-koenig.org ([94.130.110.236]:33750 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725722AbeJOEKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 00:10:23 -0400
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 41D26414091; Sun, 14 Oct 2018 22:28:10 +0200 (CEST)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alessandro Rubini <rubini@gnudd.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Vok=C3=A1=C4=8D=20Michal?= <Michal.Vokac@ysoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel@pengutronix.de
Subject: [PATCH RFC] err.h: document that PTR_ERR should only be used if IS_ERR returns true
Date:   Sun, 14 Oct 2018 22:28:07 +0200
Message-Id: <20181014202807.16412-1-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have no idea about the rationale, but that's what LDD3 recommends.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
Hello,

during a review I claimed that PTR_ERR should only be used if IS_ERR was
already checked. The rationale isn't obvious though and Thierry
suggested to keep the code as is and not introduce an IS_ERR check.

I found in Linux Device Drivers 3[1]:

	You should use PTR_ERR only on a value for which IS_ERR returns
	a true value; any other value is a valid pointer

I wonder if there is a relevant reason that LDD3 suggests to check
IS_ERR first, maybe something like "On an Alpha it is important because
not doing it results in a bus error there." There are no details
mentioned there however. If there is a reason, this patch should be
adapted such that the comment includes it.

Any ideas?

Best regards
Uwe

[1] https://static.lwn.net/images/pdf/LDD3/ch11.pdf, on page 295

 include/linux/err.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/err.h b/include/linux/err.h
index 87be24350e91..8f052983108e 100644
--- a/include/linux/err.h
+++ b/include/linux/err.h
@@ -26,6 +26,9 @@ static inline void * __must_check ERR_PTR(long error)
 	return (void *) error;
 }
 
+/*
+ * You should use PTR_ERR only on a value for which IS_ERR returns a true value.
+ */
 static inline long __must_check PTR_ERR(__force const void *ptr)
 {
 	return (long) ptr;
-- 
2.19.1

