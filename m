Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D0DC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B62D2084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544545466;
	bh=8DfYzkFUREWSWmB+LVJtf2vMQzZpCR4OCH71SI2dcTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lyiSqI9EEtlpk9a70U59U1SAG+IRH7b25b9uwlOFYqgj1ufN3qQ/qY+hHjr0ux4fN
	 +cdv0rZM6eiAEdmNB5dxQZ1LYuv5x22pOVabkJDKttGBNuzVKqSh9de31bUEaELGPy
	 6qsKjrhK+86DX1ueg+2gur76Rc4YM4ATSwIcsq54=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B62D2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbeLKQYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:24:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:59176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727332AbeLKPmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:42:46 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2EB420879;
        Tue, 11 Dec 2018 15:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544542966;
        bh=8DfYzkFUREWSWmB+LVJtf2vMQzZpCR4OCH71SI2dcTI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TJ1mMQRlddZ2MZxq2WCu+77mJsUjVf0kMYIQLUUtNwpxbT0kVhsRGR94AxN9mlMRF
         6mfbVUDmbeq+erstE/3R8gWI6mi3tDq4D5/tWRGaY3YOTQi5Ytk5F74uT0nyCMHkyq
         ZUppImFXiq52VFM5v2ObFex7JEnGbNguj14roMkE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pan Bian <bianpan2016@163.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 3.18 08/54] ext2: fix potential use after free
Date:   Tue, 11 Dec 2018 16:40:56 +0100
Message-Id: <20181211151546.448597786@linuxfoundation.org>
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

From: Pan Bian <bianpan2016@163.com>

commit ecebf55d27a11538ea84aee0be643dd953f830d5 upstream.

The function ext2_xattr_set calls brelse(bh) to drop the reference count
of bh. After that, bh may be freed. However, following brelse(bh),
it reads bh->b_data via macro HDR(bh). This may result in a
use-after-free bug. This patch moves brelse(bh) after reading field.

CC: stable@vger.kernel.org
Signed-off-by: Pan Bian <bianpan2016@163.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext2/xattr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/ext2/xattr.c
+++ b/fs/ext2/xattr.c
@@ -606,9 +606,9 @@ skip_replace:
 	}
 
 cleanup:
-	brelse(bh);
 	if (!(bh && header == HDR(bh)))
 		kfree(header);
+	brelse(bh);
 	up_write(&EXT2_I(inode)->xattr_sem);
 
 	return error;


