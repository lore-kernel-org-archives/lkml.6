Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73835C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 411B320651
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865512;
	bh=6xg1s6sYAH1bs0N7B+CgWIhPe5hyz1uG3TsOhWvwZk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bNx/maVrLocEE4BtYCfQVVbNWP+FOm12d9nqFPtAO5fwR1BY8DAhCGmGbJb/lwrOp
	 XffTpGZPH9Qu2+fBdTcLN3Lr3yW9pWB6QCvZY/ssxptaSGZM777ANarjY4xXSluuWv
	 /vn50LAXo8yxXLXLos0ZO8CYr5O+54tDwhpTUSvM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729505AbfAGMvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:51:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:41714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728506AbfAGMvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:51:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5E0420651;
        Mon,  7 Jan 2019 12:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865507;
        bh=6xg1s6sYAH1bs0N7B+CgWIhPe5hyz1uG3TsOhWvwZk8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DRQpbC4Ih2j1Kq8ynzY1qlihIzkTYcGAoMatBzrKu9k4R2Zcg/PYsMJYM9+i2Htst
         ULrOX/ue5IPzN6u1xpgLW3e1TBKwGssoaXPyftQr9RzlzjUctg1UM1xolYoRDY23ft
         /ii8jzfqzv2g7SGwYcbYrQAt7OV5C3M9we3hBK0U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sebastian Ott <sebott@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.19 087/170] s390/pci: fix sleeping in atomic during hotplug
Date:   Mon,  7 Jan 2019 13:31:54 +0100
Message-Id: <20190107104503.296009545@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
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

From: Sebastian Ott <sebott@linux.ibm.com>

commit 98dfd32620e970eb576ebce5ea39d905cb005e72 upstream.

When triggered by pci hotplug (PEC 0x306) clp_get_state is called
with spinlocks held resulting in the following warning:

zpci: n/a: Event 0x306 reconfigured PCI function 0x0
BUG: sleeping function called from invalid context at mm/page_alloc.c:4324
in_atomic(): 1, irqs_disabled(): 0, pid: 98, name: kmcheck
2 locks held by kmcheck/98:

Change the allocation to use GFP_ATOMIC.

Cc: stable@vger.kernel.org # 4.13+
Signed-off-by: Sebastian Ott <sebott@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/pci/pci_clp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/s390/pci/pci_clp.c
+++ b/arch/s390/pci/pci_clp.c
@@ -436,7 +436,7 @@ int clp_get_state(u32 fid, enum zpci_sta
 	struct clp_state_data sd = {fid, ZPCI_FN_STATE_RESERVED};
 	int rc;
 
-	rrb = clp_alloc_block(GFP_KERNEL);
+	rrb = clp_alloc_block(GFP_ATOMIC);
 	if (!rrb)
 		return -ENOMEM;
 


