Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720C8C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36A8D20870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543035;
	bh=53Wr0L3L/6COpfZMkxE6LExuLFFwgS9cUw5kPaTLTJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d4MYu50T8BGmol5JaztUvdSbJkl+mgu+Mt4ZXFUAQbewn4Tt1U59j6S20FRrONiCK
	 JzvvzXW1H+t1bXunDaYgn7KK65dZD5nqAXDEiwYHJQqc4+LE4l+jWTK2cIg2BB6OBM
	 aCIQy96lPdsU+Vyw6Nrx0QNykLtRjVfMUOpINIUY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36A8D20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbeLKPny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:43:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:60432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727647AbeLKPnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:43:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3127320672;
        Tue, 11 Dec 2018 15:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543030;
        bh=53Wr0L3L/6COpfZMkxE6LExuLFFwgS9cUw5kPaTLTJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ezB+LzuPjc9qLSJ+MsKGJFqUxymes83NLrbGjYUKaIcqEccWgBdybVzgYF/oMdpI6
         maFSuCjpwf85AJpIh0w5i+6wL/oVbxsA4MiJdf14nixO/9sQ4TCiNKcm9t5rMn3SSs
         i6ci25aXW8pxXey0Ej4iXPtXiaGvvRBXDgl72x2A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 39/54] net: amd: add missing of_node_put()
Date:   Tue, 11 Dec 2018 16:41:27 +0100
Message-Id: <20181211151548.275329017@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151546.010073210@linuxfoundation.org>
References: <20181211151546.010073210@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit c44c749d3b6fdfca39002e7e48e03fe9f9fe37a3 ]

of_find_node_by_path() acquires a reference to the node
returned by it and that reference needs to be dropped by its caller.
This place doesn't do that, so fix it.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amd/sunlance.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/sunlance.c b/drivers/net/ethernet/amd/sunlance.c
index 5e4273b7aa27..2bac37b9b4d3 100644
--- a/drivers/net/ethernet/amd/sunlance.c
+++ b/drivers/net/ethernet/amd/sunlance.c
@@ -1419,7 +1419,7 @@ static int sparc_lance_probe_one(struct platform_device *op,
 
 			prop = of_get_property(nd, "tpe-link-test?", NULL);
 			if (!prop)
-				goto no_link_test;
+				goto node_put;
 
 			if (strcmp(prop, "true")) {
 				printk(KERN_NOTICE "SunLance: warning: overriding option "
@@ -1428,6 +1428,8 @@ static int sparc_lance_probe_one(struct platform_device *op,
 				       "to ecd@skynet.be\n");
 				auxio_set_lte(AUXIO_LTE_ON);
 			}
+node_put:
+			of_node_put(nd);
 no_link_test:
 			lp->auto_select = 1;
 			lp->tpe = 0;
-- 
2.19.1



