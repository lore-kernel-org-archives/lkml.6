Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BAAC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71893206BA
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WC+zo+uB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71893206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390979AbeKLImy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:42:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:54672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404060AbeKLIXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:23:03 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87FB3223DD;
        Sun, 11 Nov 2018 22:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975586;
        bh=Y/LXwDTGXMFfQUQo2SEuiXb7Rmdx4wCHgzaobetpPQ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WC+zo+uBn3rAXy6V5x5JpTJ7/ZRQp/tdKtncIKfpikd+avT81t0VcL9JQA/UwGDwA
         orjCAJJrcGWHgN3zl8kd9Hs3uIqtHAhGR8BvltwV4MOn5wnk9NEb0FWIiryGYhLq2D
         B4ocjsCKZJpAv52nQiGMdkfzT+LqMytQHvBXUPF8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Anatoly Trosinenko <anatoly.trosinenko@gmail.com>,
        Nicolas Pitre <nico@linaro.org>
Subject: [PATCH 4.14 191/222] Cramfs: fix abad comparison when wrap-arounds occur
Date:   Sun, 11 Nov 2018 14:24:48 -0800
Message-Id: <20181111221703.985213012@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -186,7 +186,8 @@ static void *cramfs_read(struct super_bl
 			continue;
 		blk_offset = (blocknr - buffer_blocknr[i]) << PAGE_SHIFT;
 		blk_offset += offset;
-		if (blk_offset + len > BUFFER_SIZE)
+		if (blk_offset > BUFFER_SIZE ||
+		    blk_offset + len > BUFFER_SIZE)
 			continue;
 		return read_buffers[i] + blk_offset;
 	}


