Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A15DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D88820859
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pjzZPC48"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfAQWqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 17:46:19 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:42488 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbfAQWqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 17:46:18 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0HMdAho153337;
        Thu, 17 Jan 2019 22:46:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id; s=corp-2018-07-02;
 bh=0o6owPltpYV/6XBI7Z0gwP7fkogYOo4J8h3GQayBr2g=;
 b=pjzZPC48sPF3TlDEOCUwRww5RMUTNlT8WlR6d40mKr/x7SCblgvTxy8DqeyYax6XoJ7H
 ub/uV9+gS/b+L91ucaavV4K3bTw4ngU81OGAIvImbJdxXN2U3A1vwqIjNHwOGihFB6V8
 qU6zNBgS1yhgcmKckZzN8LyyqFgZFiIwblxs4fFYVXtlCl8lPtmBl76smt7cMljewXGk
 nkIkXMTKHPicR7xthY02GTVuuIqMybsSQ5uPTRkAIL5LjgClPBJLVeFQgMlVEW5lZe0H
 gN41WFHXPUoLc+DX8Edsn+ez9yJE6DarRncyltKnmJ6dv2B+uYzmyNHiVi0ECE4tkUqC 5w== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2pybjp2pk3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Jan 2019 22:46:12 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0HMk6wZ031453
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Jan 2019 22:46:06 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0HMk5TE017132;
        Thu, 17 Jan 2019 22:46:05 GMT
Received: from localhost.us.oracle.com (/10.211.15.82)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 17 Jan 2019 14:46:05 -0800
From:   eugene.loh@oracle.com
To:     linux-kernel@vger.kernel.org, ard.biesheuvel@linaro.org,
        ak@linux.intel.com, andi@firstfloor.org
Subject: [PATCH] Kbuild: Handle too long symbols in kallsyms.c
Date:   Thu, 17 Jan 2019 14:46:00 -0800
Message-Id: <1547765160-15502-1-git-send-email-eugene.loh@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9139 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=861
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901170157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugene Loh <eugene.loh@oracle.com>

When checking for symbols with excessively long names,
account for null terminating character.

Fixes: f3462aa952cf ("Kbuild: Handle longer symbols in kallsyms.c")
Signed-off-by: Eugene Loh <eugene.loh@oracle.com>
---
 scripts/kallsyms.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 77cebad..f75e7bd 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -118,8 +118,8 @@ static int read_symbol(FILE *in, struct sym_entry *s)
 			fprintf(stderr, "Read error or end of file.\n");
 		return -1;
 	}
-	if (strlen(sym) > KSYM_NAME_LEN) {
-		fprintf(stderr, "Symbol %s too long for kallsyms (%zu vs %d).\n"
+	if (strlen(sym) >= KSYM_NAME_LEN) {
+		fprintf(stderr, "Symbol %s too long for kallsyms (%zu >= %d).\n"
 				"Please increase KSYM_NAME_LEN both in kernel and kallsyms.c\n",
 			sym, strlen(sym), KSYM_NAME_LEN);
 		return -1;
-- 
1.8.3.1

