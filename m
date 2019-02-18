Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF334C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B17AC21736
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550500966;
	bh=8znYdjD6gaNxBb3jci682vJ2xqQI40ug3LmaCX64P7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ryvgIA+RVbW6poM0+uqn89x0+shI8oyetwr/GmlNhiflC/k1YLdimJUN+MiHbsXfu
	 J4jKw1RTZ95pmIYtQJvrxe4aPhGy1VmEOo2IRCr8+G3cLoOPtZxYr55aKNAwZBZO0c
	 eMPNh/AAgSPI68p1JxTejg6Yd/cRMA0+CNQa/67o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733125AbfBROmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:42:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:57472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732105AbfBRNt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:49:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C23120842;
        Mon, 18 Feb 2019 13:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497797;
        bh=8znYdjD6gaNxBb3jci682vJ2xqQI40ug3LmaCX64P7M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EE1cvEh/P75cRvzM8a6qqV8ABrkBN69VvYgzRqQX4SaR3VShk4jP7SojmqZcoEiOX
         0at4w+MoPrFyHavH/TgK9M1VxncPlk9KIqRHmjQvkFOI/6WL6hbls0RbGjcN8Vi0YE
         VaGSY4YbK3a1UVytXyCaXiKUHr04DGBk8OvuIj9A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Binderman <dcb314@hotmail.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        "David A. Long" <dave.long@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 13/85] ARM: 8810/1: vfp: Fix wrong assignement to ufp_exc
Date:   Mon, 18 Feb 2019 14:42:39 +0100
Message-Id: <20190218133501.136351810@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133459.758004711@linuxfoundation.org>
References: <20190218133459.758004711@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index 2b287d0d6bc2..66c5e693428a 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -578,7 +578,7 @@ int vfp_preserve_user_clear_hwstate(struct user_vfp *ufp,
 	 */
 	ufp_exc->fpexc = hwstate->fpexc;
 	ufp_exc->fpinst = hwstate->fpinst;
-	ufp_exc->fpinst2 = ufp_exc->fpinst2;
+	ufp_exc->fpinst2 = hwstate->fpinst2;
 
 	/* Ensure that VFP is disabled. */
 	vfp_flush_hwstate(thread);
-- 
2.19.1



