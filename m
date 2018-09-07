Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E828CC43143
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8F9620844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:14:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8F9620844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbeIHB4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 21:56:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41422 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbeIHB4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:56:44 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 33044FE6;
        Fri,  7 Sep 2018 21:13:57 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ram Pai <linuxram@us.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.18 030/145] powerpc/pkeys: Deny read/write/execute by default
Date:   Fri,  7 Sep 2018 23:08:16 +0200
Message-Id: <20180907210906.410293583@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210903.617721278@linuxfoundation.org>
References: <20180907210903.617721278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ram Pai <linuxram@us.ibm.com>

commit de113256f8c1c24d8c79ae388bf2a5abd70f7577 upstream.

Deny all permissions on all keys, with some exceptions. pkey-0 must
allow all permissions, or else everything comes to a screaching halt.
Execute-only key must allow execute permission.

Fixes: cf43d3b26452 ("powerpc: Enable pkey subsystem")
Cc: stable@vger.kernel.org # v4.16+
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/mm/pkeys.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

--- a/arch/powerpc/mm/pkeys.c
+++ b/arch/powerpc/mm/pkeys.c
@@ -124,12 +124,10 @@ int pkey_initialize(void)
 
 	/* register mask is in BE format */
 	pkey_amr_mask = ~0x0ul;
-	pkey_iamr_mask = ~0x0ul;
+	pkey_amr_mask &= ~(0x3ul << pkeyshift(0));
 
-	for (i = 0; i < (pkeys_total - os_reserved); i++) {
-		pkey_amr_mask &= ~(0x3ul << pkeyshift(i));
-		pkey_iamr_mask &= ~(0x1ul << pkeyshift(i));
-	}
+	pkey_iamr_mask = ~0x0ul;
+	pkey_iamr_mask &= ~(0x3ul << pkeyshift(0));
 
 	pkey_uamor_mask = ~0x0ul;
 	pkey_uamor_mask &= ~(0x3ul << pkeyshift(0));


