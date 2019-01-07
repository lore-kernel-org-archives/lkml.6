Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCD1C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7620121736
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866127;
	bh=fpIgt0hHU6M0Wccqr6631+ckn2qql5wD8ytJm1QxQfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZDmKXCtREy2rQVBgDJRkla5b/k2+77mAMyAQ4nyuzI5wzMTck5xdAs+amjQzRBBgk
	 8Q55UPt4ElFkgibK/QQttOtpb6rbeE5FbdotDzjPGgcZ/u4ijjs0i1G0h9M1PwmoTo
	 wiZpHW9QR0VN8dk+dcHDI+D44vArJwJqvN6QhdTM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730737AbfAGNCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:02:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:49478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730706AbfAGNCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:02:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 444552089F;
        Mon,  7 Jan 2019 13:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866123;
        bh=fpIgt0hHU6M0Wccqr6631+ckn2qql5wD8ytJm1QxQfQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tm9WywgIu6GhGCo18tnFUwYwyfT/6b5L8MhN+Tq+U55uhLOAPwOqigAHYjvPskA3X
         jeeeaXcWs+Vn5jswyXHoH274J3yZ6tXI+yFxmuZY18ibxwkkqZ16lKaGsGWthqP3PA
         cbZeTd9PD6aHJpycX4PX2HW52xzrVH68gb8K2tyo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sebastian Ott <sebott@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.14 054/101] s390/pci: fix sleeping in atomic during hotplug
Date:   Mon,  7 Jan 2019 13:32:42 +0100
Message-Id: <20190107105335.887669133@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107105330.372621917@linuxfoundation.org>
References: <20190107105330.372621917@linuxfoundation.org>
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
@@ -437,7 +437,7 @@ int clp_get_state(u32 fid, enum zpci_sta
 	struct clp_state_data sd = {fid, ZPCI_FN_STATE_RESERVED};
 	int rc;
 
-	rrb = clp_alloc_block(GFP_KERNEL);
+	rrb = clp_alloc_block(GFP_ATOMIC);
 	if (!rrb)
 		return -ENOMEM;
 


