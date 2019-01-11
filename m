Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D25C43612
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BAD02063F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217206;
	bh=VwT727p+0Sl27RpIvP1EU/ozXXjtdJ8FkKFTg1xvTgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M5Xp/46R9GLh7CkMJeltcSV72CvmtpnEV/VXUA/ORfQmS5ljcBkeQRX8NVflSPRt/
	 JoPEYAxrR0W4NJzcflHai6nKiZDEI47W4sHw0Bk5ntJxhi/wSRRpvMwOadX9fhci+F
	 nRIkgV/wDYo0utTfpCaMxfmvcOSxIH/6aniJqo+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389651AbfAKOdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:33:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:53516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389625AbfAKOdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:33:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF7C92063F;
        Fri, 11 Jan 2019 14:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217198;
        bh=VwT727p+0Sl27RpIvP1EU/ozXXjtdJ8FkKFTg1xvTgM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M8xkDqQQNpfu/poq4b0N1W8fhRzAO8aYn1/zW/mtzdbtaJ1Ccznw5NuUSE7/0QwIE
         vZSVMMmbTYGA8L4qHn4hmeHCBfgbKyquUjwQTNNPOQJPqXr0NJWa7r3YJNVEivi5mw
         BlbVd3+VGpYPiv+Hmr9R/G4htjUgNx5tCxJ47IkY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Xiao, Jin" <jin.xiao@intel.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.14 079/105] dm verity: fix crash on bufio buffer that was allocated with vmalloc
Date:   Fri, 11 Jan 2019 15:14:50 +0100
Message-Id: <20190111131109.609982794@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131102.899065735@linuxfoundation.org>
References: <20190111131102.899065735@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

commit e4b069e0945fa14c71cf8b5b89f8b1b2aa68dbc2 upstream.

Since commit d1ac3ff008fb ("dm verity: switch to using asynchronous hash
crypto API") dm-verity uses asynchronous crypto calls for verification,
so that it can use hardware with asynchronous processing of crypto
operations.

These asynchronous calls don't support vmalloc memory, but the buffer data
can be allocated with vmalloc if dm-bufio is short of memory and uses a
reserved buffer that was preallocated in dm_bufio_client_create().

Fix verity_hash_update() so that it deals with vmalloc'd memory
correctly.

Reported-by: "Xiao, Jin" <jin.xiao@intel.com>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Fixes: d1ac3ff008fb ("dm verity: switch to using asynchronous hash crypto API")
Cc: stable@vger.kernel.org # 4.12+
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Acked-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/dm-verity-target.c |   24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -139,10 +139,26 @@ static int verity_hash_update(struct dm_
 {
 	struct scatterlist sg;
 
-	sg_init_one(&sg, data, len);
-	ahash_request_set_crypt(req, &sg, NULL, len);
-
-	return verity_complete_op(res, crypto_ahash_update(req));
+	if (likely(!is_vmalloc_addr(data))) {
+		sg_init_one(&sg, data, len);
+		ahash_request_set_crypt(req, &sg, NULL, len);
+		return verity_complete_op(res, crypto_ahash_update(req));
+	} else {
+		do {
+			int r;
+			size_t this_step = min_t(size_t, len, PAGE_SIZE - offset_in_page(data));
+			flush_kernel_vmap_range((void *)data, this_step);
+			sg_init_table(&sg, 1);
+			sg_set_page(&sg, vmalloc_to_page(data), this_step, offset_in_page(data));
+			ahash_request_set_crypt(req, &sg, NULL, this_step);
+			r = verity_complete_op(res, crypto_ahash_update(req));
+			if (unlikely(r))
+				return r;
+			data += this_step;
+			len -= this_step;
+		} while (len);
+		return 0;
+	}
 }
 
 /*


