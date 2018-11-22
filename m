Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FDBC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 12:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E43B204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 12:15:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E43B204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436617AbeKVWyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 17:54:00 -0500
Received: from foss.arm.com ([217.140.101.70]:46940 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436603AbeKVWx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 17:53:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36AC536B4;
        Thu, 22 Nov 2018 04:14:51 -0800 (PST)
Received: from filthy-habits.cambridge.arm.com (filthy-habits.cambridge.arm.com [10.1.196.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D3CE3F5A0;
        Thu, 22 Nov 2018 04:14:50 -0800 (PST)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>
Subject: [PATCH 1/2] scripts/decodecode: Set ARCH when running natively on arm/arm64
Date:   Thu, 22 Nov 2018 12:14:39 +0000
Message-Id: <20181122121440.74913-2-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181122121440.74913-1-marc.zyngier@arm.com>
References: <20181122121440.74913-1-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running decodecode natively on arm64, ARCH is likely not to be set,
and we end-up with .4byte instead of .inst when generating the disassembly.

Similar effects would occur if running natively on a 32bit ARM platform,
although that's even less popular.

A simple workaround is to populate ARCH when it is not set and that we're
running on an arm/arm64 system.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 scripts/decodecode | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/scripts/decodecode b/scripts/decodecode
index 9cef558528aa..ba8b8d5834e6 100755
--- a/scripts/decodecode
+++ b/scripts/decodecode
@@ -60,6 +60,13 @@ case $width in
 4) type=4byte ;;
 esac
 
+if [ -z "$ARCH" ]; then
+    case `uname -m` in
+	aarch64*) ARCH=arm64 ;;
+	arm*) ARCH=arm ;;
+    esac
+fi
+
 disas() {
 	${CROSS_COMPILE}as $AFLAGS -o $1.o $1.s > /dev/null 2>&1
 
-- 
2.19.1

