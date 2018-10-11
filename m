Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63694C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2542321470
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAXZgIT3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2542321470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730120AbeJKXHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:07:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:37834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbeJKXHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:07:52 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBC7D2098A;
        Thu, 11 Oct 2018 15:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272409;
        bh=bAznDQmrilrj4HQxprZCERCUdbHYb/mS7CbXkxyRX7g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GAXZgIT3eZRB71PXJb0s6FYKYltoROqc0+X95rBzaEQPuUMZR+SZ7YA1TmuGy21KO
         /MA4K3vcCWVpLPNOXo7LDMiTOfkMFdNoADlcSpnWzkF44conKkhopZ1kCBRnoVtuB+
         WQc78S5r3mfGsgn5mocUZGLXjpkiM/ozZ91lMjGw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mike Snitzer <snitzer@redhat.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 3.18 098/120] dm thin metadata: fix __udivdi3 undefined on 32-bit
Date:   Thu, 11 Oct 2018 17:34:39 +0200
Message-Id: <20181011152553.839954313@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152549.500488630@linuxfoundation.org>
References: <20181011152549.500488630@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Snitzer <snitzer@redhat.com>

commit 013ad043906b2befd4a9bfb06219ed9fedd92716 upstream.

sector_div() is only viable for use with sector_t.
dm_block_t is typedef'd to uint64_t -- so use div_u64() instead.

Fixes: 3ab918281 ("dm thin metadata: try to avoid ever aborting transactions")
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-thin-metadata.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/drivers/md/dm-thin-metadata.c
+++ b/drivers/md/dm-thin-metadata.c
@@ -840,10 +840,8 @@ static void __set_metadata_reserve(struc
 	if (r) {
 		DMERR("could not get size of metadata device");
 		pmd->metadata_reserve = max_blocks;
-	} else {
-		sector_div(total, 10);
-		pmd->metadata_reserve = min(max_blocks, total);
-	}
+	} else
+		pmd->metadata_reserve = min(max_blocks, div_u64(total, 10));
 }
 
 struct dm_pool_metadata *dm_pool_metadata_open(struct block_device *bdev,


