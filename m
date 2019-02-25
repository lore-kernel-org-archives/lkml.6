Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F114C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D031A21841
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130241;
	bh=IfrIbYHx/pVzx10k32Ek02m67b3t+v/ZUiefQrUqja4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M93+wIo7tYjXrmwGElHe08HI3ml5xkb5Ct6lsbYVaDcNncx3D5FLtQTXxm2TEsMAq
	 DfuCJ+le6Wa5k/ErbO/TFt6mXkEfLwixPbCP9ziDGxj0WIIcEHLh7OgvdugWepxObF
	 CIuSp4yyHeWXuBqGlSRNhD7ryMJ/GJstZYIn0YMQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732173AbfBYVak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:30:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:36258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730028AbfBYVah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:30:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 914B0217F5;
        Mon, 25 Feb 2019 21:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130237;
        bh=IfrIbYHx/pVzx10k32Ek02m67b3t+v/ZUiefQrUqja4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GFdGhecmXHAc8UDTRpuXL8JXweC/C0MiZbIxoEmRgS3KTY+k6uWTQl9XPhbMZ3ool
         LWDH1Nc9qkOics6Q/sXq0umAGjydofpxi/cRMobTOJOZi9UlrQCVrWfSbUQAmr+xXv
         yeJHC5aSeZQREjnpD4ZyjM7haZoRhhs2Aabxek2c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Taehee Yoo <ap420073@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 056/183] netfilter: nf_tables: fix leaking object reference count
Date:   Mon, 25 Feb 2019 22:10:29 +0100
Message-Id: <20190225195103.965913612@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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

[ Upstream commit b91d9036883793122cf6575ca4dfbfbdd201a83d ]

There is no code that decreases the reference count of stateful objects
in error path of the nft_add_set_elem(). this causes a leak of reference
count of stateful objects.

Test commands:
   $nft add table ip filter
   $nft add counter ip filter c1
   $nft add map ip filter m1 { type ipv4_addr : counter \;}
   $nft add element ip filter m1 { 1 : c1 }
   $nft add element ip filter m1 { 1 : c1 }
   $nft delete element ip filter m1 { 1 }
   $nft delete counter ip filter c1

Result:
   Error: Could not process rule: Device or resource busy
   delete counter ip filter c1
   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^

At the second 'nft add element ip filter m1 { 1 : c1 }', the reference
count of the 'c1' is increased then it tries to insert into the 'm1'. but
the 'm1' already has same element so it returns -EEXIST.
But it doesn't decrease the reference count of the 'c1' in the error path.
Due to a leak of the reference count of the 'c1', the 'c1' can't be
removed by 'nft delete counter ip filter c1'.

Fixes: 8aeff920dcc9 ("netfilter: nf_tables: add stateful object reference to set elements")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 6e548d7c9f67b..aba6ec4a14cec 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -4474,6 +4474,8 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 err5:
 	kfree(trans);
 err4:
+	if (obj)
+		obj->use--;
 	kfree(elem.priv);
 err3:
 	if (nla[NFTA_SET_ELEM_DATA] != NULL)
-- 
2.19.1



