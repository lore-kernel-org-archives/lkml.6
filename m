Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18102C04EBF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3DC821479
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107257;
	bh=RPMs+LD492ZM2awy4h4g4BaI7Ys10d53wwnoJnqakys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WB9t5Qa2q7PQOpQUaZLfFkwz8MbPjqzaaNMFjk0AdMnxcEm7aA+ZG4cvK/E9OmPaN
	 /51zjpRufdcGwuOUhNA/C1G432wR28FCKHq8euXgq2e5Mlm3/TYA93cOQuGGfLOlpw
	 QZCXWIipyFl69peUex7bEdL/KG6risUTWFfH6abM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3DC821479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbeLFOk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:40:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:45096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730080AbeLFOkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:40:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DFC320661;
        Thu,  6 Dec 2018 14:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107254;
        bh=RPMs+LD492ZM2awy4h4g4BaI7Ys10d53wwnoJnqakys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EShqsmwKulwMpv1+IojvBZIOWRGnvjNQnU1Yi3MpH9/3vXRF63IABABrMMPyiXNja
         A1esD7El/ZyCKi7+KHS9r6HKDRWvCJs7ZHYnesm0TKFWS5HCKgoIqN4b39hMMit/ke
         Kj8GefUQjpwYBqxKU+9x3H6Z0CMPiMfY4B3aA5JQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.19 04/41] iser: set sector for ambiguous mr status errors
Date:   Thu,  6 Dec 2018 15:38:44 +0100
Message-Id: <20181206142950.070314955@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206142949.757402551@linuxfoundation.org>
References: <20181206142949.757402551@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sagi Grimberg <sagi@grimberg.me>

commit 24c3456c8d5ee6fc1933ca40f7b4406130682668 upstream.

If for some reason we failed to query the mr status, we need to make sure
to provide sufficient information for an ambiguous error (guard error on
sector 0).

Fixes: 0a7a08ad6f5f ("IB/iser: Implement check_protection")
Cc: <stable@vger.kernel.org>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/ulp/iser/iser_verbs.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/drivers/infiniband/ulp/iser/iser_verbs.c
+++ b/drivers/infiniband/ulp/iser/iser_verbs.c
@@ -1123,7 +1123,9 @@ u8 iser_check_task_pi_status(struct iscs
 					 IB_MR_CHECK_SIG_STATUS, &mr_status);
 		if (ret) {
 			pr_err("ib_check_mr_status failed, ret %d\n", ret);
-			goto err;
+			/* Not a lot we can do, return ambiguous guard error */
+			*sector = 0;
+			return 0x1;
 		}
 
 		if (mr_status.fail_status & IB_MR_CHECK_SIG_STATUS) {
@@ -1151,9 +1153,6 @@ u8 iser_check_task_pi_status(struct iscs
 	}
 
 	return 0;
-err:
-	/* Not alot we can do here, return ambiguous guard error */
-	return 0x1;
 }
 
 void iser_err_comp(struct ib_wc *wc, const char *type)


