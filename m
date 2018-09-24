Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2B9ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 230F92083A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:35:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 230F92083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388069AbeIXSh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:37:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58524 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728937AbeIXSh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:37:27 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 73A8D1092;
        Mon, 24 Sep 2018 12:35:30 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Xiao, Jin" <jin.xiao@intel.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.18 120/235] dm verity: fix crash on bufio buffer that was allocated with vmalloc
Date:   Mon, 24 Sep 2018 13:51:46 +0200
Message-Id: <20180924113118.142173320@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-verity-target.c |   24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -99,10 +99,26 @@ static int verity_hash_update(struct dm_
 {
 	struct scatterlist sg;
 
-	sg_init_one(&sg, data, len);
-	ahash_request_set_crypt(req, &sg, NULL, len);
-
-	return crypto_wait_req(crypto_ahash_update(req), wait);
+	if (likely(!is_vmalloc_addr(data))) {
+		sg_init_one(&sg, data, len);
+		ahash_request_set_crypt(req, &sg, NULL, len);
+		return crypto_wait_req(crypto_ahash_update(req), wait);
+	} else {
+		do {
+			int r;
+			size_t this_step = min_t(size_t, len, PAGE_SIZE - offset_in_page(data));
+			flush_kernel_vmap_range((void *)data, this_step);
+			sg_init_table(&sg, 1);
+			sg_set_page(&sg, vmalloc_to_page(data), this_step, offset_in_page(data));
+			ahash_request_set_crypt(req, &sg, NULL, this_step);
+			r = crypto_wait_req(crypto_ahash_update(req), wait);
+			if (unlikely(r))
+				return r;
+			data += this_step;
+			len -= this_step;
+		} while (len);
+		return 0;
+	}
 }
 
 /*


