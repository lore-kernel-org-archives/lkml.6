Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8AEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D07B21904
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550497801;
	bh=z1sjry4wuJhJDFxhjAkCh9RiJaYvdeo+5Bce46/wY2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BlXeVyzFLAM2ZZjLtk8xT0EjNDvtcjxwUxomg3Ohi6jbxkoTGzfUOwPbGhecnfkft
	 vQ7SkEdy2jLl0Xzdp97rwyo8l4CB+KAHc5WEoShf4LyQT0E1LO33OMbBkROU5cvkmf
	 vWUVn3rbmtyo/ReSpEcReQW0a77I2q1pvPNUELEM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732134AbfBRNt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:49:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:57404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731494AbfBRNtz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:49:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E01B21A4A;
        Mon, 18 Feb 2019 13:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497795;
        bh=z1sjry4wuJhJDFxhjAkCh9RiJaYvdeo+5Bce46/wY2o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iAQPfBJfzQNzgUPYA+rcpi9V1RAzx8ptJ6PM+yBmYcQouqOUq9jEfuNBulwn31plv
         vpp/ng/b4aycoINmq/lDFdii71bdWCCt9eWH47Dp4PAJfG00Um+4d/ROJ49MQQIH9N
         5rIp3gVPEKjrRecePmAN1MvwXt5pQ/FD1icclZQE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julien Thierry <julien.thierry@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        "David A. Long" <dave.long@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 12/85] ARM: 8797/1: spectre-v1.1: harden __copy_to_user
Date:   Mon, 18 Feb 2019 14:42:38 +0100
Message-Id: <20190218133501.046091285@linuxfoundation.org>
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

Commit a1d09e074250fad24f1b993f327b18cc6812eb7a upstream.

Sanitize user pointer given to __copy_to_user, both for standard version
and memcopy version of the user accessor.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David A. Long <dave.long@linaro.org>
Reviewed-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/lib/copy_to_user.S        | 6 +++++-
 arch/arm/lib/uaccess_with_memcpy.c | 3 ++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/lib/copy_to_user.S b/arch/arm/lib/copy_to_user.S
index caf5019d8161..970abe521197 100644
--- a/arch/arm/lib/copy_to_user.S
+++ b/arch/arm/lib/copy_to_user.S
@@ -94,6 +94,11 @@
 
 ENTRY(__copy_to_user_std)
 WEAK(arm_copy_to_user)
+#ifdef CONFIG_CPU_SPECTRE
+	get_thread_info r3
+	ldr	r3, [r3, #TI_ADDR_LIMIT]
+	uaccess_mask_range_ptr r0, r2, r3, ip
+#endif
 
 #include "copy_template.S"
 
@@ -108,4 +113,3 @@ ENDPROC(__copy_to_user_std)
 	rsb	r0, r0, r2
 	copy_abort_end
 	.popsection
-
diff --git a/arch/arm/lib/uaccess_with_memcpy.c b/arch/arm/lib/uaccess_with_memcpy.c
index 9b4ed1728616..73dc7360cbdd 100644
--- a/arch/arm/lib/uaccess_with_memcpy.c
+++ b/arch/arm/lib/uaccess_with_memcpy.c
@@ -152,7 +152,8 @@ arm_copy_to_user(void __user *to, const void *from, unsigned long n)
 		n = __copy_to_user_std(to, from, n);
 		uaccess_restore(ua_flags);
 	} else {
-		n = __copy_to_user_memcpy(to, from, n);
+		n = __copy_to_user_memcpy(uaccess_mask_range_ptr(to, n),
+					  from, n);
 	}
 	return n;
 }
-- 
2.19.1



