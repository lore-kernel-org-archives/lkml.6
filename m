Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616FEC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22C1420839
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9prZFaj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22C1420839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732706AbeKLJrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:47:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:35336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732514AbeKLISL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:18:11 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD0B921508;
        Sun, 11 Nov 2018 22:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975295;
        bh=BuuW1AFSt5RgMIqSwGI6lSo+8ObcGDSbL0F2MKuf3TY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E9prZFaj1Gz6EKu0zrYrHnCiXmMFR8qTkUXlHHLAuwNUYPJgXHssMtlZFu6+ZToTf
         KQE1VVrhG44mwGx51lI74JlAj0802VPu0J0Mmqxr8APD0QVQJ7yWecNWpBChJxPnUJ
         SR19KE20zv+CiqtqRUeRrpgqL5Bf2xrw8KlNSSnc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.19 244/361] crypto: aesni - dont use GFP_ATOMIC allocation if the request doesnt cross a page in gcm
Date:   Sun, 11 Nov 2018 14:19:51 -0800
Message-Id: <20181111221652.607603138@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

commit a788848116454d753b13a4888e0e31ada3c4d393 upstream.

This patch fixes gcmaes_crypt_by_sg so that it won't use memory
allocation if the data doesn't cross a page boundary.

Authenticated encryption may be used by dm-crypt. If the encryption or
decryption fails, it would result in I/O error and filesystem corruption.
The function gcmaes_crypt_by_sg is using GFP_ATOMIC allocation that can
fail anytime. This patch fixes the logic so that it won't attempt the
failing allocation if the data doesn't cross a page boundary.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/crypto/aesni-intel_glue.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -817,7 +817,7 @@ static int gcmaes_crypt_by_sg(bool enc,
 	/* Linearize assoc, if not already linear */
 	if (req->src->length >= assoclen && req->src->length &&
 		(!PageHighMem(sg_page(req->src)) ||
-			req->src->offset + req->src->length < PAGE_SIZE)) {
+			req->src->offset + req->src->length <= PAGE_SIZE)) {
 		scatterwalk_start(&assoc_sg_walk, req->src);
 		assoc = scatterwalk_map(&assoc_sg_walk);
 	} else {


