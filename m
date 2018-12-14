Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB1FC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15EE6214D9
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789369;
	bh=/bzVTxoPPTpyckv0lQA1d7DvwcKYwpb504TtGC34/TE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W/ktXCbHQel+9W1zWjrD2TWb6JcmDP+4EEWDMS/t3SlUpGbsvz75rUcD5VDObHqjt
	 O7v1gi5yLBaMgDO+LwXRLueUUPRU798i10XnxSryvRSm7HMeoIfKfQaMFCetXGCKNS
	 vmvZnBHg9UmNotxe+gPSXJxJJo25F5OGFF0enJDY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15EE6214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731457AbeLNMJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:09:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:55128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731447AbeLNMJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:09:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F01E52147D;
        Fri, 14 Dec 2018 12:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789364;
        bh=/bzVTxoPPTpyckv0lQA1d7DvwcKYwpb504TtGC34/TE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z/hXtyRmO1hneoEabKyJdsWyh1s3Fp2EF/9C/m1XgLQfsdYXIaP8SlxRp4xARXkCg
         qf/sXVv02DjQ5V16TyyOoH+s6JNBPbuwgqB9GdJzv1+IVT+WbD1JA/d5/nW4PrTNRx
         7oPlJH4JRD5NC/MBNi1OTG8gl+rnlgTJgqeFkVbE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Artemy Kovalyov <artemyko@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 54/89] IB/mlx5: Fix page fault handling for MW
Date:   Fri, 14 Dec 2018 13:00:07 +0100
Message-Id: <20181214115732.340971260@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115729.658859279@linuxfoundation.org>
References: <20181214115729.658859279@linuxfoundation.org>
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

[ Upstream commit 75b7b86bdb0df37e08e44b6c1f99010967f81944 ]

Memory windows are implemented with an indirect MKey, when a page fault
event comes for a MW Mkey we need to find the MR at the end of the list of
the indirect MKeys by iterating on all items from the first to the last.

The offset calculated during this process has to be zeroed after the first
iteration or the next iteration will start from a wrong address, resulting
incorrect ODP faulting behavior.

Fixes: db570d7deafb ("IB/mlx5: Add ODP support to MW")
Signed-off-by: Artemy Kovalyov <artemyko@mellanox.com>
Signed-off-by: Moni Shoua <monis@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mlx5/odp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 3d701c7a4c91..1ed94b6c0b0a 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -723,6 +723,7 @@ static int pagefault_single_data_segment(struct mlx5_ib_dev *dev,
 			head = frame;
 
 			bcnt -= frame->bcnt;
+			offset = 0;
 		}
 		break;
 
-- 
2.19.1



