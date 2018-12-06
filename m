Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC930C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2DEC20892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107635;
	bh=s2xG0Tadx/hz4glOB9bzWyqJz0xTWGrpT/nLk6EuF5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zt6hmleLMeWeYH1DXnlVenexoI8VB3H7Z0Io5d/qCSG8MGeY3JMKDypKef423LP2Z
	 opAPLUP0wTt/hqHw84DDKGWbIF+3g4JA2V83cuLTXJwtKr50A0zfH1fgeAfmTuw8GP
	 yYz2EY8oJNuQi41oZhyZWa76Du89Ba9Vcj+vHzb8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2DEC20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731388AbeLFOrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:47:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:51998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730925AbeLFOrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:47:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2B0A2082B;
        Thu,  6 Dec 2018 14:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107629;
        bh=s2xG0Tadx/hz4glOB9bzWyqJz0xTWGrpT/nLk6EuF5Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nyduSHP+bKWOBTfasOdMCixAAy/GvFhx+DxibjlC3/F+NgvXMa/z+pZfVhlHS3T3R
         kNDjLynmEno/t6fjfjS8kb9l5NOEvIAR28rjgYhyd136k4TNsXMectvqakKQuZK/rf
         w8A81204PISm33z2LChhdtPs4q6ZSW9WSqvhe2J8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH 4.9 043/101] reset: remove remaining WARN_ON() in <linux/reset.h>
Date:   Thu,  6 Dec 2018 15:38:42 +0100
Message-Id: <20181206143013.996684444@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143011.174892052@linuxfoundation.org>
References: <20181206143011.174892052@linuxfoundation.org>
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

From: Masahiro Yamada <yamada.masahiro@socionext.com>

commit bb6c7768385b200063a14d6615cc1246c3d00760 upstream.

Commit bb475230b8e5 ("reset: make optional functions really optional")
gave a new meaning to _get_optional variants.

The differentiation by WARN_ON() is not needed any more.  We already
have inconsistency about this; (devm_)reset_control_get_exclusive()
has WARN_ON() check, but of_reset_control_get_exclusive() does not.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/reset.h |    6 ------
 1 file changed, 6 deletions(-)

--- a/include/linux/reset.h
+++ b/include/linux/reset.h
@@ -107,9 +107,6 @@ static inline int device_reset_optional(
 static inline struct reset_control *
 __must_check reset_control_get_exclusive(struct device *dev, const char *id)
 {
-#ifndef CONFIG_RESET_CONTROLLER
-	WARN_ON(1);
-#endif
 	return __reset_control_get(dev, id, 0, false, false);
 }
 
@@ -255,9 +252,6 @@ static inline struct reset_control *
 __must_check devm_reset_control_get_exclusive(struct device *dev,
 					      const char *id)
 {
-#ifndef CONFIG_RESET_CONTROLLER
-	WARN_ON(1);
-#endif
 	return __devm_reset_control_get(dev, id, 0, false, false);
 }
 


