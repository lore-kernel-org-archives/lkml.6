Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BF5C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 11:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEFB12173B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 11:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="vQE5LbfJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbfADLSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 06:18:40 -0500
Received: from forwardcorp1g.cmail.yandex.net ([87.250.241.190]:48548 "EHLO
        forwardcorp1g.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727651AbfADLSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 06:18:39 -0500
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1g.cmail.yandex.net (Yandex) with ESMTP id C0CDE20EEA;
        Fri,  4 Jan 2019 14:18:36 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:10])
        by mxbackcorp1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 145WAE3PUy-IaMmxr8R;
        Fri, 04 Jan 2019 14:18:36 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1546600716; bh=7/OYKbl7jIHC4n1PbBuVzkuw772hxgHC3hVQ806mOoY=;
        h=Subject:From:To:Date:Message-ID;
        b=vQE5LbfJMLVQuoVsYzzu6QDFL5lpea0vgUHIwRtZ9HuONo2JPH1rMnipPNYqyD1WT
         VFLZh40HXF0fFOwfLoRWOmr/84a2voRTbHytKNhwJXhD3dARYZHwcN+Dfrk3tIzkc7
         6hGiTmZaUYMmuRBNpsIxYYgtKBc63Ile/IybxQhU=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-iva.dhcp.yndx.net (dynamic-iva.dhcp.yndx.net [2a02:6b8:b010:d002::1:46])
        by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id Latw1W4VQY-IakWFRrq;
        Fri, 04 Jan 2019 14:18:36 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH] scripts/decode_stacktrace.sh: handle RIP address with
 segment
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Date:   Fri, 04 Jan 2019 14:18:32 +0300
Message-ID: <154660071227.52726.15645307951282727605.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

decode line:

RIP: 0010:khugepaged+0x2a2/0x2280

into

RIP: 0010:khugepaged (mm/khugepaged.c:1885)

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 scripts/decode_stacktrace.sh |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
index 98a7d63a723e..bcdd45df3f51 100755
--- a/scripts/decode_stacktrace.sh
+++ b/scripts/decode_stacktrace.sh
@@ -37,6 +37,13 @@ parse_symbol() {
 	symbol=${symbol#\(}
 	symbol=${symbol%\)}
 
+	# Strip segment
+	local segment
+	if [[ $symbol == *:* ]] ; then
+		segment=${symbol%%:*}:
+		symbol=${symbol#*:}
+	fi
+
 	# Strip the symbol name so that we could look it up
 	local name=${symbol%+*}
 
@@ -84,7 +91,7 @@ parse_symbol() {
 	code=${code//$'\n'/' '}
 
 	# Replace old address with pretty line numbers
-	symbol="$name ($code)"
+	symbol="$segment$name ($code)"
 }
 
 decode_code() {

