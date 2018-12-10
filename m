Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B02C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59C1F214C4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmFG3hAv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59C1F214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbeLJXzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 18:55:47 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43640 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbeLJXzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 18:55:46 -0500
Received: by mail-wr1-f67.google.com with SMTP id r10so12259078wrs.10;
        Mon, 10 Dec 2018 15:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5DmAZc9VVklV20ByUugu6DlbBYBEoHVB11bBJu+y+Qs=;
        b=OmFG3hAvYDljxf6J2cRALGY4CIRpgtHBjSmPMP47zl8YX77a5yJ1+kcdjYuCbBYOWf
         PnHnuhJQZ/kUPN+ncCJ3EAXCjn4VGVf2KtkMzk31Lq4ICGwR7cWnOLHRfKG8lWjgjUDc
         lhmBlE1hiBVUUCD+J1bJOlywpVycDMIq/JLkyW4ZRo0bAGqE3oDeYWEzQ64iqMYNkr80
         1+3x+SC9iazh4amrFYThPd8EXEa28aF4Qy4XgZgkqch5Q5ksbZkeemEMfsxJXoVClate
         z44ROcXpfQVAnaC6cxixCYsxmtSgIo4V3eZAvNKRpgnATOmr1H6a4tIPwP3dpHRr77Xt
         Ki9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5DmAZc9VVklV20ByUugu6DlbBYBEoHVB11bBJu+y+Qs=;
        b=JcmxBegnmKxKtnTjgzesAsiHu1kL2nfPpz7uVUpGXopwNfANFew8JGvMVLsP53lWbV
         Rk1OK30xw3zl2+RkhRYX7U2on+tsRhqzFrsjzrh8G8IB8J3FMaT3DD6GcfnoKUBm9eMH
         ThCWT8hg5O7i+onTk9cxESMpCHtb6ijM9ARITvWouVRgGt9ZVML+pflqk/beG4+kVGur
         ljJA2iYIOHsY8LF8qDJFqpVgwyqUaniWkb0mxTPT76jMh0ZkGdbDLqjTpxOKkGsMFMUP
         2BfIkAJqnO0soT/V7Hd/kUVrScXu8Z5M5UME0ZkFyEjJ98BGnM30sjWcZvIAPPwU/kJx
         cLPg==
X-Gm-Message-State: AA+aEWZCOWoBv7eaSSqA3m7Q0XPXNlu+Bw4HNnPsh5itll6f4Ek/jbvj
        OB2WFrq25HIqBPDyY3VEKsA=
X-Google-Smtp-Source: AFSGD/Vj54GTRLb7t9pa6JpYc9kaID8lMciFqAnrfCFGDwmfCWSdVKfyzTmq0L8npUruJ6kJVGturg==
X-Received: by 2002:a5d:4303:: with SMTP id h3mr11765575wrq.273.1544486144372;
        Mon, 10 Dec 2018 15:55:44 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id j33sm25222165wre.91.2018.12.10.15.55.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 15:55:43 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     YOKOTA Hiroshi <yokota@netlab.is.tsukuba.ac.jp>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] pcmcia: Remove unnecessary parentheses
Date:   Mon, 10 Dec 2018 16:55:40 -0700
Message-Id: <20181210235540.7039-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

drivers/scsi/pcmcia/nsp_cs.c:1137:27: warning: equality comparison with
extraneous parentheses [-Wparentheses-equality]
                if ((tmpSC->SCp.Message == MSG_COMMAND_COMPLETE)) {
                     ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~
drivers/scsi/pcmcia/nsp_cs.c:1137:27: note: remove extraneous
parentheses around the comparison to silence this warning
                if ((tmpSC->SCp.Message == MSG_COMMAND_COMPLETE)) {
                    ~                   ^                      ~
drivers/scsi/pcmcia/nsp_cs.c:1137:27: note: use '=' to turn this
equality comparison into an assignment
                if ((tmpSC->SCp.Message == MSG_COMMAND_COMPLETE)) {
                                        ^~
                                        =
1 warning generated.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/scsi/pcmcia/nsp_cs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/pcmcia/nsp_cs.c b/drivers/scsi/pcmcia/nsp_cs.c
index f3230494a8c9..f28105b144fc 100644
--- a/drivers/scsi/pcmcia/nsp_cs.c
+++ b/drivers/scsi/pcmcia/nsp_cs.c
@@ -1134,7 +1134,8 @@ static irqreturn_t nspintr(int irq, void *dev_id)
 
 		//*sync_neg       = SYNC_NOT_YET;
 
-		if ((tmpSC->SCp.Message == MSG_COMMAND_COMPLETE)) {     /* all command complete and return status */
+		/* all command complete and return status */
+		if (tmpSC->SCp.Message == MSG_COMMAND_COMPLETE) {
 			tmpSC->result = (DID_OK		             << 16) |
 					((tmpSC->SCp.Message & 0xff) <<  8) |
 					((tmpSC->SCp.Status  & 0xff) <<  0);
-- 
2.20.0

