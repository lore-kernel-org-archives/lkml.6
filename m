Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18DFFC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCFC8214C2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ep3COYZO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCFC8214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731974AbeJICC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:02:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:52342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730559AbeJICC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:02:56 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4A10204FD;
        Mon,  8 Oct 2018 18:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024589;
        bh=2+5CX9mfV/8kGn5Lipvzlt8Tg2C2qdBHEjEDxKR5rSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ep3COYZOVK5aOuwQ1qi5IC19ejhop7p3tL+t5xJYs0YiS0Hn2pRi5h3V30vYQB+K/
         G9i7od+3U6FFRIagHL1/QOsb4VnW0mDiPphN0LQAG5PMxBJfu19F+cNDtfJAXlDZ9k
         YRTmLXcAQX+QdytqG5RFp3ZdTQ0WNQfd+w5I2aoY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Greentime Hu <greentime@andestech.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 066/168] nds32: fix logic for module
Date:   Mon,  8 Oct 2018 20:30:46 +0200
Message-Id: <20181008175622.561691456@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
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

From: Greentime Hu <greentime@andestech.com>

[ Upstream commit 1dfdf99106668679b0de5a62fd4f42c1a11c9445 ]

This bug is report by Dan Carpenter. We shall use ~loc_mask instead of
!loc_mask because we need to and(&) the bits of ~loc_mask.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: c9a4a8da6baa ("nds32: Loadable modules")
Signed-off-by: Greentime Hu <greentime@andestech.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/nds32/kernel/module.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/nds32/kernel/module.c
+++ b/arch/nds32/kernel/module.c
@@ -40,7 +40,7 @@ void do_reloc16(unsigned int val, unsign
 
 	tmp2 = tmp & loc_mask;
 	if (partial_in_place) {
-		tmp &= (!loc_mask);
+		tmp &= (~loc_mask);
 		tmp =
 		    tmp2 | ((tmp + ((val & val_mask) >> val_shift)) & val_mask);
 	} else {
@@ -70,7 +70,7 @@ void do_reloc32(unsigned int val, unsign
 
 	tmp2 = tmp & loc_mask;
 	if (partial_in_place) {
-		tmp &= (!loc_mask);
+		tmp &= (~loc_mask);
 		tmp =
 		    tmp2 | ((tmp + ((val & val_mask) >> val_shift)) & val_mask);
 	} else {


