Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id atIKBfxVGVt0OwAAmS7hNA
	; Thu, 07 Jun 2018 15:58:07 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 168A56089E; Thu,  7 Jun 2018 15:58:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 77996601D2;
	Thu,  7 Jun 2018 15:58:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 77996601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934672AbeFGP6E (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:58:04 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39334 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933050AbeFGOJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:07 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb7-0005Zx-K8; Thu, 07 Jun 2018 15:09:05 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb3-0002uh-Hp; Thu, 07 Jun 2018 15:09:01 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Dan Carpenter" <dan.carpenter@oracle.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.174914596@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 150/410] staging: rts5208: Fix "seg_no" calculation
 in reset_ms_card()
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>

commit 7f7aeea7cf30368b9fdb86dcc9d2c8a3ebc65dfb upstream.

I get some static checker warnings like this:

    drivers/staging/rts5208/ms.c:2607 ms_build_l2p_tbl()
    error: buffer underflow 'ms_card->segment' (-1)-16

The problem is that we memset "ms_card" to zero at the start of the
reset_ms_card() function.  That means that when we try to calculate
"ms_card->total_block / 512 - 1" then it's just always -1.  The fix is
to calculate "seg_no" before doing the memset().

This is a static checker fix, and I am not able to test it.  My theory
is that reset_ms_card() gets very little testing which is why this bug
exists.

Fixes: fa590c222fba ("staging: rts5208: add support for rts5208 and rts5288")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/staging/rts5208/ms.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/staging/rts5208/ms.c
+++ b/drivers/staging/rts5208/ms.c
@@ -2397,6 +2397,7 @@ BUILD_FAIL:
 int reset_ms_card(struct rtsx_chip *chip)
 {
 	struct ms_info *ms_card = &(chip->ms_card);
+	int seg_no = ms_card->total_block / 512 - 1;
 	int retval;
 
 	memset(ms_card, 0, sizeof(struct ms_info));
@@ -2430,7 +2431,7 @@ int reset_ms_card(struct rtsx_chip *chip
 		/* Build table for the last segment,
 		 * to check if L2P table block exists, erasing it
 		 */
-		retval = ms_build_l2p_tbl(chip, ms_card->total_block / 512 - 1);
+		retval = ms_build_l2p_tbl(chip, seg_no);
 		if (retval != STATUS_SUCCESS)
 			TRACE_RET(chip, STATUS_FAIL);
 	}
