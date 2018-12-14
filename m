Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589DAC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EC9E2147D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789168;
	bh=QpCMsYTivLaW4dLSMxIrEd+94J0u+CmZAEnHoy3LzuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z26HL92n3tG445noyFmQOO7vo2RNUP7QgsUYWEJFH7zQA6oKf31P0RK6qAoDl2stH
	 vP2LrUEHvS4qJKzbfbAfDNNp0yBo3BauIPdJ7ESqWQ3cvVl/kxH1EhaldlrNRb/mnL
	 E6KRNiEkT+IIso5Q6pb4LZd3Y/WmQzcR/pBhdtw4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EC9E2147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730839AbeLNMGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:06:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:50840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730014AbeLNMFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:05:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 977D321479;
        Fri, 14 Dec 2018 12:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789154;
        bh=QpCMsYTivLaW4dLSMxIrEd+94J0u+CmZAEnHoy3LzuM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ot2WpeyWpsPrPFAVbtGX6ihv0E5pKPlK6jNuIw6PT68Nal7/40TzwPy7kwLlguVSy
         gmzi11p/eFoNzzAUDcvHNoCyDM/zeVbMeGCjYqfGAF+BJX9WOuZSPLv0/7QzEGboE2
         9OhiNl6FLKhgfJTT88AoHU0z9ylVqVk3+lnAiAhc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pan Bian <bianpan2016@163.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 114/142] pvcalls-front: fixes incorrect error handling
Date:   Fri, 14 Dec 2018 12:59:59 +0100
Message-Id: <20181214115751.600882293@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
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

[ Upstream commit 975ef94a0284648fb0137bd5e949b18cef604e33 ]

kfree() is incorrectly used to release the pages allocated by
__get_free_page() and __get_free_pages(). Use the matching deallocators
i.e., free_page() and free_pages(), respectively.

Signed-off-by: Pan Bian <bianpan2016@163.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/pvcalls-front.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/pvcalls-front.c b/drivers/xen/pvcalls-front.c
index 2f11ca72a281..77224d8f3e6f 100644
--- a/drivers/xen/pvcalls-front.c
+++ b/drivers/xen/pvcalls-front.c
@@ -385,8 +385,8 @@ static int create_active(struct sock_mapping *map, int *evtchn)
 out_error:
 	if (*evtchn >= 0)
 		xenbus_free_evtchn(pvcalls_front_dev, *evtchn);
-	kfree(map->active.data.in);
-	kfree(map->active.ring);
+	free_pages((unsigned long)map->active.data.in, PVCALLS_RING_ORDER);
+	free_page((unsigned long)map->active.ring);
 	return ret;
 }
 
-- 
2.19.1



