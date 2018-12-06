Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72EAAC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36B5220892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107459;
	bh=jauIOnLMSuT1MYajvg59O8W++NLatCMI4W8RLqv4CB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J+mRyJLxcCsgv3Pz3U8U52xvCFQ8aQdrdV0d5SITcZdPnmNfqTARl9JDAMlHde6C0
	 WkyLdv9bqSxVv9AEfFngHmiH0TK1PIOtCvlyN+P6Nbyp0STvEdLLkC8lpoqAEXCPvO
	 fD+0xB53rKZw+4ew52dImRyvL9pc/jor6UcNOf7I=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36B5220892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730849AbeLFOoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:44:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:48868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730810AbeLFOoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:44:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00E9520661;
        Thu,  6 Dec 2018 14:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107455;
        bh=jauIOnLMSuT1MYajvg59O8W++NLatCMI4W8RLqv4CB4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cDyOy7e2aS0EQGisDR1RGrjeowz1VVrGHBgRZb/BRwtBI2z+9eZMFdOIo5jwnUKlN
         by/fjfwy2dReugJKduN+aZlNidZiJdqtc4YKzRXj2VrzLlGfbqGq1RByFLIrP8aInv
         DlAg6zeIGam+cL2SBuGKnwURuKc12+MUE3fyp1Nw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.9 013/101] iser: set sector for ambiguous mr status errors
Date:   Thu,  6 Dec 2018 15:38:12 +0100
Message-Id: <20181206143012.322948317@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143011.174892052@linuxfoundation.org>
References: <20181206143011.174892052@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1110,7 +1110,9 @@ u8 iser_check_task_pi_status(struct iscs
 					 IB_MR_CHECK_SIG_STATUS, &mr_status);
 		if (ret) {
 			pr_err("ib_check_mr_status failed, ret %d\n", ret);
-			goto err;
+			/* Not a lot we can do, return ambiguous guard error */
+			*sector = 0;
+			return 0x1;
 		}
 
 		if (mr_status.fail_status & IB_MR_CHECK_SIG_STATUS) {
@@ -1138,9 +1140,6 @@ u8 iser_check_task_pi_status(struct iscs
 	}
 
 	return 0;
-err:
-	/* Not alot we can do here, return ambiguous guard error */
-	return 0x1;
 }
 
 void iser_err_comp(struct ib_wc *wc, const char *type)


