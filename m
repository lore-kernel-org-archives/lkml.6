Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8B9C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE952098A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:51:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DE952098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbeHPVvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 17:51:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57390 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbeHPVsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 17:48:10 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 86418D58;
        Thu, 16 Aug 2018 18:48:00 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Gary R Hook <gary.hook@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.18 11/22] crypto: ccp - Check for NULL PSP pointer at module unload
Date:   Thu, 16 Aug 2018 20:45:27 +0200
Message-Id: <20180816171556.956609959@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180816171556.502583508@linuxfoundation.org>
References: <20180816171556.502583508@linuxfoundation.org>
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

From: Tom Lendacky <thomas.lendacky@amd.com>

commit afb31cd2d1a1bc3ca055fb2519ec4e9ab969ffe0 upstream.

Should the PSP initialization fail, the PSP data structure will be
freed and the value contained in the sp_device struct set to NULL.
At module unload, psp_dev_destroy() does not check if the pointer
value is NULL and will end up dereferencing a NULL pointer.

Add a pointer check of the psp_data field in the sp_device struct
in psp_dev_destroy() and return immediately if it is NULL.

Cc: <stable@vger.kernel.org> # 4.16.x-
Fixes: 2a6170dfe755 ("crypto: ccp: Add Platform Security Processor (PSP) device support")
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Acked-by: Gary R Hook <gary.hook@amd.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/ccp/psp-dev.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/crypto/ccp/psp-dev.c
+++ b/drivers/crypto/ccp/psp-dev.c
@@ -856,6 +856,9 @@ void psp_dev_destroy(struct sp_device *s
 {
 	struct psp_device *psp = sp->psp_data;
 
+	if (!psp)
+		return;
+
 	if (psp->sev_misc)
 		kref_put(&misc_dev->refcount, sev_exit);
 


