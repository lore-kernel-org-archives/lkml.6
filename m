Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEABC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A38BE20850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1/z7mMig"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A38BE20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbeLEJli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:41:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:46142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728941AbeLEJlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:41:37 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20CB820851;
        Wed,  5 Dec 2018 09:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002896;
        bh=/9eTUreKMxnHdfEnxgc48V+SbmdaUtFa+ywCWWq0qoY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1/z7mMighrFtzj21cbRea44YJhe5sDBdFEbbMdBAflYqBeCSTGvWfeuW8cnMZRuAi
         Htzef0QZAw8EvPkMxfFlK6cXpqnItljL0ESZOFTithr0HGiIt4TmxFITwfx+thBAan
         LGvyTBjplyo5jSm+ehdJOxYBDYavWlRYMUr0QxJM=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Pan Bian <bianpan2016@163.com>, Juergen Gross <jgross@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 103/123] pvcalls-front: fixes incorrect error handling
Date:   Wed,  5 Dec 2018 04:35:35 -0500
Message-Id: <20181205093555.5386-103-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pan Bian <bianpan2016@163.com>

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
2.17.1

