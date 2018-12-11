Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A063BC67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55C9D20811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:26:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55C9D20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbeLKT06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 14:26:58 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55976 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbeLKT0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 14:26:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3878215AB;
        Tue, 11 Dec 2018 11:26:54 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 292D53F6A8;
        Tue, 11 Dec 2018 11:26:53 -0800 (PST)
From:   Dave Martin <Dave.Martin@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Alan Hayward <alan.hayward@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>
Subject: [PATCH 1/3] kbuild: install_headers.sh: Strip _UAPI from #if-defined() guards
Date:   Tue, 11 Dec 2018 19:26:45 +0000
Message-Id: <1544556407-19897-2-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1544556407-19897-1-git-send-email-Dave.Martin@arm.com>
References: <1544556407-19897-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

install_headers.sh knows how to strip the _UAPI prefix from #ifdef/
ifndef and #define directives used to guard headers against multiple
or inappropriate inclusion.  Currently this does not work for guards
in the "#if defined()" style, which may be needed for non-trivial
cases.

This patch adds similar logic so that the _UAPI prefix is also
stripped from guard directives written using "#if defined()" etc.

This is not completely foolproof, but will work for simple cases of
using #if defined() to guard against inappropriate header inclusion.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 scripts/headers_install.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/headers_install.sh b/scripts/headers_install.sh
index 593f8879..fe1d3fc 100755
--- a/scripts/headers_install.sh
+++ b/scripts/headers_install.sh
@@ -38,6 +38,7 @@ do
 		-e 's/(^|[^a-zA-Z0-9])__packed([^a-zA-Z0-9_]|$)/\1__attribute__((packed))\2/g' \
 		-e 's/(^|[[:space:](])(inline|asm|volatile)([[:space:](]|$)/\1__\2__\3/g' \
 		-e 's@#(ifndef|define|endif[[:space:]]*/[*])[[:space:]]*_UAPI@#\1 @' \
+		-e ':1;s/(#(if|elif)(.*[^A-Za-z0-9_])defined\([[:space:]]*)_UAPI/\1/;t1' \
 		"$SRCDIR/$i" > "$OUTDIR/$FILE.sed" || exit 1
 	scripts/unifdef -U__KERNEL__ -D__EXPORTED_HEADERS__ "$OUTDIR/$FILE.sed" \
 		> "$OUTDIR/$FILE"
-- 
2.1.4

