Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF86C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5240220871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TrNT7I5o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5240220871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388402AbeKLJ32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:29:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:42142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388046AbeKLITr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:19:47 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D79D22360;
        Sun, 11 Nov 2018 22:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975391;
        bh=kqDDduOozg8xf2c2lrMLghnlmZdOxZfKXJuZGfEgR50=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TrNT7I5oU490uxnxV/NcvSkeJo71ocX+mCv1rgFRxAIsWOV/cvjj5wCnpNGmKW3E1
         5mu4TfHinU0YKTYXBMKOPdTTiSt3C1yBZbRxzrRXGCu1Si2eAkTFpfuVj9FpQqeUSi
         0hpoQSPhy4+MZfTtSb9onqdoMRYlOf1KvAD+lnYI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 074/350] lightnvm: pblk: fix race on sysfs line state
Date:   Sun, 11 Nov 2018 14:18:58 -0800
Message-Id: <20181111221710.227367992@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
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

From: Javier González <javier@cnexlabs.com>

[ Upstream commit 44cdbdc657b23f75736eca3e88b781f009104363 ]

pblk exposes a sysfs interface that represents its internal state. Part
of this state is the map bitmap for the current open line, which should
be protected by the line lock to avoid a race when freeing the line
metadata. Currently, it is not.

This patch makes sure that the line state is consistent and NULL
bitmap pointers are not dereferenced.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/lightnvm/pblk-core.c  |    5 +++--
 drivers/lightnvm/pblk-sysfs.c |    8 +++++++-
 2 files changed, 10 insertions(+), 3 deletions(-)

--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1538,13 +1538,14 @@ struct pblk_line *pblk_line_replace_data
 	struct pblk_line *cur, *new = NULL;
 	unsigned int left_seblks;
 
-	cur = l_mg->data_line;
 	new = l_mg->data_next;
 	if (!new)
 		goto out;
-	l_mg->data_line = new;
 
 	spin_lock(&l_mg->free_lock);
+	cur = l_mg->data_line;
+	l_mg->data_line = new;
+
 	pblk_line_setup_metadata(new, l_mg, &pblk->lm);
 	spin_unlock(&l_mg->free_lock);
 
--- a/drivers/lightnvm/pblk-sysfs.c
+++ b/drivers/lightnvm/pblk-sysfs.c
@@ -262,8 +262,14 @@ static ssize_t pblk_sysfs_lines(struct p
 		sec_in_line = l_mg->data_line->sec_in_line;
 		meta_weight = bitmap_weight(&l_mg->meta_bitmap,
 							PBLK_DATA_LINES);
-		map_weight = bitmap_weight(l_mg->data_line->map_bitmap,
+
+		spin_lock(&l_mg->data_line->lock);
+		if (l_mg->data_line->map_bitmap)
+			map_weight = bitmap_weight(l_mg->data_line->map_bitmap,
 							lm->sec_per_line);
+		else
+			map_weight = 0;
+		spin_unlock(&l_mg->data_line->lock);
 	}
 	spin_unlock(&l_mg->free_lock);
 


