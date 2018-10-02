Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9298DC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 522A9206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:31:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 522A9206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731001AbeJBUOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:14:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34110 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730036AbeJBUOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:14:47 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 02C0CBF0;
        Tue,  2 Oct 2018 13:31:24 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ganesh Goudar <ganeshgr@chelsio.com>,
        Atul Gupta <atul.gupta@chelsio.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 209/228] crypto: chtls - fix null dereference chtls_free_uld()
Date:   Tue,  2 Oct 2018 06:25:06 -0700
Message-Id: <20181002132511.892106140@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ganesh Goudar <ganeshgr@chelsio.com>

[ Upstream commit 65b2c12dcdb883fc015c0ec65d6c2f857e0456ac ]

call chtls_free_uld() only for the initialized cdev,
this fixes NULL dereference in chtls_free_uld()

Signed-off-by: Ganesh Goudar <ganeshgr@chelsio.com>
Signed-off-by: Atul Gupta <atul.gupta@chelsio.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/chelsio/chtls/chtls.h      |    5 +++++
 drivers/crypto/chelsio/chtls/chtls_main.c |    7 +++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

--- a/drivers/crypto/chelsio/chtls/chtls.h
+++ b/drivers/crypto/chelsio/chtls/chtls.h
@@ -96,6 +96,10 @@ enum csk_flags {
 	CSK_CONN_INLINE,	/* Connection on HW */
 };
 
+enum chtls_cdev_state {
+	CHTLS_CDEV_STATE_UP = 1
+};
+
 struct listen_ctx {
 	struct sock *lsk;
 	struct chtls_dev *cdev;
@@ -146,6 +150,7 @@ struct chtls_dev {
 	unsigned int send_page_order;
 	int max_host_sndbuf;
 	struct key_map kmap;
+	unsigned int cdev_state;
 };
 
 struct chtls_hws {
--- a/drivers/crypto/chelsio/chtls/chtls_main.c
+++ b/drivers/crypto/chelsio/chtls/chtls_main.c
@@ -160,6 +160,7 @@ static void chtls_register_dev(struct ch
 	tlsdev->hash = chtls_create_hash;
 	tlsdev->unhash = chtls_destroy_hash;
 	tls_register_device(&cdev->tlsdev);
+	cdev->cdev_state = CHTLS_CDEV_STATE_UP;
 }
 
 static void chtls_unregister_dev(struct chtls_dev *cdev)
@@ -281,8 +282,10 @@ static void chtls_free_all_uld(void)
 	struct chtls_dev *cdev, *tmp;
 
 	mutex_lock(&cdev_mutex);
-	list_for_each_entry_safe(cdev, tmp, &cdev_list, list)
-		chtls_free_uld(cdev);
+	list_for_each_entry_safe(cdev, tmp, &cdev_list, list) {
+		if (cdev->cdev_state == CHTLS_CDEV_STATE_UP)
+			chtls_free_uld(cdev);
+	}
 	mutex_unlock(&cdev_mutex);
 }
 


