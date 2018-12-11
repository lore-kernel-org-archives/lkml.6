Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE345C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0D8620855
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543585;
	bh=1R0kPdxQ+hHjkduxaehpqdU/cbaHqwiuEfqk5QpAe+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WKS/dVryPE5Xp5zc7LHozdAUDnCa+kGX4CEZRs26LowzhJXFIPeUCE3FllvFdJL4C
	 p9wFf2WSN2XBGEitmcyR0eQawgie/rhPnZ1Vst1oBUpDIH8qI5q2ovqtu3DgDMXu6k
	 TdITuZGCTW4SAunMj0jOntU08mqNqPIJ5db1U4IU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0D8620855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729849AbeLKPxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:53:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:41658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729335AbeLKPw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:52:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B51F20855;
        Tue, 11 Dec 2018 15:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543578;
        bh=1R0kPdxQ+hHjkduxaehpqdU/cbaHqwiuEfqk5QpAe+o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RtMAMuVEeYPhipkSCskFX4cK9CFad0ji5Yne2wqtNe/w6uNnEmx3OHp6mR/cjMGjZ
         sYXCuaNjRPLfnmwND1GbMNKYxkT24xQ2fhASiFcoG9EGGcko2XAwAIFtckwZ0eeBhZ
         iWoLI/JxEFc1LHmMfSrMBjN3buRHKAjS4gonqW6A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Subject: [PATCH 4.14 52/67] staging: atomisp: remove "fun" strncpy warning
Date:   Tue, 11 Dec 2018 16:41:52 +0100
Message-Id: <20181211151633.021294573@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151630.378216233@linuxfoundation.org>
References: <20181211151630.378216233@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

[for older kernels only, atomisp has been removed from upstream]

gcc-8 rightfully warns that this instance of strncpy is just copying
from the source, to the same source, for a few bytes.  Meaning this call
does nothing.  As the author of the code obviously meant it to do
something, but this code must be working properly, just replace the call
to the kernel internal strscpy() which gcc doesn't know about, so the
warning goes away.

As this driver was deleted from newer kernel versions, none of this
really matters but now at least we do not have to worry about a build
warning in the stable trees.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/media/atomisp/pci/atomisp2/css2400/runtime/debug/src/ia_css_debug.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/staging/media/atomisp/pci/atomisp2/css2400/runtime/debug/src/ia_css_debug.c
+++ b/drivers/staging/media/atomisp/pci/atomisp2/css2400/runtime/debug/src/ia_css_debug.c
@@ -2860,9 +2860,7 @@ ia_css_debug_pipe_graph_dump_stage(
 			if (l <= ENABLE_LINE_MAX_LENGTH) {
 				/* It fits on one line, copy string and init */
 				/* other helper strings with empty string */
-				strcpy_s(enable_info,
-					sizeof(enable_info),
-					ei);
+				strscpy(enable_info, ei, sizeof(enable_info));
 			} else {
 				/* Too big for one line, find last comma */
 				p = ENABLE_LINE_MAX_LENGTH;


