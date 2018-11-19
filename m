Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1E3C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D62214F1
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1U0N32JE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6D62214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404808AbeKTDXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:23:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:35672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404341AbeKTDXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:23:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 787012151B;
        Mon, 19 Nov 2018 16:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646761;
        bh=SXPBEUsrtImy4DfNz+V55AVF/37BeJ4SvllIM+ZlVqk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1U0N32JEu6gGIlRV1qyslVKekAarQHhNs9GavcANzvzHXBmy8ur1pRQWpNaRgiyTx
         A/IT2+VQC7m3W30z2dCmoeByTMReF479ATzylVavccU5lLCr/siKwOkIxnNk7S3y0A
         v0aqCEpPx0dGpJ4hxoIHa9W0ULsPMjiFM+ViUWq8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Anatoly Trosinenko <anatoly.trosinenko@gmail.com>,
        Nicolas Pitre <nico@linaro.org>
Subject: [PATCH 4.4 081/160] Cramfs: fix abad comparison when wrap-arounds occur
Date:   Mon, 19 Nov 2018 17:28:40 +0100
Message-Id: <20181119162639.071893784@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162630.031306128@linuxfoundation.org>
References: <20181119162630.031306128@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicolas Pitre <nicolas.pitre@linaro.org>

commit 672ca9dd13f1aca0c17516f76fc5b0e8344b3e46 upstream.

It is possible for corrupted filesystem images to produce very large
block offsets that may wrap when a length is added, and wrongly pass
the buffer size test.

Reported-by: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Signed-off-by: Nicolas Pitre <nico@linaro.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cramfs/inode.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -185,7 +185,8 @@ static void *cramfs_read(struct super_bl
 			continue;
 		blk_offset = (blocknr - buffer_blocknr[i]) << PAGE_CACHE_SHIFT;
 		blk_offset += offset;
-		if (blk_offset + len > BUFFER_SIZE)
+		if (blk_offset > BUFFER_SIZE ||
+		    blk_offset + len > BUFFER_SIZE)
 			continue;
 		return read_buffers[i] + blk_offset;
 	}


