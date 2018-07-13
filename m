Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBF9ECDFAA
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 00:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBD002147E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 00:41:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBD002147E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387897AbeGMAxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 20:53:41 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9613 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387799AbeGMAxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 20:53:41 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7A626A9709DA;
        Fri, 13 Jul 2018 08:41:23 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.382.0; Fri, 13 Jul 2018 08:41:15 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>,
        Eddie James <eajames@linux.vnet.ibm.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] fsi: sbefifo: Fix missing unlock on error in sbefifo_dump_ffdc()
Date:   Fri, 13 Jul 2018 00:50:07 +0000
Message-ID: <1531443007-144851-1-git-send-email-weiyongjun1@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing unlock before return from function sbefifo_dump_ffdc()
in the error handling case.

Fixes: 9f4a8a2d7f9d ("fsi/sbefifo: Add driver for the SBE FIFO")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/fsi/fsi-sbefifo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/fsi/fsi-sbefifo.c b/drivers/fsi/fsi-sbefifo.c
index 6b31cc24..35f2749 100644
--- a/drivers/fsi/fsi-sbefifo.c
+++ b/drivers/fsi/fsi-sbefifo.c
@@ -150,6 +150,7 @@ static void sbefifo_dump_ffdc(struct device *dev, const __be32 *ffdc,
 		u32 w0, w1, w2, i;
 		if (ffdc_sz < 3) {
 			dev_err(dev, "SBE invalid FFDC package size %zd\n", ffdc_sz);
+			mutex_unlock(&sbefifo_ffdc_mutex);
 			return;
 		}
 		w0 = be32_to_cpu(*(ffdc++));

