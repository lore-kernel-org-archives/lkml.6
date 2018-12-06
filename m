Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AB3C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47F9020700
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544108204;
	bh=ZUIW6LxHPBXJjvpJtlJFdRcY3wVMHGxrQ/jy+QdcK1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RTiyho3IC91U+mAZMPHo8EwTsHpiJBw/dWaLSE15aPArl5H7kvVuklZPhSXBkwbRd
	 ip4f8aSkGpmewBMGPxtx0m1Be7ZRS+Li8p7rQPZgehMOrO6EUzZoLz3PhlN7fU3jAz
	 Mws8tZe3CtEqLAljZ6BE0HwcDkkiGjPnFQGCy5Vs=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47F9020700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbeLFO4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:56:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:47662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730141AbeLFOnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:43:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A45E20892;
        Thu,  6 Dec 2018 14:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107397;
        bh=ZUIW6LxHPBXJjvpJtlJFdRcY3wVMHGxrQ/jy+QdcK1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X1KvimOKZ15t4nEXfEOAagw0FM1F2PbWxT0Uhi7Hv2fvKkKwLe9jsVasTuxqIQKSC
         4xpmU8c9usUkQlZGPeeLGoUAh3kEQdgVajIfCJhpHmuoyq8Xsy34iggqVOY9qwkQWW
         7X6nVAc7Sa4V9gllCExq7V/yRn/CNz80dtlY/6Gs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH 4.14 46/55] reset: remove remaining WARN_ON() in <linux/reset.h>
Date:   Thu,  6 Dec 2018 15:39:20 +0100
Message-Id: <20181206143004.231275920@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143001.749982936@linuxfoundation.org>
References: <20181206143001.749982936@linuxfoundation.org>
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
@@ -125,9 +125,6 @@ static inline int device_reset_optional(
 static inline struct reset_control *
 __must_check reset_control_get_exclusive(struct device *dev, const char *id)
 {
-#ifndef CONFIG_RESET_CONTROLLER
-	WARN_ON(1);
-#endif
 	return __reset_control_get(dev, id, 0, false, false);
 }
 
@@ -273,9 +270,6 @@ static inline struct reset_control *
 __must_check devm_reset_control_get_exclusive(struct device *dev,
 					      const char *id)
 {
-#ifndef CONFIG_RESET_CONTROLLER
-	WARN_ON(1);
-#endif
 	return __devm_reset_control_get(dev, id, 0, false, false);
 }
 


