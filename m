Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39B4C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 734AE218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358236;
	bh=fYitXcVpVGKVuGrYeTnAWqgCHhahTJoFZ5LTFudv4gs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=djFwwLWdibraGXg/BG6n6/0DE6TqbiOXLLWHhdo6jzkgWnaTbLGfOu7QM/CzQDmQt
	 KZGLb81NCWgHk9okOaJH9lSzwYMG1JZ+wlq9nxAYkgeg4OBVToVI6IMX11ttpNweJy
	 Fk8jf5nZ8z1Dk8urtTo6+i6ojP/Du021C5CqclGc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731430AbfAXTad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:30:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:58050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730703AbfAXTaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:30:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16558218E2;
        Thu, 24 Jan 2019 19:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358229;
        bh=fYitXcVpVGKVuGrYeTnAWqgCHhahTJoFZ5LTFudv4gs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yKPG9wPqbM+VFqFxyDi/IvZjELC12NijGtLnpAhBAdQwXAhraTdpZ9UCJzM59sU3H
         q2r4ifZWKcTALuGOQ8SYQzy8yn1IyY6mfkR5N//WWeuFlm80vDklCLpbH8TTm/Nuzz
         Vc4jLVhCqt+ZKQAed7WBTtHtIgfBpA/5eduyI6Kc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Airlie <airlied@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.9 39/39] locking/qspinlock: Pull in asm/byteorder.h to ensure correct endianness
Date:   Thu, 24 Jan 2019 20:20:42 +0100
Message-Id: <20190124190449.768201183@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190448.232316246@linuxfoundation.org>
References: <20190124190448.232316246@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/asm-generic/qspinlock_types.h |    2 ++
 1 file changed, 2 insertions(+)

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


