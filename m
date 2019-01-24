Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24D3C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCC33218CD
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbfAXSyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 13:54:31 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34432 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbfAXSyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 13:54:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2FBDEBD;
        Thu, 24 Jan 2019 10:54:30 -0800 (PST)
Received: from brain-police.canterbury.ac.nz (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 936703F237;
        Thu, 24 Jan 2019 10:54:29 -0800 (PST)
From:   Will Deacon <will.deacon@arm.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Dave Airlie <airlied@redhat.com>,
        stable@vger.kernel.org, Will Deacon <will.deacon@arm.com>
Subject: [PATCH stable-4.9.y] locking/qspinlock: Pull in asm/byteorder.h to ensure correct endianness
Date:   Thu, 24 Jan 2019 18:54:15 +0000
Message-Id: <20190124185415.29830-1-will.deacon@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Airlie <airlied@redhat.com>

This commit is not required upstream, but is required for the 4.9.y
stable series.

Upstream commit 101110f6271c ("Kbuild: always define endianess in
kconfig.h") ensures that either __LITTLE_ENDIAN or __BIG_ENDIAN is
defined to reflect the endianness of the target CPU architecture
regardless of whether or not <asm/byteorder.h> has been #included. The
upstream definition of 'struct qspinlock' relies on this property.

Unfortunately, the 4.9.y stable series does not provide this guarantee,
so the 'spin_unlock()' routine can erroneously treat the underlying
lockword as big-endian on little-endian architectures using native
qspinlock (i.e. x86_64 without PV) if the caller has not included
<asm/byteorder.h>. This can lead to hangs such as the one in
'i915_gem_request()' reported via bugzilla:

  https://bugzilla.kernel.org/show_bug.cgi?id=202063

Fix the issue by ensuring that <asm/byteorder.h> is #included in
<asm/qspinlock_types.h>, where 'struct qspinlock' is defined.

Cc: <stable@vger.kernel.org> # 4.9
Signed-off-by: Dave Airlie <airlied@redhat.com>
[will: wrote commit message]
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 include/asm-generic/qspinlock_types.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/asm-generic/qspinlock_types.h b/include/asm-generic/qspinlock_types.h
index d10f1e7d6ba8..6503e96710fa 100644
--- a/include/asm-generic/qspinlock_types.h
+++ b/include/asm-generic/qspinlock_types.h
@@ -18,6 +18,8 @@
 #ifndef __ASM_GENERIC_QSPINLOCK_TYPES_H
 #define __ASM_GENERIC_QSPINLOCK_TYPES_H
 
+#include <asm/byteorder.h>
+
 /*
  * Including atomic.h with PARAVIRT on will cause compilation errors because
  * of recursive header file incluson via paravirt_types.h. So don't include
-- 
2.17.1

