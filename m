Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C76C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10BAA2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:47:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10BAA2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbeLJRr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:47:27 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59822 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729044AbeLJRrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:47:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC7F21682;
        Mon, 10 Dec 2018 09:47:16 -0800 (PST)
Received: from filthy-habits.cambridge.arm.com (filthy-habits.cambridge.arm.com [10.1.196.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2FD523F6A8;
        Mon, 10 Dec 2018 09:47:16 -0800 (PST)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>
Subject: [RESEND PATCH 2/2] scripts/decode_stacktrace: Only strip base path when a prefix of the path
Date:   Mon, 10 Dec 2018 17:46:59 +0000
Message-Id: <20181210174659.31054-3-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181210174659.31054-1-marc.zyngier@arm.com>
References: <20181210174659.31054-1-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running something like:

	decodecode vmlinux .

leads to interested results where not only the leading "." gets stripped
from the displayed paths, but also anywhere in the string, displaying
something like:

	kvm_vcpu_check_block (arch/arm64/kvm/virt/kvm/kvm_mainc:2141)

which doesn't help further processing.

Fix it by only stripping the base path if it is a prefix of the path.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 scripts/decode_stacktrace.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
index 64220e36ce3b..98a7d63a723e 100755
--- a/scripts/decode_stacktrace.sh
+++ b/scripts/decode_stacktrace.sh
@@ -78,7 +78,7 @@ parse_symbol() {
 	fi
 
 	# Strip out the base of the path
-	code=${code//$basepath/""}
+	code=${code//^$basepath/""}
 
 	# In the case of inlines, move everything to same line
 	code=${code//$'\n'/' '}
-- 
2.19.1

