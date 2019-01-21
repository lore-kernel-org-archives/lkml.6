Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035C1C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C98D420861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548080390;
	bh=qM6w4+yzsFLwdNK6g5amleqeNrgmAc3BL76qCAsnCBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NtvjvlL+OKqzb6bNXZmEwBRd61WOyyoxigG2/hEWy+i+GbDe3tuxB1aKiOo/4u4FF
	 SENg4XQ/ygEQB1LlQb+kj04sQ96YbLuNgUtmrTfHi6hJXS315TmL8AOBgUnSsgO5l6
	 Zy58yc6PNMNJIOz4d5Qa98UpccTzc+DYcIqqql10=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730688AbfAUOTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:19:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:58484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729336AbfAUNsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:48:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53E852063F;
        Mon, 21 Jan 2019 13:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078510;
        bh=qM6w4+yzsFLwdNK6g5amleqeNrgmAc3BL76qCAsnCBc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=crX9BgIGc7n+RNxqlceE+LpjMU49jqvwL2Gb9+c++FM2eWRCya0P26kR56at1BlRC
         3HJfr98IQD8APr0kqtEN98C7UyAsP1GN9wwLrJr+J8ehb3IR8nhpRfWL+YbzwE3oTZ
         bWybAGQwWMYOmsNDpP7+0L7DjYw7EPGu/h/kxhFY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.20 058/111] RDMA/nldev: Dont expose unsafe global rkey to regular user
Date:   Mon, 21 Jan 2019 14:42:52 +0100
Message-Id: <20190121122502.277934697@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122455.819406896@linuxfoundation.org>
References: <20190121122455.819406896@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leon Romanovsky <leonro@mellanox.com>

commit a9666c1cae8dbcd1a9aacd08a778bf2a28eea300 upstream.

Unsafe global rkey is considered dangerous because it exposes memory
registered for all memory in the system. Only users with a QP on the same
PD can use the rkey, and generally those QPs will already know the
value. However, out of caution, do not expose the value to unprivleged
users on the local system. Require CAP_NET_ADMIN instead.

Cc: <stable@vger.kernel.org> # 4.16
Fixes: 29cf1351d450 ("RDMA/nldev: provide detailed PD information")
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/core/nldev.c |    4 ----
 1 file changed, 4 deletions(-)

--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -580,10 +580,6 @@ static int fill_res_pd_entry(struct sk_b
 	if (nla_put_u64_64bit(msg, RDMA_NLDEV_ATTR_RES_USECNT,
 			      atomic_read(&pd->usecnt), RDMA_NLDEV_ATTR_PAD))
 		goto err;
-	if ((pd->flags & IB_PD_UNSAFE_GLOBAL_RKEY) &&
-	    nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_UNSAFE_GLOBAL_RKEY,
-			pd->unsafe_global_rkey))
-		goto err;
 
 	if (fill_res_name_pid(msg, res))
 		goto err;


