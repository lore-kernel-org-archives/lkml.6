Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B96ECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 04:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 286A02146E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 04:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFf9VpzY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 286A02146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387596AbeITJqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 05:46:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39105 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbeITJqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 05:46:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id s14-v6so7831450wrw.6;
        Wed, 19 Sep 2018 21:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zNmWobYggymmqpmgdb6SxrIz+4HVMyxn1KeF/THy9mo=;
        b=DFf9VpzYlCfZeXhT7TdZNmss+mrC+uHUjxviLd3dCO9Nv3iNDMEnqNSFadDxU3PUEg
         7IpAlLi0VMEks9q9ubFv/QyieLCY1pBk4F5TOidntvUBI2g7pJvc6id4V1JO8QF1LZJf
         K+x5uzZrObmseFDzDj/7fkCGW/LF5roaxATTZt0CkSuat0fytBs8FtHKy0IDqBtZ3+q7
         z3+jTMGdjxlDUtbUbhSwbpCyOKtabmNg9F2K/2XDdmaqCYrghw++4kQ4+7tL5twII2bq
         IzHqLzzEoQJxEK+SN+2neSjt2tJmbZJoyGRRNhte8SDMm/kjn3ZSZTuTDaEMWmfmCmXi
         1hhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zNmWobYggymmqpmgdb6SxrIz+4HVMyxn1KeF/THy9mo=;
        b=GlVZWs+upUTYHNGqW7jObgIHx6180TeB7d5j94louFPq9FJlfjDwQLTPM8D6xfgi2q
         DTylNJ7wPUR673WRYltCdc/zACCF8HBEx3sOX9ZWiLlnbREh4/WFLvaXUxQKXs0dLSAI
         GzLer4lHYvxtV4kLyA3VJEODU9jgtRYZ8L9zM37IdMqssxIw+D4bIdj2OThNeUreYpj3
         9IZ5oGmbPWAIMQWSSev7Ffrp+lMqhCzP02ra5n/tCjKPJjxwP+RF/c2SwaH9BIt9kOWw
         LW1TzKgGofx9Q1JoHKChiBkgo27ni5yB63oCCuczHdstX8NnWcWFYFi4OyaMC8PGkYE8
         g8aw==
X-Gm-Message-State: APzg51BSAvIix6XvvuO65IZowgfvTmqg41hKSDtbzCfNzM+6Vc+O/wNM
        KIINQMLHbHVnCpFeUh2VjwY=
X-Google-Smtp-Source: ANB0VdYHEPGm6EWVXqGHy23ijek9Zskht3AtN/GZkXy/brHI8vr90wMtKUmcC7wb0Te7wTGFGoj8FQ==
X-Received: by 2002:adf:c64e:: with SMTP id u14-v6mr11732674wrg.177.1537416334132;
        Wed, 19 Sep 2018 21:05:34 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id 144-v6sm615182wma.19.2018.09.19.21.05.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 21:05:32 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Karsten Keil <isdn@linux-pingi.de>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] isdn/hisax: Remove unnecessary parenthesis
Date:   Wed, 19 Sep 2018 21:05:23 -0700
Message-Id: <20180920040523.21671-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when more than one set of parentheses are used for single
conditional statements:

drivers/isdn/hisax/w6692.c:627:30: warning: equality comparison with
extraneous parentheses [-Wparentheses-equality]
                if ((cs->dc.w6692.ph_state == W_L1IND_DRD)) {
                     ~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~
drivers/isdn/hisax/w6692.c:627:30: note: remove extraneous parentheses
around the comparison to silence this warning
                if ((cs->dc.w6692.ph_state == W_L1IND_DRD)) {
                    ~                      ^             ~
drivers/isdn/hisax/w6692.c:627:30: note: use '=' to turn this equality
comparison into an assignment
                if ((cs->dc.w6692.ph_state == W_L1IND_DRD)) {
                                           ^~
                                           =
1 warning generated.

Remove the parentheses to silence this warning.

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/isdn/hisax/w6692.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/isdn/hisax/w6692.c b/drivers/isdn/hisax/w6692.c
index c4be1644f5bb..bb8e4b7e34ea 100644
--- a/drivers/isdn/hisax/w6692.c
+++ b/drivers/isdn/hisax/w6692.c
@@ -624,7 +624,7 @@ W6692_l1hw(struct PStack *st, int pr, void *arg)
 		break;
 	case (HW_RESET | REQUEST):
 		spin_lock_irqsave(&cs->lock, flags);
-		if ((cs->dc.w6692.ph_state == W_L1IND_DRD)) {
+		if (cs->dc.w6692.ph_state == W_L1IND_DRD) {
 			ph_command(cs, W_L1CMD_ECK);
 			spin_unlock_irqrestore(&cs->lock, flags);
 		} else {
-- 
2.19.0

