Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F116C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D92F420868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="o72pLIlT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D92F420868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbeK3U0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 15:26:08 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:53045 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbeK3UZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 15:25:53 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id wAU9GEae028692;
        Fri, 30 Nov 2018 18:16:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com wAU9GEae028692
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1543569377;
        bh=gzYKmCi7RFLRJbVhrqU0TB39r/78EVYGgl3EJRt3LHA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o72pLIlT3hEsKSyRX4sL507cGrtN4IE8mSFLVIfTcleG3s5VOVof1gKNVqSQNktLG
         n24ORWdy1EUxa1xbG60LGIQeCghPp2/Al8rzDExxTs1sNIAf3pdRE304SPh6KbxO69
         VRaFCg5vDTEDBAfmZUbGvloDkizBIPXGTUXQzfROJlrlyDIks8G0zZa5mJqSTd7oR0
         Jq64CddIkYgWNWLs6SYdsFNAXp2vnEy/636vV96MiM+yAsgrFhI0quBktqFzzXedoD
         /OvPqD+J4YSl7uNPCTXUZQUm0p2ZgjGhGyVtydfiWLCgzVM85DxGDnx1GXReM1hvE2
         7N3K3ET8HYhBQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] kconfig: remove k_invalid from expr_parse_string() return type
Date:   Fri, 30 Nov 2018 18:15:52 +0900
Message-Id: <1543569352-4899-5-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543569352-4899-1-git-send-email-yamada.masahiro@socionext.com>
References: <1543569352-4899-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only possibility of k_invalid being returned was when
expr_parse_sting() parsed S_OTHER type symbol. This actually never
happened, and this is even clearer since S_OTHER has gone.

Clean up unreachable code.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/expr.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/scripts/kconfig/expr.c b/scripts/kconfig/expr.c
index e1a39e9..57ebf71 100644
--- a/scripts/kconfig/expr.c
+++ b/scripts/kconfig/expr.c
@@ -980,7 +980,6 @@ enum string_value_kind {
 	k_string,
 	k_signed,
 	k_unsigned,
-	k_invalid
 };
 
 union string_value {
@@ -1011,13 +1010,10 @@ static enum string_value_kind expr_parse_string(const char *str,
 		val->u = strtoull(str, &tail, 16);
 		kind = k_unsigned;
 		break;
-	case S_STRING:
-	case S_UNKNOWN:
+	default:
 		val->s = strtoll(str, &tail, 0);
 		kind = k_signed;
 		break;
-	default:
-		return k_invalid;
 	}
 	return !errno && !*tail && tail > str && isxdigit(tail[-1])
 	       ? kind : k_string;
@@ -1073,13 +1069,7 @@ tristate expr_calc_value(struct expr *e)
 
 	if (k1 == k_string || k2 == k_string)
 		res = strcmp(str1, str2);
-	else if (k1 == k_invalid || k2 == k_invalid) {
-		if (e->type != E_EQUAL && e->type != E_UNEQUAL) {
-			printf("Cannot compare \"%s\" and \"%s\"\n", str1, str2);
-			return no;
-		}
-		res = strcmp(str1, str2);
-	} else if (k1 == k_unsigned || k2 == k_unsigned)
+	else if (k1 == k_unsigned || k2 == k_unsigned)
 		res = (lval.u > rval.u) - (lval.u < rval.u);
 	else /* if (k1 == k_signed && k2 == k_signed) */
 		res = (lval.s > rval.s) - (lval.s < rval.s);
-- 
2.7.4

