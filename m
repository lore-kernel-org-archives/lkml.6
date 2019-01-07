Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8E3C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D0822183F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866356;
	bh=Ld13Sbe4HKYF/4vuBE9S6BPU0VGVUx0VCiKIsG3FJ/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WBu/ItZdKXpewlt724pU7wvq1uaf1zZSHxvzBqpX5dls/6C+Vc4u0cDukZXEIS7r1
	 j90g01MR2nMzMwv+VZPX99BtD+91c8EthZfr+7ezAexL8FHqbd5D5t8w1zCYxCy7jD
	 WVw+9ROGRhuKzQ5QGwcNOE9zzWKvlt5EhNGKSTgQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731511AbfAGNFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:05:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:53442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730806AbfAGNFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:05:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41C6021736;
        Mon,  7 Jan 2019 13:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866352;
        bh=Ld13Sbe4HKYF/4vuBE9S6BPU0VGVUx0VCiKIsG3FJ/Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v/9Ykk0V1F1w8z57L6pSoV/r/ZzXT16loLkAG+QqdQ1vVY7ns7LCZjljtIu6x2rO6
         C4NHEq8vmCV9pr/RIAd8FwvdrYKinPpi/sL/CdTMmhc52pBrvLyfqKUq9FEAT/9nHo
         pjYcAE005L6Cyf2nVd7u968xf4eVABWztJ2yCY+c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 04/71] net: core: Fix Spectre v1 vulnerability
Date:   Mon,  7 Jan 2019 13:32:33 +0100
Message-Id: <20190107105330.536657603@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107105330.280153213@linuxfoundation.org>
References: <20190107105330.280153213@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>

[ Upstream commit 50d5258634aee2e62832aa086d2fb0de00e72b91 ]

flen is indirectly controlled by user-space, hence leading to
a potential exploitation of the Spectre variant 1 vulnerability.

This issue was detected with the help of Smatch:

net/core/filter.c:1101 bpf_check_classic() warn: potential spectre issue 'filter' [w]

Fix this by sanitizing flen before using it to index filter at line 1101:

	switch (filter[flen - 1].code) {

and through pc at line 1040:

	const struct sock_filter *ftest = &filter[pc];

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/filter.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -51,6 +51,7 @@
 #include <net/dst_metadata.h>
 #include <net/dst.h>
 #include <net/sock_reuseport.h>
+#include <linux/nospec.h>
 
 /**
  *	sk_filter_trim_cap - run a packet through a socket filter
@@ -786,6 +787,7 @@ static int bpf_check_classic(const struc
 	bool anc_found;
 	int pc;
 
+	flen = array_index_nospec(flen, BPF_MAXINSNS + 1);
 	/* Check the filter code now */
 	for (pc = 0; pc < flen; pc++) {
 		const struct sock_filter *ftest = &filter[pc];


