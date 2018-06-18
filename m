Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F7CC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5868208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:54:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5868208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967834AbeFRIyo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:54:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35846 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967731AbeFRIeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:34:44 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 57EA6BAD;
        Mon, 18 Jun 2018 08:34:43 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexandre Jutras <alexandre.jutras@nxp.com>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 119/189] tee: check shm references are consistent in offset/size
Date:   Mon, 18 Jun 2018 10:13:35 +0200
Message-Id: <20180618081214.032696342@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618081209.254234434@linuxfoundation.org>
References: <20180618081209.254234434@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Etienne Carriere <etienne.carriere@linaro.org>

[ Upstream commit ab9d3db5b320a052452b9cd035599ee3c84bbee9 ]

This change prevents userland from referencing TEE shared memory
outside the area initially allocated by its owner. Prior this change an
application could not reference or access memory it did not own but
it could reference memory not explicitly allocated by owner but still
allocated to the owner due to the memory allocation granule.

Reported-by: Alexandre Jutras <alexandre.jutras@nxp.com>
Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tee/tee_core.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -181,6 +181,17 @@ static int params_from_user(struct tee_c
 			if (IS_ERR(shm))
 				return PTR_ERR(shm);
 
+			/*
+			 * Ensure offset + size does not overflow offset
+			 * and does not overflow the size of the referred
+			 * shared memory object.
+			 */
+			if ((ip.a + ip.b) < ip.a ||
+			    (ip.a + ip.b) > shm->size) {
+				tee_shm_put(shm);
+				return -EINVAL;
+			}
+
 			params[n].u.memref.shm_offs = ip.a;
 			params[n].u.memref.size = ip.b;
 			params[n].u.memref.shm = shm;


