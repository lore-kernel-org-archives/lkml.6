Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C328AC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D7AA2082E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfA1OtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 09:49:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45784 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbfA1OtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 09:49:09 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 89AC358E27;
        Mon, 28 Jan 2019 14:49:09 +0000 (UTC)
Received: from localhost (unknown [10.43.2.219])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 91350C95B1;
        Mon, 28 Jan 2019 14:49:06 +0000 (UTC)
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brian Behlendorf <behlendorf1@llnl.gov>,
        Siarhei Volkau <lis8215@gmail.com>
Subject: [PATCH] lib/div64: off by one in shift
Date:   Mon, 28 Jan 2019 15:49:04 +0100
Message-Id: <1548686944-11891-1-git-send-email-sgruszka@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 28 Jan 2019 14:49:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fls counts bits starting from 1 to 32 (returns 0 for zero argument).
If we add 1 we shift right one bit more and loose precision from
divisor, what cause function incorect results with some numbers.

Corrected code was tested in user-space, see bugzilla:
https://bugzilla.kernel.org/show_bug.cgi?id=202391

Fixes: 658716d19f8f ("div64_u64(): improve precision on 32bit platforms")
Reported-and-tested-by: Siarhei Volkau <lis8215@gmail.com>
Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
---
 lib/div64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/div64.c b/lib/div64.c
index 01c8602bb6ff..ee146bb4c558 100644
--- a/lib/div64.c
+++ b/lib/div64.c
@@ -109,7 +109,7 @@ u64 div64_u64_rem(u64 dividend, u64 divisor, u64 *remainder)
 		quot = div_u64_rem(dividend, divisor, &rem32);
 		*remainder = rem32;
 	} else {
-		int n = 1 + fls(high);
+		int n = fls(high);
 		quot = div_u64(dividend >> n, divisor >> n);
 
 		if (quot != 0)
@@ -147,7 +147,7 @@ u64 div64_u64(u64 dividend, u64 divisor)
 	if (high == 0) {
 		quot = div_u64(dividend, divisor);
 	} else {
-		int n = 1 + fls(high);
+		int n = fls(high);
 		quot = div_u64(dividend >> n, divisor >> n);
 
 		if (quot != 0)
-- 
1.9.3

