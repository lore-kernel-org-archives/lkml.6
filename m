Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0544C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 00:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A932175B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 00:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MxSVb+tn";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MxSVb+tn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3A932175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731789AbeKNKwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 05:52:39 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:43052 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbeKNKwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 05:52:38 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B3DD3606DD; Wed, 14 Nov 2018 00:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542156708;
        bh=ol9scosW61WusJViQsEkbLleT7CRNA63lOg1Ieicw0k=;
        h=From:To:Cc:Subject:Date:From;
        b=MxSVb+tn6Y6TXgNhTrUxyvuARXznpXEL8xmKQoaEl2bWtDFfcDvW0XJi44rflpaZg
         dcdTHBKQG/bE+dEGDVcc//Iq/O0S6/TVNuGofbIYsBuFCz3vu8wyYLWYNyFFDZLY3M
         HSjfNCoVAK+394CqyKF9KkBNPZYcAqDBrKCY7Zm8=
Received: from isaacm-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: isaacm@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A79AB60452;
        Wed, 14 Nov 2018 00:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542156708;
        bh=ol9scosW61WusJViQsEkbLleT7CRNA63lOg1Ieicw0k=;
        h=From:To:Cc:Subject:Date:From;
        b=MxSVb+tn6Y6TXgNhTrUxyvuARXznpXEL8xmKQoaEl2bWtDFfcDvW0XJi44rflpaZg
         dcdTHBKQG/bE+dEGDVcc//Iq/O0S6/TVNuGofbIYsBuFCz3vu8wyYLWYNyFFDZLY3M
         HSjfNCoVAK+394CqyKF9KkBNPZYcAqDBrKCY7Zm8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A79AB60452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=isaacm@codeaurora.org
From:   "Isaac J. Manjarres" <isaacm@codeaurora.org>
To:     keescook@chromium.org, crecklin@redhat.com
Cc:     "Isaac J. Manjarres" <isaacm@codeaurora.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, psodagud@codeaurora.org,
        tsoni@codeaurora.org, stable@vger.kernel.org
Subject: [PATCH] mm/usercopy: Use memory range to be accessed for wraparound check
Date:   Tue, 13 Nov 2018 16:51:26 -0800
Message-Id: <1542156686-12253-1-git-send-email-isaacm@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, when checking to see if accessing n bytes starting at
address "ptr" will cause a wraparound in the memory addresses,
the check in check_bogus_address() adds an extra byte, which is
incorrect, as the range of addresses that will be accessed is
[ptr, ptr + (n - 1)].

This can lead to incorrectly detecting a wraparound in the
memory address, when trying to read 4 KB from memory that is
mapped to the the last possible page in the virtual address
space, when in fact, accessing that range of memory would not
cause a wraparound to occur.

Use the memory range that will actually be accessed when
considering if accessing a certain amount of bytes will cause
the memory address to wrap around.

Change-Id: I2563a5988e41122727ede17180f365e999b953e6
Fixes: f5509cc18daa ("mm: Hardened usercopy")
Co-Developed-by: Prasad Sodagudi <psodagud@codeaurora.org>
Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
Cc: stable@vger.kernel.org
---
 mm/usercopy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/usercopy.c b/mm/usercopy.c
index 852eb4e..0293645 100644
--- a/mm/usercopy.c
+++ b/mm/usercopy.c
@@ -151,7 +151,7 @@ static inline void check_bogus_address(const unsigned long ptr, unsigned long n,
 				       bool to_user)
 {
 	/* Reject if object wraps past end of memory. */
-	if (ptr + n < ptr)
+	if (ptr + (n - 1) < ptr)
 		usercopy_abort("wrapped address", NULL, to_user, 0, ptr + n);
 
 	/* Reject if NULL or ZERO-allocation. */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

