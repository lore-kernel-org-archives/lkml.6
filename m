Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A86AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BCA32077B
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498265;
	bh=7I3d22eDGavfk/iiSDx3w/rr7gZ0BpGHVQ8kyKgqNrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Sq/wB7fjCyr6fTqrXAuPp+o+qOfeo0tZB4fKGYxwT0uNFuwReMwJ3qq+2RM677GS1
	 gFyMLK8a0uxbWQxTgxDM7UFND/z7ZOawIuSqSCMEH/CgkNANlA6UWzfhn3n9niFCH/
	 45BrrACfg92xSB3j6JNOR44MFT2d5X6q3kTIrZIM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388143AbfBRN5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:57:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:38188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733173AbfBRN5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:57:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F28AD2077B;
        Mon, 18 Feb 2019 13:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498260;
        bh=7I3d22eDGavfk/iiSDx3w/rr7gZ0BpGHVQ8kyKgqNrU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mMNDI2Wze/+6SgI1QIP31KxuWNOugLP7HkSIryZIFPaeUiHHQ/C921Du7xwTUH7cK
         iTWAB9GPyml3XkoNf3lb6Boh2pH//Kt49ti/zh9a3V6L2XVZce2tBrwVfgXXnrbFen
         7d5mvtgHVBasL8x/7yonYN+gUk9hL/Q4sn9KJcrI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Binderman <dcb314@hotmail.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        "David A. Long" <dave.long@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 12/58] ARM: 8810/1: vfp: Fix wrong assignement to ufp_exc
Date:   Mon, 18 Feb 2019 14:43:33 +0100
Message-Id: <20190218133509.522680760@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133508.567416115@linuxfoundation.org>
References: <20190218133508.567416115@linuxfoundation.org>
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

Commit 5df7a99bdd0de4a0480320264c44c04543c29d5a upstream.

In vfp_preserve_user_clear_hwstate, ufp_exc->fpinst2 gets assigned to
itself. It should actually be hwstate->fpinst2 that gets assigned to the
ufp_exc field.

Fixes commit 3aa2df6ec2ca6bc143a65351cca4266d03a8bc41 ("ARM: 8791/1:
vfp: use __copy_to_user() when saving VFP state").

Reported-by: David Binderman <dcb314@hotmail.com>
Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David A. Long <dave.long@linaro.org>
Reviewed-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/vfp/vfpmodule.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index df3fa52c0aa3..00dd8cf36632 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -579,7 +579,7 @@ int vfp_preserve_user_clear_hwstate(struct user_vfp *ufp,
 	 */
 	ufp_exc->fpexc = hwstate->fpexc;
 	ufp_exc->fpinst = hwstate->fpinst;
-	ufp_exc->fpinst2 = ufp_exc->fpinst2;
+	ufp_exc->fpinst2 = hwstate->fpinst2;
 
 	/* Ensure that VFP is disabled. */
 	vfp_flush_hwstate(thread);
-- 
2.19.1



