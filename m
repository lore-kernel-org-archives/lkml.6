Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD511C10F07
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 23:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93A0B2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 23:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfBTXcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 18:32:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34842 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbfBTXcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 18:32:15 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C43AF30832DC;
        Wed, 20 Feb 2019 23:32:14 +0000 (UTC)
Received: from [IPv6:::1] (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 508921A837;
        Wed, 20 Feb 2019 23:32:14 +0000 (UTC)
From:   Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH] sysctl: Fix proc_do_large_bitmap for large input buffers
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        fsdevel <linux-fsdevel@vger.kernel.org>, netdev@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Message-ID: <53be40fc-6ec4-c714-a64e-f69c96f7058f@redhat.com>
Date:   Wed, 20 Feb 2019 17:32:13 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Wed, 20 Feb 2019 23:32:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Today, proc_do_large_bitmap() truncates a large write input buffer
to PAGE_SIZE - 1, which may result in misparsed numbers at the
(truncated) end of the buffer.  Further, it fails to notify the caller
that the buffer was truncated, so it doesn't get called iteratively
to finish the entire input buffer.

Tell the caller if there's more work to do by adding the skipped
amount back to left/*lenp before returning.

To fix the misparsing, reset the position if we have completely
consumed a truncated buffer (or if just one char is left, which
may be a "-" in a range), and ask the caller to come back for
more.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index ba4d9e85feb8..970a96659809 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -3089,9 +3089,13 @@ int proc_do_large_bitmap(struct ctl_table *table, int write,
 
 	if (write) {
 		char *kbuf, *p;
+		size_t skipped = 0;
 
-		if (left > PAGE_SIZE - 1)
+		if (left > PAGE_SIZE - 1) {
 			left = PAGE_SIZE - 1;
+			/* How much of the buffer we'll skip this pass */
+			skipped = *lenp - left;
+		}
 
 		p = kbuf = memdup_user_nul(buffer, left);
 		if (IS_ERR(kbuf))
@@ -3108,9 +3112,22 @@ int proc_do_large_bitmap(struct ctl_table *table, int write,
 		while (!err && left) {
 			unsigned long val_a, val_b;
 			bool neg;
+			size_t saved_left;
 
+			/* In case we stop parsing mid-number, we can reset */
+			saved_left = left;
 			err = proc_get_long(&p, &left, &val_a, &neg, tr_a,
 					     sizeof(tr_a), &c);
+			/*
+			 * If we consumed the entirety of a truncated buffer or
+			 * only one char is left (may be a "-"), then stop here,
+			 * reset, & come back for more.
+			 */
+			if ((left <= 1) && skipped) {
+				left = saved_left;
+				break;
+			}
+
 			if (err)
 				break;
 			if (val_a >= bitmap_len || neg) {
@@ -3128,6 +3145,15 @@ int proc_do_large_bitmap(struct ctl_table *table, int write,
 				err = proc_get_long(&p, &left, &val_b,
 						     &neg, tr_b, sizeof(tr_b),
 						     &c);
+				/*
+				 * If we consumed all of a truncated buffer or
+				 * then stop here, reset, & come back for more.
+				 */
+				if (!left && skipped) {
+					left = saved_left;
+					break;
+				}
+
 				if (err)
 					break;
 				if (val_b >= bitmap_len || neg ||
@@ -3146,6 +3172,7 @@ int proc_do_large_bitmap(struct ctl_table *table, int write,
 			proc_skip_char(&p, &left, '\n');
 		}
 		kfree(kbuf);
+		left += skipped;
 	} else {
 		unsigned long bit_a, bit_b = 0;
 


