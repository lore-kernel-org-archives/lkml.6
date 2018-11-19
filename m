Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53942C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1975C20989
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YcJYJ0TG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1975C20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731368AbeKTC61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:58:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:57508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729995AbeKTC60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:58:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DE8721104;
        Mon, 19 Nov 2018 16:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645258;
        bh=pg0wOZ2O93KrWKnGL8ZFgKfUpRoNO7kGc4Ez2xsFUDg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YcJYJ0TGHODIYKM0bVa616J5KqVbLeHfWSkp9QNWpU8Bn10co7W/NWwpx67I+0h4p
         gNLkkuWV0Pv53/LIAp/k9znlo8ta/rAH5Uf0Q8hvqlPwHsf9ntyJPBrjfDuReqtqyC
         1yAAjD+/iI7KF9E/DaViHjfXUCgdv3UAR1smEwko=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        John Garry <john.garry@huawei.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.19 095/205] crypto: hisilicon - Fix reference after free of memories on error path
Date:   Mon, 19 Nov 2018 17:26:42 +0100
Message-Id: <20181119162632.718350821@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
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

From: John Garry <john.garry@huawei.com>

commit 0b0cf6af3f3151c26c27e8e51def5527091c3e69 upstream.

coccicheck currently warns of the following issues in the driver:
drivers/crypto/hisilicon/sec/sec_algs.c:864:51-66: ERROR: reference preceded by free on line 812
drivers/crypto/hisilicon/sec/sec_algs.c:864:40-49: ERROR: reference preceded by free on line 813
drivers/crypto/hisilicon/sec/sec_algs.c:861:8-24: ERROR: reference preceded by free on line 814
drivers/crypto/hisilicon/sec/sec_algs.c:860:41-51: ERROR: reference preceded by free on line 815
drivers/crypto/hisilicon/sec/sec_algs.c:867:7-18: ERROR: reference preceded by free on line 816

It would appear than on certain error paths that we may attempt reference-
after-free some memories.

This patch fixes those issues. The solution doesn't look perfect, but
having same memories free'd possibly from separate functions makes it
tricky.

Fixes: 915e4e8413da ("crypto: hisilicon - SEC security accelerator driver")
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: John Garry <john.garry@huawei.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/hisilicon/sec/sec_algs.c |   21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

--- a/drivers/crypto/hisilicon/sec/sec_algs.c
+++ b/drivers/crypto/hisilicon/sec/sec_algs.c
@@ -808,13 +808,6 @@ static int sec_alg_skcipher_crypto(struc
 	 * more refined but this is unlikely to happen so no need.
 	 */
 
-	/* Cleanup - all elements in pointer arrays have been coppied */
-	kfree(splits_in_nents);
-	kfree(splits_in);
-	kfree(splits_out_nents);
-	kfree(splits_out);
-	kfree(split_sizes);
-
 	/* Grab a big lock for a long time to avoid concurrency issues */
 	mutex_lock(&queue->queuelock);
 
@@ -829,13 +822,13 @@ static int sec_alg_skcipher_crypto(struc
 	     (!queue->havesoftqueue ||
 	      kfifo_avail(&queue->softqueue) > steps)) ||
 	    !list_empty(&ctx->backlog)) {
+		ret = -EBUSY;
 		if ((skreq->base.flags & CRYPTO_TFM_REQ_MAY_BACKLOG)) {
 			list_add_tail(&sec_req->backlog_head, &ctx->backlog);
 			mutex_unlock(&queue->queuelock);
-			return -EBUSY;
+			goto out;
 		}
 
-		ret = -EBUSY;
 		mutex_unlock(&queue->queuelock);
 		goto err_free_elements;
 	}
@@ -844,7 +837,15 @@ static int sec_alg_skcipher_crypto(struc
 	if (ret)
 		goto err_free_elements;
 
-	return -EINPROGRESS;
+	ret = -EINPROGRESS;
+out:
+	/* Cleanup - all elements in pointer arrays have been copied */
+	kfree(splits_in_nents);
+	kfree(splits_in);
+	kfree(splits_out_nents);
+	kfree(splits_out);
+	kfree(split_sizes);
+	return ret;
 
 err_free_elements:
 	list_for_each_entry_safe(el, temp, &sec_req->elements, head) {


