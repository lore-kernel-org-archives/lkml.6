Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A815C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0744208DC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:20:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0744208DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbeH0XIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 19:08:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37752 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726939AbeH0XIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 19:08:00 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F35E6400738B;
        Mon, 27 Aug 2018 19:20:05 +0000 (UTC)
Received: from dba62.ml3.eng.bos.redhat.com (dba62.ml3.eng.bos.redhat.com [10.19.176.128])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D75E52166B41;
        Mon, 27 Aug 2018 19:20:03 +0000 (UTC)
From:   David Arcari <darcari@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, David Arcari <darcari@redhat.com>,
        Al Stone <ahs3@redhat.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Subject: [PATCH] mailbox: PCC: handle parse error
Date:   Mon, 27 Aug 2018 15:19:08 -0400
Message-Id: <1535397548-69588-1-git-send-email-darcari@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 27 Aug 2018 19:20:06 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 27 Aug 2018 19:20:06 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'darcari@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

acpi_pcc_probe calls acpi_table_parse_entries_array but fails to check
for an error return.  This in turn can result in calling kcalloc with
a negative count as well as emitting the following misleading erorr
message:

[    2.642015] Could not allocate space for PCC mbox channels

Fixes: 8f8027c5f935 ("mailbox: PCC: erroneous error message when parsing ACPI PCCT")

Signed-off-by: David Arcari <darcari@redhat.com>
Cc: Al Stone <ahs3@redhat.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>
---
 drivers/mailbox/pcc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 311e91b..256f18b 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -461,8 +461,11 @@ static int __init acpi_pcc_probe(void)
 	count = acpi_table_parse_entries_array(ACPI_SIG_PCCT,
 			sizeof(struct acpi_table_pcct), proc,
 			ACPI_PCCT_TYPE_RESERVED, MAX_PCC_SUBSPACES);
-	if (count == 0 || count > MAX_PCC_SUBSPACES) {
-		pr_warn("Invalid PCCT: %d PCC subspaces\n", count);
+	if (count <= 0 || count > MAX_PCC_SUBSPACES) {
+		if (count < 0)
+			pr_warn("Error parsing PCC subspaces from PCCT\n");
+		else
+			pr_warn("Invalid PCCT: %d PCC subspaces\n", count);
 		return -EINVAL;
 	}
 
-- 
1.8.3.1

