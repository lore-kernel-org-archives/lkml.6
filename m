Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A822C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2A2E20657
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dxlKpwoq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2A2E20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbeH2Tic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 15:38:32 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55238 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbeH2Tic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 15:38:32 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7TFdo9k063789;
        Wed, 29 Aug 2018 15:40:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id; s=corp-2018-07-02;
 bh=qwMqs9Zkj3I45LMTA3lz6R0icX7nRFBMR0u7fKQ1To4=;
 b=dxlKpwoqUAqxTJ2W1+94v6uiKxpPjzaqxV3YU6j3/cvwC+YWqyshW+NQH0UEX7Utf2iT
 fTd9mL6AaxhHEEomkbSp33TW0OLqh5utiWdA1MaX/Zbl4pP9lW1PAXRAoJkPx5Bs9dk8
 x7hKaMG/9qnUDOuKdFe2bQlPujKXLf7hnRDXh0bX4gi1gq9NKKyEKKg/VMOdfxbOiBXT
 8zdPVPN6+Pn+IqbvLEn20dV92jotWdh5Igo3bHQZp4H1mmqwxiNTGZeAGt6RBWMfTce1
 1W9Z0TxHLI2wzSOtBPGi1bh/mb5mI4ZCKQ0CcQ68LmanJGBWZnegwjxQEWfIijM+FZzz uw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2m2xhttnhn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Aug 2018 15:40:59 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7TFewxk002961
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Aug 2018 15:40:58 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7TFevl5020715;
        Wed, 29 Aug 2018 15:40:57 GMT
Received: from dhcp-10-152-33-205.usdhcp.oraclecorp.com.com (/10.152.33.205)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 Aug 2018 08:40:56 -0700
From:   George Kennedy <george.kennedy@oracle.com>
To:     matthew@wil.cx, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, george.kennedy@oracle.com
Subject: [PATCH] sym53c8xx: fix NULL pointer dereference panic in sym_int_sir() in sym_hipd.c
Date:   Wed, 29 Aug 2018 11:38:16 -0400
Message-Id: <1535557096-1324-1-git-send-email-george.kennedy@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9000 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=909
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808290165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sym_int_sir() in sym_hipd.c does not check the command pointer for NULL
before using it in debug message prints.

Suggested-by: Matthew Wilcox <matthew.wilcox@oracle.com>
Signed-off-by: George Kennedy <george.kennedy@oracle.com>
Reviewed-by: Mark Kanda <mark.kanda@oracle.com>
---
 drivers/scsi/sym53c8xx_2/sym_hipd.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/sym53c8xx_2/sym_hipd.c b/drivers/scsi/sym53c8xx_2/sym_hipd.c
index bd3f6e2..0a2a545 100644
--- a/drivers/scsi/sym53c8xx_2/sym_hipd.c
+++ b/drivers/scsi/sym53c8xx_2/sym_hipd.c
@@ -4370,6 +4370,13 @@ static void sym_nego_rejected(struct sym_hcb *np, struct sym_tcb *tp, struct sym
 	OUTB(np, HS_PRT, HS_BUSY);
 }
 
+#define sym_printk(lvl, tp, cp, fmt, v...) do { \
+	if (cp)							\
+		scmd_printk(lvl, cp->cmd, fmt, ##v);		\
+	else							\
+		starget_printk(lvl, tp->starget, fmt, ##v);	\
+} while (0)
+
 /*
  *  chip exception handler for programmed interrupts.
  */
@@ -4415,7 +4422,7 @@ static void sym_int_sir(struct sym_hcb *np)
 	 *  been selected with ATN.  We do not want to handle that.
 	 */
 	case SIR_SEL_ATN_NO_MSG_OUT:
-		scmd_printk(KERN_WARNING, cp->cmd,
+		sym_printk(KERN_WARNING, tp, cp,
 				"No MSG OUT phase after selection with ATN\n");
 		goto out_stuck;
 	/*
@@ -4423,7 +4430,7 @@ static void sym_int_sir(struct sym_hcb *np)
 	 *  having reselected the initiator.
 	 */
 	case SIR_RESEL_NO_MSG_IN:
-		scmd_printk(KERN_WARNING, cp->cmd,
+		sym_printk(KERN_WARNING, tp, cp,
 				"No MSG IN phase after reselection\n");
 		goto out_stuck;
 	/*
@@ -4431,7 +4438,7 @@ static void sym_int_sir(struct sym_hcb *np)
 	 *  an IDENTIFY.
 	 */
 	case SIR_RESEL_NO_IDENTIFY:
-		scmd_printk(KERN_WARNING, cp->cmd,
+		sym_printk(KERN_WARNING, tp, cp,
 				"No IDENTIFY after reselection\n");
 		goto out_stuck;
 	/*
@@ -4460,7 +4467,7 @@ static void sym_int_sir(struct sym_hcb *np)
 	case SIR_RESEL_ABORTED:
 		np->lastmsg = np->msgout[0];
 		np->msgout[0] = M_NOOP;
-		scmd_printk(KERN_WARNING, cp->cmd,
+		sym_printk(KERN_WARNING, tp, cp,
 			"message %x sent on bad reselection\n", np->lastmsg);
 		goto out;
 	/*
-- 
1.8.3.1

