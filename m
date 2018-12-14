Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C96EC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4B2421479
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789013;
	bh=fNmZh5JyYhvVK8w93oS4NQ8A0j1vDv5ovEzGR2nP+9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UKj9PYmlcDcSXdOCIV3lIR8zdULWTQ2ifo2B1tZV5jvA9xQERC4OzXteyW6yXN5Ue
	 BadFP2CeueHhQoJ6fuHZi5W9MoDEmt+3lptLau/3JJHP2Ks4QzvD7qPUex0Wt5XzHZ
	 qTDFT2vCWW+cTShPnvef4d/VG2Kw3po2VuJtdXTM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4B2421479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730333AbeLNMDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:03:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:47226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729775AbeLNMD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:03:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4EF62146F;
        Fri, 14 Dec 2018 12:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789009;
        bh=fNmZh5JyYhvVK8w93oS4NQ8A0j1vDv5ovEzGR2nP+9I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rkjsU4k9nvCmHwkRD7sdB57ufYbV40KlA37bzgwtmfTQDuV0csomk6dP5inv2yx/B
         YpF7+yKYZszry2ssb1nCsYXVxTxB+0jvFz+Gbw2M+Diw48NMAd/wFXAOff3c88LhQr
         ZpJQbzLny8FAegrA69WKOG12Xysv8t1cRn1mxIQI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 059/142] aio: fix failure to put the file pointer
Date:   Fri, 14 Dec 2018 12:59:04 +0100
Message-Id: <20181214115749.419556941@linuxfoundation.org>
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

[ Upstream commit 53fffe29a9e664a999dd3787e4428da8c30533e0 ]

If the ioprio capability check fails, we return without putting
the file pointer.

Fixes: d9a08a9e616b ("fs: Add aio iopriority support")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/aio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/aio.c b/fs/aio.c
index b9350f3360c6..04c4d6218978 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1436,6 +1436,7 @@ static int aio_prep_rw(struct kiocb *req, struct iocb *iocb)
 		ret = ioprio_check_cap(iocb->aio_reqprio);
 		if (ret) {
 			pr_debug("aio ioprio check cap error: %d\n", ret);
+			fput(req->ki_filp);
 			return ret;
 		}
 
-- 
2.19.1



