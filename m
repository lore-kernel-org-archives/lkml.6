Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF173C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B667208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWhilPxw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B667208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391104AbeKTDUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:20:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:59312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390603AbeKTDUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:20:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF9C9206BA;
        Mon, 19 Nov 2018 16:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646549;
        bh=/u7X4RLY76Qh2xifzXvm4NiyJQiZWbhNet7aCsROWlI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oWhilPxwNF/YHNY4ZdTMDjckw7lbO5Zb6EsHx1CIs5437C1b2AgniNW+1HGGEwQp1
         8a5VfK9YOsPdDxAfx135IFTx0eOoHYJJMaktC3v2X8pKbbdb0SogtUiqF70mAX/T1+
         WYteKL1cJJJI6Oe6FcqxV9wxz/IQTSmjzvJAaNiw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Maciej W. Rozycki" <macro@linux-mips.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 4.9 71/83] rtc: hctosys: Add missing range error reporting
Date:   Mon, 19 Nov 2018 17:29:37 +0100
Message-Id: <20181119162625.949312970@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162612.046511542@linuxfoundation.org>
References: <20181119162612.046511542@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maciej W. Rozycki <macro@linux-mips.org>

commit 7ce9a992ffde8ce93d5ae5767362a5c7389ae895 upstream.

Fix an issue with the 32-bit range error path in `rtc_hctosys' where no
error code is set and consequently the successful preceding call result
from `rtc_read_time' is propagated to `rtc_hctosys_ret'.  This in turn
makes any subsequent call to `hctosys_show' incorrectly report in sysfs
that the system time has been set from this RTC while it has not.

Set the error to ERANGE then if we can't express the result due to an
overflow.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
Fixes: b3a5ac42ab18 ("rtc: hctosys: Ensure system time doesn't overflow time_t")
Cc: stable@vger.kernel.org # 4.17+
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/rtc/hctosys.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/rtc/hctosys.c
+++ b/drivers/rtc/hctosys.c
@@ -50,8 +50,10 @@ static int __init rtc_hctosys(void)
 	tv64.tv_sec = rtc_tm_to_time64(&tm);
 
 #if BITS_PER_LONG == 32
-	if (tv64.tv_sec > INT_MAX)
+	if (tv64.tv_sec > INT_MAX) {
+		err = -ERANGE;
 		goto err_read;
+	}
 #endif
 
 	err = do_settimeofday64(&tv64);


