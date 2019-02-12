Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB149C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98D1C222BE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731428AbfBLUqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 15:46:05 -0500
Received: from gateway34.websitewelcome.com ([192.185.149.46]:13351 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727012AbfBLUqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 15:46:05 -0500
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id A869AA0C8B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 14:46:04 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id tewOgLDNc90ontewOgibnb; Tue, 12 Feb 2019 14:46:04 -0600
X-Authority-Reason: nr=8
Received: from [189.250.119.20] (port=55402 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gtewL-003MG7-3X; Tue, 12 Feb 2019 14:46:01 -0600
Date:   Tue, 12 Feb 2019 14:46:00 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] audit: mark expected switch fall-through
Message-ID: <20190212204600.GA24049@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.119.20
X-Source-L: No
X-Exim-ID: 1gtewL-003MG7-3X
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.119.20]:55402
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 17
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warning:

kernel/auditfilter.c: In function ‘audit_krule_to_data’:
kernel/auditfilter.c:668:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
    if (krule->pflags & AUDIT_LOGINUID_LEGACY && !f->val) {
       ^
kernel/auditfilter.c:674:3: note: here
   default:
   ^~~~~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

Notice that, in this particular case, the code comment is modified
in accordance with what GCC is expecting to find.

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 kernel/auditfilter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index add360b46b38..63f8b3f26fab 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -670,7 +670,7 @@ static struct audit_rule_data *audit_krule_to_data(struct audit_krule *krule)
 				data->values[i] = AUDIT_UID_UNSET;
 				break;
 			}
-			/* fallthrough if set */
+			/* fall through - if set */
 		default:
 			data->values[i] = f->val;
 		}
-- 
2.20.1

