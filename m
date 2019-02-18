Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0709BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCE4420842
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498067;
	bh=CiJjSjLZ0k2upHtqjVBs6SwsOM1wQho2ho0/6xV+1dc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QTruTS/jPKi8dnDopMoDlA/RYVfarTIjqvvi7IC/yQ2DxE/4AftiErakD4ldN80in
	 6Pum3WbfeAv4FQToswuKznBQb3pSkGd1HqLDHbEKtdScXjhy+CeXVPWNO4IAI9f2TB
	 9jSShrcE5KjO9miSBkCuR+AQ7cgcF73QVmfFap8w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733189AbfBRNy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:54:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:34226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733151AbfBRNyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:54:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 377CA20842;
        Mon, 18 Feb 2019 13:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498058;
        bh=CiJjSjLZ0k2upHtqjVBs6SwsOM1wQho2ho0/6xV+1dc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1+LhP6FK3Wf8pcTHC0S3ozGlC6L63UyTEfQ1FzdlDhyKb95zQmPGa7cpgM88vW93M
         Z+aVDbkMKfjVAM3+YA7Nl9IzkeT2biFDL1IFym9ZW2O+OO1XQaRHpHWRekw585qEqo
         hEIRpZn3Oaa030wxAcqjJL9HOYvwjfpxtj1Ujktc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julien Thierry <julien.thierry@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        "David A. Long" <dave.long@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 10/62] ARM: 8794/1: uaccess: Prevent speculative use of the current addr_limit
Date:   Mon, 18 Feb 2019 14:43:16 +0100
Message-Id: <20190218133506.710093576@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133505.801423074@linuxfoundation.org>
References: <20190218133505.801423074@linuxfoundation.org>
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

Commit 621afc677465db231662ed126ae1f355bf8eac47 upstream.

A mispredicted conditional call to set_fs could result in the wrong
addr_limit being forwarded under speculation to a subsequent access_ok
check, potentially forming part of a spectre-v1 attack using uaccess
routines.

This patch prevents this forwarding from taking place, but putting heavy
barriers in set_fs after writing the addr_limit.

Porting commit c2f0ad4fc089cff8 ("arm64: uaccess: Prevent speculative use
of the current addr_limit").

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David A. Long <dave.long@linaro.org>
Reviewed-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/include/asm/uaccess.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
index 4140be431087..7d19584f5c39 100644
--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -69,6 +69,14 @@ extern int __put_user_bad(void);
 static inline void set_fs(mm_segment_t fs)
 {
 	current_thread_info()->addr_limit = fs;
+
+	/*
+	 * Prevent a mispredicted conditional call to set_fs from forwarding
+	 * the wrong address limit to access_ok under speculation.
+	 */
+	dsb(nsh);
+	isb();
+
 	modify_domain(DOMAIN_KERNEL, fs ? DOMAIN_CLIENT : DOMAIN_MANAGER);
 }
 
-- 
2.19.1



