Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA82C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5C2C20817
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VEVHurWL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5C2C20817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389386AbeKLIVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:21:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:47678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387728AbeKLIVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:21:10 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE6B622353;
        Sun, 11 Nov 2018 22:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975473;
        bh=IcxksAb5g9Z1z+NeS74GWkwbYaMjaKjsG8xhr8qKZE4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VEVHurWLQIdJiXXA9ptvpaHdNzGVpRnlsYGkJ9lMEfiRtPlhWZLtw5lGUohvpc5XR
         MTpF5/Q+MNxSCluJc1bEg7UHxdOH5YIpWLLJ9JBepFvOrpVG097WlLsw5Ms7VWdd43
         PKdrOy55eRSpKNgObRCa1hN0kDbYZ8SEN4aqMBA8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.18 237/350] crypto: lrw - Fix out-of bounds access on counter overflow
Date:   Sun, 11 Nov 2018 14:21:41 -0800
Message-Id: <20181111221717.949596290@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ondrej Mosnacek <omosnace@redhat.com>

commit fbe1a850b3b1522e9fc22319ccbbcd2ab05328d2 upstream.

When the LRW block counter overflows, the current implementation returns
128 as the index to the precomputed multiplication table, which has 128
entries. This patch fixes it to return the correct value (127).

Fixes: 64470f1b8510 ("[CRYPTO] lrw: Liskov Rivest Wagner, a tweakable narrow block cipher mode")
Cc: <stable@vger.kernel.org> # 2.6.20+
Reported-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/lrw.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/crypto/lrw.c
+++ b/crypto/lrw.c
@@ -143,7 +143,12 @@ static inline int get_index128(be128 *bl
 		return x + ffz(val);
 	}
 
-	return x;
+	/*
+	 * If we get here, then x == 128 and we are incrementing the counter
+	 * from all ones to all zeros. This means we must return index 127, i.e.
+	 * the one corresponding to key2*{ 1,...,1 }.
+	 */
+	return 127;
 }
 
 static int post_crypt(struct skcipher_request *req)


