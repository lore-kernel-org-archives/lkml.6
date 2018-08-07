Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D99C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8636B2172E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:56:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8636B2172E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404486AbeHGVML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:12:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33920 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732347AbeHGVMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:12:10 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 63F5CD01;
        Tue,  7 Aug 2018 18:56:27 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 12/85] RDMA/mad: Convert BUG_ONs to error flows
Date:   Tue,  7 Aug 2018 20:51:14 +0200
Message-Id: <20180807172357.812723076@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807172357.357252052@linuxfoundation.org>
References: <20180807172357.357252052@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leon Romanovsky <leonro@mellanox.com>

[ Upstream commit 2468b82d69e3a53d024f28d79ba0fdb8bf43dfbf ]

Let's perform checks in-place instead of BUG_ONs.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/core/mad.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -1466,7 +1466,8 @@ static int add_oui_reg_req(struct ib_mad
 			    mad_reg_req->oui, 3)) {
 			method = &(*vendor_table)->vendor_class[
 						vclass]->method_table[i];
-			BUG_ON(!*method);
+			if (!*method)
+				goto error3;
 			goto check_in_use;
 		}
 	}
@@ -1476,10 +1477,12 @@ static int add_oui_reg_req(struct ib_mad
 				vclass]->oui[i])) {
 			method = &(*vendor_table)->vendor_class[
 				vclass]->method_table[i];
-			BUG_ON(*method);
 			/* Allocate method table for this OUI */
-			if ((ret = allocate_method_table(method)))
-				goto error3;
+			if (!*method) {
+				ret = allocate_method_table(method);
+				if (ret)
+					goto error3;
+			}
 			memcpy((*vendor_table)->vendor_class[vclass]->oui[i],
 			       mad_reg_req->oui, 3);
 			goto check_in_use;


