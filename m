Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4449C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D9AF2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9iBOzlT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D9AF2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730966AbeKZV57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:57:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:42670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729291AbeKZV56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:57:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3026B20672;
        Mon, 26 Nov 2018 11:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230252;
        bh=Bf5ZrfPhkHSEyDVVXRxboYurn9+12f58M0ISOryw7W0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M9iBOzlTH7hEolDSFTdhzYARwZqEmHDaWaGzRpgVs7qS8Yn/m0cHnbsNN/ijWBA7P
         IL9D3KvTodiXBjDZ1FUesPs/6oyJMLHMXZFmwWaU5aoailEjRm1uLhcF4hRiqkNtlf
         Y5reng/hYNh14HQ4ETozIkZPhLaodBOYUQuF2gUM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 065/118] block: Clear kernel memory before copying to user
Date:   Mon, 26 Nov 2018 11:50:59 +0100
Message-Id: <20181126105103.487695080@linuxfoundation.org>
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

[ Upstream commit f3587d76da05f68098ddb1cb3c98cc6a9e8a402c ]

If the kernel allocates a bounce buffer for user read data, this memory
needs to be cleared before copying it to the user, otherwise it may leak
kernel memory to user space.

Laurence Oberman <loberman@redhat.com>
Signed-off-by: Keith Busch <keith.busch@intel.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/bio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/bio.c b/block/bio.c
index 0093bed81c0e..41173710430c 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1261,6 +1261,7 @@ struct bio *bio_copy_user_iov(struct request_queue *q,
 		if (ret)
 			goto cleanup;
 	} else {
+		zero_fill_bio(bio);
 		iov_iter_advance(iter, bio->bi_iter.bi_size);
 	}
 
-- 
2.17.1



