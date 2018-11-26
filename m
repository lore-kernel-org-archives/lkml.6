Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B277FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 796AC20645
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zYIMLpwU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 796AC20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730906AbeKZV5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:57:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:42236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729785AbeKZV5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:57:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64E4220672;
        Mon, 26 Nov 2018 11:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230238;
        bh=fecaK5DVAzXTRyM+gVar8Bkg/SdXLsKDzl3A9JGp2TY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zYIMLpwUkREXlq7xVGXrB9DRQoXHXkDE0ZoLDidXB84vQIu0IfcQAseIU7K/td1vO
         f2KvA/d6EoFrYNv2BKoLcVkw0bD4BMCrB176wgxsILp5aVwcnPmKh/cSEW5j4YdNrY
         MeLe/O/XUU1P8kUSuo0Lk0wjk5XKop7Fh6pCEnzc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ross Philipson <ross.philipson@oracle.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Mark Kanda <mark.kanda@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 060/118] xen/grant-table: Fix incorrect gnttab_dma_free_pages() pr_debug message
Date:   Mon, 26 Nov 2018 11:50:54 +0100
Message-Id: <20181126105103.236735094@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105059.832485122@linuxfoundation.org>
References: <20181126105059.832485122@linuxfoundation.org>
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

[ Upstream commit d9cccfa7c4d1d9ef967ec9308df7304a18609b30 ]

If a call to xenmem_reservation_increase() in gnttab_dma_free_pages()
fails it triggers a message "Failed to decrease reservation..." which
should be "Failed to increase reservation..."

Fixes: 9bdc7304f536 ('xen/grant-table: Allow allocating buffers suitable for DMA')
Reported-by: Ross Philipson <ross.philipson@oracle.com>
Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
Reviewed-by: Mark Kanda <mark.kanda@oracle.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/grant-table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
index 84575baceebc..97341fa75458 100644
--- a/drivers/xen/grant-table.c
+++ b/drivers/xen/grant-table.c
@@ -914,7 +914,7 @@ int gnttab_dma_free_pages(struct gnttab_dma_alloc_args *args)
 
 	ret = xenmem_reservation_increase(args->nr_pages, args->frames);
 	if (ret != args->nr_pages) {
-		pr_debug("Failed to decrease reservation for DMA buffer\n");
+		pr_debug("Failed to increase reservation for DMA buffer\n");
 		ret = -EFAULT;
 	} else {
 		ret = 0;
-- 
2.17.1



