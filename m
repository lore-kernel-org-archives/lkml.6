Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35F4C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C8F42147C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2exSSB1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C8F42147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388081AbeK3BeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:34:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:34942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733011AbeK3BeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:34:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C193921479;
        Thu, 29 Nov 2018 14:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501707;
        bh=M7s1uxl/NrpZkeKVL71UROH2AsK+TJqNW14MKoCxWQk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V2exSSB1g75sUxmH970cGJ41kmOhNmTe3nL+CXb3yE/w7xBZjcTkv1Mvw/xl0Z9NX
         n8eF4FZgO5BCgj8XIE9oKQyT9fyGOUlyLyegZu6wNOnGqEL46N76KZLNc2ewEWts4e
         VaLWtIwWOcsQsGjXTPHfSIfG0eKE6dpVRE6Rm2os=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.14 083/100] i40iw: Fix memory leak in error path of create QP
Date:   Thu, 29 Nov 2018 15:12:53 +0100
Message-Id: <20181129140105.959505095@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140058.768942700@linuxfoundation.org>
References: <20181129140058.768942700@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mustafa Ismail <mustafa.ismail@intel.com>

commit 5a7189d529cd146cd5838af97b32fcac4122b471 upstream.

If i40iw_allocate_dma_mem fails when creating a QP, the
memory allocated for the QP structure using kzalloc is not
freed because iwqp->allocated_buffer is used to free the
memory and it is not setup until later. Fix this by setting
iwqp->allocated_buffer before allocating the dma memory.

Fixes: d37498417947 ("i40iw: add files for iwarp interface")
Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/i40iw/i40iw_verbs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -631,6 +631,7 @@ static struct ib_qp *i40iw_create_qp(str
 		return ERR_PTR(-ENOMEM);
 
 	iwqp = (struct i40iw_qp *)mem;
+	iwqp->allocated_buffer = mem;
 	qp = &iwqp->sc_qp;
 	qp->back_qp = (void *)iwqp;
 	qp->push_idx = I40IW_INVALID_PUSH_PAGE_INDEX;
@@ -659,7 +660,6 @@ static struct ib_qp *i40iw_create_qp(str
 		goto error;
 	}
 
-	iwqp->allocated_buffer = mem;
 	iwqp->iwdev = iwdev;
 	iwqp->iwpd = iwpd;
 	iwqp->ibqp.qp_num = qp_num;


