Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A680FC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DEC82146D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107627;
	bh=7UWI9SoqjIHTtpzFJE05QxL7RkyIwcWNJjxKkM4CCOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PwBlGqMTfXKYGiF0HLfYBdjw2uq6YQ5cEK5qrbOfvtVIMpmahUFc/e0M/n9QxBZGx
	 kvpoRsO2MOqLMTdhDExCiYSSHvKcw9GsQN825zDEEHFpVUDuPg6VUAcRxv/knpn9PQ
	 X20GXz1H9/IzKfLE21AwxZUC60T3xBs7DvhbeFdk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DEC82146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730400AbeLFOrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:47:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:51832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730284AbeLFOrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:47:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 421EF21479;
        Thu,  6 Dec 2018 14:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107621;
        bh=7UWI9SoqjIHTtpzFJE05QxL7RkyIwcWNJjxKkM4CCOI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hvhq44mZp7441CLLJzZrZu9p+rhsqSqt9la5dcqra+TpV6cg79T1LGOFbS9fkh0n4
         44jEu5t/u4IWtTVdoPOezViVAttkWLqA2YaYU6sVUsMunWMGDQlh0xJY0neCbi7Emy
         xyvDq+0tPlzLwMOXS3RyhHP+hScxWs7l9yZ6KDxc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>,
        Ramiro Oliveira <Ramiro.Oliveira@synopsys.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH 4.9 040/101] reset: fix optional reset_control_get stubs to return NULL
Date:   Thu,  6 Dec 2018 15:38:39 +0100
Message-Id: <20181206143013.834024019@linuxfoundation.org>
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

From: Philipp Zabel <p.zabel@pengutronix.de>

commit 0ca10b60ceeb5372da01798ca68c116ae45a6eb6 upstream.

When RESET_CONTROLLER is not enabled, the optional reset_control_get
stubs should now also return NULL.

Since it is now valid for reset_control_assert/deassert/reset/status/put
to be called unconditionally, with NULL as an argument for optional
resets, the stubs are not allowed to warn anymore.

Fixes: bb475230b8e5 ("reset: make optional functions really optional")
Reported-by: Andrzej Hajda <a.hajda@samsung.com>
Tested-by: Andrzej Hajda <a.hajda@samsung.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Cc: Ramiro Oliveira <Ramiro.Oliveira@synopsys.com>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/reset.h |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

--- a/include/linux/reset.h
+++ b/include/linux/reset.h
@@ -31,31 +31,26 @@ static inline int device_reset_optional(
 
 static inline int reset_control_reset(struct reset_control *rstc)
 {
-	WARN_ON(1);
 	return 0;
 }
 
 static inline int reset_control_assert(struct reset_control *rstc)
 {
-	WARN_ON(1);
 	return 0;
 }
 
 static inline int reset_control_deassert(struct reset_control *rstc)
 {
-	WARN_ON(1);
 	return 0;
 }
 
 static inline int reset_control_status(struct reset_control *rstc)
 {
-	WARN_ON(1);
 	return 0;
 }
 
 static inline void reset_control_put(struct reset_control *rstc)
 {
-	WARN_ON(1);
 }
 
 static inline int __must_check device_reset(struct device *dev)
@@ -74,14 +69,14 @@ static inline struct reset_control *__of
 					const char *id, int index, bool shared,
 					bool optional)
 {
-	return ERR_PTR(-ENOTSUPP);
+	return optional ? NULL : ERR_PTR(-ENOTSUPP);
 }
 
 static inline struct reset_control *__devm_reset_control_get(
 					struct device *dev, const char *id,
 					int index, bool shared, bool optional)
 {
-	return ERR_PTR(-ENOTSUPP);
+	return optional ? NULL : ERR_PTR(-ENOTSUPP);
 }
 
 #endif /* CONFIG_RESET_CONTROLLER */


