Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C95C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA96020842
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550497831;
	bh=euZNLnY4G35TAFMnBvKgbMNcGEgw2I2FVvdGNvPtW50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sEmfZruuLPrsN90MBaQCEk1GOD1o8kyBGih+5FYDtiNnFqgLYNDD+IuCJ7XfRp55I
	 L13DeOyvvR0nKgx7NVXNWWfDc6gt1qwtM2UdGOBX0QTzqLitiOTM4CLYrA9JFS9z3y
	 R6ib95oZiBve22m/sN6j42kKbXEqCpppnK8HSv64=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730117AbfBRNub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:50:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:58102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730904AbfBRNu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:50:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFD7920842;
        Mon, 18 Feb 2019 13:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497826;
        bh=euZNLnY4G35TAFMnBvKgbMNcGEgw2I2FVvdGNvPtW50=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u8o3B7kWEKSpAYrTOMk74VALWD+Qk36EgRGS4RLn4+gdtus2ZvQrLHzV6o/6L7IQH
         FBe1eRXeDfioburXx55jwLtXSavbcGTRP71ICZwHhkoKNoeNPvcOBgw2pUoF6uiAcL
         KPMBElC5nYzjQX5qUg4AhHwgBEz3MuNnoNk3KL4g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julien Thierry <julien.thierry@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        "David A. Long" <dave.long@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 05/85] ARM: 8790/1: signal: always use __copy_to_user to save iwmmxt context
Date:   Mon, 18 Feb 2019 14:42:31 +0100
Message-Id: <20190218133500.359396486@linuxfoundation.org>
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

Commit 73839798af7ebc6c8d0c9271ebbbc148700e521f upstream.

When setting a dummy iwmmxt context, create a local instance and
use __copy_to_user both cases whether iwmmxt is being used or not.
This has the benefit of disabling/enabling PAN once for the whole copy
intead of once per write.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David A. Long <dave.long@linaro.org>
Reviewed-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/kernel/signal.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index 76fe75d36312..464393d241e1 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -77,8 +77,6 @@ static int preserve_iwmmxt_context(struct iwmmxt_sigframe __user *frame)
 		kframe->magic = IWMMXT_MAGIC;
 		kframe->size = IWMMXT_STORAGE_SIZE;
 		iwmmxt_task_copy(current_thread_info(), &kframe->storage);
-
-		err = __copy_to_user(frame, kframe, sizeof(*frame));
 	} else {
 		/*
 		 * For bug-compatibility with older kernels, some space
@@ -86,10 +84,14 @@ static int preserve_iwmmxt_context(struct iwmmxt_sigframe __user *frame)
 		 * Set the magic and size appropriately so that properly
 		 * written userspace can skip it reliably:
 		 */
-		__put_user_error(DUMMY_MAGIC, &frame->magic, err);
-		__put_user_error(IWMMXT_STORAGE_SIZE, &frame->size, err);
+		*kframe = (struct iwmmxt_sigframe) {
+			.magic = DUMMY_MAGIC,
+			.size  = IWMMXT_STORAGE_SIZE,
+		};
 	}
 
+	err = __copy_to_user(frame, kframe, sizeof(*kframe));
+
 	return err;
 }
 
-- 
2.19.1



