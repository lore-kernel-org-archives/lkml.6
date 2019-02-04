Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2686C282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9255A2070C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277549;
	bh=/Tpsoo1dn1kLSDv/crzLDSCYdxypQg5CGuIGlDTw6xw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bvUlyvegdufs8gMQseDggHL/KIO36Ax3TCbb5rfuHeQ8N9aleDARUlPuTIsl26TYV
	 5Qla+ALkpOhOAV3tEIcyTU/yqIWYO6kjFmpEWqxQzbG/hr7FnKT6lK2xHx6S+oOGls
	 bWkIWKotsXuZ7ig1I8W5p87x5FfOgh7BH3sx9GkY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732603AbfBDKw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:52:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:50088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732588AbfBDKwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:52:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC70E217D6;
        Mon,  4 Feb 2019 10:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277543;
        bh=/Tpsoo1dn1kLSDv/crzLDSCYdxypQg5CGuIGlDTw6xw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zwIKiBEXFxNDQX8lRqN7pGsAjdcqN3JasKirRxbGP7yBfI3YQ3ugshqHk5wpWGwgI
         oPiXixhcPpUf6sGhDnaG9sIznTCTRBx6MCxkqWOBYOulxk+7QOOxWouDQQefCL/3u5
         fCEv8gXNShde6ErYQAAe9kxRASUTU/mNeYwyzUlc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Morse <james.morse@arm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.20 47/80] arm64: hyp-stub: Forbid kprobing of the hyp-stub
Date:   Mon,  4 Feb 2019 11:37:07 +0100
Message-Id: <20190204103626.738891507@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103620.287366543@linuxfoundation.org>
References: <20190204103620.287366543@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Morse <james.morse@arm.com>

commit 8fac5cbdfe0f01254d9d265c6aa1a95f94f58595 upstream.

The hyp-stub is loaded by the kernel's early startup code at EL2
during boot, before KVM takes ownership later. The hyp-stub's
text is part of the regular kernel text, meaning it can be kprobed.

A breakpoint in the hyp-stub causes the CPU to spin in el2_sync_invalid.

Add it to the __hyp_text.

Signed-off-by: James Morse <james.morse@arm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/kernel/hyp-stub.S |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/arm64/kernel/hyp-stub.S
+++ b/arch/arm64/kernel/hyp-stub.S
@@ -28,6 +28,8 @@
 #include <asm/virt.h>
 
 	.text
+	.pushsection	.hyp.text, "ax"
+
 	.align 11
 
 ENTRY(__hyp_stub_vectors)


