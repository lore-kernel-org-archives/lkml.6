Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7426C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78C6E2082D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YITHwAc8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78C6E2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbeKCDqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:46:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:39876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727556AbeKCDqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:46:11 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77B4D2081B;
        Fri,  2 Nov 2018 18:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541183881;
        bh=oLe+FhyKueroUBkOvuSRmUGxNa7HCSzxXGbD5wZYYHo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YITHwAc8yPK6fIyDeZXHVZG2bbOwq87G+aQRpzs9UV1Cvr7NiXDjpXCcdbeLURrUM
         vWLMwWsa++w4g2IyvsfJ/AIo4BpsJGqqyD1zV1bSsqUFXNRXD+7elriynLACxtfvfv
         scL0f/vhfd0RHYdl7n/rHw/uaUeZWhJvtV20DNPY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ivan Vecera <ivecera@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 19/24] Revert "be2net: remove desc field from be_eq_obj"
Date:   Fri,  2 Nov 2018 19:34:52 +0100
Message-Id: <20181102182842.695383897@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182839.725385066@linuxfoundation.org>
References: <20181102182839.725385066@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ivan Vecera <ivecera@redhat.com>

[ Upstream commit 5ef79151c2fbc401cf38325e9a32e77b9fc593ae ]

The mentioned commit needs to be reverted because we cannot pass
string allocated on stack to request_irq(). This function stores
uses this pointer for later use (e.g. /proc/interrupts) so we need
to keep this string persistently.

Fixes: d6d9704af8f4 ("be2net: remove desc field from be_eq_obj")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/emulex/benet/be.h      |    1 +
 drivers/net/ethernet/emulex/benet/be_main.c |    6 ++----
 2 files changed, 3 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/emulex/benet/be.h
+++ b/drivers/net/ethernet/emulex/benet/be.h
@@ -185,6 +185,7 @@ static inline void queue_tail_inc(struct
 
 struct be_eq_obj {
 	struct be_queue_info q;
+	char desc[32];
 
 	struct be_adapter *adapter;
 	struct napi_struct napi;
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -3488,11 +3488,9 @@ static int be_msix_register(struct be_ad
 	int status, i, vec;
 
 	for_all_evt_queues(adapter, eqo, i) {
-		char irq_name[IFNAMSIZ+4];
-
-		snprintf(irq_name, sizeof(irq_name), "%s-q%d", netdev->name, i);
+		sprintf(eqo->desc, "%s-q%d", netdev->name, i);
 		vec = be_msix_vec_get(adapter, eqo);
-		status = request_irq(vec, be_msix, 0, irq_name, eqo);
+		status = request_irq(vec, be_msix, 0, eqo->desc, eqo);
 		if (status)
 			goto err_msix;
 


